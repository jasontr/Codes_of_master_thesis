Run_me_first;
Install_mex;
u = '_';
%si = 100;
%ri = 5;
%OS = 10;
%matn = [num2str(si), u, num2str(ri), u, num2str(OS), '.mat'];
%Beta_process(matn);

for si = 100:50:200
    for ri = 5:5:15
        for OS = 10:10:30
            matn = [num2str(si), u, num2str(ri), u, num2str(OS), '.mat'];
             Beta_process(matn);
        end
    end
end
