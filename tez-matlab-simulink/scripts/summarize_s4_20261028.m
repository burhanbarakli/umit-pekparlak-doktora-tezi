% İP-5 özet: results/<case>/metrik.csv dosyalarını s4_tarama.csv'de birleştirir,
% akım izleme (25 A) ve basamak yanıtı şekillerini PNG + FIG olarak yazar.
% Çağrı (proje kökünden): matlab -batch "run('scripts/summarize_s4_20261028.m')"
root_dir = fileparts(fileparts(mfilename('fullpath')));
run_dir = fullfile(root_dir, 'runs', '2026-10-28_s4_kapali_cevrim');
res = fullfile(run_dir, 'results'); fig_dir = fullfile(run_dir, 'sekiller');
if ~exist(fig_dir, 'dir'), mkdir(fig_dir); end
cases = {'P_2p3A', 'P_10A', 'P_25A', 'PI_2p3A', 'PI_10A', 'PI_25A', 'PIR_25A', 'PI_basamak_10_25A'};
T = table();
for k = 1:numel(cases)
    f = fullfile(res, cases{k}, 'metrik.csv');
    if ~isfile(f), continue, end
    r = readtable(f, 'TextType', 'string');
    if isempty(T), T = r; else, T = outerjoin(T, r, 'MergeKeys', true); end
end
% sıra
[~, ord] = ismember(T.case, string(cases)); [~, i] = sort(ord); T = T(i, :);
cols = {'case', 'mode', 'I_ref_rms', 'Kp', 'Ki', 'Kr', 'IL1_1_rms_A', 'izleme_genlik_hatasi_pct', ...
    'izleme_faz_hatasi_deg', 'izleme_hatasi_rms_pct', 'Iac_rms_A', 'Iac_1_rms_A', 'Vac_rms_V', ...
    'THD_I_ac_tumbant_pct', 'THD_I_ac_h50_pct', 'I_ac_h3_pct', 'THD_I_L1_h50_pct', 'P_dc_W', 'P_ac_W', ...
    'verim_pct', 'Q1_var', 'cosphi1', 'PF', 'Vdc_ort_V', 'u_top_max', 'u_ff_max', 'u_fb_rms', ...
    'doyum_orani_pct', 'u_top_max_tum', 'doyum_orani_tum_pct', 'iL1_tepe_A', 'iL1_max_tum_A', ...
    'IGBT_tepe_A', 'diyot_tepe_A', 'kayip_toplam_simscape_W', 'kayip_IGBT_W', 'kayip_diyot_W', ...
    'kayip_L1Rp_W', 'dP_ac_onceki_periyot_pct', 'dIL1_onceki_periyot_pct', 'asim_pct', ...
    'yerlesme_hata_ms', 'yerlesme_zarf_ms', 'basamak_oncesi_IL1_1_rms_A', 'zarf_tepeleri_A', ...
    'D_AC_Akim_THD', 'D_Verim', 'D_AC_Aktif_Guc', 'D_DC_Guc', 'stop_time', 'wall_s'};
cols = cols(ismember(cols, T.Properties.VariableNames));
writetable(T(:, cols), fullfile(run_dir, 's4_tarama.csv'), 'Encoding', 'UTF-8');
disp(T(:, cols));

% --- Şekil 1: 25 A akım izleme (P, PI, varsa PIR), son iki periyot -------------------
c25 = intersect({'P_25A', 'PI_25A', 'PIR_25A'}, cases(cellfun(@(c) isfile(fullfile(res, c, 'dalga.mat')), cases)), 'stable');
if ~isempty(c25)
    fh = figure('Visible', 'off', 'Position', [100 100 1000 280*numel(c25)]);
    tl = tiledlayout(fh, numel(c25), 1, 'TileSpacing', 'compact');
    for k = 1:numel(c25)
        d = load(fullfile(res, c25{k}, 'dalga.mat')); w = d.dalga; tt = 1e3*(w.t - w.t(1));
        ax = nexttile(tl); hold(ax, 'on'); grid(ax, 'on');
        plot(ax, tt, w.iL1, 'Color', [0.75 0.75 0.75], 'DisplayName', 'i_{L1} (anlık)');
        plot(ax, tt, w.iL1_avg, 'b', 'LineWidth', 1.2, 'DisplayName', 'i_{L1} (periyot ortalaması)');
        plot(ax, tt, w.i_ref, 'k--', 'LineWidth', 1.2, 'DisplayName', 'i_{ref}');
        plot(ax, tt, w.i_ac, 'r', 'DisplayName', 'i_{ac} (C noktası)');
        yyaxis(ax, 'right'); plot(ax, tt, w.v_ac, 'Color', [0.2 0.6 0.2], 'DisplayName', 'v_{ac}'); ylabel(ax, 'v_{ac} [V]');
        yyaxis(ax, 'left'); ylabel(ax, 'akım [A]');
        m = d.M;
        title(ax, sprintf('%s: I_{L1,1} = %.2f A (ref %.1f A), genlik hatası %+.2f %%, faz %+.2f°, THD_I = %.1f %%, η = %.2f %%', ...
            strrep(c25{k}, '_', ' '), m.IL1_1_rms_A, m.I_ref_rms, m.izleme_genlik_hatasi_pct, ...
            m.izleme_faz_hatasi_deg, m.THD_I_ac_h50_pct, m.verim_pct), 'FontWeight', 'normal');
        if k == 1, legend(ax, 'Location', 'eastoutside'); end
    end
    xlabel(tl, 't [ms] (son iki şebeke periyodu)');
    exportgraphics(fh, fullfile(fig_dir, 's4_akim_izleme_25A.png'), 'Resolution', 300);
    savefig(fh, fullfile(fig_dir, 's4_akim_izleme_25A.fig'));
end

% --- Şekil 2: basamak yanıtı -------------------------------------------------------
f = fullfile(res, 'PI_basamak_10_25A', 'dalga.mat');
if isfile(f)
    d = load(f); a = d.tum; m = d.M;
    fh = figure('Visible', 'off', 'Position', [100 100 1000 600]);
    tl = tiledlayout(fh, 2, 1, 'TileSpacing', 'compact');
    ax = nexttile(tl); hold(ax, 'on'); grid(ax, 'on');
    plot(ax, 1e3*a.t, a.iL1_avg, 'b', 'DisplayName', 'i_{L1} (periyot ortalaması)');
    plot(ax, 1e3*a.t, a.i_ref, 'k--', 'DisplayName', 'i_{ref}');
    xline(ax, 1e3*m.basamak_t_s, 'm:', 'HandleVisibility', 'off');
    ylabel(ax, 'akım [A]'); legend(ax, 'Location', 'northwest');
    title(ax, sprintf('PI, 10 \\rightarrow 25 A basamak (t = %.1f ms): aşım %.1f %%, yerleşme (hata bandı) %.1f ms, (zarf ±%%2) %.1f ms', ...
        1e3*m.basamak_t_s, m.asim_pct, m.yerlesme_hata_ms, m.yerlesme_zarf_ms), 'FontWeight', 'normal');
    ax = nexttile(tl); hold(ax, 'on'); grid(ax, 'on');
    plot(ax, 1e3*a.t, a.u_top, 'DisplayName', 'u = u_{ff} + u_{fb}');
    plot(ax, 1e3*a.t, a.u_fb, 'DisplayName', 'u_{fb}');
    yline(ax, [-1 1], 'r:', 'HandleVisibility', 'off');
    ylabel(ax, 'modülasyon [-]'); xlabel(ax, 't [ms]'); legend(ax, 'Location', 'northwest');
    exportgraphics(fh, fullfile(fig_dir, 's4_basamak_PI_10_25A.png'), 'Resolution', 300);
    savefig(fh, fullfile(fig_dir, 's4_basamak_PI_10_25A.fig'));
end

% --- Şekil 3: tarama özeti -----------------------------------------------------------
sel = ~contains(T.case, 'basamak');
if any(sel)
    U = T(sel, :);
    fh = figure('Visible', 'off', 'Position', [100 100 1000 330]);
    tl = tiledlayout(fh, 1, 3, 'TileSpacing', 'compact');
    q = {'verim_pct', 'η [%]'; 'THD_I_ac_h50_pct', 'THD_I (h \leq 50) [%]'; 'izleme_genlik_hatasi_pct', 'genlik hatası [%]'};
    for j = 1:3
        ax = nexttile(tl); hold(ax, 'on'); grid(ax, 'on');
        for md = unique(U.mode).'
            r = U(U.mode == md, :);
            plot(ax, r.I_ref_rms, r.(q{j, 1}), '-o', 'DisplayName', md);
        end
        xlabel(ax, 'I_{ref} [A RMS]'); ylabel(ax, q{j, 2});
        if j == 1, legend(ax, 'Location', 'best'); end
    end
    exportgraphics(fh, fullfile(fig_dir, 's4_tarama_ozet.png'), 'Resolution', 300);
    savefig(fh, fullfile(fig_dir, 's4_tarama_ozet.fig'));
end
