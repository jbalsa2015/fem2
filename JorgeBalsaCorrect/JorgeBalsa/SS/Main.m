% This program solves a convection-diffusion problem 
% in a square domain [0,1]x[0,1] using bilinear elements.
% 

clear, close all, home

global diffusion  h 

% 
%disp(' ')
%disp('This program solves a diffusion equation on [0,1]x[0,1]')
%disp(' ')
%disp('No source term is considered');
X=load('../nodes_2D_quad_linear.dat');
T=load('../elm_2D_quad_linear.dat');

%
X = X(:,2:3);
T = T(:,2:5);
nnode = length(X);
nelem = length(T);
%

%nx = sqrt(length(T));
%ny = nx; h = 1/nx;

save('elements.dat','T','-ascii');
save('nodes.dat','X','-ascii');

diffusion= load('properties.dat');

%diffusion = input('Diffusion coefficient = ');
%disp(' ')



% GEOMETRY
% Matrix of nodel coordinates and conectivities
%[X,T] = CreateMesh(0,1,0,1,nx,ny);
%


% NUMERICAL INTEGRATION
% Number of gauss points
ngaus = 4;
% Quadrature,Shape Functions
[n,wpg,pospg,N,dNdxi] = C2D4 ;

% SYSTEM RESULTING OF DISCRETIZING THE WEAK FORM
[K,f] = CreateMatrix(X,T,pospg,wpg,N,dNdxi);

% BOUNDARY CONDITIONS 
% Boundary conditions are imposed using Lagrange multipliers

% nodes_y0 = [1:nx+1]';                           % Nodes on the boundary y=0
% nodes_x1 = [2*(nx+1):nx+1:(ny+1)*(nx+1)]' ;     % Nodes on the boundary x=1
% nodes_y1 = [ny*(nx+1)+nx:-1:ny*(nx+1)+1]' ;     % Nodes on the boundary y=1
% nodes_x0 = [(ny-1)*(nx+1)+1:-(nx+1):nx+2]';     % Nodes on the boundary x=0

%plot_BC;
%disp ('On G1 solution is set to 1');
%disp ('On G2 solution is set to 0');
%disp ('On G3 either natural or essential homogeneous boundary conditions can be imposed.')
%BC = input ('Condiciones en G3 (1:Neumann, 2: Dirichlet):  ');
%if BC == 1   
    % nodes on which solution is u=1
 %   nodesDir1 = [nodes_x0(1:ny-2)];
    % nodes on which solution is u=0
 %   nodesDir0 = [nodes_x0(ny-1);nodes_y0];
    % Boundary condition matrix
 %   C = [nodesDir1, ones(length(nodesDir1),1);
  %       nodesDir0, zeros(length(nodesDir0),1)];
  

  
%elseif BC == 2
    % nodes on which solution is u=1
 %   nodesDir1 = [nodes_x0(1:ny-2)];
    % nodes on which solution is u=0
  %  nodesDir0 = [nodes_x0(ny-1); nodes_y0; nodes_x1; nodes_y1 ];
    % Boundary condition matrix
   % C = [nodesDir1, ones(length(nodesDir1),1);
    %     nodesDir0, zeros(length(nodesDir0),1)];
%else 
 %   error ('Error imposing boundary conditions' );
  %  end

     %nodes on which solution is u=1
    nodesDir1 = [1 14 75 76 77 78 79 80]';
   % nodes on which solution is u=0
    nodesDir0 = [4 5 6 7 8 9 10 11 12]';
    %Boundary condition matrix
    C = [nodesDir1, ones(length(nodesDir1),1);
         nodesDir0, zeros(length(nodesDir0),1)];

ndir = size(C,1);
neq  = size(f,1);
A = zeros(ndir,neq);
A(:,C(:,1)) = eye(ndir);
b = C(:,2);


% SOLUTION OF THE LINEAR SYSTEM
% Entire matrix
Ktot = [K A';A zeros(ndir,ndir)];
ftot = [f;b];



sol = Ktot\ftot;
save('sol.dat','sol','-ascii');
% disp(sol);
Temp = sol(1:neq);
%
save('Temp.dat','Temp','-ascii');
%
multip = sol(neq+1:end);

% POSTPROCESS


