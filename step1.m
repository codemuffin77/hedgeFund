% step 1 portfolio
Datas = xlsread('data.xlsx');
Data = Datas([2:end],[1:end]); %��������
Data = flipud(Data);  %����
accReturnSPX = Data(:,1)/Data(1,1);  % ����SPX������ۼ�������
accReturnFNERTR = Data(:,2)/Data(1,2);  % ����FNERTR������ۼ�������
equal_w_portfolio = sum(Data(:,[3:end])/30,2); % ��Ȩ���еļ۸�
acc_equalWeight = equal_w_portfolio/equal_w_portfolio(1) %��Ȩ���е��ۼ�������

plot([accReturnSPX, accReturnFNERTR,acc_equalWeight]);
legend('spx', 'fnertr', 'equalweight');
saveas(gcf,'portfolio1.jpg');

acc_money = [accReturnSPX, accReturnFNERTR,acc_equalWeight];
% ���1�꣬2�꣬3�꣬4��ıȽϽ��
[acc_row, acc_col] = size(acc_money);
for i=1:15
disp([num2str(i),'��:']);
disp(acc_money(min(250*i,acc_row),:));
if 250*i > acc_row
    break
end
end