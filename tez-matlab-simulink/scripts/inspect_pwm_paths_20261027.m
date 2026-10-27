% İP-1 / D-01 ön incelemesi: S3 modelinde g11…g41 kapı işaretlerini üreten
% modülasyon/PWM yolunu ve S1+S2 modelindeki karşılığını blok blok çıkarır.
% Modeller yalnız okunur (kaydedilmez).
% Çağrı (proje kökünden):
%   matlab -batch "run('scripts/inspect_pwm_paths_20261027.m')"
% Çıktı: runs/2026-10-27_s2_kapi_onarimi/inspection/pwm_yolu_<model>.txt
root_dir = fileparts(fileparts(mfilename('fullpath')));
ins_run_dir = fullfile(root_dir, 'runs', '2026-10-27_s2_kapi_onarimi');
ins_model_dir = fullfile(ins_run_dir, 'model');
ins_out_dir = fullfile(ins_run_dir, 'inspection');
if ~exist(ins_out_dir, 'dir'), mkdir(ins_out_dir); end
cd(ins_model_dir);
evalin('base', sprintf('run(''%s'');', fullfile(ins_model_dir, 'inverter_common_parameters.m')));

ins_cases = {
    'inverter_senaryo3', 'Subsystem2'
    'inverter_scenario1_parametric5_etiquetli', 'Subsystem'};
for ins_m = 1:size(ins_cases, 1)
    mdl = ins_cases{ins_m, 1};
    pwm = [mdl '/' ins_cases{ins_m, 2}];
    load_system(mdl);
    fid = fopen(fullfile(ins_out_dir, ['pwm_yolu_' mdl '.txt']), 'w', 'n', 'UTF-8');
    fprintf(fid, 'MODEL %s\nPWM alt sistemi: %s\n', mdl, pwm);

    fprintf(fid, '\n== PWM alt sistemine giden yukarı akış (üst düzey)\n');
    pwm_upstream(fid, pwm, 0, {});

    fprintf(fid, '\n== PWM alt sistemi içi (tüm derinlik, maske altı dahil)\n');
    pwm_dump_system(fid, pwm);
    subs = find_system(pwm, 'LookUnderMasks', 'all', 'FollowLinks', 'on', 'BlockType', 'SubSystem');
    for k = 2:numel(subs)
        pwm_dump_system(fid, subs{k});
    end

    fprintf(fid, '\n== PWM çıkışlarından aşağı akış\n');
    ph = get_param(pwm, 'PortHandles');
    for p = 1:numel(ph.Outport)
        ln = get_param(ph.Outport(p), 'Line');
        if ln < 0, fprintf(fid, 'Out%d: bağlı değil\n', p); continue, end
        dst = get_param(ln, 'DstBlockHandle');
        for d = 1:numel(dst)
            fprintf(fid, 'Out%d -> %s %s\n', p, pwm_name(dst(d)), pwm_tag(dst(d)));
        end
    end

    fprintf(fid, '\n== Goto / From etiketleri (tüm derinlik)\n');
    gts = find_system(mdl, 'LookUnderMasks', 'all', 'FollowLinks', 'on', 'BlockType', 'Goto');
    for k = 1:numel(gts)
        fprintf(fid, 'Goto %-6s vis=%-8s %s\n', get_param(gts{k}, 'GotoTag'), ...
            get_param(gts{k}, 'TagVisibility'), pwm_clean(gts{k}));
    end
    frs = find_system(mdl, 'LookUnderMasks', 'all', 'FollowLinks', 'on', 'BlockType', 'From');
    for k = 1:numel(frs)
        fprintf(fid, 'From %-6s %s\n', get_param(frs{k}, 'GotoTag'), pwm_clean(frs{k}));
    end

    fprintf(fid, '\n== Gate Drive alt sistemleri: hangi IGBT''yi sürüyor\n');
    gds = find_system(mdl, 'SearchDepth', 1, 'Regexp', 'on', 'Name', '^Gate');
    for k = 1:numel(gds)
        ph = get_param(gds{k}, 'PortHandles');
        tags = find_system(gds{k}, 'LookUnderMasks', 'all', 'BlockType', 'From');
        tagstr = strjoin(cellfun(@(b) get_param(b, 'GotoTag'), tags, 'UniformOutput', false), ',');
        conn = get_param(gds{k}, 'PortConnectivity');
        dsts = {};
        for c = 1:numel(conn)
            for d = 1:numel(conn(c).DstBlock)
                dsts{end+1} = pwm_name(conn(c).DstBlock(d)); %#ok<AGROW>
            end
        end
        fprintf(fid, '%s  From=[%s]  -> %s\n', pwm_clean(gds{k}), tagstr, strjoin(unique(dsts), ' | '));
        % Simscape bağlantıları (LConn/RConn) için:
        lh = [ph.LConn ph.RConn];
        for q = 1:numel(lh)
            l = get_param(lh(q), 'Line');
            if l < 0, continue, end
            blks = [get_param(l, 'SrcBlockHandle'), get_param(l, 'DstBlockHandle')'];
            blks = blks(blks > 0);
            fprintf(fid, '    fiziksel uç %d -> %s\n', q, strjoin(arrayfun(@pwm_name, blks, 'UniformOutput', false), ' | '));
        end
    end
    fclose(fid);
    close_system(mdl, 0);
    fprintf('incelendi: %s\n', mdl);
end

function pwm_upstream(fid, blk, depth, seen)
ph = get_param(blk, 'PortHandles');
for p = 1:numel(ph.Inport)
    ln = get_param(ph.Inport(p), 'Line');
    if ln < 0, fprintf(fid, '%s%s:In%d bağlı değil\n', blanks(2*depth), pwm_clean(blk), p); continue, end
    src = get_param(ln, 'SrcBlockHandle');
    sp = get_param(get_param(ln, 'SrcPortHandle'), 'PortNumber');
    fprintf(fid, '%s%s:In%d <- %s:Out%d  [%s] %s\n', blanks(2*depth), pwm_clean(blk), p, ...
        pwm_name(src), sp, get_param(src, 'BlockType'), pwm_params(src));
    nm = getfullname(src);
    if ~any(strcmp(seen, nm)) && depth < 12
        pwm_upstream(fid, nm, depth + 1, [seen {nm}]);
    end
end
end

function pwm_dump_system(fid, sys)
fprintf(fid, '\n-- %s\n', pwm_clean(sys));
blks = find_system(sys, 'SearchDepth', 1, 'LookUnderMasks', 'all', 'FollowLinks', 'on', 'Type', 'Block');
for k = 2:numel(blks)
    fprintf(fid, '  [%s] %s %s\n', get_param(blks{k}, 'BlockType'), ...
        pwm_clean(strrep(blks{k}, [sys '/'], '')), pwm_params(blks{k}));
end
lines = find_system(sys, 'SearchDepth', 1, 'LookUnderMasks', 'all', 'FollowLinks', 'on', 'FindAll', 'on', 'Type', 'line');
for k = 1:numel(lines)
    src = get_param(lines(k), 'SrcBlockHandle');
    dst = get_param(lines(k), 'DstBlockHandle');
    if src < 0 || isempty(dst) || any(dst < 0), continue, end
    sp = get_param(get_param(lines(k), 'SrcPortHandle'), 'PortNumber');
    dph = get_param(lines(k), 'DstPortHandle');
    for d = 1:numel(dst)
        fprintf(fid, '  %s:%d -> %s:%d\n', pwm_clean(get_param(src, 'Name')), sp, ...
            pwm_clean(get_param(dst(d), 'Name')), get_param(dph(d), 'PortNumber'));
    end
end
end

function s = pwm_params(b)
bt = get_param(b, 'BlockType');
keys = {};
switch bt
    case 'Gain', keys = {'Gain'};
    case 'Sin', keys = {'SineType', 'Amplitude', 'Bias', 'Frequency', 'Phase', 'SampleTime'};
    case 'Sum', keys = {'Inputs'};
    case 'Product', keys = {'Inputs'};
    case 'Math', keys = {'Operator', 'Exponent'};
    case 'Fcn', keys = {'Expr'};
    case 'Constant', keys = {'Value'};
    case 'RelationalOperator', keys = {'Operator'};
    case 'Logic', keys = {'Operator', 'Inputs'};
    case 'Saturate', keys = {'UpperLimit', 'LowerLimit'};
    case 'Abs', keys = {};
    case 'Signum', keys = {};
    case 'Switch', keys = {'Criteria', 'Threshold'};
    case {'Goto', 'From'}, keys = {'GotoTag'};
    case 'DataTypeConversion', keys = {'OutDataTypeStr'};
    case 'Reference', keys = {'SourceBlock'};
    case 'SubSystem'
        keys = {'MaskType'};
        try
            mv = get_param(b, 'MaskNames'); vv = get_param(b, 'MaskValues');
            for i = 1:numel(mv), keys{end+1} = mv{i}; end %#ok<AGROW>
        catch
        end
end
parts = {};
for i = 1:numel(keys)
    try
        v = get_param(b, keys{i});
        if ischar(v), parts{end+1} = sprintf('%s=%s', keys{i}, v); end %#ok<AGROW>
    catch
    end
end
try
    rb = get_param(b, 'ReferenceBlock');
    if ~isempty(rb), parts{end+1} = ['ref=' pwm_clean(rb)]; end
catch
end
s = strjoin(parts, '; ');
end

function s = pwm_tag(h)
s = '';
if strcmp(get_param(h, 'BlockType'), 'Goto')
    s = ['tag=' get_param(h, 'GotoTag') ' vis=' get_param(h, 'TagVisibility')];
end
end

function s = pwm_name(h)
s = pwm_clean(getfullname(h));
end

function s = pwm_clean(s)
s = strrep(s, newline, ' ');
end
