% Kalibre S3 benzetim modelinin üst düzey çiziminin vektör PDF olarak alınması (İP-11).
% Model açılır, derlenmez ve kaydedilmez; yalnız çizim yazdırılır.
%   Girdi : tez-matlab-simulink/runs/2026-10-28_parametre_tablosu/model/tez/inverter_senaryo3_kal.slx
%   Çıktı : bu klasörde s3_model_ust_duzey_tam.pdf; ardından kirp_model_cizimi.py -> s3_model_ust_duzey.pdf
% Çağrı  : matlab -batch "run('<bu dosya>')"
here = fileparts(mfilename('fullpath'));
mdir = fullfile(here, '..', '..', '..', 'tez-matlab-simulink', 'runs', '2026-10-28_parametre_tablosu', 'model', 'tez');
mdir = char(java.io.File(mdir).getCanonicalPath());
evalin('base', sprintf('run(''%s'');', fullfile(mdir, 'inverter_common_parameters.m')));
mdl = 'inverter_senaryo3_kal';
load_system(fullfile(mdir, [mdl '.slx']));
set_param(mdl, 'ShowPageBoundaries', 'off');
set_param(mdl, 'PaperOrientation', 'landscape', 'PaperPositionMode', 'auto');
out = fullfile(here, 's3_model_ust_duzey_tam.pdf');   % kirp_model_cizimi.py etkin devreye kırpar
print(['-s' mdl], '-dpdf', out);
close_system(mdl, 0);
fprintf('yazıldı: %s\n', out);
