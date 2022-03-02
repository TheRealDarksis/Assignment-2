clear all;
nx = 20; ny = 30;
G = sparse(nx*ny, nx*ny);
V = zeros(nx, ny);
F = zeros(nx*ny, 1);

for i = 1:nx 
    for j = 1:ny
        nxm = j + (i-2)*ny;
        nxp = j + i*ny;
        nyp = j + 1 + (i-1)*ny;
        nym = j - 1 + (i-1)*ny;
        n = j + (i-1)*ny;
        if i == 1           % Left
            G(n, n) = 1;
            F(n) = 1;
        elseif i == nx      % Right
            G(n, n) = 1;
        elseif j == 1       % Bottom, no nym
            G(n, nxm) = 1;
            G(n, nxp) = 1;          
            G(n, nyp) = 1;         
            G(n, n) = -(G(n, nxp)+G(n, nxm)+G(n, nyp));
        elseif j == ny      % Top, no nyp
            G(n, nxm) = 1;
            G(n, nxp) = 1;                   
            G(n, nym) = 1;
            G(n, n) = -(G(n, nxp)+G(n, nxm)+G(n, nym));            
        else
            G(n, n) = -4;
            G(n, nxm) = 1;         
            G(n, nxp) = 1;          
            G(n, nyp) = 1;         
            G(n, nym) = 1;       
        end
    end
end

M = G\F;
for i = 1:nx
    for j = 1:ny
        n = j + (i-1)*ny;
        V(i,j) = M(n);
    end
end
surf(V,'linestyle','none')