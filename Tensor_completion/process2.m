function process2(filemat)
    cd mat;
    load((filemat), 'problem_description');
    cd ../data_r4/;

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

    fprintf('%s\t%s\n\n', func2str(p.params.solver), func2str(p.params.linesearch));
    fixedrank_tensor_completion(p);

    diary off;
    cd ..;
end