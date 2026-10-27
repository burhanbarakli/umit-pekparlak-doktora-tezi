function analyze_s2_gates_20261027(run_name, mdl)
% İP-1: onarılmış S1+S2 koşusunun logsout.mat kaydından S2 kapı işaretlerini
% (g12…g42, PWM alt sistemi çıkışı) son şebeke periyodunda alternans bazında
% özetler ve kapı + AA akım dalga biçimini çizer. Model açılmaz.
% Çağrı (proje kökünden):
%   matlab -batch "addpath('scripts'); analyze_s2_gates_20261027"
% Çıktı: runs/<run_name>/results/<mdl>/s2_kapi_ozeti.csv, s2_kapi_dalga.png
if nargin < 1 || isempty(run_name), run_name = '2026-10-27_s2_kapi_onarimi'; end
if nargin < 2 || isempty(mdl), mdl = 'inverter_s1s2_s2onarim'; end
root_dir = fileparts(fileparts(mfilename('fullpath')));
res_dir = fullfile(root_dir, 'runs', run_name, 'results', mdl);
S = load(fullfile(res_dir, 'logsout.mat'), 'logs');
L = S.logs;
names = arrayfun(@(k) L.getElement(k).Name, 1:L.numElements, 'UniformOutput', false);

tags = {'g12_S2', 'g22_S2', 'g32_S2', 'g42_S2'};
t_end = L.getElement(tags{1}).Values.Time(end);
% phase_deg2 = 0: referans 50 Hz sinüs; son periyot [t_end-0.02, t_end]
win = {'pozitif', t_end - 0.02 + [0.0005 0.0095]; 'negatif', t_end - 0.01 + [0.0005 0.0095]};
rows = {};
for k = 1:numel(tags)
    v = L.getElement(tags{k}).Values;
    t = v.Time; d = double(squeeze(v.Data));
    for w = 1:size(win, 1)
        idx = t >= win{w, 2}(1) & t <= win{w, 2}(2);
        dd = d(idx); tt = t(idx);
        rows(end+1, :) = {tags{k}, win{w, 1}, win{w, 2}(1), win{w, 2}(2), ...
            sum(abs(diff(dd)) > 0.5), trapz(tt, dd) / (tt(end) - tt(1)), min(dd), max(dd)}; %#ok<AGROW>
    end
end
tbl = cell2table(rows, 'VariableNames', {'kapi', 'alternans', 't_bas', 't_bit', 'gecis', 'ortalama', 'min', 'max'});
writetable(tbl, fullfile(res_dir, 's2_kapi_ozeti.csv'));
disp(tbl);

% Dalga biçimi: son periyot, kapılar + S2 AA akımı (varsa)
fig = figure('Visible', 'off', 'Position', [100 100 900 800]);
n = numel(tags) + 1;
for k = 1:numel(tags)
    v = L.getElement(tags{k}).Values;
    idx = v.Time >= t_end - 0.02;
    subplot(n, 1, k); stairs((v.Time(idx) - (t_end - 0.02))*1e3, double(squeeze(v.Data(idx))));
    ylim([-0.2 1.2]); ylabel(strrep(tags{k}, '_', '\_')); grid on
end
ia = find(contains(names, 'AC_Current_Sensor2'), 1);
subplot(n, 1, n);
if ~isempty(ia)
    v = L.getElement(ia).Values;
    idx = v.Time >= t_end - 0.02;
    dd = squeeze(v.Data); if size(dd, 1) ~= numel(v.Time), dd = dd.'; end
    plot((v.Time(idx) - (t_end - 0.02))*1e3, dd(idx, 1)); ylabel('i_{ac,S2} [A]');
    title(strrep(names{ia}, '_', '\_'), 'FontWeight', 'normal');
end
grid on; xlabel('t - (t_{son} - 20 ms) [ms]');
exportgraphics(fig, fullfile(res_dir, 's2_kapi_dalga.png'), 'Resolution', 200);
close(fig);
fprintf('yazıldı: %s\n', res_dir);
end
