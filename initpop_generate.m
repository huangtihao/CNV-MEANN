function initpop = initpop_generate(popsize,S1,S2,S3,P,T)

% 编码长度（权值/阈值总个数）
S = S1*S2 + S2*S3 + S2 + S3;

% 预分配初始种群数组
initpop = zeros(popsize,S+1);

for i = 1:popsize
    % 随机产生一个个体[-1,1]
    x = rand(1,S)*2 - 1;
    
    % 前S1*S2个编码为W1（输入层与隐含层间权值）
    temp = x(1:S1*S2);
    W1 = reshape(temp,S2,S1);
    
    % 接着的S2*S3个编码为W2（隐含层与输出层间权值）
    temp = x(S1*S2+1:S1*S2+S2*S3);
    W2 = reshape(temp,S3,S2);

    % 接着的S2个编码为B1（隐含层神经元阈值）
    temp = x(S1*S2+S2*S3+1:S1*S2+S2*S3+S2);
    B1 = reshape(temp,S2,1);

    %接着的S3个编码B2（输出层神经元阈值）
    temp = x(S1*S2+S2*S3+S2+1:end);
    B2 = reshape(temp,S3,1);
    
    % 计算隐含层神经元的输出
    A1 = tansig(W1*P,B1);
    % 计算输出层神经元的输出
    A2 = purelin(W2*A1,B2);
    % 计算误差
%     A2=abs(A2);
%     abs_error=abs(T-A2);
%     [mmm,nnn]=size(T);
%     SE_1=[1,nnn];
%     for q=1:nnn
%         if (( abs_error(1,q) < abs_error(2,q) && abs_error(1,q) < abs_error(3,q) && abs_error(1,q) < abs_error(4,q) && goutput_train(1,q) == 1)||( abs_error(2,q) < abs_error(1,q) && abs_error(2,q) < abs_error(3,q) && abs_error(2,q) < abs_error(4,q) && goutput_train(2,q) == 1) || ( abs_error(3,q) < abs_error(1,q) && abs_error(3,q) < abs_error(2,q) && abs_error(3,q) < abs_error(4,q) && goutput_train(3,q) == 1) || (abs_error(4,q) < abs_error(1,q) && abs_error(4,q) < abs_error(2,q) && abs_error(4,q) < abs_error(3,q) && goutput_train(4,q) == 1)) 
%             SE_1(1,q)=0.001;
%         else
%             SE_1(1,q)=10;
%         end
%     end
%     SE = sum(SE_1);
    SE = mse(T-A2);
    % 思维进化算法的得分
    val = 1 / SE;
    % 个体与得分合并
    initpop(i,:) = [x val];
end