function result = func_SALA(hsi_t1,hsi_t2)
%% Spectral Angle Weighted-based Local Abosulte Distance(SALA)
% Proposed and compiled by ZephyrHou on 2020-11-13
%%
% Function usage:
%  Input: 
%       hsi_t1 -- the 3D hyperspectral imagery(rows x cols x bands) at t1 time 
%       hsi_t2 -- the 3D hyperspectral imagery(rows x cols x bands) at t2 time 
%  Output: 
%          result-- the 2D detection result with the size of rows x cols 
% Reference:
%  1. Hyperspectral Change Detection Based on Multiple Morphological Profiles

%% Main Function
% eight-neighborhood pixels
win_out=3;
win_in=1;

[rows, cols, bands] = size(hsi_t1);
result = zeros(rows, cols);
t = fix(win_out/2);
t1 = fix(win_in/2);
M = win_out^2;
%% Adaptive Boundary Filling
DataTest1 = zeros(rows+2*t,cols+2*t, bands);
DataTest1(t+1:rows+t, t+1:cols+t, :) = hsi_t1;
DataTest1(t+1:rows+t, 1:t, :) = hsi_t1(:, t:-1:1, :);
DataTest1(t+1:rows+t, t+cols+1:cols+2*t, :) = hsi_t1(:, cols:-1:cols-t+1, :);
DataTest1(1:t, :, :) = DataTest1(2*t:-1:(t+1), :, :);
DataTest1(t+rows+1:rows+2*t, :, :) = DataTest1(t+rows:-1:(rows+1), :, :);

DataTest2 = zeros(rows+2*t,cols+2*t, bands);
DataTest2(t+1:rows+t, t+1:cols+t, :) = hsi_t2;
DataTest2(t+1:rows+t, 1:t, :) = hsi_t2(:, t:-1:1, :);
DataTest2(t+1:rows+t, t+cols+1:cols+2*t, :) = hsi_t2(:, cols:-1:cols-t+1, :);
DataTest2(1:t, :, :) = DataTest2(2*t:-1:(t+1), :, :);
DataTest2(t+rows+1:rows+2*t, :, :) = DataTest2(t+rows:-1:(rows+1), :, :);
%% SALA core algorithm
for i = t+1:cols+t 
    for j = t+1:rows+t
        block1 = DataTest1(j-t: j+t, i-t: i+t, :);
        y1 = squeeze(DataTest1(j, i, :));   % num_dim x 1
        block1(t-t1+1:t+t1+1, t-t1+1:t+t1+1, :) = NaN;
        block1 = reshape(block1, M, bands);
        block1(isnan(block1(:, 1)), :) = [];
        H1 = block1';  % num_dim x num_sam
		
		block2 = DataTest2(j-t: j+t, i-t: i+t, :);
        y2 = squeeze(DataTest2(j, i, :));   % num_dim x 1
        block2(t-t1+1:t+t1+1, t-t1+1:t+t1+1, :) = NaN;
        block2 = reshape(block2, M, bands);
        block2(isnan(block2(:, 1)), :) = [];
        H2 = block2';  % num_dim x num_sam	
		tempD=sum(abs(H2-H1)); % 1 x num_sam   
        w=(((y1'*y2)/(norm(y1)*norm(y2)))^2);  % weight
        result(j-t, i-t) =sum(tempD)*w;    
    end
end
end




