clear;clc;
tic;
global h T wf N DOF L
h = 0.1;      %采样周期 0.01s
T = 10;       %轨迹时间 10s
wf= 2*pi/10;  %基频为0.1hz ~ 10s
N = 5;        %5次傅里叶叠加
DOF = 7;
L1=0.18;
L2=0.27;
L3=0.03857;
L4=0.20;
L5=0.065;
L6=0.041;
L = [L1;L2;L3;L4;L5;L6];

%% 是否优化已有参数
optimize_existed_paras = 0;
if optimize_existed_paras == 1
    load('x_set1_opt1.mat');
    x0 = x;
else
    x0 = rand(DOF*11,1)*0.1;
end

%% 开始优化
options = optimoptions('fmincon','Display','iter');
options = optimoptions(options,'Display','iter','MaxIter',15000,'MaxFunEvals',1000000)
[x z exitflag output]=fmincon(@optim_object,x0,[],[],[],[],[],[],@optim_constraints,options);

% clc;
% x
% z
% disp('迭代次数为：')
% disp(output.iterations)
exitflag
if exitflag>0    
    disp('求解过程正常收敛')
    save x.mat x x0
elseif exitflag==0    
    disp('超过迭代次数限制')
else
    disp('收敛异常')
end
toc


function f =optim_object(x)
    global h T wf N DOF L
    %!!!x must be a column vector
    a = [x(1:DOF),          x(DOF*1+1:DOF*2),x(DOF*2+1:DOF*3),x(DOF*3+1:DOF*4),x(DOF*4+1:DOF*5)];  %DOF by 5
    b = [x(DOF*5+1:DOF*6),  x(DOF*6+1:DOF*7),x(DOF*7+1:DOF*8),x(DOF*8+1:DOF*9),x(DOF*9+1:DOF*10)];  %DOF by 5
    c = x(DOF*10+1:DOF*11); %DOF by 1
    Phi = [];
    for t = 0:h:T
        q = c;
        q_dot = 0;
        q_ddot = 0;
        for l = 1:N
            q = q + a(:,l)*sin(l*wf*t)/(wf*l) - b(:,l)*cos(l*wf*t)/(wf*l);
            q_dot = q_dot + a(:,l)*cos(l*wf*t) + b(:,l)*sin(l*wf*t);
            q_ddot = q_ddot - a(:,l)*l*wf*sin(l*wf*t) + b(:,l)*l*wf*cos(l*wf*t);
        end
        Y = getY_dualArmV2(q,q_dot,q_ddot,L);
        Phi = [Phi;Y];
    end
    f=cond(Phi);
    %     PhiPhi = Phi'*Phi;
    %     f=cond(PhiPhi);
    %     svd(Phi)
    %     ff = 1;
    %     for i = 1:size(Phi,2)
    %         tmp = 0;
    %         for j = 1:size(Phi,1)
    %            tmp = tmp + Phi(j,i)^2;
    %         end
    %         ff = ff*tmp;
    %     end
    %
    %     f = 1/ff;
end


function [cneq,ceq]=optim_constraints(x)
    global  T wf N DOF
    %!!!x must be a column vector
    a = [x(1:DOF),          x(DOF*1+1:DOF*2),x(DOF*2+1:DOF*3),x(DOF*3+1:DOF*4),x(DOF*4+1:DOF*5)];  %DOF by 5
    b = [x(DOF*5+1:DOF*6),  x(DOF*6+1:DOF*7),x(DOF*7+1:DOF*8),x(DOF*8+1:DOF*9),x(DOF*9+1:DOF*10)];  %DOF by 5
    c = x(DOF*10+1:DOF*11); %7 by 1
    
    %% 位置、速度、加速度上下界
    q_min = deg2rad([-80,-70,-80,-80,-80,-80,-80]');
    q_max = deg2rad([80,20,80,80,80,80,80]');
    q_dotmax = deg2rad([100,100,100,100,100,100,100]')*1.0;
    q_ddotmax = [300,300,300,300,300,300,300]'*1.0;
    
    %% ceq
    q_init = zeros(DOF,1);
    for jnt = 1:DOF
        q_init(jnt)=(q_max(jnt)+q_min(jnt))/2;
    end
    q_dot_init = zeros(DOF,1);
    q_ddot_init = zeros(DOF,1);
    
    q0 = c;
    q_dot0 = zeros(DOF,1);
    q_ddot0 = zeros(DOF,1); 
    for l = 1:N
        q0 = q0 - b(:,l)/(wf*l);
        q_dot0 = q_dot0 + a(:,l);
        q_ddot0 = q_ddot0 + b(:,l)*wf*l;
    end

    qf = c;
    q_dotf = zeros(DOF,1);
    q_ddotf = zeros(DOF,1);
    for l = 1:N
        qf = qf + a(:,l)*sin(wf*l*T)/(wf*l) - b(:,l)*cos(wf*l*T)/(wf*l);
        q_dotf = q_dotf + a(:,l)*cos(wf*l*T) + b(:,l)*sin(wf*l*T);
        q_ddotf = q_ddotf - a(:,l)*wf*l*sin(wf*l*T) + b(:,l)*wf*l*cos(wf*l*T);
    end

    ceq = [q0-q_init;q_dot0-q_dot_init;q_ddot0-q_ddot_init;qf-q_init;q_dotf-q_dot_init;q_ddotf-q_ddot_init];

    %% cneq
    q=abs(c-(q_max+q_min)/2);
    q_dot = 0;
    q_ddot = 0;

    for l = 1:N
        q = q + sqrt(a(:,l).^2+b(:,l).^2)/(wf*l);
        q_dot = q_dot + sqrt(a(:,l).^2+b(:,l).^2);
        q_ddot = q_ddot + sqrt(a(:,l).^2+b(:,l).^2)*(wf*l);
    end
    cneq = [q-(q_max-q_min)/2;q_dot-q_dotmax;q_ddot-q_ddotmax];
    
end

