function weights = pca(Data)
% Data is the daily return of each stocks, expect 5*30
% expect_return is the expect return of 30 elements
% weights is the weight of each stocks according to pca model
%create the covariance and correlation matrix
covDJI = cov(Data) ;
%PCA analysis
[COEFF,latent,explained] = pcacov(covDJI);
%annualized return for all 30 components
stockReturn = mean(Data,1) * 250;
A = stockReturn.';
expect_return = COEFF * A;
weight = [];   % PCA֮���portfilioȨ��
expect_return(expect_return < 0) = 0;  %����Ϊ����element����Ȩ��Ϊ0����ʵ����ΪԤ��Ϊ���Ĳ���������
total_return = sum(expect_return);   % ������

for i=1:30
    weight(i) = expect_return(i)/total_return;
end
real_weight = [];
weight(weight<0) = 0;   % ������Ϊ����element����Ȩ��Ϊ0����ʵ����ΪԤ��Ϊ���Ĳ���������
for i = 1:30            % ��COEFF����Ȩ�صõ�ÿ�����ɵ�Ȩ��
    real_weight(i,:) = COEFF(i,:) * weight(i);
end

weights = sum(real_weight);
weights(weights<0) = 0; % ȥ����Ȩ��
weights = weights/sum(weights);  % ��һ��

