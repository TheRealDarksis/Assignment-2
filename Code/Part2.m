clear all;
ny = 30; nx = 20;
W = 20e-9; L = 30e-9;
G = sparse(nx*ny, nx*ny);
V = zeros(nx, ny);
F = zeros(nx*ny, 1);
vMap = zeros(nx,ny);
Vo = 1;

cMap = ones(nx, ny);
for i = 8:12
    for j = 1:7
        cMap(i,j) = 0.5;
    end
    for j = 22:30
        cMap(i,j) = 0.5;
    end
end

for i = 1:nx 
    for j = 1:ny
        nxm = j + (i-2)*ny;
        nxp = j + i*ny;
        nyp = j + 1 + (i-1)*ny;
        nym = j - 1 + (i-1)*ny;
        n = j + (i-1)*ny;
        if i == 1           % Left
            G(n, n) = cMap(i,j);
            F(n) = 1;
        elseif i == nx      % Right
            G(n, n) = cMap(i,j);
            F(n) = 0;
        elseif j == 1       % Bottom     
            G(n, nxm) = cMap(i-1,j);         
            G(n, nxp) = cMap(i+1,j);          
            G(n, nyp) = cMap(i,j+1); 
            G(n, n) = -(G(n, nxp)+G(n, nxm)+G(n, nyp));
        elseif j == ny      % Top
            G(n, nxm) = cMap(i-1,j);         
            G(n, nxp) = cMap(i+1,j);                   
            G(n, nym) = cMap(i,j-1); 
            G(n, n) = -(G(n, nxp)+G(n, nxm)+G(n, nym));
        else
            G(n, nxm) = cMap(i-1,j);         
            G(n, nxp) = cMap(i+1,j);          
            G(n, nyp) = cMap(i,j+1);         
            G(n, nym) = cMap(i,j-1);  
            G(n, n) = -(G(n, nxp)+G(n, nxm)+G(n, nym)+G(n, nyp));
        end
    end
end
V = G\F;

for i = 1:nx
    for j = 1:ny
        n = j + (i-1)*ny;
        vMap(i,j) = V(n);
    end
end
[Ex,Ey] = gradient(vMap);
E = sqrt(Ex.^2 + Ey.^2);
J = cMap.*E;

subplot(2,2,1), surf(cMap)
title('Conductivity')
subplot(2,2,2), surf(vMap)
title('V')
subplot(2,2,3), surf(E)
title('E')
subplot(2,2,4), surf(J)
title('J')


