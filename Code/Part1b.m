clear all;
nx = 200; ny = 300;
G = sparse(nx*ny, nx*ny);
V = zeros(nx, ny);
V2 = zeros(nx, ny);
F = zeros(nx*ny, 1);
SumV2 = zeros(nx, ny);
Vo = 1;
% Numerical
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
            F(n) = 1;
        elseif j == 1       % Bottom     
            G(n, nxm) = 0;         
            G(n, nxp) = 0;          
            G(n, nyp) = 0; 
            G(n, n) = 1;
        elseif j == ny      % Top
            G(n, nxm) = 0;         
            G(n, nxp) = 0;                   
            G(n, nym) = 0; 
            G(n, n) = 1;
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

%Analytical
L = 300e-9;
W = 200e-9;
a = W;
b = L/2;
x = linspace(-b,b,nx);
y = linspace(0,a,ny);
for ind = 1:2:100
    for xx = 1:nx
        for yy = 1:ny  
            V2(xx,yy) = cosh(ind*pi*x(xx)/a) / (cosh(ind*pi*b/a)*ind) * sin(ind*pi*y(yy)/a);
        end 
    end 
    SumV2 = SumV2 + 4*Vo/pi*V2;
end
subplot(1,2,1),surf(V,'linestyle','none')
title('Numerical Solution - Saddle')
subplot(1,2,2),surf(SumV2,'linestyle','none')
title('Analytical Solution - Saddle')