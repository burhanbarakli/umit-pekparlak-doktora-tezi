function build_enjeksiyon_kararlilik_20261028(kopyalar)
% İP-6 (K-07, katman 3): anahtarlamalı S4 modelinin ÖLÇÜM kopyasını kurar. Çevrim
% kazancı L(jw) anahtarlamalı modelde, denetleyici çıkışına küçük çok tonlu
% (multisine) bir işaret d eklenerek ölçülür:
%     u_x = u_fb + d   (modülasyon toplamına u_ff ile birlikte giren geri besleme payı)
%     L(jw) = -U_fb(jw) / U_x(jw),  S = U_x/D,  T = -U_fb/D,  P = Y_m/U_x
% Bu bir model DÜZELTMESİ değildir (D-xx yok): yalnız ölçüm için bir toplama bloğu
% eklenir; d = 0 iken model İP-5'in inverter_senaryo4_kc modeliyle matematiksel
% olarak aynıdır (u_fb + 0).
%
% Kaynak: runs/2026-10-28_s4_kapali_cevrim/model/inverter_senaryo4_kc.slx (İP-5, D-02)
% Çıktı : runs/2026-10-28_kararlilik/<kopya>/inverter_senaryo4_enj.slx (+ iki m-dosyası)
% Eklenen bloklar (üst düzey, "S6 " önekli):
%   S6 Enjeksiyon Tonlari  Sine Wave, vektör: genlik S6_inj_A, frekans 2*pi*S6_inj_f,
%                          faz S6_inj_ph, örnekleme pwm_ref_Ts (1 µs)
%   S6 Ton Toplami         Sum (eleman toplamı) -> d_inj
%   S6 Enjeksiyon Toplami  Sum (++): u_fb + d_inj -> u_x -> S4 Modulasyon Toplami/2
% Kayıt: u_fb (denetleyici çıkışı, yeniden adlandırılır), d_inj, u_x.
% Çağrı (proje kökünden):
%   matlab -batch "addpath('scripts'); build_enjeksiyon_kararlilik_20261028({'model_a','model_b','model_c'})"
if nargin < 1, kopyalar = {'model_a', 'model_b', 'model_c'}; end
root_dir = fileparts(fileparts(mfilename('fullpath')));
src_dir = fullfile(root_dir, 'runs', '2026-10-28_s4_kapali_cevrim', 'model');
run_dir = fullfile(root_dir, 'runs', '2026-10-28_kararlilik');
ins_dir = fullfile(run_dir, 'inspection');
if ~exist(ins_dir, 'dir'), mkdir(ins_dir); end
src_mdl = 'inverter_senaryo4_kc'; mdl = 'inverter_senaryo4_enj';
d1 = fullfile(run_dir, kopyalar{1});
if ~exist(d1, 'dir'), mkdir(d1); end
copyfile(fullfile(src_dir, 'inverter_common_parameters.m'), d1, 'f');
copyfile(fullfile(src_dir, 's4_denetleyici_parametreleri.m'), d1, 'f');
copyfile(fullfile(src_dir, [src_mdl '.slx']), fullfile(d1, [src_mdl '_kaynak.slx']), 'f');
log = {};
log{end+1} = sprintf('build_enjeksiyon_kararlilik_20261028 — %s — %s', char(datetime('now')), version);
log{end+1} = sprintf('kaynak: %s (SHA-256 %s)', fullfile(src_dir, [src_mdl '.slx']), file_hash(fullfile(src_dir, [src_mdl '.slx'])));
cd(d1);
for m = {mdl, src_mdl, [src_mdl '_kaynak']}, if bdIsLoaded(m{1}), close_system(m{1}, 0); end, end
evalin('base', sprintf('run(''%s''); run(''%s'');', fullfile(d1, 'inverter_common_parameters.m'), ...
    fullfile(d1, 's4_denetleyici_parametreleri.m')));
assignin('base', 'S6_inj_A', [0 0 0]); assignin('base', 'S6_inj_f', [212.5 525 1037.5]);
assignin('base', 'S6_inj_ph', [0 0 0]);
load_system(fullfile(d1, [src_mdl '_kaynak.slx']));
src_loaded = [src_mdl '_kaynak'];
new_file = fullfile(d1, [mdl '.slx']);
if isfile(new_file), delete(new_file); end
save_system(src_loaded, new_file);
assert(bdIsLoaded(mdl));
delete(fullfile(d1, [src_mdl '_kaynak.slx']));

ctl = [mdl '/S4 Akim Denetleyicisi'];
pc = get_param(ctl, 'PortHandles');
ln = get_param(pc.Outport(1), 'Line');
dst = get_param(ln, 'DstBlockHandle');
log{end+1} = sprintf('u_fb hattinin hedefleri (silinmeden once): %s', strjoin(arrayfun(@(h) getfullname(h), dst, 'UniformOutput', false), ' | '));
assert(numel(dst) == 1 && strcmp(getfullname(dst), [mdl '/S4 Modulasyon Toplami']), 'u_fb beklenmeyen hedef');
delete_line(ln);
p0 = get_param(ctl, 'Position'); X = p0(3) + 30; Y = p0(2);
add_block('simulink/Sources/Sine Wave', [mdl '/S6 Enjeksiyon Tonlari'], 'SineType', 'Time based', ...
    'Amplitude', 'S6_inj_A', 'Frequency', '2*pi*S6_inj_f', 'Phase', 'S6_inj_ph', 'Bias', '0', ...
    'SampleTime', 'pwm_ref_Ts', 'Position', [X, Y + 170, X + 40, Y + 200]);
add_block('simulink/Math Operations/Sum', [mdl '/S6 Ton Toplami'], 'Inputs', '+', ...
    'IconShape', 'rectangular', 'Position', [X + 60, Y + 170, X + 90, Y + 200]);
add_block('simulink/Math Operations/Sum', [mdl '/S6 Enjeksiyon Toplami'], 'Inputs', '++', ...
    'IconShape', 'rectangular', 'Position', [X + 110, Y + 40, X + 140, Y + 100]);
add_line(mdl, 'S6 Enjeksiyon Tonlari/1', 'S6 Ton Toplami/1', 'autorouting', 'on');
add_line(mdl, 'S4 Akim Denetleyicisi/1', 'S6 Enjeksiyon Toplami/1', 'autorouting', 'on');
add_line(mdl, 'S6 Ton Toplami/1', 'S6 Enjeksiyon Toplami/2', 'autorouting', 'on');
add_line(mdl, 'S6 Enjeksiyon Toplami/1', 'S4 Modulasyon Toplami/2', 'autorouting', 'on');
name_log(mdl, 'S4 Akim Denetleyicisi', 1, 'u_fb');
name_log(mdl, 'S6 Ton Toplami', 1, 'd_inj');
name_log(mdl, 'S6 Enjeksiyon Toplami', 1, 'u_x');
ann = Simulink.Annotation([mdl '/S6 Not']);
ann.Position = [X, Y + 220, X + 600, Y + 250];
ann.Text = sprintf(['IP-6 olcum kopyasi: u_x = u_fb + d (cok tonlu enjeksiyon). L = -U_fb/U_x. ' ...
    'S6_inj_A = 0 iken inverter_senaryo4_kc ile ayni. build_enjeksiyon_kararlilik_20261028.m, %s.'], char(datetime('today')));
set_param(mdl, 'PreLoadFcn', ['s4_pre_dir = fileparts(which(''' mdl ''')); if isempty(s4_pre_dir), s4_pre_dir = pwd; end; ' ...
    'run(fullfile(s4_pre_dir, ''inverter_common_parameters.m'')); run(fullfile(s4_pre_dir, ''s4_denetleyici_parametreleri.m'')); ' ...
    'S6_inj_A = [0 0 0]; S6_inj_f = [212.5 525 1037.5]; S6_inj_ph = [0 0 0]; clear s4_pre_dir']);
log{end+1} = ['PreLoadFcn: ' get_param(mdl, 'PreLoadFcn')];
log{end+1} = ['InitFcn (degismedi): ' get_param(mdl, 'InitFcn')];
save_system(mdl);
close_system(mdl, 0);
evalin('base', 'clear all');
load_system(new_file);
try
    set_param(mdl, 'SimulationCommand', 'update');
    log{end+1} = 'derleme (update): basarili';
catch err
    log{end+1} = ['derleme (update) HATA: ' err.message];
end
nb = find_system(mdl, 'SearchDepth', 1, 'Regexp', 'on', 'Name', '^S6 ');
log{end+1} = sprintf('--- eklenen bloklar (%d) ---', numel(nb));
log = [log, cellfun(@(s) strrep(s, newline, ' '), nb.', 'UniformOutput', false)];
close_system(mdl, 0);
log{end+1} = sprintf('model SHA-256: %s', file_hash(new_file));
for k = 2:numel(kopyalar)
    dk = fullfile(run_dir, kopyalar{k});
    if ~exist(dk, 'dir'), mkdir(dk); end
    for f = {[mdl '.slx'], 'inverter_common_parameters.m', 's4_denetleyici_parametreleri.m'}
        copyfile(fullfile(d1, f{1}), fullfile(dk, f{1}), 'f');
    end
    log{end+1} = sprintf('kopya: %s', dk); %#ok<AGROW>
end
fid = fopen(fullfile(ins_dir, 'build_enjeksiyon_denetim.txt'), 'w', 'n', 'UTF-8');
fprintf(fid, '%s\n', log{:}); fclose(fid);
fprintf('%s\n', log{:});
end

function name_log(mdl, blk, port, nm)
ph = get_param([mdl '/' blk], 'PortHandles');
set_param(ph.Outport(port), 'Name', nm, 'DataLogging', 'on', 'DataLoggingNameMode', 'SignalName');
end

function h = file_hash(f)
md = java.security.MessageDigest.getInstance('SHA-256');
fid = fopen(f, 'r'); b = fread(fid, inf, '*uint8'); fclose(fid);
md.update(b);
h = lower(reshape(dec2hex(typecast(md.digest(), 'uint8')).', 1, []));
end
