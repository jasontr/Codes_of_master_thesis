function void = copydata()
%path = uigetdir();
path = 'C:\Users\jason_000\Documents\coding\Codes_of_master_thesis\Tensor_completion\data_beta_v2';
localpath = pwd;

maindir = path;
    subdir  = dir( maindir );

    for i = 1 : length( subdir )
        if( isequal( subdir( i ).name, '.' )||...
            isequal( subdir( i ).name, '..')||...
            ~subdir( i ).isdir)               % î@â ïsê•ñ⁄??íµ?
            continue;
        end
        subdirpath = fullfile( maindir, subdir( i ).name, '*.mat' );
        mat = dir( subdirpath );               % éqï∂åè?â∫ùQç@??datìIï∂åè
        
        
        for j = 0 : 9
            OS = subdir( i ).name(end-1:end);
            datapath = fullfile(localpath, 'plot_data', OS, num2str(j));
            [L, newL] = create_beta_name(subdir( i ).name, j);
            %L = mat(ismember([mat.name], L));
            %newL = mat(ismember([mat.name], newL));
            Lmatpath = fullfile( maindir, subdir( i ).name, L);
            newLmatpath = fullfile( maindir, subdir( i ).name, newL);
            
            copyfile(Lmatpath,datapath);
            copyfile(newLmatpath,datapath);
        end
    end
    void = 0;
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