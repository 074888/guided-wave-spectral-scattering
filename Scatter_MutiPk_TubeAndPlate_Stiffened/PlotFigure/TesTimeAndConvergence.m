clear;close all;clc
time_var = 0;
N_var = 0;
convergenceAll = 0;
for N=5:5:90
    Tube_Tube_Single_Scaterr
    
    time_var = [time_var elapsed_time];
    convergenceAll = [convergenceAll convergence]
    N_var = [N_var N];
end
figure(110)
plot(N_var,time_var,"*r");hold on
plot(N_var,time_var,"-k");hold on

xlabel('离散点数')
ylabel('求解时间(s)')
title('计算散射矩阵所需的时间')
grid on
grid minor

figure(111)
plot(N_var,convergenceAll,"*b");hold on
plot(N_var,convergenceAll,"-g");hold on

xlabel('离散点数')
ylabel('第一入射模式的能量总和')
title('取点数与收敛性')
grid on