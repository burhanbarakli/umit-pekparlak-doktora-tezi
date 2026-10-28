function R = run_enjeksiyon_kararlilik_20261028(case_name, mode, I_ref, stop_time, opts)
% İP-6 (K-07, katman 3): anahtarlamalı S4 ölçüm kopyasını (inverter_senaryo4_enj)
% çok tonlu enjeksiyonla koşturur ve ton frekanslarında L, S, T, P, C'yi çıkarır.
% Kesin ayarlar KC_* ile aynıdır (K-20 + D-11): K14 = 0.44343, K34 = 0.384306,
% phase_deg4 = 0.6575°, Cdc_pos = Cdc_neg = 5,6 mF. Bu değerler (ve K34 = 0 gibi
% değişiklikler) bellekteki modelin InitFcn'inin SONUNA eklenir; InitFcn
% inverter_common_parameters.m'yi yeniden çalıştırdığı için taban çalışma alanına
% yazmak yetmez (İP-5 tuzağı). Etkin değerler kosu_bilgisi.txt'ye yazılır.
%   case_name : runs/2026-10-28_kararlilik/results/<case_name>/
%   mode      : 'P' | 'PI' | 'PIR'
%   I_ref     : [A RMS]; basamak için [I_once I_sonra]
%   stop_time : [s]
%   opts      : tonlar [Hz] (12,5 Hz ızgarası; varsayılan [212.5 525 1037.5]),
%               A (ton genliği, görev oranı birimi; varsayılan 0.015), ust (struct,
%               InitFcn sonuna eklenecek ek değerler, ör. K34 = 0), model_kopya
%               ('model_a' ...), pencere [t0 t1] (varsayılan [stop_time-0.08, stop_time]),
%               t_step (basamak anı; varsayılan 1e3 = yok)
% Ton seçimi: pencere 80 ms -> 12,5 Hz ızgara; tonlar 50 Hz harmoniklerine (n ≡ 0 mod 4)
% ve birbirlerinin 100 Hz dönüşümlerine (n_i ≡ ±n_j mod 8) düşmeyecek şekilde
% n = f/12,5 sınıflarından {1,7}, {2,6}, {3,5}'ten birer tane seçilir.
% Çağrı (proje kökünden):
%   matlab -batch "addpath('scripts'); run_enjeksiyon_kararlilik_20261028('PI25_K34_A', 'PI', 25, 0.11, struct('model_kopya','model_a'))"
if nargin < 5, opts = struct(); end
kc = struct('K14', 0.44343, 'K34', 0.384306, 'phase_deg4', 0.6575, 'Cdc_pos', 5.6e-3, 'Cdc_neg', 5.6e-3);
opts = defaults(opts, struct('tonlar', [212.5 525 1037.5], 'A', 0.015, 'ust', struct(), ...
    'model_kopya', 'model_a', 'pencere', [], 't_step', 1e3, 'sim_mode', 'accelerator'));
if isempty(opts.pencere), opts.pencere = [stop_time - 0.08, stop_time]; end
fu = fieldnames(opts.ust);
for k = 1:numel(fu), kc.(fu{k}) = opts.ust.(fu{k}); end
root_dir = fileparts(fileparts(mfilename('fullpath')));
run_dir = fullfile(root_dir, 'runs', '2026-10-28_kararlilik');
model_dir = fullfile(run_dir, opts.model_kopya);
out_dir = fullfile(run_dir, 'results', case_name);
if ~exist(out_dir, 'dir'), mkdir(out_dir); end
mdl = 'inverter_senaryo4_enj';
cd(model_dir);
evalin('base', sprintf('run(''%s''); run(''%s'');', fullfile(model_dir, 'inverter_common_parameters.m'), ...
    fullfile(model_dir, 's4_denetleyici_parametreleri.m')));
load_system(mdl);
fn = fieldnames(kc); ek = '';
for k = 1:numel(fn)
    assignin('base', fn{k}, kc.(fn{k}));
    ek = [ek sprintf(' %s = %.10g;', fn{k}, kc.(fn{k}))]; %#ok<AGROW>
end
set_param(mdl, 'InitFcn', [get_param(mdl, 'InitFcn') newline ek]);
P = evalin('base', 'struct(''Kp'', Kp, ''fz'', S4_PI_fz, ''Kr'', S4_PIR_Kr, ''f_grid'', f_grid, ''Ts'', pwm_ref_Ts, ''Vdc4'', Vdc4)');
switch upper(mode)
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
nt = numel(opts.tonlar);
Avec = opts.A .* ones(1, nt);
ph = pi*(0:nt-1).^2/nt;                       % Schroeder fazları (tepe/rms düşük)
assignin('base', 'S6_inj_A', Avec); assignin('base', 'S6_inj_f', opts.tonlar(:).');
assignin('base', 'S6_inj_ph', ph);
set_param(mdl, 'SimscapeLogType', 'none');
set_param(mdl, 'StopTime', num2str(stop_time, 10));
info = sprintf(['model: %s\nmatlab: %s\nbaslangic: %s\nkip: %s\nkazanc [Kp Ki Kaw Kr]: %s\nI_ref [A RMS]: %s\n' ...
    't_step: %g\nStopTime: %g\nmod: %s\nmodel klasoru: %s\nInitFcn eki:%s\ntonlar [Hz]: %s\nton genligi: %s\n' ...
    'ton fazi [rad]: %s\npencere [s]: %s\n'], mdl, version, char(datetime('now')), mode, mat2str(g, 6), ...
    mat2str(I_ref), opts.t_step, stop_time, opts.sim_mode, model_dir, ek, mat2str(opts.tonlar), ...
    mat2str(Avec, 4), mat2str(ph, 4), mat2str(opts.pencere));
fprintf('%s', info);
wall = tic;
out = sim(mdl, 'SimulationMode', opts.sim_mode);
wall_s = toc(wall);
etkin = evalin('base', '[K14 K34 phase_deg4 Cdc_pos Cdc_neg]');
etkin_inj = evalin('base', 'S6_inj_A');
info = [info sprintf('duvar_suresi_s: %.1f\netkin K14 K34 phase_deg4 Cdc_pos Cdc_neg: %s\netkin S6_inj_A: %s\n', ...
    wall_s, mat2str(etkin, 6), mat2str(etkin_inj, 4))];

L = out.logsout;
names = {'i_ref', 'iL1_olcum', 'u_fb', 'u_x', 'd_inj', 'u_top', 'u_ff', 'iL1_1us', 'i_ac_1us', 'v_ac_1us', 'v_dc_1us', 'v_inv_1us'};
S = struct();
for k = 1:numel(names)
    el = L.getElement(names{k});
    if iscell(el) || isa(el, 'Simulink.SimulationData.Dataset'), el = el{1}; end
    S.(names{k}) = el.Values;
end
t = S.iL1_1us.Time; Ts = median(diff(t));
rs = @(x) interp1(x.Time, squeeze(x.Data), t, 'previous', 'extrap');
x = struct();
for k = 1:numel(names), x.(names{k}) = rs(S.(names{k})); end
x.iL1_avg = movmean(x.iL1_1us, round(1/10e3/Ts));
w = t >= opts.pencere(1) - Ts/2 & t < opts.pencere(2) - Ts/2;
tw = t(w);
ph1 = @(s, f) 2*mean(s(w).*exp(-1j*2*pi*f*tw));     % karmaşık genlik (tepe)
rows = cell(nt, 1);
Kpwm = P.Vdc4/2;
for q = 1:nt
    f = opts.tonlar(q);
    D = ph1(x.d_inj, f); UX = ph1(x.u_x, f); UFB = ph1(x.u_fb, f); YM = ph1(x.iL1_olcum, f);
    IL = ph1(x.iL1_1us, f); IR = ph1(x.i_ref, f); VI = ph1(x.v_inv_1us, f);
    Lm = -UFB/UX; Sm = UX/D; Tm = -UFB/D; Pm = YM/UX; Cm = -UFB/(YM - IR); Gm = IL/(Kpwm*UX);
    Gv = IL/VI;                                     % köprü çıkış gerilimine göre i_L1/v_inv
    Kef = VI/UX;                                    % etkin köprü kazancı [V / görev oranı]
    rows{q} = {f, abs(D), abs(UX), abs(UFB), abs(YM), abs(IL), abs(IR), ...
        20*log10(abs(Lm)), angle(Lm)*180/pi, 20*log10(abs(Sm)), angle(Sm)*180/pi, 20*log10(abs(Tm)), angle(Tm)*180/pi, ...
        20*log10(abs(Pm)), angle(Pm)*180/pi, abs(Cm), angle(Cm)*180/pi, 20*log10(abs(Gm)), angle(Gm)*180/pi, ...
        20*log10(abs(Gv)), angle(Gv)*180/pi, abs(Kef), angle(Kef)*180/pi, real(Lm), imag(Lm), real(Pm), imag(Pm), real(Gv), imag(Gv)};
end
T = cell2table(vertcat(rows{:}), 'VariableNames', {'f_Hz', 'D', 'UX', 'UFB', 'YM_A', 'IL1_A', 'IREF_A', ...
    'L_dB', 'L_deg', 'S_dB', 'S_deg', 'T_dB', 'T_deg', 'P_dB', 'P_deg', 'C_abs', 'C_deg', 'G_dB', 'G_deg', ...
    'Gv_dB', 'Gv_deg', 'Kef_V', 'Kef_deg', 'L_re', 'L_im', 'P_re', 'P_im', 'Gv_re', 'Gv_im'});
writetable(T, fullfile(out_dir, 'tonlar.csv'));
% arka plan: tonların her birinin ±12,5·k komşu ızgara noktaları (harmonik olmayan)
bg = [];
for q = 1:nt
    for dk = [-3 -1 1 3]
        fb = opts.tonlar(q) + 12.5*dk;
        if mod(round(fb/12.5), 4) == 0 || any(abs(fb - opts.tonlar) < 1), continue, end
        bg(end+1, :) = [opts.tonlar(q), fb, abs(ph1(x.u_fb, fb)), abs(ph1(x.u_x, fb)), abs(ph1(x.iL1_olcum, fb))]; %#ok<AGROW>
    end
end
writetable(array2table(bg, 'VariableNames', {'ton_Hz', 'f_Hz', 'UFB', 'UX', 'YM_A'}), fullfile(out_dir, 'arka_plan.csv'));

% temel bileşen ve bozulma (son 20 ms)
Tg = 1/P.f_grid; t_end = t(end);
w2 = t >= t_end - Tg - Ts/2 & t < t_end - Ts/2;
f1 = @(s, h) 2*mean(s(w2).*exp(-1j*2*pi*P.f_grid*h*t(w2)));
IR1 = f1(x.i_ref, 1); IL11 = f1(x.iL1_1us, 1); IL13 = f1(x.iL1_1us, 3);
M = struct();
M.case = string(case_name); M.mode = string(mode); M.I_ref_rms = I_ref(2);
M.IL1_1_rms_A = abs(IL11)/sqrt(2);
M.izleme_genlik_hatasi_pct = 100*(abs(IL11)/abs(IR1) - 1);
M.izleme_faz_hatasi_deg = angle(IL11/IR1)*180/pi;
M.IL1_3_rms_A = abs(IL13)/sqrt(2);
M.IL1_3_faz_deg = angle(IL13)*180/pi;
acc = 0; for h = 2:50, acc = acc + abs(f1(x.iL1_1us, h))^2; end
M.THD_I_L1_h50_pct = 100*sqrt(acc)/abs(IL11);
M.u_top_max = max(abs(x.u_top(w)));
M.doyum_orani_pct = 100*mean(abs(x.u_top(w)) > 1);
M.u_fb_1_tepe = abs(f1(x.u_fb, 1)); M.u_fb_3_tepe = abs(f1(x.u_fb, 3));
M.u_ff_1_tepe = abs(f1(x.u_ff, 1)); M.u_ff_3_tepe = abs(f1(x.u_ff, 3));
M.Vdc_ort_V = mean(x.v_dc_1us(w2));
M.wall_s = wall_s; M.stop_time = stop_time;
M.K14 = etkin(1); M.K34 = etkin(2); M.phase_deg4 = etkin(3); M.Cdc_F = etkin(4);
if opts.t_step < stop_time
    M = step_metrics(M, t, x, opts.t_step, I_ref, Tg);
end
writetable(struct2table(M, 'AsArray', true), fullfile(out_dir, 'metrik.csv'), 'Encoding', 'UTF-8');
dec = 10;
olcum = struct('t', t(w), 'd_inj', x.d_inj(w), 'u_x', x.u_x(w), 'u_fb', x.u_fb(w), 'iL1_olcum', x.iL1_olcum(w), ...
    'iL1', x.iL1_1us(w), 'i_ref', x.i_ref(w), 'u_top', x.u_top(w), 'v_inv', x.v_inv_1us(w), 'v_dc', x.v_dc_1us(w));
tum = struct('t', t(1:dec:end), 'i_ref', x.i_ref(1:dec:end), 'iL1_avg', x.iL1_avg(1:dec:end), ...
    'u_top', x.u_top(1:dec:end), 'u_fb', x.u_fb(1:dec:end), 'u_ff', x.u_ff(1:dec:end), 'v_dc', x.v_dc_1us(1:dec:end));
save(fullfile(out_dir, 'olcum.mat'), 'olcum', 'tum', 'M', 'T', 'opts', '-v7.3');
fid = fopen(fullfile(out_dir, 'kosu_bilgisi.txt'), 'w', 'n', 'UTF-8');
fprintf(fid, '%s', info); fclose(fid);
close_system(mdl, 0);
disp(T(:, {'f_Hz', 'L_dB', 'L_deg', 'P_dB', 'P_deg', 'C_abs', 'C_deg', 'S_dB'}));
disp(struct2table(M, 'AsArray', true));
R = struct('T', T, 'M', M);
fprintf('%s: tamamlandi (%.1f s)\n', case_name, wall_s);
end

function M = step_metrics(M, t, x, ts, I_ref, Tg)
% run_s4_closed_loop_20261028.m ile aynı tanımlar
Ipk = sqrt(2)*I_ref(2);
a = t >= ts & t <= ts + Tg;
M.basamak_t_s = ts;
M.asim_pct = 100*(max(abs(x.iL1_avg(a))) - Ipk)/Ipk;
e = x.i_ref - x.iL1_avg;
wl = t >= t(end) - Tg;
band = max(abs(e(wl))) + 0.02*Ipk;
k = find(t >= ts & abs(e) > band, 1, 'last');
if isempty(k), M.yerlesme_hata_ms = 0; else, M.yerlesme_hata_ms = 1e3*(t(k) - ts); end
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
end

function o = defaults(o, d)
f = fieldnames(d);
for k = 1:numel(f), if ~isfield(o, f{k}), o.(f{k}) = d.(f{k}); end, end
end
