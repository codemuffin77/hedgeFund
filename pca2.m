function ar = pca2(Data)
% Data is the daily return of each stocks, expect 5*30
% expect_return is the expect return of 30 elements
% weights is the weight of each stocks according to pca model
%create the covariance and correlation matrix
covDJI = cov(Data) ;
%PCA analysis
[COEFF,latent,explained] = pcacov(covDJI);
sum_assets = sum(diag(covDJI)); % 资产的方差和;

sixpcas = [];
% 30个股票，取前6个主成分
for i=1:6
    sixpcas(:,i) = Data*(COEFF(i,:).'); %
end
covDJII = cov(sixpcas);
sum_pcas = sum(diag(covDJII));  % 主成分的方差
ar = sum_pcas/sum_assets;
