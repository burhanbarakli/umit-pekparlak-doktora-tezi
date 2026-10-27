% Gelen Senaryo 1 modelini değiştirmeden yapısal olarak denetler.

root_dir = fileparts(fileparts(mfilename('fullpath')));
model_file = getenv('RECEIVED_SCENARIO1_MODEL');
if isempty(model_file)
    model_file = fullfile(root_dir,'incoming_real_data','models', ...
        'Inverter2_senaryo1_2026-08-16.slx');
end
[~,model_name] = fileparts(model_file);
load_system(model_file);
cleanup = onCleanup(@()close_system(model_name,0));

fprintf('MODEL=%s\n',model_name);
fprintf('StopTime=%s Solver=%s MaxStep=%s\n', ...
    get_param(model_name,'StopTime'),get_param(model_name,'Solver'), ...
    get_param(model_name,'MaxStep'));

types = {'ToWorkspace','Scope','Display','RMS','Fourier'};
for k = 1:numel(types)
    blocks = find_system(model_name,'LookUnderMasks','all', ...
        'FollowLinks','on','BlockType',types{k});
    fprintf('\n[%s] count=%d\n',types{k},numel(blocks));
    for n = 1:numel(blocks)
        fprintf('%s\n',blocks{n});
        if strcmp(types{k},'ToWorkspace')
            fprintf('  VariableName=%s SaveFormat=%s\n', ...
                get_param(blocks{n},'VariableName'),get_param(blocks{n},'SaveFormat'));
        end
    end
end

all_blocks = find_system(model_name,'LookUnderMasks','all','FollowLinks','on');
needles = {'Vdc','Idc','THD','eff','verim','power','aktif','akım','current'};
fprintf('\n[NAME_MATCHES]\n');
for n = 1:numel(all_blocks)
    label = lower(all_blocks{n});
    if any(cellfun(@(x)contains(label,lower(x)),needles))
        fprintf('%s | %s\n',all_blocks{n},get_param(all_blocks{n},'BlockType'));
    end
end
