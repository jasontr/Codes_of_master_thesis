u = '_';
for si = 100:50:200
    for ri = 5:5:15
        for OS = 10:10:30
            matn = [num2str(si), u, num2str(ri), u, num2str(OS), '.mat'];
            process2(matn);
        end
    end
end