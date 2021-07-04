function Res= func_AD(hsi_t1,hsi_t2)
%% Absolute Distance(AD)
% Author: ZephyrHou
% Time: 2020-06-17
%
% Function usage:
%  Input: 
%       hsi_t1 -- the 3D hyperspectral imagery(rows x cols x bands) at t1 time 
%       hsi_t2 -- the 3D hyperspectral imagery(rows x cols x bands) at t2 time 
%  Output: 
%          Res -- the 2D detection result with the size of rows x cols 
%
% Reference:
%        1.Fusion of Difference Images for Change Detection Over Urban
%        Areas
%% Main Function
Res=sum(abs(hsi_t2-hsi_t1),3);

end
