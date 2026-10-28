function M = run_s4_closed_loop_20261028(case_name, mode, I_ref, stop_time, opts)
% İP-5: S4 kapalı çevrim modelini (inverter_senaryo4_kc) bir çalışma noktasında
% koşturur ve metrikleri çıkarır. Model dosyası kaydedilmez; kazançlar ve referans
% taban çalışma alanından verilir.
%   case_name : sonuç klasörü adı (runs/2026-10-28_s4_kapali_cevrim/results/<case_name>/)
%   mode      : 'P' (Kp = 0.03, 12.10 tarifi) | 'PI' | 'PIR' | 'OL' (u_fb = 0, ileri besleme yalnız)
%   I_ref     : [A RMS] referans; basamak için [I_once, I_sonra]
%   stop_time : [s] benzetim süresi; kararlı durum penceresi son 20 ms
%   opts      : struct — t_step (basamak anı, varsayılan 1e3), sim_mode ('accelerator'),
%               simscape (true: cihaz akımı/kaybı için yerel Simscape kaydı), hist (adım sayısı),
%               Cdc ([F] her DC bara kapasitörü; boş: m-dosyası değeri 470 µF; D-11),
%               ust (struct: taban çalışma alanı değişkenlerinin üzerine yazılacak değerler,
%                    ör. kalibre K14/K34/phase_deg4),
%               model_kopya (paralel koşu için model klasörü adı, ör. 'model_b'; yoksa
%                    model/ klasöründen slx + iki m-dosyası kopyalanır)
% Not (28.10.2026): modelin InitFcn'i sim() başında inverter_common_parameters.m'yi
% yeniden çalıştırır. Bu yüzden Cdc/ust değerleri yalnız taban çalışma alanına
% yazılırsa ezilir; bellekteki modelin InitFcn'ine sona eklenir (model kaydedilmez).
% Çağrı (proje kökünden):
%   matlab -batch "addpath('scripts'); run_s4_closed_loop_20261028('P_25A', 'P', 25, 0.06)"
if nargin < 5, opts = struct(); end
opts = defaults(opts, struct('t_step', 1e3, 'sim_mode', 'accelerator', 'simscape', true, 'hist', 1.5e6, 'Cdc', [], 'ust', struct(), 'model_kopya', ''));
root_dir = fileparts(fileparts(mfilename('fullpath')));
run_dir = fullfile(root_dir, 'runs', '2026-10-28_s4_kapali_cevrim');
model_dir = fullfile(run_dir, 'model');
if ~isempty(opts.model_kopya)
    src_dir = model_dir; model_dir = fullfile(run_dir, opts.model_kopya);
    if ~exist(model_dir, 'dir')
        mkdir(model_dir);
        for f = {'inverter_senaryo4_kc.slx', 'inverter_common_parameters.m', 's4_denetleyici_parametreleri.m'}
            copyfile(fullfile(src_dir, f{1}), fullfile(model_dir, f{1}));
        end
    end
end
out_dir = fullfile(run_dir, 'results', case_name);
if ~exist(out_dir, 'dir'), mkdir(out_dir); end
mdl = 'inverter_senaryo4_kc';
cd(model_dir);
evalin('base', sprintf('run(''%s''); run(''%s'');', fullfile(model_dir, 'inverter_common_parameters.m'), ...
    fullfile(model_dir, 's4_denetleyici_parametreleri.m')));
% D-11: 25 A'da 2 x 470 µF orta noktası ~±120 V salınır; anma akımı koşularında
% kapasitörler yalnız bu koşu için büyütülür (m-dosyası aynı).
ust = opts.ust;
if ~isempty(opts.Cdc), ust.Cdc_pos = opts.Cdc; ust.Cdc_neg = opts.Cdc; end
load_system(mdl);
fn = fieldnames(ust); ek = '';
for k = 1:numel(fn)
    assignin('base', fn{k}, ust.(fn{k}));
    ek = [ek sprintf(' %s = %.10g;', fn{k}, ust.(fn{k}))]; %#ok<AGROW>
end
if ~isempty(ek), set_param(mdl, 'InitFcn', [get_param(mdl, 'InitFcn') newline ek]); end
P = evalin('base', 'struct(''Kp'', Kp, ''fz'', S4_PI_fz, ''Kr'', S4_PIR_Kr, ''f_grid'', f_grid, ''Ts'', pwm_ref_Ts)');
switch upper(mode)
    case 'OL',  g = [0, 0, 0, 0];
    case 'P',   g = [P.Kp, 0, 0, 0];
    case 'PI',  g = [P.Kp, P.Kp*2*pi*P.fz, 2*pi*P.fz, 0];
    case 'PIR', g = [P.Kp, P.Kp*2*pi*P.fz, 2*pi*P.fz, P.Kr];
    otherwise, error('kip: %s', mode);
end
if isscalar(I_ref), I_ref = [I_ref, I_ref]; end
assignin('base', 'S4_Kp_c', g(1)); assignin('base', 'S4_Ki_c', g(2));
assignin('base', 'S4_Kaw', g(3));  assignin('base', 'S4_Kr', g(4));
assignin('base', 'S4_Iref', I_ref(1)); assignin('base', 'S4_Iref_step', I_ref(2));
assignin('base', 'S4_t_step', opts.t_step);

% Display kaynakları: yalnız son birkaç nokta (çapraz denetim)
disp_blocks = find_system(mdl, 'SearchDepth', 1, 'BlockType', 'Display');
dmap = {};
for k = 1:numel(disp_blocks)
    ph = get_param(disp_blocks{k}, 'PortHandles');
    ln = get_param(ph.Inport, 'Line'); if ln < 0, continue, end
    src = get_param(ln, 'SrcPortHandle');
    nm = ['D_' ascii_name(get_param(disp_blocks{k}, 'Name'))];
    set_param(src, 'DataLogging', 'on', 'DataLoggingNameMode', 'Custom', 'DataLoggingName', nm, ...
        'DataLoggingLimitDataPoints', 'on', 'DataLoggingMaxPoints', '3');
    dmap(end+1, :) = {nm, strrep(get_param(disp_blocks{k}, 'Name'), newline, ' ')}; %#ok<AGROW>
end
dev = {};
if opts.simscape
    dev = find_system(mdl, 'SearchDepth', 1, 'BlockType', 'SimscapeBlock');
    dev = dev(contains(get_param(dev, 'SourceFile'), {'igbt', 'diode', 'inductor', 'resistor'}));
    logtype = 'local';
    try
        for k = 1:numel(dev), set_param(dev{k}, 'LogSimulationData', 'on'); end
    catch err
        fprintf('LogSimulationData ayarlanamadi (%s); SimscapeLogType = all\n', err.message);
        logtype = 'all';
    end
    set_param(mdl, 'SimscapeLogType', logtype, 'SimscapeLogName', 'simlog', 'SimscapeLogLimitData', 'on', ...
        'SimscapeLogDataHistory', opts.hist, 'SimscapeLogDecimation', 1);
else
    set_param(mdl, 'SimscapeLogType', 'none');
end
set_param(mdl, 'StopTime', num2str(stop_time, 10));
info = sprintf('model: %s\nmatlab: %s\nbaslangic: %s\nkip: %s\nkazanc [Kp Ki Kaw Kr]: %s\nI_ref [A RMS]: %s\nt_step: %g\nStopTime: %g\nmod: %s\nmodel klasoru: %s\nInitFcn eki:%s\n', ...
    mdl, version, char(datetime('now')), mode, mat2str(g, 6), mat2str(I_ref), opts.t_step, stop_time, opts.sim_mode, ...
    model_dir, ek);
fprintf('%s', info);
wall = tic;
out = sim(mdl, 'SimulationMode', opts.sim_mode);
wall_s = toc(wall);
Cdc_kullanilan = evalin('base', '[Cdc_pos Cdc_neg]');   % InitFcn sonrası etkin değerler
ff_kullanilan = evalin('base', '[K14 K34 phase_deg4]');
info = [info sprintf('duvar_suresi_s: %.1f\netkin Cdc_pos/Cdc_neg [F]: %s\netkin K14 K34 phase_deg4: %s\n', ...
    wall_s, mat2str(Cdc_kullanilan, 4), mat2str(ff_kullanilan, 6))];

% ---- sinyaller --------------------------------------------------------------------
L = out.logsout;
names = {'i_ref', 'iL1_olcum', 'u_fb', 'u_top', 'u_mod', 'u_ff', 'aw_asim', 'iL1_1us', 'i_ac_1us', ...
    'v_ac_1us', 'v_dc_1us', 'i_dc_1us', 'v_inv_1us'};
S = struct();
for k = 1:numel(names)
    el = L.getElement(names{k});
    if iscell(el) || isa(el, 'Simulink.SimulationData.Dataset'), el = el{1}; end
    S.(names{k}) = el.Values;
end
t = S.iL1_1us.Time;  % 1 µs ızgara
Ts = median(diff(t));
rs = @(x) interp1(x.Time, squeeze(x.Data), t, 'previous', 'extrap');
x = struct();
for k = 1:numel(names), x.(names{k}) = rs(S.(names{k})); end
x.iL1_avg = movmean(x.iL1_1us, round(1/10e3/Ts));   % merkezli periyot ortalaması (son işlem)
t_end = t(end); Tg = 1/P.f_grid;
w_ss = t >= t_end - Tg - Ts/2 & t < t_end - Ts/2;   % son tam periyot
w_pr = t >= t_end - 2*Tg - Ts/2 & t < t_end - Tg - Ts/2;
M = metrics(t, x, w_ss, P.f_grid);
Mp = metrics(t, x, w_pr, P.f_grid);
M.case = string(case_name); M.mode = string(mode); M.I_ref_rms = I_ref(2);
M.Kp = g(1); M.Ki = g(2); M.Kaw = g(3); M.Kr = g(4);
M.wall_s = wall_s; M.stop_time = stop_time; M.Cdc_F = Cdc_kullanilan(1);
M.K14 = ff_kullanilan(1); M.K34 = ff_kullanilan(2); M.phase_deg4 = ff_kullanilan(3);
M.dP_ac_onceki_periyot_pct = 100*(M.P_ac_W - Mp.P_ac_W)/M.P_ac_W;
M.dIL1_onceki_periyot_pct = 100*(M.IL1_1_rms_A - Mp.IL1_1_rms_A)/M.IL1_1_rms_A;
t_skip = 5e-3;   % ilk 5 ms başlangıç geçişi
M.u_top_max_tum = max(abs(x.u_top(t > t_skip)));
M.doyum_orani_tum_pct = 100*mean(abs(x.u_top(t > t_skip)) > 1);
M.iL1_max_tum_A = max(abs(x.iL1_1us));

% Display son değerleri
for k = 1:size(dmap, 1)
    try
        el = L.getElement(dmap{k, 1}); if iscell(el), el = el{1}; end
        v = squeeze(el.Values.Data); M.(dmap{k, 1}) = v(end);
    catch
    end
end

% basamak metrikleri
if opts.t_step < stop_time
    M = step_metrics(M, t, x, opts.t_step, I_ref, Tg);
end

% ---- Simscape: cihaz akımları ve kayıplar ----------------------------------------------
if opts.simscape && any(strcmp(out.who, 'simlog'))
  try
    sl = out.simlog;
    rows = {};
    tl0 = NaN; tl1 = NaN;
    for k = 1:numel(dev)
        nm = get_param(dev{k}, 'Name');
        if ~contains(get_param(dev{k}, 'SourceFile'), {'igbt', 'diode'}), continue, end
        node = sl.(regexprep(strrep(nm, newline, ' '), '[^A-Za-z0-9]', '_'));
        ids = node.childIds;
        cand = intersect({'iCE', 'i', 'ic', 'i_C', 'iC'}, ids, 'stable');
        if isempty(cand), rows(end+1, :) = {nm, strjoin(ids, ','), NaN, NaN, NaN, NaN}; continue, end %#ok<AGROW>
        sr = node.(cand{1}).series; ti = sr.time; iv = sr.values('A');
        ww = ti >= t_end - Tg;
        tl0 = ti(1); tl1 = ti(end);
        rows(end+1, :) = {nm, cand{1}, max(iv(ww)), min(iv(ww)), ...
            sqrt(trapz(ti(ww), iv(ww).^2)/(ti(find(ww, 1, 'last')) - ti(find(ww, 1)))), max(abs(iv))}; %#ok<AGROW>
    end
    Tdev = cell2table(rows, 'VariableNames', {'blok', 'degisken', 'i_max_son_periyot_A', ...
        'i_min_son_periyot_A', 'i_rms_son_periyot_A', 'abs_i_max_kayit_A'});
    writetable(Tdev, fullfile(out_dir, 'cihaz_akimlari.csv'), 'Encoding', 'UTF-8');
    info = [info sprintf('simscape_kayit_penceresi_s: %.6f - %.6f\n', tl0, tl1)];
    try
        TL = ee_getPowerLossSummary(sl, max(t_end - Tg, tl0), t_end);
        TL.Total = TL.Power + TL.SwitchingLosses; TL.LoggingNode = string(TL.LoggingNode);
        writetable(TL, fullfile(out_dir, 'kayip_ozeti.csv'), 'Encoding', 'UTF-8');
        M.kayip_toplam_simscape_W = sum(TL.Total);
        isg = contains(TL.LoggingNode, 'IGBT'); isd = contains(TL.LoggingNode, 'Diode') & ~contains(TL.LoggingNode, 'Blocking');
        M.kayip_IGBT_W = sum(TL.Total(isg)); M.kayip_diyot_W = sum(TL.Total(isd));
        M.kayip_L1Rp_W = sum(TL.Total(contains(TL.LoggingNode, 'L1_Core_Loss_Rp')));
    catch err
        info = [info 'ee_getPowerLossSummary hata: ' err.message newline];
    end
    sg = startsWith(Tdev.blok, 'N-Channel IGBT');
    M.IGBT_tepe_A = max(Tdev.i_max_son_periyot_A(sg));
    sd = ~sg & ~contains(Tdev.blok, 'Blocking');   % T-tipi kol diyotları (DA blokaj diyotu hariç)
    M.diyot_tepe_A = max(Tdev.i_max_son_periyot_A(sd));
    M.IGBT_tepe_tum_A = max(Tdev.abs_i_max_kayit_A(sg));
    if tl1 - max(t_end - Tg, tl0) < Tg - 1e-6
        info = [info sprintf('UYARI: Simscape kaydi son periyodu kapsamiyor (%.2f ms)\n', 1e3*(tl1 - tl0))];
    end
  catch err
    info = [info 'Simscape cikarim hatasi: ' getReport(err, 'basic', 'hyperlinks', 'off') newline];
    fprintf('%s\n', err.message);
  end
end

% ---- yazım ---------------------------------------------------------------------------
writetable(struct2table(M, 'AsArray', true), fullfile(out_dir, 'metrik.csv'), 'Encoding', 'UTF-8');
dec = max(1, round(10e-6/Ts));
ww = t >= t_end - 2*Tg;
dalga = struct('t', t(ww), 'i_ref', x.i_ref(ww), 'iL1', x.iL1_1us(ww), 'iL1_avg', x.iL1_avg(ww), ...
    'iL1_olcum', x.iL1_olcum(ww), 'i_ac', x.i_ac_1us(ww), 'v_ac', x.v_ac_1us(ww), 'u_top', x.u_top(ww), ...
    'u_ff', x.u_ff(ww), 'u_fb', x.u_fb(ww), 'v_inv', x.v_inv_1us(ww));
tum = struct('t', t(1:dec:end), 'i_ref', x.i_ref(1:dec:end), 'iL1_avg', x.iL1_avg(1:dec:end), ...
    'i_ac', x.i_ac_1us(1:dec:end), 'u_top', x.u_top(1:dec:end), 'u_fb', x.u_fb(1:dec:end), ...
    'v_dc', x.v_dc_1us(1:dec:end));
save(fullfile(out_dir, 'dalga.mat'), 'dalga', 'tum', 'M');
fid = fopen(fullfile(out_dir, 'kosu_bilgisi.txt'), 'w', 'n', 'UTF-8');
fprintf(fid, '%s', info); fclose(fid);
close_system(mdl, 0);
disp(struct2table(M, 'AsArray', true));
fprintf('%s: tamamlandi (%.1f s)\n', case_name, wall_s);
end

% ======================================================================================
function M = metrics(t, x, w, fg)
tw = t(w);
ph = @(s) fourier1(tw, s(w), fg);
[Iref1, aref] = ph(x.i_ref); [IL11, aL1] = ph(x.iL1_1us); [Iac1, aac] = ph(x.i_ac_1us);
[Vac1, avac] = ph(x.v_ac_1us);
M.Iref_1_rms_A = Iref1/sqrt(2);
M.IL1_rms_A = rms(x.iL1_1us(w));
M.IL1_1_rms_A = IL11/sqrt(2);
M.izleme_genlik_hatasi_pct = 100*(IL11/Iref1 - 1);
M.izleme_faz_hatasi_deg = wrap180((aL1 - aref)*180/pi);
M.izleme_hatasi_rms_pct = 100*rms(x.i_ref(w) - x.iL1_avg(w))/rms(x.i_ref(w));
M.iL1_faz_sebekeye_gore_deg = wrap180((aL1 - avac)*180/pi);
M.Iac_rms_A = rms(x.i_ac_1us(w));
M.Iac_1_rms_A = Iac1/sqrt(2);
M.Vac_rms_V = rms(x.v_ac_1us(w));
M.THD_I_ac_tumbant_pct = 100*sqrt(max(M.Iac_rms_A^2 - M.Iac_1_rms_A^2, 0))/M.Iac_1_rms_A;
M.THD_I_ac_h50_pct = 100*thd_h(tw, x.i_ac_1us(w), fg, 50);
M.THD_I_L1_h50_pct = 100*thd_h(tw, x.iL1_1us(w), fg, 50);
[I3, ~] = fourier_h(tw, x.i_ac_1us(w), fg, 3);
M.I_ac_h3_pct = 100*I3/Iac1;
M.P_ac_W = mean(x.v_ac_1us(w).*x.i_ac_1us(w));
M.P_dc_W = mean(x.v_dc_1us(w).*x.i_dc_1us(w));
M.verim_pct = 100*M.P_ac_W/M.P_dc_W;
phi = avac - aac;   % akım gerilimin gerisinde: phi > 0 -> Q > 0 (üretici kuralı, D-06)
M.Q1_var = (Vac1/sqrt(2))*(Iac1/sqrt(2))*sin(phi);
M.cosphi1 = cos(phi);
M.PF = M.P_ac_W/(M.Vac_rms_V*M.Iac_rms_A);
M.Vdc_ort_V = mean(x.v_dc_1us(w));
M.u_top_max = max(abs(x.u_top(w)));
M.u_fb_rms = rms(x.u_fb(w));
M.u_ff_max = max(abs(x.u_ff(w)));
M.doyum_orani_pct = 100*mean(abs(x.u_top(w)) > 1);
M.iL1_tepe_A = max(abs(x.iL1_1us(w)));
end

function M = step_metrics(M, t, x, ts, I_ref, Tg)
Ipk = sqrt(2)*I_ref(2);
a = t >= ts & t <= ts + Tg;
M.basamak_t_s = ts;
M.asim_pct = 100*(max(abs(x.iL1_avg(a))) - Ipk)/Ipk;
e = x.i_ref - x.iL1_avg;
wl = t >= t(end) - Tg;
band = max(abs(e(wl))) + 0.02*Ipk;
k = find(t >= ts & abs(e) > band, 1, 'last');
if isempty(k), M.yerlesme_hata_ms = 0; else, M.yerlesme_hata_ms = 1e3*(t(k) - ts); end
% yarım periyot tepe zarfı: son tepe ±%2
nh = floor((t(end) - ts)/(Tg/2));
pk = nan(nh, 1); tp = nan(nh, 1);
for q = 1:nh
    b = t >= ts + (q - 1)*Tg/2 & t < ts + q*Tg/2;
    [pk(q), i] = max(abs(x.iL1_avg(b))); tb = t(b); tp(q) = tb(i);
end
fin = pk(end);
q = find(abs(pk - fin) > 0.02*fin, 1, 'last');
if isempty(q), M.yerlesme_zarf_ms = 0; else, M.yerlesme_zarf_ms = 1e3*(tp(min(q + 1, nh)) - ts); end
M.zarf_tepeleri_A = string(mat2str(pk.', 4));
M.basamak_oncesi_IL1_1_rms_A = NaN;
b = t >= ts - Tg & t < ts;
[A, ~] = fourier1(t(b), x.iL1_1us(b), 1/Tg); M.basamak_oncesi_IL1_1_rms_A = A/sqrt(2);
end

function [A, ph] = fourier1(t, s, f)
[A, ph] = fourier_h(t, s, f, 1);
end

function [A, ph] = fourier_h(t, s, f, h)
w = 2*pi*f*h;
a = 2*mean(s(:).*sin(w*t(:))); b = 2*mean(s(:).*cos(w*t(:)));
A = hypot(a, b); ph = atan2(b, a);   % s ≈ A sin(wt + ph)
end

function r = thd_h(t, s, f, H)
[A1, ~] = fourier_h(t, s, f, 1);
acc = 0;
for h = 2:H, [Ah, ~] = fourier_h(t, s, f, h); acc = acc + Ah^2; end
r = sqrt(acc)/A1;
end

function d = wrap180(d)
d = mod(d + 180, 360) - 180;
end

function o = defaults(o, d)
f = fieldnames(d);
for k = 1:numel(f), if ~isfield(o, f{k}), o.(f{k}) = d.(f{k}); end, end
end

function s = ascii_name(s)
s = strrep(s, newline, ' ');
s = strrep(strrep(strrep(s, 'ü', 'u'), 'ı', 'i'), 'ç', 'c');
s = strrep(strrep(strrep(s, 'Ü', 'U'), 'ğ', 'g'), 'ş', 's');
s = regexprep(s, '[^A-Za-z0-9]+', '_');
end
