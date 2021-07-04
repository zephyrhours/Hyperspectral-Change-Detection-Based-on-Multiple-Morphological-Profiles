% Time: 2020-08-29
clc;clear;close all
addpath('E:\TestDatasets\ChangeDetection\Binary_datasets')


% load('Hermiston.mat');



hsi_t1=double(hsi_t1);
hsi_t2=double(hsi_t2);
%%
[rows,cols,bands]=size(hsi_t1);

% 归一化处理
% hsi_t1=(hsi_t1-min(hsi_t1(:)))/(max(hsi_t1(:)-min(hsi_t1(:))));
% hsi_t2=(hsi_t2-min(hsi_t2(:)))/(max(hsi_t2(:)-min(hsi_t2(:))));

%%
PCA_t1 = func_PCA(hsi_t1,1);
PCA_t2 = func_PCA(hsi_t2,1);

PCA_t1=(PCA_t1-min(PCA_t1(:)))/(max(PCA_t1(:)-min(PCA_t1(:))));
PCA_t2=(PCA_t2-min(PCA_t2(:)))/(max(PCA_t2(:)-min(PCA_t2(:))));

figure;
subplot(1,5,1);imshow(hsi_t1(:,:,50),[]);title('hsi\_t1');
subplot(1,5,2);imshow(hsi_t2(:,:,50),[]);title('hsi\_t2');
subplot(1,5,3);imshow(hsi_gt,[]);title('hsi\_gt');
subplot(1,5,4);imshow(PCA_t1,[]);title('PCA\_t1');
subplot(1,5,5);imshow(PCA_t2,[]);title('PCA\_t2');

%% 保存结果
multibandwrite(PCA_t1,'cut_santaBarbara_PCA_t1.img','bsq','machfmt','ieee-le','precision','double');% 注意：此处表名，gt为double精度的tif格式
multibandwrite(PCA_t2,'cut_santaBarbara_PCA_t2.img','bsq','machfmt','ieee-le','precision','double');% 注意：此处表名，gt为double精度的tif格式

figure;imshow(PCA_t1,[]);title('PCA\_t1');
figure;imshow(PCA_t2,[]);title('PCA\_t2');











