% step 1 portfolio
Datas = xlsread('data.xlsx');
Data = Datas([2:end],[1:end]); %��������
Data = flipud(Data);  %����
rdata = price2ret(Data(:,[3:end]));
[row, col] = size(Data);
weights = ones(30,1) /30;  % ��ʼ��Ȩ�����ã�
acc_money = [];
money = sum(Data(1,[3:end]))/30;  %�ʼ���ܽ�
acc_money(1,1) = Data(1,1);  % ��һ��ΪSPX
acc_money(1,2) = Data(1,2);  % �ڶ���ΪREN
acc_money(1,3) = money;      % ������Ϊportfilio����
nums = ones(1, 30)/30;   % ÿֻ��Ʊ��ʵ�ʹ�Ʊ����
for i=6:5:row
    count = 1 + floor(i/6);
    money = sum(nums.*Data(i,[3:end]));    % �����ܽ��
    acc_money(count, 1) = Data(i, 1);
    acc_money(count, 2) = Data(i,2);
    acc_money(count, 3) = money;
    expect_weight = pca(rdata([max(i-6,1):i-2], :));  % �������Ȩ��
    nums = (money * expect_weight)./Data(i,[3:end]);  % ���·���õ�������Ʊ�ĳֲ���;
end
for i=1:3
acc_money(:,i) = acc_money(:,i)/acc_money(1,i);
end
plot(acc_money);
legend('spx', 'fnertr', 'port2');
saveas(gcf,'portfolio2.jpg');
[acc_row, acc_col] = size(acc_money);
for i=1:15
disp([num2str(i),'��:']);
disp(acc_money(min(50*i,acc_row),:));
if 50*i > acc_row
    break
end
end