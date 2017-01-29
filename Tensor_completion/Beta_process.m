function Beta_process(filemat)
    cd mat;
    load((filemat), 'problem_description');
    cd ../data_beta_v2/;

    p = problem_description;
    u = '_';
    OS = p.OS;
    foldername = [num2str(p.tensor_size(1)), u, num2str(p.tensor_rank(1)),...
        u, num2str(OS)];
    p.foldername = foldername;
    if ~exist((foldername),'dir') == 1
           mkdir (foldername);
    end
    data_file_name = ['./', foldername, '/', foldername, '.txt'];
    delete (data_file_name);
    diary(data_file_name);
    fprintf('%s', 'tensor_size');
    disp(p.tensor_size);
    fprintf('%s', 'tensor_rank');
    disp(p.tensor_rank);
    fprintf('%s', 'OS');
    disp(OS);
    bp = 1;
    for i = 0:0
        p.params.beta_para = i;
        p.params.solver = @steepestdescent;
        fprintf('=============> beta: %s <==============\n', num2str(p.params.beta_para/5));
        p.params.linesearch = @linesearchguess2;
        fprintf('%s\t%s\n', func2str(p.params.solver), func2str(p.params.linesearch));
        fixedrank_tensor_completion(p);
        p.params.linesearch = @linesearchdefault;
        fprintf('\n\n%s\t%s\n', func2str(p.params.solver), func2str(p.params.linesearch));
        fixedrank_tensor_completion(p);
        fprintf('\n\n');
    end


    diary off;
    cd ..;
end
