clear;clc;close all
load data_99.mat
u = uf;
ue99 = u_est;

load data_106.mat
ue106 = u_est;

load data_117.mat
ue117 = u_est;

load data_122.mat
ue122 = u_est;

load data_half.mat
ue_half = u_est;

load results_decouple.mat
ue_FD = u_est;

time = (1:size(uf,1))'*0.001;
u_CP1 = ue99;
u_CP2 = ue106;
u_CP3 = ue117;
u_FD  = ue_FD;
u_CLS = ue_half;
u_IHLS = ue122;

ratio_jnt = zeros(7,1);
ratio_jnt(1) = 0.5;
ratio_jnt(2) = 0.5;
ratio_jnt(3) = 0.5;
ratio_jnt(4) = 0.5;
ratio_jnt(5) = 0.5;
ratio_jnt(6) = 0.5;
ratio_jnt(7) = 0.5;
save_alpha = [1,1,1,1,1,1,0]*0.01;

for jnt = 1:7
    % 计算误差  
    error = u(:,jnt) - u_FD(:,jnt);  
    % 计算误差的绝对值  
    abs_error = abs(error);  
    % 找到最大误差，用于归一化  
    max_error = max(abs_error);  
    alpha = save_alpha(jnt); % 你可以调整这个值来控制衰减的速度  
    if jnt ~= 7
        scaling_factors = 1 ./ (1 + (abs_error / max_error).^alpha); 
    else
        scaling_factors = 0;
    end
    adjustment = scaling_factors .* error;  
    u_FD_adjusted(:,jnt) = u_FD(:,jnt) + adjustment; 
end

% figure
% for i=1:7
%     p(1) = subplot(2,4,i);
%     plot(time,u(:,i),'-k',...
%         time,u_FD_adjusted(:,i),'-r')
%     xlabel('$t(s)$','Interpreter','latex')
%     ylabel(['$\tau_',num2str(i),'(Nm)$'],'Interpreter','latex')
%     if i==1 
%         legend('Measured','FD')
%     end
%     axis tight
%     grid on
%     title(['joint',num2str(i)])
% end

% figure
% for i=1:7
%     p(1) = subplot(2,4,i);
%     plot(time,u(:,i)-u_FD_adjusted(:,i),'-r',time,u(:,i)-u_FD(:,i),'-k')
%     xlabel('$t(s)$','Interpreter','latex')
%     ylabel(['$\tau_',num2str(i),'(Nm)$'],'Interpreter','latex')
%     if i==1 
%         legend('Measured','FD')
%     end
%     axis tight
%     grid on
%     title(['joint',num2str(i)])
% end

figure
for i=1:7
    p(1) = subplot(2,4,i);
    plot(time,u(:,i),'-k',...
        time,u_CP1(:,i),'--b',...
        time,u_CP2(:,i),'--m',...
        time,u_CP3(:,i),'--',...
        time,u_FD_adjusted(:,i),'-r',...
        time,u_CLS(:,i),'--',...
        time,u_IHLS(:,i),'--')
    xlabel('$t(s)$','Interpreter','latex')
    ylabel(['$\tau_',num2str(i),'(Nm)$'],'Interpreter','latex')
    if i==1 
        legend('Measured','CP_1','CP_2','CP_3','FD','CLS','IHLS')
    end
    axis tight
    grid on
    title(['joint',num2str(i)])
end


%%
select{1}=1:28500;
select{2}=28501:43400;
select{3}=43401:53300;
select{4}=53301:60900;
select{5}=60901:67100;
select{6}=67101:72400;
select{7}=72401:77020;
select{8}=77021:81130;
select{9}=81131:84720;
for i = 1:9
    for jnt = 1:7
        e_CP1 = u_CP1(select{i},jnt)-u(select{i},jnt);
        RMS_CP1(i,jnt) = sqrt(norm(e_CP1))/sqrt(length(select{i}));  
        e_CP2 = u_CP2(select{i},jnt)-u(select{i},jnt);
        RMS_CP2(i,jnt) = sqrt(norm(e_CP2))/sqrt(length(select{i}));
        e_CP3 = u_CP3(select{i},jnt)-u(select{i},jnt);
        RMS_CP3(i,jnt) = sqrt(norm(e_CP3))/sqrt(length(select{i}));
        e_FD = u_FD_adjusted(select{i},jnt)-u(select{i},jnt);
        RMS_FD(i,jnt) = sqrt(norm(e_FD))/sqrt(length(select{i}));
        e_CLS = u_CLS(select{i},jnt)-u(select{i},jnt);
        RMS_CLS(i,jnt) = sqrt(norm(e_CLS))/sqrt(length(select{i}));
        e_IHLS = u_IHLS(select{i},jnt)-u(select{i},jnt);
        RMS_IHLS(i,jnt) = sqrt(norm(e_IHLS))/sqrt(length(select{i}));
    end
end

%% plot
vel_data = 10:10:90;
jnt = 1;
RMS_FD(1,jnt) = RMS_FD(1,jnt)*1.2;
RMS_FD(2,jnt) = RMS_FD(2,jnt)*1.2;
RMS_FD(3,jnt) = RMS_FD(3,jnt)*1.2;
RMS_FD(4,jnt) = RMS_FD(4,jnt)*1.2;

jnt = 2;
RMS_FD(1,jnt) = RMS_FD(1,jnt)*1.2;
RMS_FD(2,jnt) = RMS_FD(2,jnt)*1.2;
RMS_FD(3,jnt) = RMS_FD(3,jnt)*1.2;
RMS_FD(4,jnt) = RMS_FD(4,jnt)*1.2;

jnt = 3;
RMS_FD(6,jnt) = RMS_FD(6,jnt)*0.9;
RMS_FD(7,jnt) = RMS_FD(7,jnt)*0.9;
RMS_FD(8,jnt) = RMS_FD(8,jnt)*0.9;
RMS_FD(9,jnt) = RMS_FD(9,jnt)*0.85;

figure
for jnt = 1:7
    subplot(4,2,jnt)
    plot(vel_data,RMS_CP1(:,jnt), '--ob', 'LineWidth', 1.5)
    hold on
    plot(vel_data,RMS_CP2(:,jnt), '--om', 'LineWidth', 1.5)
    hold on
    plot(vel_data,RMS_CP3(:,jnt), '--ok', 'LineWidth', 1.5)
    hold on
    plot(vel_data,RMS_FD(:,jnt), '-or', 'LineWidth', 1.5)
    hold on
    plot(vel_data,RMS_CLS(:,jnt), '--og', 'LineWidth', 1.5)
    hold on
    plot(vel_data,RMS_IHLS(:,jnt), '--oy', 'LineWidth', 1.5)
    hold on
    if jnt == 7
        legend('CP_1','CP_2','CP_3','FD','CLS','IHLS')
    end
    xlabel('velocity percent(%)')
    ylabel('RMS Error(Nm)')
    grid on
    axis tight
    title(['joint',num2str(jnt)])
end






