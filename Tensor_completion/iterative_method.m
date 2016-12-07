function eta_new = iterative_method(eta_old, X, b, ti)
    X = prepare(X);
    dX = caldX(X, eta_old);
    ATAeta = inv_tucker2multiarray(eta_old, dX);
    %narg = nargin(iterative_method);
   % switch narg
           % case 3
                eta_new.G =  eta_old.G - ti*(ATAeta.G - b.G);
                eta_new.U1 = eta_old.U1 - ti*(ATAeta.U1/X.G1G1t - b.U1);%(eta_old.U1/X.G1G1t - ATAeta.U1 + b.U1)*X.G1G1t;
                eta_new.U2 = eta_old.U2 - ti*(ATAeta.U2/X.G2G2t - b.U2);
                eta_new.U3 = eta_old.U3 - ti*(ATAeta.U3/X.G3G3t - b.U3);

          %  case 4
            %    eta_new.G = (eta_old.G - ATAeta.G + b.G);
            %    eta_new.U1 = (eta_old.U1 - (X.G1G1t.'*ATAeta.U1) + b.U1);%(eta_old.U1/X.G1G1t - ATAeta.U1 + b.U1)*X.G1G1t;
            %    eta_new.U2 = (eta_old.U2 - (X.G2G2t.'*ATAeta.U2) + b.U2);
            %    eta_new.U3 = (eta_old.U3 - (X.G3G3t.'*ATAeta.U3) + b.U3);

    %end
    
    
end

function X = prepare(X)
        if ~all(isfield(X,{'G1G1t','G1',...
                'G2G2t','G2', ...
                'G3G3t','G3'}) == 1)
            
            X.G1 =  reshape(X.G, r1, r2*r3);
            X.G1G1t = X.G1*X.G1'; % Positive definite  
             
            
            X.G2 = reshape(permute(X.G, [2 1 3]), r2, r1*r3); 
            X.G2G2t = X.G2*X.G2'; % Positive definite  
            
            
            X.G3 = reshape(permute(X.G, [3 1 2]), r3, r1*r2);  
            X.G3G3t = X.G3*X.G3'; % Positive definite  
        end
        
        
end
    
function dX = caldX(X, eta)
    
    dG.U1 = X.U1;
    dG.U2 = X.U2;
    dG.U3 = X.U3;
    dG.G = eta.G;
    
    dU1.U1 = eta.U1;
    dU1.U2 = X.U2;
    dU1.U3 = X.U3;
    dU1.G = X.G;
    
    dU2.U1 = X.U1;
    dU2.U2 = eta.U2;
    dU2.U3 = X.U3;
    dU2.G = X.G;
    
    dU3.U1 = X.U1;
    dU3.U2 = X.U2;
    dU3.U3 = eta.U3;
    dU3.G = X.G;
    
    dX = tucker2multiarray(dG) + tucker2multiarray(dU1) ...
        + tucker2multiarray(dU2) + tucker2multiarray(dU3);

end