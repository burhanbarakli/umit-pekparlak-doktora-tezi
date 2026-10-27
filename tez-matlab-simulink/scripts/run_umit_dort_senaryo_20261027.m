function run_umit_dort_senaryo_20261027(mdl)
% Ümit'in 12.10.2026 paketindeki bir modeli devre ve parametrelerine
% dokunmadan koşturur. Bellekte yalnız Display bloklarını besleyen sinyallerin
% ve sensör çıkışlarının kaydı açılır; model dosyası kaydedilmez.
% Çağrı (proje kökünden):
%   matlab -batch "addpath('scripts'); run_umit_dort_senaryo_20261027('inverter_senaryo3')"
% Çıktı: runs/2026-10-27_dort_senaryo_ilk_kosu/results/<model>/
root_dir = fileparts(fileparts(mfilename('fullpath')));
run_dir = fullfile(root_dir, 'runs', '2026-10-27_dort_senaryo_ilk_kosu');
model_dir = fullfile(run_dir, 'model');
out_dir = fullfile(run_dir, 'results', mdl);
if ~exist(out_dir, 'dir'), mkdir(out_dir); end

cd(model_dir);  % InitFcn parametre dosyasını buradan okur; slprj burada kalır
% Simscape diyot parametrelerinin türü InitFcn'den önce çözülür; temiz oturumda
% değişkenler yoksa Qrr/didt "string" hatası verir. Ümit'in kullanımındaki gibi
% parametre dosyası önce taban çalışma alanında çalıştırılır (InitFcn yine koşar).
evalin('base', sprintf('run(''%s'');', fullfile(model_dir, 'inverter_common_parameters.m')));
load_system(mdl);

% Display kaynaklarını kaydet: ad = Display bloğunun adı (ASCII'leştirilmiş)
disp_blocks = find_system(mdl, 'SearchDepth', 1, 'BlockType', 'Display');
map = {};
for k = 1:numel(disp_blocks)
    ph = get_param(disp_blocks{k}, 'PortHandles');
    ln = get_param(ph.Inport, 'Line');
    if ln < 0, continue, end
    src = get_param(ln, 'SrcPortHandle');
    name = ascii_name(get_param(disp_blocks{k}, 'Name'));
    if strcmp(get_param(src, 'DataLogging'), 'off')
        set_param(src, 'DataLogging', 'on', 'DataLoggingNameMode', 'Custom', ...
            'DataLoggingName', name);
    end
    map(end+1, :) = {name, get_param(src, 'DataLoggingName'), ...
        strrep(get_param(disp_blocks{k}, 'Name'), newline, ' ')}; %#ok<AGROW>
end

% Ham dalga biçimleri: sensör alt sistemlerinin çıkışları
sensors = find_system(mdl, 'SearchDepth', 1, 'Regexp', 'on', 'Name', '^AC (Current|Voltage) Sensor');
for k = 1:numel(sensors)
    ph = get_param(sensors{k}, 'PortHandles');
    for p = 1:numel(ph.Outport)
        set_param(ph.Outport(p), 'DataLogging', 'on', 'DataLoggingNameMode', 'Custom', ...
            'DataLoggingName', ascii_name(get_param(sensors{k}, 'Name')));
    end
end
set_param(mdl, 'SignalLogging', 'on', 'SignalLoggingName', 'logsout', ...
    'ReturnWorkspaceOutputs', 'on');

% Modeller Accelerator modunda kayıtlı. 27.10.2026 ilk koşusunda S3/S4 Accelerator
% ile derlendi; aynı klasörde eşzamanlı üçüncü derleme (S1+S2) MEX oluşturma
% hatası verdi. Paralel koşularda çakışmayı önlemek için Normal mod kullanılır
% (yalnız yürütme biçimi; devre ve çözücü ayarları aynı).
info = struct('model', mdl, 'matlab', version, 'start', char(datetime('now')), ...
    'kayitli_mod', get_param(mdl, 'SimulationMode'));
wall = tic;
try
    out = sim(mdl, 'SimulationMode', 'normal');
    info.status = 'tamamlandi';
    info.message = '';
catch err
    out = [];
    info.status = 'hata';
    info.message = getReport(err, 'extended', 'hyperlinks', 'off');
end
info.wall_s = toc(wall);
info.stop_time = get_param(mdl, 'StopTime');

if ~isempty(out)
    logs = out.logsout;
    rows = {};
    for k = 1:logs.numElements
        el = logs.getElement(k);
        ts = el.Values;
        t = ts.Time;
        v = squeeze(ts.Data);
        if size(v, 1) ~= numel(t), v = v.'; end
        last20 = t >= t(end) - 0.02;
        for c = 1:size(v, 2)
            rows(end+1, :) = {el.Name, c, v(end, c), mean(v(last20, c)), ...
                min(v(last20, c)), max(v(last20, c))}; %#ok<AGROW>
        end
    end
    tbl = cell2table(rows, 'VariableNames', ...
        {'sinyal', 'kanal', 'son_deger', 'ort_son20ms', 'min_son20ms', 'max_son20ms'});
    writetable(tbl, fullfile(out_dir, 'display_degerleri.csv'));
    save(fullfile(out_dir, 'logsout.mat'), 'logs', '-v7.3');
end
writetable(cell2table(map, 'VariableNames', {'kayit_adi', 'kaynak_kayit_adi', 'display_adi'}), ...
    fullfile(out_dir, 'display_eslemesi.csv'));
fid = fopen(fullfile(out_dir, 'kosu_bilgisi.txt'), 'w', 'n', 'UTF-8');
fprintf(fid, '%s: %s\n', 'model', info.model);
fprintf(fid, '%s: %s\n', 'matlab', info.matlab);
fprintf(fid, '%s: %s\n', 'baslangic', info.start);
fprintf(fid, '%s: %s\n', 'durum', info.status);
fprintf(fid, '%s: %.1f\n', 'duvar_suresi_s', info.wall_s);
fprintf(fid, '%s: %s\n', 'StopTime', info.stop_time);
fprintf(fid, '%s: %s -> normal\n', 'SimulationMode', info.kayitli_mod);
fprintf(fid, '%s\n', info.message);
fclose(fid);
close_system(mdl, 0);
fprintf('%s: %s (%.1f s)\n', mdl, info.status, info.wall_s);
end

function s = ascii_name(s)
s = strrep(s, newline, ' ');
s = strrep(strrep(strrep(s, 'ü', 'u'), 'ı', 'i'), 'ç', 'c');
s = strrep(strrep(strrep(s, 'Ü', 'U'), 'ğ', 'g'), 'ş', 's');
s = regexprep(s, '[^A-Za-z0-9]+', '_');
end
