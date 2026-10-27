% Geçici ortalama model için L, S, T ve şebeke endüktansı duyarlılığı.

root_dir=fileparts(fileparts(mfilename('fullpath')));
run(fullfile(root_dir,'parameters','closed_loop_demo_parameters.m'));
result_dir=fullfile(root_dir,'results','stability');
if ~exist(result_dir,'dir'),mkdir(result_dir);end

% Seri sönüm dirençli LCL durum uzayı: x=[i1 vc i2].
L2t=L2_sw;
A=[-(R1_sw+Rd_sw)/L1_sw, -1/L1_sw, Rd_sw/L1_sw; ...
    1/Cf_sw, 0, -1/Cf_sw; ...
    Rd_sw/L2t, 1/L2t, -(R2_sw+Rd_sw)/L2t];
B=[1/L1_sw, 0; 0,0; 0,-1/L2t];
Cout=[0 0 1];
D=[0 0];
Pall=ss(A,B,Cout,D);
P=minreal(Pall(:,1));               % v_inv -> i_grid

s=tf('s');
Cpr=Kp_cl+(2*Kr_cl*wc_cl*s)/(s^2+2*wc_cl*s+w_grid_sw^2);
total_delay=1.5*Ts_control_cl;      % hesaplama + PWM eşdeğer gecikmesi
[nd,dd]=pade(total_delay,2);
Gd=tf(nd,dd);
L=minreal(Cpr*Gd*P);
S=feedback(1,L);
T=feedback(L,1);

[gm,pm,wcg,wcp]=margin(L);
gm_db=20*log10(gm);
stable_closed_loop=isstable(T);
margins=table(gm,gm_db,pm,wcg,wcp,total_delay,stable_closed_loop, ...
    'VariableNames',{'GainMargin','GainMargin_dB','PhaseMargin_deg', ...
    'Wcg_rad_s','Wcp_rad_s','TotalDelay_s','ClosedLoopStable'});
writetable(margins,fullfile(result_dir,'margins.csv'));
disp(margins);

w=logspace(1,5.3,1800);
fig=figure('Color','w','Position',[100 100 1150 850]);
tiledlayout(3,1,'TileSpacing','compact');
nexttile; bodemag(L,w); grid on; title('Açık çevrim L(s)');
nexttile; bodemag(S,w); grid on; title('Duyarlılık S(s)');
nexttile; bodemag(T,w); grid on; title('Tamamlayıcı duyarlılık T(s)');
exportgraphics(fig,fullfile(result_dir,'bode_LST.png'),'Resolution',200);
savefig(fig,fullfile(result_dir,'bode_LST.fig'));
close(fig);

% Şebeke endüktansı değişiminin marjlara etkisi
Lg_values=[0 0.25e-3 0.5e-3 1e-3 2e-3];
gm_grid=zeros(numel(Lg_values),1);
pm_grid=zeros(numel(Lg_values),1);
stable_grid=false(numel(Lg_values),1);
loops=cell(numel(Lg_values),1);
for k=1:numel(Lg_values)
    L2eff=L2_sw+Lg_values(k);
    Ak=[-(R1_sw+Rd_sw)/L1_sw, -1/L1_sw, Rd_sw/L1_sw; ...
        1/Cf_sw,0,-1/Cf_sw; ...
        Rd_sw/L2eff,1/L2eff,-(R2_sw+Rd_sw)/L2eff];
    Bk=[1/L1_sw;0;0];
    Pk=ss(Ak,Bk,Cout,0);
    loops{k}=minreal(Cpr*Gd*Pk);
    [gmk,pmk]=margin(loops{k});
    gm_grid(k)=20*log10(gmk);
    pm_grid(k)=pmk;
    stable_grid(k)=isstable(feedback(loops{k},1));
end
robustness=table(1e3*Lg_values(:),gm_grid,pm_grid,stable_grid, ...
    'VariableNames',{'GridInductance_mH','GainMargin_dB','PhaseMargin_deg','Stable'});
writetable(robustness,fullfile(result_dir,'grid_inductance_robustness.csv'));

fig=figure('Color','w','Position',[100 100 1000 700]);
tiledlayout(2,1,'TileSpacing','compact');
nexttile; plot(1e3*Lg_values,gm_grid,'o-','LineWidth',1.3); grid on;
ylabel('Kazanç marjı (dB)'); title('Şebeke endüktansı duyarlılığı');
nexttile; plot(1e3*Lg_values,pm_grid,'s-','LineWidth',1.3); grid on;
ylabel('Faz marjı (derece)'); xlabel('Ek şebeke endüktansı (mH)');
exportgraphics(fig,fullfile(result_dir,'grid_inductance_robustness.png'),'Resolution',200);
close(fig);

if ~stable_closed_loop || any(~stable_grid)
    warning('Geçici denetleyici tüm incelenen koşullarda kararlı değildir.');
end
