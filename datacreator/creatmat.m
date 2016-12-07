
for si = 100:50:200
    for ri = 5:5:15
        for OS = 10:10:30
            fixedrank_tensor_completion(si, ri, OS);
        end
    end
end