function a = time()
addpath(pwd);
rpath = 'C:\Users\jason_000\Documents\coding\Codes_of_master_thesis\plot\plot_data\';
cd plot_data
for OS = 10:10:30
    cd (num2str(OS));
    f1 = figure(OS);
    %ps = ginput(1);
    
    %text(ps(1),ps(2), ['Test error in OS=', num2str(OS)],'FontSize',30);
    ha = tight_subplot(f1,1,10,[.0 .0],[.07 .1],[.06 .04]);
    for beta = 0:9

        cd(num2str(beta))
        path = pwd;
        subpath = fullfile( path, '*.mat' );
        mat = dir (subpath);
        pdata = struct();
        for tensorsize = 100:50:200
            tensorsetting = [num2str(tensorsize), '_10_', num2str(OS)];
            [L, newL] = create_beta_name(tensorsetting, beta);
            pdata = readdata(L, newL, pdata);
        end
         
        
        axes(ha(beta+1));
        %set(ha(beta+1),'Title', stitle);
        
        dim = [.2 .5 .3 .3];
        %annotation('textbox',dim,'String',str,'FitBoxToText','on');
        %text(ha(beta+1),.5,.9,str);
        name = {'100';'150';'200'};
        y = [pdata.time]; 
        bar(y)
        ylim([0 35])
        cd ..;
    end
    for lop = 0:9
        axes(ha(lop+1));
        str = ['\beta = ', num2str(lop*0.2)];
        title(ha(lop+1), str, 'FontSize',18);
        ylabel(ha(1),'Time(second)','FontSize',30);
    end
    
    legend1 = legend(ha(10),'L','newL');
    set(legend1,'FontSize',14);
    set(ha(1:10),'XTickLabel',name,'FontSize',18); 
    set(ha(2:10),'YTickLabel','');
    cd ..;
    pause;
end
cd ..;
a = 0;


end

function plot_f()

ha = tight_subplot(1,6,[.0 .0],[.1 .01],[.04 .04]);
for ii = 1:10; 
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


function data_plot_ = readdata(L, newL, data_plot)
            try
                it = data_plot.iter;
                ti = data_plot.time;
                tes = data_plot.test_error;
            catch
                it = [];
                ti = [];
                tes = [];
            end
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



    %data_plot.beta = b;
    %data_plot.index = ii;
    %data_plot.tsize = s;
    %data_plot.trank = r;
    %data_plot.OS = OS;
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

