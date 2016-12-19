function a = test()

ha = tight_subplot(1,6,[.0 .0],[.1 .01],[.04 .04]);
path = 'C:\Users\jason_000\Documents\coding\Codes_of_master_thesis\Tensor_completion\data_beta_v2\100_5_10\';
load((filemat), 'problem_description');
for ii = 1:5; 
    axes(ha(ii)); 
    name = {'m1';'m2'};
    y = [19,24;12,14]; 
    bar(y)
    ylim([0 80])
end
axes(ha(6)); 
y = [60,24;12,14]; 
bar(y);
ylim([0 80]);
set(ha(1:6),'XTickLabel',name); 
set(ha(2:6),'YTickLabel','')

end

function data_plot_ = readdata(path, data_plot)
    
            localpath = pwd;
            cd(matpath);
            load(L, 'infos');
            iter = [infos.iter];
            time = [infos.time];
            test_error = [infos.test_error_square];
            biter = iter(end);
            btime = time(end);
            bte = test_error(end);
            
            load(newL, 'infos');
            iter = [infos.iter];
            time = [infos.time];
            test_error = [infos.test_error_square];
            biter = [biter, iter(end)];
            btime = [btime, time(end)];
            bte = [bte, test_error(end)];
            it = [it; biter];
            ti = [ti; btime];
            tes = [tes; bte];
        end
    end


    data_plot.beta = b;
    data_plot.index = ii;
    data_plot.tsize = s;
    data_plot.trank = r;
    data_plot.OS = OS;
    data_plot.iter = it;
    data_plot.time = ti;
    data_plot.test_error = tes;
    data_plot_ = data_plot;
end

function [L_filenameinfo, newL_filenameinfo]= create_beta_name(foldername, b_index)

    method = 'CG_L_';
    L_filenameinfo = LSname(method);
    method = 'CG_NewL_';
    newL_filenameinfo = LSname(method);

    function filenameinfo = LSname(method)
        u = '_';
        method = [method, 'Beta_', num2str(b_index), u];
        filenameinfo = [foldername, u, 'KM_', method, 'info', '.mat'];
    end
end
