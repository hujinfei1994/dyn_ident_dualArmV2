clear;clc;close all;


% vmax=deg2rad([120,120,140,140,280,280,280])*0.7;
% amax=[15,15,15,15,30,30,30];
vmax=deg2rad([120,120,120,120,180,180,180])*0.7;
amax=[15,15,15,15,15,15,15];

acc_vel_rate = amax./vmax;
jerk_acc_rate = [15;15;15;15;15;15;15];
max_vel = vmax;

percent_data=10:10:90;
percent_num=length(percent_data);


%% J1,J2,J3,J4,J5,J6£¬J7
% pos_neg = deg2rad([-80,-60,-80,80,-80,-80,-80]);
% pos_pos = deg2rad([80,40,80,-60,80,80,80]);
pos_neg = deg2rad([-80,-80,-80,80,-80,-80,-80]);
pos_pos = deg2rad([80,40,80,-40,80,80,80]);


gen_test_traj_muti_dualArmV2;


