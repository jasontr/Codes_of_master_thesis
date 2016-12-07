function eta_new = inv_tucker2multiarray(X, dX)

    
    U1 = X.U1;
    U2 = X.U2;
    U3 = X.U3;
    G = X.G;
    X_d = dX;
    
    % Core tensor size
    r1 = size(U1, 2);
    r2 = size(U2, 2);
    r3 = size(U3, 2);
    
    % Full size
    [n1, n2, n3] = size(X_d);
    
    %eta.G
    % Multplication by U1
    X1 = reshape(X_d, n1, n2*n3);
    XU1 = reshape(U1.'*X1, r1, n2, n3);
    
    % Further multplication by U2
    X2 = reshape(permute(XU1, [2 1 3]), n2, r1*n3);
    XU1U2 = permute(reshape(U2.'*X2, r2, r1, n3), [2 1 3]);
    
    % Further multplication by U3
    X3 = reshape(permute(XU1U2, [3 1 2]), n3, r1*r2);    
    XU1U2U3 = permute(reshape(U3.'*X3, r3, r1, r2), [2 3 1]);
    
    eta_new.G = XU1U2U3;% Core tensor
   
    %eta.U1
    
    X2 = reshape(permute(X_d, [2 1 3]), n2, n1*n3);
    XU2 = permute(reshape(U2.'*X2, r2, n1, n3), [2 1 3]);
    
    X3 = reshape(permute(XU2, [3 1 2]), n3, n1*r2);    
    XU2U3 = permute(reshape(U3.'*X3, r3, n1, r2), [2 3 1]);

    X1 = reshape(XU2U3, n1, r2*r3);
    G1 = reshape(G, r1, r2*r3);
    eta_new.U1 = X1*G1.';
    
   %eta.U2 
    
    X1 = reshape(X_d, n1, n2*n3);
    XU1 = reshape(U1.'*X1, r1, n2, n3);
    
    X3 = reshape(permute(XU1, [3 1 2]), n3, r1*n2);    
    XU1U3 = permute(reshape(U3.'*X3, r3, r1, n2), [2 3 1]);
    
    X2 = reshape(permute(XU1U3, [2 1 3]), n2, r1*r3);
    G2 = reshape(permute(G, [2 1 3]), r2, r1*r3);
    eta_new.U2 = X2*G2.';

    %eta.U3
    
    X1 = reshape(X_d, n1, n2*n3);
    XU1 = reshape(U1.'*X1, r1, n2, n3);
    
    X2 = reshape(permute(XU1, [2 1 3]), n2, r1*n3);
    XU1U2 = permute(reshape(U2.'*X2, r2, r1, n3), [2 1 3]);

    X3 = reshape(permute(XU1U2, [3 1 2]), n3, r1*r2);
    G3 = reshape(permute(G, [3 1 2]), r3, r1*r2);
    eta_new.U3 = X3*G3.';
    
end

