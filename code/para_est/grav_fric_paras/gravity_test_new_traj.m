close all
clear;clc;
%% 画图初始化
% plot_init;
% tau_cof=[4.2,4.2,4.2,4.2,1.6,1.6,1.6];
qmin=deg2rad([-120,-50,-90,-85,-140,-90,-90]);
qmax=deg2rad([120,50,90,85,140,90,90]);

%% 加载数据
load grav_fric_raw_data_J1.mat
raw_data{1} = grav_fric_raw_data;
load grav_fric_raw_data_J2.mat
raw_data{2} = grav_fric_raw_data;
load grav_fric_raw_data_J3.mat
raw_data{3} = grav_fric_raw_data;
load grav_fric_raw_data_J4.mat
raw_data{4} = grav_fric_raw_data;
load grav_fric_raw_data_J5.mat
raw_data{5} = grav_fric_raw_data;
load grav_fric_raw_data_J6.mat
raw_data{6} = grav_fric_raw_data;
load grav_fric_raw_data_J7.mat
raw_data{7} = grav_fric_raw_data;

%% 对齐匀速段计算重力
close all
figure(1)
for jnt = 1:7 %2-5轴和重力相关
    subplot(2,4,jnt)
    for i = 1:4  %舍去非常高的速度点（匀速段段太短）
       %j = i+3;
       j = i+0;
       raw_data{jnt}.grav{i}=(raw_data{jnt}.tau_select_neg2pos{j}+flip(raw_data{jnt}.tau_select_pos2neg{j}))/2;
       raw_data{jnt}.pos{i} = raw_data{jnt}.pos_select_neg2pos{j};
       plot(raw_data{jnt}.pos{i},raw_data{jnt}.grav{i})
       hold on
       % index=1:1:length(raw_data{jnt}.pos{i});
       % plot(index,raw_data{jnt}.grav{i})
       % hold on
    end
    legend('1','2','3','4','5','6','7','8','9','10')
    % legend('1','2','3','4')
    grav = raw_data{jnt}.grav;
    pos  = raw_data{jnt}.pos;
    save(['grav_data_J',num2str(jnt),'.mat'], 'grav', 'pos')
    axis tight
end


%%
%clear;clc;
g = -9.81;

offset_angle=28.4898*pi/180;
%% J7
load grav_data_J7.mat
num = length(pos);
save_beta45 = zeros(num,1);
save_beta38 = zeros(num,1);
for i = 1:num
    q7 = pos{i};
    G7 = grav{i};
    U7 = G7;
    Y7 = [sin(offset_angle+q7),cos(offset_angle+q7)];
    tmp = pinv(Y7)*U7/g;
    save_beta38(i) = tmp(1);
    save_beta45(i) = tmp(2);
end
save_beta45
save_beta38
beta45 = mean(save_beta45)
beta38 = mean(save_beta38)


%% J6
load grav_data_J6.mat
num = length(pos);
save_beta44 = zeros(num,1);
save_beta37 = zeros(num,1);
for i = 1:num
    q6 = pos{i};
    G6 = grav{i};
    U6 = G6-g*beta38*sin(offset_angle+q6);
    Y6 = [cos(offset_angle+q6),sin(offset_angle+q6)];
    tmp = pinv(Y6)*U6/g;
    save_beta44(i) = tmp(1);
    save_beta37(i) = tmp(2);
end
save_beta44
save_beta37
beta44 = mean(save_beta44)
beta37 = mean(save_beta37)


%% J5
load grav_data_J5.mat
num = length(pos);
save_beta43 = zeros(num,1);
save_beta36 = zeros(num,1);
for i = 1:num
    q5 = pos{i};
    G5 = grav{i};
    U5 = G5-g*(beta37*cos(q5)+beta38*cos(q5)-beta45*sin(offset_angle))*sin(offset_angle);
    Y5 = [-sin(q5)*sin(offset_angle),cos(q5)*sin(offset_angle)];
    tmp = pinv(Y5)*U5/g;
    save_beta43(i) = tmp(1);
    save_beta36(i) = tmp(2);
end
save_beta43
save_beta36
beta43 = mean(save_beta43)
beta36 = mean(save_beta36)

%% J4
load grav_data_J4.mat
num = length(pos);
save_beta42 = zeros(num,1);
save_beta35 = zeros(num,1);
for i = 1:num
    q4 = pos{i};
    G4 = grav{i};
    U4 = G4-g*(beta36*cos(q4+offset_angle) + beta44*cos(q4+offset_angle) + beta37*sin(q4+offset_angle) + beta38*sin(q4+offset_angle));
    Y4 = [-sin(q4+offset_angle),cos(q4+offset_angle)];
    tmp = pinv(Y4)*U4/g;
    save_beta42(i) = tmp(1);
    save_beta35(i) = tmp(2);
end
save_beta42
save_beta35
beta42 = mean(save_beta42)
beta35 = mean(save_beta35)


%% J3
load grav_data_J3.mat
num = length(pos);
save_beta41 = zeros(num,1);
save_beta34 = zeros(num,1);
for i = 1:num
    q3 = pos{i};
    G3 = grav{i};
    U3 = G3-g*(beta37*cos(q3)+beta38*cos(q3)-beta42*cos(q3) - beta43*sin(q3) - beta45*sin(q3))*sin(offset_angle);
    Y3 = [cos(q3)*sin(offset_angle),-sin(q3)*sin(offset_angle)];
    tmp = pinv(Y3)*U3/g;
    save_beta34(i) = tmp(1);
    save_beta41(i) = tmp(2);
end
save_beta41
save_beta34
beta41 = mean(save_beta41)
beta34 = mean(save_beta34)


%% J2
load grav_data_J2.mat
num = length(pos);
save_beta40 = zeros(num,1);
save_beta33 = zeros(num,1);
for i = 1:num
    q2 = pos{i};
    G2 = grav{i};
    U2 = G2-g*(beta34*cos(offset_angle+q2) - beta35*cos(offset_angle+q2)  + beta36*cos(offset_angle+q2) + beta44*cos(offset_angle+q2)...
        + beta37*sin(offset_angle+q2) + beta38*sin(offset_angle+q2) - beta42*sin(offset_angle+q2));
    Y2 = [-sin(offset_angle+q2),cos(offset_angle+q2)];
    tmp = pinv(Y2)*U2/g;
    save_beta40(i) = tmp(1);
    save_beta33(i) = tmp(2);
end
save_beta40
save_beta33
beta40 = mean(save_beta40)
beta33 = mean(save_beta33)


%% J1
load grav_data_J1.mat
num = length(pos);
save_beta39 = zeros(num,1);
save_beta32 = zeros(num,1);
for i = 1:num
    q1 = pos{i};
    G1 = grav{i};
    U1 = G1-g*(beta37*cos(q1)*sin(offset_angle)+beta38*cos(q1)*sin(offset_angle)-beta40*cos(q1)*sin(offset_angle)-beta42*cos(q1)*sin(offset_angle)...
        -beta41*sin(q1)*sin(offset_angle)-beta43*sin(q1)*sin(offset_angle)-beta45*sin(q1)*sin(offset_angle));
    Y1 = [-sin(q1)*sin(offset_angle),cos(q1)*sin(offset_angle)];
    tmp = pinv(Y1)*U1/g;
    save_beta39(i) = tmp(1);
    save_beta32(i) = tmp(2);
end
save_beta39
save_beta32
beta39 = mean(save_beta39)
beta32 = mean(save_beta32)

%% 存入mat文件
save('betaG_dualArm.mat','beta32','beta33','beta34','beta35','beta36','beta37','beta38','beta39','beta40','beta41','beta42','beta43','beta44','beta45')


qmin=deg2rad([-180,-180,-180,-180,-180,-180,-180]);
qmax=deg2rad([180,180,180,180,180,180,180]);

% 7轴
q7 = qmin(7):0.01:qmax(7);
G7_g = beta38*sin(offset_angle+q7) + beta45*cos(offset_angle+q7);
save_G7 = G7_g * g;
% 6轴
q6 = qmin(6):0.01:qmax(6);
G6_g =  (beta37 + beta38)*sin(offset_angle+q6) + beta44*cos(offset_angle+q6);
save_G6 = G6_g * g;
% 5轴
q5 = qmin(5):0.01:qmax(5);
G5_g = ((beta36 + beta37 + beta38) * cos(q5) - (beta45 + beta43) * sin(q5)) * sin(offset_angle);
save_G5 = G5_g * g;

% 4轴
q4 = qmin(4):0.01:qmax(4);
G4_g =  (beta35 + beta36 + beta44)*cos(offset_angle+q4) + (beta37 + beta38 - beta42)*sin(offset_angle+q4);
save_G4 = G4_g * g;

% 3轴
q3 = qmin(3):0.01:qmax(3);
G3_g =   ((beta34+beta37+beta38-beta42)*cos(q3) - (beta43+beta45+beta41)*sin(q3))*sin(offset_angle);
save_G3 = G3_g * g;
% G1g = ((beta32+ beta33 + beta34 + beta35 + beta36 + beta44)*c1 - (beta41+ beta43+ beta45+ beta39)*s1)*st 	
% G2g = (beta33 + beta34- beta37 - beta38 + beta42)*c2t + (beta35+ beta36 + beta44 - beta40)*s2t	
% G3g = ((beta34+ beta37 + beta38 - beta42)*c3 - (beta43+ beta45+ beta41)*s3)*st	
% G4g = (beta35 + beta36 + beta44)*c4t + (beta37 + beta38 - beta42)*s4t 	
% G5g = ((beta36 + beta37 + beta38)*c5 - (beta45+beta43)*s5)*st	
% G6g = (beta37 + beta38)*s6t + beta44*c6t	
% G7g = beta38*s7t + beta45*c7t	
% 其中s7t=sin(t+q7）,c7t=cos(t+q7),st=sin(t)
% 2轴
q2 = qmin(2):0.01:qmax(2);
G2_g = (beta33+beta34+beta35+beta36+beta44)*cos(offset_angle+q2) + (beta37+beta38-beta40-beta42)*sin(offset_angle+q2);
save_G2 = G2_g * g;
% 2轴
q1 = qmin(1):0.01:qmax(1);
G1_g = ((beta32+beta37+beta38-beta40-beta42)*cos(q1) - (beta41+beta43+beta45+beta39)*sin(q1))*sin(offset_angle);
save_G1 = G1_g * g;



%% 画重力曲线
%2-6轴和重力相关
save_q1 = q1;
save_q2 = q2;
save_q3 = q3;
save_q4 = q4;
save_q5 = q5;
save_q6 = q6;
save_q7 = q7;

subplot(2,4,1)
hold on
plot(save_q1,save_G1,'-y', 'lineWidth', 2)
xlabel(['$q_1(rad)$'],'Interpreter','latex')
ylabel(['$G_1(Nm)$'],'Interpreter','latex')
ylim([-10,10])
grid on

subplot(2,4,2)
hold on
plot(save_q2,save_G2,'-y', 'lineWidth', 2)
xlabel(['$q_2(rad)$'],'Interpreter','latex')
ylabel(['$G_2(Nm)$'],'Interpreter','latex')
grid on

subplot(2,4,3)
hold on
plot(save_q3,save_G3,'-y', 'lineWidth', 2)
xlabel(['$q_3(rad)$'],'Interpreter','latex')
ylabel(['$G_3(Nm)$'],'Interpreter','latex')
grid on

subplot(2,4,4)
hold on
plot(save_q4,save_G4,'-y', 'lineWidth', 2)
xlabel(['$q_4(rad)$'],'Interpreter','latex')
ylabel(['$G_4(Nm)$'],'Interpreter','latex')
grid on

subplot(2,4,5)
hold on
plot(save_q5,save_G5,'-y', 'lineWidth', 2)
xlabel(['$q_5(rad)$'],'Interpreter','latex')
ylabel(['$G_5(Nm)$'],'Interpreter','latex')
grid on

subplot(2,4,6)
hold on
plot(save_q6,save_G6,'-y', 'lineWidth', 2)
xlabel(['$q_6(rad)$'],'Interpreter','latex')
ylabel(['$G_6(Nm)$'],'Interpreter','latex')
grid on

subplot(2,4,7)
hold on
plot(save_q7,save_G7,'-y', 'lineWidth', 2)
xlabel(['$q_7(rad)$'],'Interpreter','latex')
ylabel(['$G_7(Nm)$'],'Interpreter','latex')
ylim([-1,1])
grid on


%% 
str = "show_diff"
% L1=0.085;L2=0.250289;L3=0.209883;L4=0.062172;L5=0.076335;

mini_grav_param=[beta32;beta33;beta34;beta35;beta36;beta37;beta38;
                beta39;beta40;beta41;beta42;beta43;beta44;beta45];



