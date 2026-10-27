% Ümit'in 12.10.2026 dört senaryo paketini değiştirmeden inceler:
% üst düzey alt sistemler, ölçüm/kayıt blokları, senaryo değişkeni kullanımı.
% Çıktı: runs/2026-10-27_dort_senaryo_ilk_kosu/inspection/*.txt
root_dir = fileparts(fileparts(mfilename('fullpath')));
run_dir = fullfile(root_dir, 'runs', '2026-10-27_dort_senaryo_ilk_kosu');
model_dir = fullfile(run_dir, 'model');
out_dir = fullfile(run_dir, 'inspection');
if ~exist(out_dir, 'dir'), mkdir(out_dir); end

cd(model_dir);  % InitFcn parametre dosyasını model klasöründen okur; slprj burada kalır
models = {'inverter_scenario1_parametric5_etiquetli', 'inverter_senaryo3', 'inverter_senaryo4'};
watch_vars = {'K11','K12','K13','K14','K33','K34','Vdc1','Vdc2','Vdc3','Vdc4', ...
    'Vac1_peak','Vac2_peak','Vac3_peak','Vac4_peak','phase_deg1','phase_deg2', ...
    'phase_deg3','phase_deg4','Kp','L1_core_Rp','L1_core_Rp4','L2','L2r'};

for m = 1:numel(models)
    mdl = models{m};
    fid = fopen(fullfile(out_dir, [mdl '.txt']), 'w', 'n', 'UTF-8');
    load_system(mdl);
    fprintf(fid, 'MODEL %s\nStopTime=%s Solver=%s MaxStep=%s\n', mdl, ...
        get_param(mdl,'StopTime'), get_param(mdl,'Solver'), get_param(mdl,'MaxStep'));
    fprintf(fid, 'InitFcn=%s\nPreLoadFcn=%s\n', get_param(mdl,'InitFcn'), get_param(mdl,'PreLoadFcn'));

    fprintf(fid, '\n== Üst düzey bloklar\n');
    top = find_system(mdl, 'SearchDepth', 1, 'Type', 'Block');
    for k = 2:numel(top)
        fprintf(fid, '%-28s %s\n', get_param(top{k},'BlockType'), top{k});
    end

    fprintf(fid, '\n== Ölçüm / kayıt blokları (tüm derinlik)\n');
    all_blocks = find_system(mdl, 'LookUnderMasks', 'all', 'FollowLinks', 'on', 'Type', 'Block');
    for k = 1:numel(all_blocks)
        b = all_blocks{k};
        bt = get_param(b, 'BlockType');
        ref = '';
        try, ref = get_param(b, 'ReferenceBlock'); catch, end
        is_meas = any(strcmp(bt, {'Scope','ToWorkspace','Display','Outport'})) || ...
            contains(ref, {'THD','RMS','Mean','Power','PWM Generator','powergui'});
        if is_meas && ~contains(b, '/Power/') && numel(strfind(b,'/')) <= 3
            fprintf(fid, '%-12s %-45s %s\n', bt, ref, strrep(b, newline, ' '));
            if strcmp(bt, 'ToWorkspace')
                fprintf(fid, '             VariableName=%s SaveFormat=%s\n', ...
                    get_param(b,'VariableName'), get_param(b,'SaveFormat'));
            end
        end
    end

    % Simulink.findVars derlemesi Simscape parametrelerini metin olarak
    % değerlendirip hata verdiği için diyalog parametreleri doğrudan taranır.
    fprintf(fid, '\n== Senaryo değişkenlerinin kullanıldığı bloklar\n');
    for k = 1:numel(all_blocks)
        b = all_blocks{k};
        try
            p = fieldnames(get_param(b, 'DialogParameters'));
        catch
            continue
        end
        for q = 1:numel(p)
            v = get_param(b, p{q});
            if ~ischar(v), continue, end
            hit = watch_vars(cellfun(@(w) ~isempty(regexp(v, ['\<' w '\>'], 'once')), watch_vars));
            if ~isempty(hit)
                fprintf(fid, '%-14s %s.%s = %s\n', strjoin(hit, ','), ...
                    strrep(b, newline, ' '), p{q}, v);
            end
        end
    end
    fclose(fid);
    close_system(mdl, 0);
    fprintf('incelendi: %s\n', mdl);
end
