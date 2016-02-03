function [ncoord,nelnodes,elident]=T2D4
%====================== No. integration points =============================
%
%   Defines the number of integration points:be used for
%   each element type
% 
   
n = 1;
ncoord = 2;
nelnodes = 3;


        
%
%====================== INTEGRATION POINTS ==================================
%
%   Defines positions of integration points

 xi(1,1) = 1./3.;
 xi(2,1) = 1./3.;
%
 
         
         
         %================= INTEGRATION WEIGHTS ==================================
%
%   Defines integration weights w_i
%



 w(1) = 0.5;
     
   %
%================= SHAPE FUNCTIONS ==================================
%
%        Calculates shape functions for various element types
%
 

   N = zeros(nelnodes,1);

  N(1) = xi(1);
       N(2) = xi(2);
       N(3) = 1.-xi(1)-xi(2); 
       
       %================= SHAPE FUNCTION DERIVATIVES ======================
%


  dNdxi = zeros(nelnodes,ncoord);

%  2D elements

%    Triangular element
%
       dNdxi(1,1) = 1.;
       dNdxi(2,2) = 1.;
       dNdxi(3,1) = -1.;
       dNdxi(3,2) = -1.;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


