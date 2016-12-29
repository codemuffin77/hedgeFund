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
weight = [];   % PCA之后的portfilio权重
expect_return(expect_return < 0) = 0;  %收益为负的element设置权重为0，现实意义为预期为负的不进行配置
total_return = sum(expect_return);   % 总收益

for i=1:30
    weight(i) = expect_return(i)/total_return;
end
real_weight = [];
weight(weight<0) = 0;   % 将收益为负的element设置权重为0，现实意义为预期为负的不进行配置
for i = 1:30            % 将COEFF乘以权重得到每个个股的权重
    real_weight(i,:) = COEFF(i,:) * weight(i);
end

weights = sum(real_weight);
weights(weights<0) = 0; % 去除负权重
weights = weights/sum(weights);  % 归一化

