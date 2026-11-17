%% analyze_s4_sign_flips_20261117.m
% Ilk tezin 3.7.2 savi (dusuk akimda akim denetleyicisinin duzeltmesi karsi anahtar
% grubunu devreye sokar) icin S4 kapali cevrim kayitlarinda salt okunur sayim.
% Kaynak: runs/2026-10-28_s4_kapali_cevrim/results/<kosu>/dalga.mat (yeni benzetim yok).
% Yari periyot gostergesi kappa = (u_top >= 0) (Bolum 4, eq:susturma-etkinlestirme).
% Son temel periyotta (20 ms):
%   - u_top ve u_ff isaret degisimi sayisi,
%   - sgn(u_top) ~= sgn(i_ref) olan "ters kappa" araliklari: sayi, toplam sure orani,
%     anahtarlama periyodundan (100 us) uzun olanlarin sayisi,
%   - ters kappa araliginda L1 akiminin referansa ters yondeki yuku (A*us).
% Cikti: results/s4_isaret_degisimi_20261117/isaret_degisimi.csv
root_dir = fileparts(fileparts(mfilename('fullpath')));
kok = fullfile(root_dir, 'runs', '2026-10-28_s4_kapali_cevrim', 'results');
out_dir = fullfile(root_dir, 'results', 's4_isaret_degisimi_20261117');
if ~exist(out_dir, 'dir'), mkdir(out_dir); end
kosular = {'KC_P_2p3A','KC_PI_2p3A','KC_P_10A','KC_PI_10A','KC_P_25A','KC_PI_25A'};
Ts = 1e-4; T0 = 0.02;
satir = {};
for k = 1:numel(kosular)
    S = load(fullfile(kok, kosular{k}, 'dalga.mat'), 'dalga'); d = S.dalga;
    if k == 1, disp(fieldnames(d)'); end
    tt = d.t(:); m = tt >= tt(end) - T0; t = tt(m);
    u = d.u_top(m); u = u(:); uf = d.u_ff(m); uf = uf(:); ir = d.i_ref(m); ir = ir(:);
    su = sign(u); su(su == 0) = 1; sf = sign(uf); sf(sf == 0) = 1;
    sr = sign(ir); sr(sr == 0) = 1;
    nu = sum(diff(su) ~= 0); nff = sum(diff(sf) ~= 0);
    dt = [diff(t); median(diff(t))];
    ters = su ~= sr;
    % ters araliklar
    kenar = diff([0; ters; 0]); bas = find(kenar == 1); son = find(kenar == -1) - 1;
    sure = arrayfun(@(a, b) sum(dt(a:b)), bas, son);
    n_ters = numel(bas); n_uzun = sum(sure > Ts);
    oran = 100 * sum(dt(ters)) / sum(dt);
    % L1 akimi alani
    if isfield(d, 'iL1')
        il = d.iL1(m); il = il(:);
    elseif isfield(d, 'i_L1')
        il = d.i_L1(m); il = il(:);
    else
        il = nan(size(u));
    end
    qrev = sum(max(-il .* sr, 0) .* dt) * 1e6;            % tum periyot, A*us
    qrev_ters = sum(max(-il(ters) .* sr(ters), 0) .* dt(ters)) * 1e6;
    fprintf('%-11s flip(u)=%3d flip(uff)=%d ters_aralik=%3d (>Ts: %3d) ters_sure=%.2f%% Qrev=%.1f A*us (ters kappa icinde %.1f)\n', ...
        kosular{k}, nu, nff, n_ters, n_uzun, oran, qrev, qrev_ters);
    satir(end+1, :) = {kosular{k}, nu, nff, n_ters, n_uzun, oran, qrev, qrev_ters}; %#ok<AGROW>
end
T = cell2table(satir, 'VariableNames', {'kosu','isaret_degisimi_u','isaret_degisimi_uff', ...
    'ters_kappa_aralik','ters_kappa_aralik_Ts_ustu','ters_kappa_sure_pct','Qrev_Aus','Qrev_ters_kappa_Aus'});
writetable(T, fullfile(out_dir, 'isaret_degisimi.csv'));
