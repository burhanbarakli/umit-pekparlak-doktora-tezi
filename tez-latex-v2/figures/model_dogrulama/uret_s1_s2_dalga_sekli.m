% S1 ve S2 kalibre benzetim dalga bicimleri ile S2 kapi isaretlerinin vektorel cizimi.
% Yalniz mevcut kosu kayitlarini okur; benzetim kosturmaz, yeni metrik uretmez.
%   Girdi 1: tez-matlab-simulink/runs/2026-10-28_kalibrasyon/results/{s1_k4,s2_k4}/dalga.mat
%            (v_inv, v_ac, i_ac; 0,06-0,10 s; review/2026-10-28_KALIBRASYON_S1_S3.md)
%   Girdi 2: tez-matlab-simulink/runs/2026-10-27_diyot_esleme/results/inverter_s1s2_s2onarim_d08/logsout.mat
%            (S2 devresinin g12..g42 kapi kayitlari; review/2026-10-27_D08_DIYOT_ESLEME.md)
%   Cikti : bu klasorde s1_s2_kalibre_dalga.pdf, s2_kapi_isaretleri.pdf
% Cagri  : matlab -batch "run('<bu dosya>')"
here = fileparts(mfilename('fullpath'));
kok  = fullfile(here,'..','..','..','tez-matlab-simulink','runs');
S1 = load(fullfile(kok,'2026-10-28_kalibrasyon','results','s1_k4','dalga.mat')); S1 = S1.W;
S2 = load(fullfile(kok,'2026-10-28_kalibrasyon','results','s2_k4','dalga.mat')); S2 = S2.W;

ta = 0.08; tb = 0.10;            % son tam sebeke periyodu
if ~exist('ZA','var'), ZA = 0.0806; end
za = ZA; zb = ZA + 400e-6;       % dusuk akim bolgesinde 400 us
renk1 = [0 0.447 0.741]; renk2 = [0.850 0.325 0.098];

f = figure('Units','centimeters','Position',[2 2 16 15],'Color','w','Visible','off');
tl = tiledlayout(f,3,1,'TileSpacing','compact','Padding','compact');
for k = 1:2
    if k == 1, W = S1; ad = '(a) S1 (klasik)'; else, W = S2; ad = '(b) S2 (susturma)'; end
    ax = nexttile(tl);
    [tt,vv] = zarf(W.v_inv.t, W.v_inv.v, ta, tb, 4e-6);
    yyaxis(ax,'left'); plot(ax,(tt-ta)*1e3, vv,'-','Color',[0.55 0.55 0.55],'LineWidth',0.3); hold(ax,'on');
    [tt,vv] = zarf(W.v_ac.t, W.v_ac.v, ta, tb, 20e-6);
    plot(ax,(tt-ta)*1e3, vv,'-','Color',renk1,'LineWidth',1.0);
    ylabel(ax,'gerilim [V]'); ylim(ax,[-260 260]); ax.YColor = renk1;
    yyaxis(ax,'right');
    [tt,vv] = zarf(W.i_ac.t, W.i_ac.v, ta, tb, 20e-6);
    plot(ax,(tt-ta)*1e3, vv,'-','Color',renk2,'LineWidth',1.0);
    ylabel(ax,'i_{g} [A]'); ylim(ax,[-6 6]); ax.YColor = renk2;
    xlim(ax,[0 20]); grid(ax,'on'); title(ax,ad,'FontWeight','normal');
    if k == 2, xlabel(ax,'t - 80 ms [ms]'); end
    if k == 1
        legend(ax,{'v_{inv} (kutup)','v_{g} (C)','i_{g} (C)'},'Location','southwest','FontSize',7,'Box','off');
    end
end
ax = nexttile(tl); hold(ax,'on');
[tt,vv] = esit(S1.v_inv.t, S1.v_inv.v, za, zb, 0.05e-6);
plot(ax,(tt-za)*1e6, vv,'-','Color',renk1,'LineWidth',0.8);
[tt,vv] = esit(S2.v_inv.t, S2.v_inv.v, za, zb, 0.05e-6);
plot(ax,(tt-za)*1e6, vv,'-','Color',renk2,'LineWidth',0.8);
xlim(ax,[0 (zb-za)*1e6]); ylim(ax,[-40 260]); grid(ax,'on');
xlabel(ax,['t - ' strrep(num2str(za*1e3,'%.1f'),'.',',') ' ms [\mus]']); ylabel(ax,'v_{inv} [V]');
legend(ax,{'S1','S2'},'Location','northeast','FontSize',7,'Box','off');
title(ax,'(c) Kutup gerilimi v_{inv}, 400 \mus pencere','FontWeight','normal');
set(findall(f,'-property','FontName'),'FontName','Helvetica');
exportgraphics(f, fullfile(here,'s1_s2_kalibre_dalga.pdf'),'ContentType','vector');
close(f);

% S2 kapi isaretleri (D-01 + D-08 kosusu)
L = load(fullfile(kok,'2026-10-27_diyot_esleme','results','inverter_s1s2_s2onarim_d08','logsout.mat'));
ads = {'g12_S2','g22_S2','g32_S2','g42_S2'}; etk = {'q_1','q_2','q_3','q_4'};  % 15.11.2026 (K-31): g32 -> Q3 (faz), g42 -> Q4 (orta nokta); tümleyen çiftler Q1-Q3, Q2-Q4
f = figure('Units','centimeters','Position',[2 2 16 11],'Color','w','Visible','off');
tl = tiledlayout(f,4,2,'TileSpacing','compact','Padding','compact','TileIndexing','columnmajor');
G = cell(1,4);
for i = 1:4, e = L.logs.getElement(ads{i}); G{i} = e.Values; end
for pencere = 1:2
    if pencere == 1, a = ta; b = tb; olc = 1e3; xl = [0 20]; xt = 't - 80 ms [ms]';
    else, a = za; b = zb; olc = 1e6; xl = [0 (zb-za)*1e6]; xt = ['t - ' strrep(num2str(za*1e3,'%.1f'),'.',',') ' ms [\mus]']; end
    for i = 1:4
        ax = nexttile(tl);
        [tt,vv] = kenar(G{i}.Time, squeeze(G{i}.Data), a, b);
        stairs(ax,(tt-a)*olc, vv,'Color',renk1,'LineWidth',0.6);
        ylim(ax,[-0.2 1.2]); xlim(ax,xl); yticks(ax,[0 1]); grid(ax,'on');
        ylabel(ax, etk{i});
        if i < 4, ax.XTickLabel = []; else, xlabel(ax,xt); end
    end
end
set(findall(f,'-property','FontName'),'FontName','Helvetica');
exportgraphics(f, fullfile(here,'s2_kapi_isaretleri.pdf'),'ContentType','vector');
close(f);
disp('tamam');

function [to,vo] = zarf(t,v,a,b,dt)
% dt genislikli kutularda min/maks zarfi (gorsel olarak ozdes, az nokta)
t = t(:); v = double(v(:)); m = t>=a & t<=b; t = t(m); v = v(m);
kut = floor((t-a)/dt); [u,~,j] = unique(kut);
vmin = accumarray(j,v,[],@min); vmax = accumarray(j,v,[],@max);
tc = a + (u+0.5)*dt;
to = reshape([tc tc]',[],1); vo = reshape([vmin vmax]',[],1);
end
function [to,vo] = esit(t,v,a,b,dt)
t = t(:); v = double(v(:)); [t,iu] = unique(t); v = v(iu);
to = (a:dt:b)'; vo = interp1(t,v,to,'previous');
end
function [to,vo] = kenar(t,v,a,b)
t = t(:); v = double(v(:)); m = t>=a & t<=b; t = t(m); v = v(m);
d = [true; diff(v)~=0]; d(end) = true; to = t(d); vo = v(d);
end
