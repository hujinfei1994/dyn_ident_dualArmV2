clear all;clc;close all
load x_13.5.mat
%load x_15.7.mat
%load x_52.2.mat
%x = rand(77,1);


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
h = 0.1;      %采样周期 0.01s
T = 10;       %轨迹时间 10s
wf= 2*pi/10;  %基频为0.1hz ~ 10s
N = 5;        %5次傅里叶叠加

save_t = 0:h:T; % Define the time vector
m = length(save_t); % Number of time steps
Phi = zeros(DOF*m, 50); % Initialize Phi matrix
Phi_M = zeros(DOF*m, 36);
Phi_G = zeros(DOF*m, 14);

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
    Phi_M((cnt-1)*DOF+1:cnt*DOF, :) = Y(:,[1:31,46:50]);
    Phi_G((cnt-1)*DOF+1:cnt*DOF, :) = Y(:,32:45);
    cnt = cnt + 1;
end

Phi_cond = cond(Phi)
PhiM_cond = cond(Phi_M)
PhiG_cond = cond(Phi_G)

%PhiF_cond = 5.3;
%PhiM_cond*0.7+PhiG_cond*0.2+PhiF_cond*0.1
