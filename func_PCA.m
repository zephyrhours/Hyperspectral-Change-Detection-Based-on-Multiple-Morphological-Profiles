function PCAImg= func_PCA(hsi,PCs)
%% PCA �任������ʵ�ָ߹����������ɷ���ȡ
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

% �Զ�ȷ��ѡ������ɷָ���
if nargin<2
    rate = 0.9999;%�ò����ɵ�   
    Sumva1 = rate * sum(Deigvalue); % ���ܺ�0.99999������Сȡ������ֵ
    T0=cumsum(Deigvalue);           % cumsumΪ�ۼӺ����������ۼ�  
    ki=find(T0>Sumva1);   
    PCs=ki(1);
end

EigVector=Deigvector(:,1:PCs);
PCAImg=hsi*EigVector;  % pixels x PCs

PCAImg=reshape(PCAImg,rows,cols,PCs);

end

