% R2025b Simscape donusum adayinin elektriksel parametrelerini raporlar.
% Modelde veya kaynak dosyada degisiklik yapmaz.

root_dir = fileparts(fileparts(mfilename('fullpath')));
model_file = fullfile(root_dir,'models', ...
    'Inverter2_senaryo1_20260816_simscape_conversion_candidate.slx');
[~,model_name] = fileparts(model_file);
load_system(model_file);
cleanup = onCleanup(@()close_system(model_name,0));

fprintf('MODEL=%s\n',model_name);
fprintf('StopTime=%s Solver=%s MaxStep=%s RelTol=%s\n', ...
    get_param(model_name,'StopTime'),get_param(model_name,'Solver'), ...
    get_param(model_name,'MaxStep'),get_param(model_name,'RelTol'));

blocks = find_system(model_name,'LookUnderMasks','all','FollowLinks','off');
for k = 2:numel(blocks)
    object_parameters = get_param(blocks{k},'ObjectParameters');
    if strcmp(get_param(blocks{k},'BlockType'),'SimscapeBlock')
        source = 'SimscapeBlock';
    elseif contains(get_param(blocks{k},'Name'),'Solver')
        source = 'Solver Configuration';
    else
        continue;
    end
    block_name = get_param(blocks{k},'Name');
    if ~(contains(block_name,'Inductor') || contains(block_name,'CL1') || ...
            contains(block_name,'Capacitor') || contains(block_name,'Resistor') || ...
            contains(block_name,'Diode') || contains(block_name,'IGBT') || ...
            contains(block_name,'Solver'))
        continue;
    end
    fprintf('\nBLOCK=%s\nSOURCE=%s\n',blocks{k},strrep(source,newline,' '));
    names = {'l','l_unit','r','r_unit','R','R_unit','c','c_unit', ...
        'Vf','Vf_unit','Ron','Ron_unit','Goff','Goff_unit','CJ','CJ_unit', ...
        'iRM','iRM_unit','iF','iF_unit','didt','didt_unit','trr','trr_unit', ...
        'fidelity_level','UseLocalSolver','LocalSolverChoice', ...
        'LocalSolverSampleTime','MaxNonlinIter','MaxModeIter'};
    for n = 1:numel(names)
        if isfield(object_parameters,names{n})
            value = get_param(blocks{k},names{n});
            if isnumeric(value), value = mat2str(value); end
            fprintf('  %s=%s\n',names{n},value);
        end
    end
end
