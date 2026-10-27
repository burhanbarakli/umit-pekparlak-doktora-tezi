% Eski tez Sekil 4.1 ve 4.2 icin yeniden uretilebilir kapi darbesi adaylari.
% Parametre kaynagi: 05_sonradan_gelenler/Desarjv30parametre_deadtime_olmayan.m
% Kapi mantigi kaynagi: build_switching_ttype_model.m

clearvars;
close all;

root_dir = fileparts(fileparts(mfilename('fullpath')));
result_dir = fullfile(root_dir,'results','gate_comparison');
if ~exist(result_dir,'dir'), mkdir(result_dir); end

f_grid = 50;
f_switch = 10e3;
dt = 1e-7;
m_index = 0.86; % switching_demo_parameters.m; gelen dosyada modulasyon indeksi yok.
t = (0:dt:0.021).';

theta = 2*pi*f_grid*t;
sin_ref = sin(theta);
tri_phase = mod(t*f_switch,1);
carrier = 1-abs(2*tri_phase-1);
pwm_active = abs(m_index*sin_ref) >= carrier;
positive_half = sin_ref >= 0;
negative_half = ~positive_half;
not_pwm = ~pwm_active;

% build_switching_ttype_model.m ile ayni mantik:
% pozitif alternans: P=1010, O=0011
% negatif alternans: N=0101, O=0011
Q1 = positive_half & pwm_active;
Q2 = negative_half & pwm_active;
Q3 = positive_half | not_pwm;
Q4 = negative_half | not_pwm;
gates = double([Q1 Q4 Q2 Q3]); % Eski Scope sirasi: Q1, Q4, Q2, Q3

state_matrix = unique(double([Q1 Q2 Q3 Q4]),'rows');
expected_states = [0 0 1 1; 0 1 0 1; 1 0 1 0];
if ~isequal(state_matrix,expected_states)
    error('Kapi mantigi beklenen P/O/N durumlarini uretmedi.');
end

labels = {'Q1','Q4','Q2','Q3'};
full_file = fullfile(result_dir,'yeniden_uretilen_sekil_4_1_tam_periyot.png');
zoom_file = fullfile(result_dir,'yeniden_uretilen_sekil_4_2_yakin.png');

plot_gate_scope(t,gates,labels,[0 0.021],full_file, ...
    'Yeniden üretilen klasik anahtarlama - tam temel periyot');
plot_gate_scope(t,gates,labels,[2.16e-3 2.75e-3],zoom_file, ...
    'Yeniden üretilen klasik anahtarlama - yakın görünüm');

parameter_table = table(f_grid,f_switch,dt,m_index,false, ...
    'VariableNames',{'Grid_Hz','Switching_Hz','Simulation_Step_s', ...
    'Modulation_Index','Deadtime_Enabled'});
writetable(parameter_table,fullfile(result_dir,'uretim_parametreleri.csv'));

state_table = array2table(expected_states, ...
    'VariableNames',{'Q1','Q2','Q3','Q4'});
state_table.Durum = ["O";"N";"P"];
writetable(state_table,fullfile(result_dir,'izinli_kapi_durumlari.csv'));

fid = fopen(fullfile(result_dir,'dogrulama.txt'),'w','n','UTF-8');
fprintf(fid,'Kaynak parametreler: 50 Hz, 10 kHz, 1e-7 s, olu zaman yok (deadtime disabled).\n');
fprintf(fid,'Modulasyon indeksi: 0.86 (bizim switching_demo_parameters.m).\n');
fprintf(fid,'Gozlenen durumlar: O=0011, N=0101, P=1010.\n');
fprintf(fid,'Eski Sekil 4.1/4.2 ile mantiksal eslesme: EVET.\n');
fprintf(fid,'Piksel/zaman fazi bakimindan bire bir eslesme: KANITLANAMADI.\n');
fclose(fid);

function plot_gate_scope(t,gates,labels,x_limits,out_file,main_title)
    fig = figure('Color','w','Position',[80 80 1500 900]);
    layout = tiledlayout(fig,4,1,'TileSpacing','compact','Padding','compact');
    title(layout,main_title,'FontWeight','bold');
    for k = 1:4
        ax = nexttile(layout);
        ax.Toolbar.Visible = 'off';
        ax.Color = [0.02 0.02 0.02];
        ax.XColor = [0.25 0.25 0.25];
        ax.YColor = [0.25 0.25 0.25];
        hold(ax,'on');
        stairs(ax,t,gates(:,k),'Color',[1.0 1.0 0.35],'LineWidth',0.75);
        xlim(ax,x_limits);
        ylim(ax,[-0.1 1.1]);
        yticks(ax,[0 0.5 1]);
        grid(ax,'on');
        ax.GridColor = [0.72 0.72 0.72];
        ax.GridAlpha = 0.32;
        ylabel(ax,labels{k},'FontWeight','bold','Color','k','Rotation',0, ...
            'HorizontalAlignment','right','VerticalAlignment','middle');
        if k < 4
            ax.XTickLabel = [];
        else
            xlabel(ax,'Zaman (s)');
        end
    end
    exportgraphics(fig,out_file,'Resolution',220);
    close(fig);
end
