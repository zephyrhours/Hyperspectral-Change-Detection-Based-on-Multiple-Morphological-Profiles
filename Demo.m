%% Demo 
% Author: Zephyr Hou
% Time: 2021-07-04
% Reference:
% 1.Hyperspectral Change Detection Based on Multiple Morphological Profiles
clc;clear;close all
%% Load images
[imgname,pathname]=uigetfile('*.*', 'Select the MaxTree *.mat dataset','.\Datasets\');
str=strcat(pathname,imgname);
disp('The dataset is :')
disp(str);
addpath(pathname);
load(strcat(pathname,imgname));

[rows,cols,bands]=size(hsi_t1);
label_value=reshape(hsi_gt,1,rows*cols);

%% Proposed 1: Spectral Angle Weighted-based Local Absolute Distance£¨SALA)
tic
R6= func_SALA(hsi_t1,hsi_t2);
t6=toc;
R6value = reshape(R6,1,rows*cols);
[FA6,PD6] = perfcurve(label_value,R6value,'1') ;
AUC6=-sum((FA6(1:end-1)-FA6(2:end)).*(PD6(2:end)+PD6(1:end-1))/2);
disp(['SALA:    ',num2str(AUC6)])

%% Proposed2: MaxTree CD
tic
R7= func_MAPCD(hsi_t1,hsi_t2,maxAP_hsi_t1,maxAP_hsi_t2);
t7=toc;
R01value = reshape(R7,1,rows*cols);
[FA7,PD7] = perfcurve(label_value,R01value,'1') ;
AUC7=-sum((FA7(1:end-1)-FA7(2:end)).*(PD7(2:end)+PD7(1:end-1))/2);
disp(['MaxTree_CD:    ',num2str(AUC7)])

%% Proposed3: MinTree CD
tic
R8= func_MAPCD(hsi_t1,hsi_t2,minAP_hsi_t1,minAP_hsi_t2);
t8=toc;
R8value = reshape(R8,1,rows*cols);
[FA8,PD8] = perfcurve(label_value,R8value,'1') ;
AUC8=-sum((FA8(1:end-1)-FA8(2:end)).*(PD8(2:end)+PD8(1:end-1))/2);
disp(['MinTree_CD:    ',num2str(AUC8)])

%% AUC Values & Execution Time
disp('-------------------------------------------------------------------')
disp('SALA')
disp(['AUC:     ',num2str(AUC6),'          Time:     ',num2str(t6)])
disp('MaxTreeCD')
disp(['AUC:     ',num2str(AUC7),'          Time:     ',num2str(t7)])
disp('MinTreeCD')
disp(['AUC:     ',num2str(AUC8),'          Time:     ',num2str(t8)])
disp('-------------------------------------------------------------------')

%% Plot ROC Curves
figure;
plot(FA6, PD6, 'b-', 'LineWidth', 2);  hold on
plot(FA7, PD7, 'k-', 'LineWidth', 2);  hold on
plot(FA8, PD8, 'r-', 'LineWidth', 2);  hold on
xlabel('False alarm rate'); ylabel('Probability of detection');
axis([0,0.8,0,1])  
legend('SALA','maxtreeCD','mintreeCD','location','southeast')

%% Enlarged View
figure;
semilogx(FA6, PD6, 'b-', 'LineWidth', 2);  hold on
semilogx(FA7, PD7, 'k-', 'LineWidth', 2);  hold on
semilogx(FA8, PD8, 'r-', 'LineWidth', 2);  hold on
axis([0.28,0.8,0.92,1])  
legend('SALA','maxtreeCD','mintreeCD','location','southeast')







