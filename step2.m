% step 1 portfolio
Datas = xlsread('data.xlsx');
Data = Datas([2:end],[1:end]); %读入数据
Data = flipud(Data);  %逆序
rdata = price2ret(Data(:,[3:end]));
[row, col] = size(Data);
weights = ones(30,1) /30;  % 初始化权重配置；
acc_money = [];
money = sum(Data(1,[3:end]))/30;  %最开始的总金额；
acc_money(1,1) = Data(1,1);  % 第一列为SPX
acc_money(1,2) = Data(1,2);  % 第二列为REN
acc_money(1,3) = money;      % 第三列为portfilio收益
nums = ones(1, 30)/30;   % 每只股票的实际股票数；
for i=6:5:row
    count = 1 + floor(i/6);
    money = sum(nums.*Data(i,[3:end]));    % 当期总金额
    acc_money(count, 1) = Data(i, 1);
    acc_money(count, 2) = Data(i,2);
    acc_money(count, 3) = money;
    expect_weight = pca(rdata([max(i-6,1):i-2], :));  % 理想分配权重
    nums = (money * expect_weight)./Data(i,[3:end]);  % 重新分配得到各个股票的持仓量;
end
for i=1:3
acc_money(:,i) = acc_money(:,i)/acc_money(1,i);
end
plot(acc_money);
legend('spx', 'fnertr', 'port2');
saveas(gcf,'portfolio2.jpg');
[acc_row, acc_col] = size(acc_money);
for i=1:15
disp([num2str(i),'年:']);
disp(acc_money(min(50*i,acc_row),:));
if 50*i > acc_row
    break
end
end