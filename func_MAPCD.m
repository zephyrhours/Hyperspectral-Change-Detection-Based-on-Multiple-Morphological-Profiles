function Result= func_MAPCD(hsi_t1,hsi_t2,AP_hsi_t1,AP_hsi_t2,winsize)
%% Morphology Attribute Profile Change Detection (MAPCD)
% Author; Zephyr Hou
% Time: 2020-11-13
%%
% Function usage:
%  Input: 
%       hsi_t1 -- the 3D hyperspectral imagery(rows x cols x bands) at t1 time 
%       hsi_t2 -- the 3D hyperspectral imagery(rows x cols x bands) at t2 time 
%       AP_hsi_t1 -- the attribute profile reconstruction image at t1 time (rows x cols x dim1)
%       AP_hsi_t2 -- the attribute profile reconstruction image at t2 time (rows x cols x dim2)
%       win_out - spatial size window of outer(e.g., 3, 5, 7, 9,...)
%       win_in - spatial size window of inner(e.g., 3, 5, 7, 9,...)
%  Output: 
%       Result -- the 2D detection result with the size of rows x cols 
%
% Proposed by Zephyr Hou
%% ====================== Main Function =========================
%% Parameter judgment 
if (nargin == 4)
    winsize = 5;
end

%% AP dataset normalization
AP_hsi_t1=(AP_hsi_t1-min(AP_hsi_t1(:)))/(max(AP_hsi_t1(:))-min(AP_hsi_t1(:)));
AP_hsi_t2=(AP_hsi_t2-min(AP_hsi_t2(:)))/(max(AP_hsi_t2(:))-min(AP_hsi_t2(:)));

%% Spectral domain 
R01= func_SALA(hsi_t1,hsi_t2);

%% Spatial domain
R02= func_AD(AP_hsi_t1,AP_hsi_t2);

%% Guided Filtering
Result = imguidedfilter(R01,R02,'NeighborhoodSize',[winsize,winsize]); % £¨SantaBarbara maxtreeCD=[17,17]/mintreeCD=[21,21],others default£©
end









