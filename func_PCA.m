function PCAImg= func_PCA(hsi,PCs)
%% PCA 变换函数，实现高光谱数据主成分提取
%  Compiled by Zephyr Hou on 2020-05-22
%  Function Usage:
%  Input:
%       hsi -- the hyperspectral imagery with the size of rows x cols x bands
%       PCs -- the number of Principal Components
%  Output:
%       PCAImg --  the output imagery after PCA with the size of rows x cols x PCs
%%
[rows,cols,bands]=size(hsi);
pixels=rows*cols;

hsi=reshape(hsi,pixels,bands); % pixels x bands

meanVal=mean(hsi,1);           % 1 x bands
hsi=hsi-repmat(meanVal,pixels ,1);  % pixels x bands

CovMat=(hsi'*hsi)/pixels;

[eigvector, eigvalue]=eig(CovMat);

[Deigvalue,ind]=sort(diag(eigvalue),'descend');
Deigvector=eigvector(:,ind');

% 自动确定选择的主成分个数
if nargin<2
    rate = 0.9999;%该参数可调   
    Sumva1 = rate * sum(Deigvalue); % 按总和0.99999比例大小取舍特征值
    T0=cumsum(Deigvalue);           % cumsum为累加函数，向下累加  
    ki=find(T0>Sumva1);   
    PCs=ki(1);
end

EigVector=Deigvector(:,1:PCs);
PCAImg=hsi*EigVector;  % pixels x PCs

PCAImg=reshape(PCAImg,rows,cols,PCs);

end

