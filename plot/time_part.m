function a = time_part()
addpath(pwd);
rpath = 'C:\Users\jason_000\Documents\coding\Codes_of_master_thesis\plot\plot_data\';
cd plot_data
f1 = figure(1);
ha = tight_subplot(f1,1,3,[.0 .0],[.07 .1],[.15 .04]);
for OS = 10:10:30
    cd (num2str(OS));
    a = OS/10;
    
    %ps = ginput(1);
    %text(ps(1),ps(2), ['Test error in OS=', num2str(OS)],'FontSize',30);
    
    
        beta = 5;
        cd(num2str(0))
        path = pwd;
        subpath = fullfile( path, '*.mat' );
        mat = dir (subpath);
        pdata = struct();
        for tensorsize = 100:50:200
            tensorsetting = [num2str(tensorsize), '_10_', num2str(OS)];
            [L, newL] = create_beta_name(tensorsetting, beta);
            pdata = readdata(L, newL, pdata);
        end
        axes(ha(a));
        
        
        %set(ha(beta+1),'Title', stitle);
        
        %dim = [.2 .5 .3 .3];
        %annotation('textbox',dim,'String',str,'FitBoxToText','on');
        %text(ha(beta+1),.5,.9,str);
        name = {'100';'150';'200'};
        y = pdata.time; 
        bar(y);
        ylim([0 35]);   
        cd ..;
    
    
    
 
       
    cd ..;
end

    legend1 = legend(ha(3),'SD+L','CG+newL');
    set(legend1,'FontSize',14);
    set(ha(1:3),'XTickLabel',name,'FontSize',18); 
    set(ha(2:3),'YTickLabel','');
    ylabel(ha(1),'Time(second)','FontSize',30);
    for T = 1:3
        axes(ha(T));
        str = ['OS=', num2str(T*10)];
        title(ha(T), str, 'FontSize',18);
        %ylabel(ha(1),'Time(second)','FontSize',30);
    end
    
cd ..;
at = 0;


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
            cd ..;
            cd '0';
            load(L, 'infos');
            iter = [infos.iter];
            time = [infos.time];
            test_error = [infos.test_error_square];
            biter = iter(end);
            btime = time(end);
            bte = test_error(end);
            cd ..;
            cd(num2str(5));
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
            %cd ..;


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
    L_filenameinfo = LSname(method,0);
    method = 'CG_NewL_';
    newL_filenameinfo = LSname(method,1);

    function filenameinfo = LSname(method,al)
        u = '_';
        method = [method, 'Beta_', num2str(al*b_index), u];
        filenameinfo = [foldername, u, 'KM_', method, 'info', '.mat'];
    end
end

