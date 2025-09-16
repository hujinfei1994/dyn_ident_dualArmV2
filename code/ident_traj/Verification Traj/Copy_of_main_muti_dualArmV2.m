clear;clc;close all;


vmax=deg2rad([120,120,140,140,280,280,280])*0.6;
amax=[15,10,10,15,15,15,15];

acc_vel_rate = amax./vmax;
jerk_acc_rate = [10;10;10;10;10;10;10];
max_vel = vmax;

percent_data=10:10:90;
percent_num=length(percent_data);


%% J1,J2,J3,J4,J5,J6£¬J7
% qmin=deg2rad([-140,-90,-150,-90,-150,-60,-150]);
% qmax=deg2rad([140,90,150,130,150,230,150]);
pos_neg = deg2rad([-80,-60,-80,80,-80,-80,-80]);
pos_pos = deg2rad([80,40,80,-60,80,80,80]);

gen_test_traj_muti_dualArmV2;


