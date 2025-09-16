clear;clc;close all;
%load save_x_dualArmV2_cond99.mat
%load save_x_dualArmV2_cond106.mat
%load save_x_dualArmV2_cond122.mat

%cond_num = 13.5;
%cond_num = 15.7;
cond_num = 52.2;
load(['x_',num2str(cond_num),'.mat'])

xx = x;
%% a b c 
DOF = 7;
L1=0.18;
L2=0.27;
L3=0.03857;
L4=0.20;
L5=0.065;
L6=0.041;
L = [L1;L2;L3;L4;L5;L6];

%!!!x must be a column vector
a = [x(1:DOF),          x(DOF*1+1:DOF*2),x(DOF*2+1:DOF*3),x(DOF*3+1:DOF*4),x(DOF*4+1:DOF*5)];  %DOF by 5
b = [x(DOF*5+1:DOF*6),  x(DOF*6+1:DOF*7),x(DOF*7+1:DOF*8),x(DOF*8+1:DOF*9),x(DOF*9+1:DOF*10)];  %DOF by 5
c = x(DOF*10+1:DOF*11); %DOF by 1
h = 0.01;      % 0.005s
T = 10;       % 10s
wf= 2*pi/10;  %0.1hz ~ 10s
N = 5;        %5

save_t = 0:h:T; % Define the time vector
m = length(save_t); % Number of time steps
Phi = zeros(DOF*m, 50); % Initialize Phi matrix

save_q = [];
save_q_dot = [];
save_q_ddot = [];
cnt = 1;

for t = save_t
    q = c;
    q_dot = 0;
    q_ddot = 0;
    
    for l = 1:N
        q = q + a(:,l) * sin(l * wf * t) / (wf * l) - b(:,l) * cos(l * wf * t) / (wf * l);
        q_dot = q_dot + a(:,l) * cos(l * wf * t) + b(:,l) * sin(l * wf * t);
        q_ddot = q_ddot - a(:,l) * l * wf * sin(l * wf * t) + b(:,l) * l * wf * cos(l * wf * t);
    end
    
    save_q = [save_q, q];
    save_q_dot = [save_q_dot, q_dot];
    save_q_ddot = [save_q_ddot, q_ddot];
    
    Y = getY_dualArmV2(q,q_dot,q_ddot,L);
    Phi((cnt-1)*DOF+1:cnt*DOF, :)   = Y;
    cnt = cnt + 1;
end

Phi_cond = cond(Phi);

% Scale the saved variables
rate = 1.0;
save_q = save_q * rate;
save_q_dot = save_q_dot * rate;
save_q_ddot = save_q_ddot * rate;

% Repeat the saved variables for three periods
save_q = repmat(save_q, 1, 3);
save_q_dot = repmat(save_q_dot, 1, 3);
save_q_ddot = repmat(save_q_ddot, 1, 3);

% Adjust save_t to reflect the concatenation
save_t_period = save_t(end) - save_t(1) + h;
save_t = [save_t, save_t + save_t_period, save_t + 2 * save_t_period];


save_data = [save_q;save_q_dot;save_q_ddot;save_t];

dlmwrite(['dualArmV2_data_read_excitation_',num2str(cond_num),'.txt'],save_data);

q_max     = max(save_q,[],2);
q_min     = min(save_q,[],2);
q_dot_max = max(save_q_dot,[],2);
q_dot_min = min(save_q_dot,[],2);
q_ddot_max = max(save_q_ddot,[],2);
q_ddot_min = min(save_q_ddot,[],2);



figure(1)
for i = 1:DOF
    subplot(3,3,i)      
    plot(save_t,save_q(i,:))
    hold on
    grid on
    xlabel('$t(s)$','interpreter','latex')
    ylabel(['$q_',num2str(i),'(rad)$'],'interpreter','latex')
    axis tight
end

% figure(2)
% for i = 1:7
%     subplot(2,4,i)    
%     plot(save_t,save_q_dot(i,:))
%     title(['q_d_o_t_',num2str(i)])
% end
%  
% figure(3)
% for i = 1:7
%     subplot(2,4,i)     
%     plot(save_t,save_q_ddot(i,:))
%     title(['q_d_d_o_t_',num2str(i)])
% end

