% step 1 portfolio
Datas = xlsread('data.xlsx');
Data = Datas([2:end],[1:end]); %读入数据
Data = flipud(Data);  %逆序
accReturnSPX = Data(:,1)/Data(1,1);  % 持有SPX不变的累计收益率
accReturnFNERTR = Data(:,2)/Data(1,2);  % 持有FNERTR不变的累计收益率
equal_w_portfolio = sum(Data(:,[3:end])/30,2); % 等权持有的价格
acc_equalWeight = equal_w_portfolio/equal_w_portfolio(1) %等权持有的累计收益率

plot([accReturnSPX, accReturnFNERTR,acc_equalWeight]);
legend('spx', 'fnertr', 'equalweight');
saveas(gcf,'portfolio1.jpg');

acc_money = [accReturnSPX, accReturnFNERTR,acc_equalWeight];
% 输出1年，2年，3年，4年的比较结果
[acc_row, acc_col] = size(acc_money);
for i=1:15
disp([num2str(i),'年:']);
disp(acc_money(min(250*i,acc_row),:));
if 250*i > acc_row
    break
end
end