function extract_umit_display_values_20261027(run_name)
% run_umit_dort_senaryo_20261027 çıktısındaki logsout.mat'tan Display değerlerini
% kaynak blok + port üzerinden eşler. Ümit'in modellerinde farklı hatlar aynı
% kayıt adını (ör. Idc_s1) taşıdığından ad değil blok yolu esas alınır.
% Çıktı: runs/<run_name>/results/<model>/display_degerleri_eslesik.csv
% Çağrı (proje kökünden):
%   matlab -batch "run('scripts/extract_umit_display_values_20261027.m')"   % ilk koşu (eski çağrı)
%   matlab -batch "addpath('scripts'); extract_umit_display_values_20261027('2026-10-27_s2_kapi_onarimi')"
% 27.10.2026 (İP-1): betikten fonksiyona çevrildi; argümansız çağrı (run(...) dahil)
% eski davranışı korur: run_name = '2026-10-27_dort_senaryo_ilk_kosu'.
if nargin < 1 || isempty(run_name), run_name = '2026-10-27_dort_senaryo_ilk_kosu'; end
root_dir = fileparts(fileparts(mfilename('fullpath')));
run_dir = fullfile(root_dir, 'runs', run_name);
model_dir = fullfile(run_dir, 'model');
cd(model_dir);
evalin('base', sprintf('run(''%s'');', fullfile(model_dir, 'inverter_common_parameters.m')));

result_dirs = dir(fullfile(run_dir, 'results'));
for r = 1:numel(result_dirs)
    mdl = result_dirs(r).name;
    mat = fullfile(run_dir, 'results', mdl, 'logsout.mat');
    if startsWith(mdl, '.') || ~isfile(mat), continue, end
    S = load(mat, 'logs');
    logs = S.logs;
    load_system(mdl);
    disp_blocks = find_system(mdl, 'SearchDepth', 1, 'BlockType', 'Display');
    rows = {};
    for k = 1:numel(disp_blocks)
        ph = get_param(disp_blocks{k}, 'PortHandles');
        ln = get_param(ph.Inport, 'Line');
        if ln < 0, continue, end
        src_blk = getfullname(get_param(ln, 'SrcBlockHandle'));
        src_port = get_param(get_param(ln, 'SrcPortHandle'), 'PortNumber');
        for e = 1:logs.numElements
            el = logs.getElement(e);
            if strcmp(el.BlockPath.getBlock(1), src_blk) && el.PortIndex == src_port
                t = el.Values.Time;
                v = squeeze(el.Values.Data);
                if size(v, 1) ~= numel(t), v = v.'; end
                last20 = t >= t(end) - 0.02;
                for c = 1:size(v, 2)
                    rows(end+1, :) = {strrep(get_param(disp_blocks{k}, 'Name'), newline, ' '), ...
                        strrep(src_blk, [mdl '/'], ''), src_port, c, v(end, c), mean(v(last20, c))}; %#ok<AGROW>
                end
                break
            end
        end
    end
    close_system(mdl, 0);
    tbl = cell2table(rows, 'VariableNames', ...
        {'display', 'kaynak_blok', 'port', 'kanal', 'son_deger', 'ort_son20ms'});
    writetable(tbl, fullfile(run_dir, 'results', mdl, 'display_degerleri_eslesik.csv'), 'Encoding', 'UTF-8');
    fprintf('%s: %d display eşlendi\n', mdl, height(tbl));
end
end
