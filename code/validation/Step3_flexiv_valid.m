clear;clc;close all
filename ='flexiv_data_write_validation.mat';
load(filename)
load T_flexiv.mat
DOF = 7;
%cond_num = '99';
%cond_num = '106';
%cond_num = '117';
%cond_num = '122';
cond_num = 'half';
filename = [ 'beta_hat_x_',num2str(cond_num),'.mat'];


load(filename)
qf = q_filtered;
qf_dot = q_dot_filtered;
qf_ddot = q_ddot_filtered;
uf = jointacttorque_filtered;
M = size(q_filtered,1);

%% ª≠Õº—È÷§
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
figure(2)
for i = 1:7
    subplot(2,4,i)
    plot(u_est(:,i));
    hold on
    plot(uf(:,i))
    if i ==7
        legend('estimate','actual')
    end
end

filename = [ 'data_',num2str(cond_num),'.mat'];
save(filename,'u_est','uf')


% figure(2)
% save_U_est = save_Phi*beta_hat_MSP;
% error = save_U_est - save_U;
% for i = 1:7
%     subplot(2,4,i)
%     plot(save_U_est(i:DOF:end));
%     hold on
%     plot(save_U(i:DOF:end))
%     legend('estimate','actual')
% end

%% save
% save('beta_hat.mat','beta_hat_MSP','beta_hat_LS');


% %% plot
% Ts = 0.001;
% time = 0:Ts:Ts*(size(qf,1)-1);
% figure(1)
% for i = 1:6
%     subplot(2,4,i)
%     plot(time,u_est(:,i))
%     hold on
%     plot(time,uf(:,i))
%     legend('estimate','act')
% end
% 
% figure(2)
% p(1) = subplot(3,1,1);
% plot(time,uf(:,3),time,u_est(:,3))
% title('joint3')
% p(2) = subplot(3,1,2);
% plot(time,uf(:,3)-u_est(:,3))
% title('joint3TorqueError')
% p(3) = subplot(3,1,3);
% plot(time,qf_dot(:,3))
% title('joint3Vel')
% linkaxes(p,'x')
% 
% 
% figure(3)
% p(1) = subplot(3,1,1);
% plot(time,uf(:,2),time,u_est(:,2))
% title('joint2')
% p(2) = subplot(3,1,2);
% plot(time,uf(:,2)-u_est(:,2))
% title('joint2TorqueError')
% p(3) = subplot(3,1,3);
% plot(time,qf_dot(:,2))
% title('joint2Vel')
% linkaxes(p,'x')
% 
% figure(4)
% p(1) = subplot(3,1,1);
% plot(time,uf(:,1),time,u_est(:,1))
% title('joint1')
% p(2) = subplot(3,1,2);
% plot(time,uf(:,1)-u_est(:,1))
% title('joint1TorqueError')
% p(3) = subplot(3,1,3);
% plot(time,qf_dot(:,1))
% title('joint1Vel')
% linkaxes(p,'x')





