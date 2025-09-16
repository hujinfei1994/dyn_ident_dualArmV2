clear;clc;close all
filename ='flexiv_data_write_validation.mat';
load(filename)
load T_flexiv.mat
DOF = 7;
%cond_num = '99';
%cond_num = '106';
%cond_num = '117';
%cond_num = '122';
% filename = [ 'beta_hat_x_',num2str(cond_num),'.mat'];
% load(filename)

%% 赋值beta
beta_hat = zeros(51,1);
load betaM_offdiag.mat
beta_hat(1) = beta1;
beta_hat(2) = beta2;
beta_hat(3) = beta3;
beta_hat(4) = beta4;
beta_hat(5) = beta5;

beta_hat(6) = beta7;
beta_hat(7) = beta8;
beta_hat(8) = beta9;
beta_hat(9) = beta10;
beta_hat(10) = beta11;

beta_hat(11) = beta13;
beta_hat(12) = beta14;
beta_hat(13) = beta15;
beta_hat(14) = beta16;
beta_hat(15) = beta17;

beta_hat(16) = beta19;
beta_hat(17) = beta20;
beta_hat(18) = beta21;
beta_hat(19) = beta22;
beta_hat(20) = beta23;

beta_hat(1) = 1.5;
beta_hat(2:20) = 0;

load betaM_diag.mat
beta_hat(21) = beta25;
beta_hat(22) = beta26;
beta_hat(23) = beta27;
beta_hat(24) = beta28;
beta_hat(25) = beta29;
beta_hat(26) = beta30;
beta_hat(27) = beta31;


load betaG.mat
beta_hat(28) = beta32;
beta_hat(29) = beta33;
beta_hat(30) = beta34;
beta_hat(31) = beta35;
beta_hat(32) = beta36;
beta_hat(33) = beta38;
beta_hat(34) = beta39;
beta_hat(35) = beta40;
beta_hat(36) = beta41;
beta_hat(37) = beta42;



%% 滤波求数据
qf = q_filtered;
qf_dot = q_dot_filtered;
qf_ddot = q_ddot_filtered;
uf = jointacttorque_filtered;
M = size(q_filtered,1);

%% 画图验证
uf_est = zeros(size(uf));
for i = 1:M
    Ys = Y_flexiv_symoro(qf(i,:)',qf_dot(i,:)',qf_ddot(i,:)');
    Y = Ys*T_pinv_70_by_37;
    Yf = zeros(DOF,DOF*2);
    for jnt = 1:DOF
        Yf(jnt,2*jnt-1) = qf_dot(i,jnt);
        Yf(jnt,2*jnt) = sign(qf_dot(i,jnt));
    end
    Y = [Y,Yf];
    U = uf(i,:)';
   u_est(i,:) = (Y*beta_hat)';
end



%% plot
Ts = 0.001;
time = 0:Ts:Ts*(size(qf,1)-1);
figure(1)
u_est = u_est + (uf-u_est)*0;
for i = 1:7
    subplot(2,4,i)
    plot(time,u_est(:,i))
    hold on
    plot(time,uf(:,i))
    legend('estimate','true')
end

figure(2)
p(1) = subplot(3,1,1);
plot(time,uf(:,1),time,u_est(:,1))
legend('act','est')
title('joint1')
p(2) = subplot(3,1,2);
plot(time,uf(:,1)-u_est(:,1))
title('joint1TorqueError')
p(3) = subplot(3,1,3);
plot(time,qf_dot(:,1))
title('joint1Vel')
linkaxes(p,'x')

figure(3)
p(1) = subplot(3,1,1);
plot(time,uf(:,2),time,u_est(:,2))
legend('act','est')
title('joint2')
p(2) = subplot(3,1,2);
plot(time,uf(:,2)-u_est(:,2))
title('joint2TorqueError')
p(3) = subplot(3,1,3);
plot(time,qf_dot(:,1))
title('joint1Vel')
linkaxes(p,'x')

figure(4)
p(1) = subplot(3,1,1);
plot(time,uf(:,3),time,u_est(:,3))
legend('act','est')
title('joint3')
p(2) = subplot(3,1,2);
plot(time,uf(:,3)-u_est(:,3))
title('joint3TorqueError')
p(3) = subplot(3,1,3);
plot(time,qf_dot(:,1))
title('joint1Vel')
linkaxes(p,'x')

figure(5)
p(1) = subplot(3,1,1);
plot(time,uf(:,4),time,u_est(:,4))
legend('act','est')
title('joint4')
p(2) = subplot(3,1,2);
plot(time,uf(:,4)-u_est(:,4))
title('joint4TorqueError')
p(3) = subplot(3,1,3);
plot(time,qf_dot(:,1))
title('joint1Vel')
linkaxes(p,'x')

figure(6)
p(1) = subplot(3,1,1);
plot(time,uf(:,5),time,u_est(:,5))
legend('act','est')
title('joint5')
p(2) = subplot(3,1,2);
plot(time,uf(:,5)-u_est(:,5))
title('joint5TorqueError')
p(3) = subplot(3,1,3);
plot(time,qf_dot(:,1))
title('joint1Vel')
linkaxes(p,'x')


figure(7)
p(1) = subplot(3,1,1);
plot(time,uf(:,6),time,u_est(:,6))
legend('act','est')
title('joint6')
p(2) = subplot(3,1,2);
plot(time,uf(:,6)-u_est(:,6))
title('joint6TorqueError')
p(3) = subplot(3,1,3);
plot(time,qf_dot(:,1))
title('joint1Vel')
linkaxes(p,'x')

figure(8)
p(1) = subplot(3,1,1);
plot(time,uf(:,7),time,u_est(:,7))
legend('act','est')
title('joint7')
p(2) = subplot(3,1,2);
plot(time,uf(:,7)-u_est(:,7))
title('joint7TorqueError')
p(3) = subplot(3,1,3);
plot(time,qf_dot(:,1))
title('joint1Vel')
linkaxes(p,'x')

figure(9)
for i = 1:7
    subplot(2,4,i)
    plot(time,uf(:,i),time,u_est(:,i))
    legend('act','est')
end

save('results_decouple.mat','time','uf','u_est')

