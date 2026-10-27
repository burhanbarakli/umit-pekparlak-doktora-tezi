% Results altındaki bütün MATLAB figürlerini tez için PDF ve SVG'ye aktarır.

root_dir=fileparts(fileparts(mfilename('fullpath')));
result_dir=fullfile(root_dir,'results');
fig_files=dir(fullfile(result_dir,'**','*.fig'));
export_log=table('Size',[numel(fig_files) 4], ...
    'VariableTypes',{'string','string','string','string'}, ...
    'VariableNames',{'Source_FIG','PDF','SVG','Status'});
for k=1:numel(fig_files)
    src=fullfile(fig_files(k).folder,fig_files(k).name);
    [~,stem]=fileparts(src);pdf_file=fullfile(fig_files(k).folder,[stem '.pdf']);
    svg_file=fullfile(fig_files(k).folder,[stem '.svg']);
    export_log.Source_FIG(k)=string(src);export_log.PDF(k)=string(pdf_file);
    export_log.SVG(k)=string(svg_file);
    try
        f=openfig(src,'invisible');
        exportgraphics(f,pdf_file,'ContentType','vector');
        exportgraphics(f,svg_file,'ContentType','vector');
        close(f);export_log.Status(k)="OK";
        fprintf('%d/%d aktarıldı: %s\n',k,numel(fig_files),stem);
    catch ME
        if exist('f','var') && isgraphics(f),close(f);end
        export_log.Status(k)="HATA: "+string(ME.message);
        warning('%s aktarılamadı: %s',src,ME.message);
    end
end
writetable(export_log,fullfile(result_dir,'vector_export_log.csv'));
assert(all(export_log.Status=="OK"),'En az bir figür vektörel aktarılamadı.');
