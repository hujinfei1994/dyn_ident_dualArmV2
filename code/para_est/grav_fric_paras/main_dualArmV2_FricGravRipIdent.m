clear;close all;clc;
fig_cnt = 1;

%% 1��
jnt = 1;                  %�ĸ��ؽ�
load time_grav_fric_ident_J_test_dualArmV21.mat
% filename = 'write_filewrite_filedualarm_data_write_grav_fric_ident_J1.txt';
filename = 'arm_0_joint_1_results.txt';
txt2data_dualArmV2_grav_fric;
dualArm_FricGravRipIdent;

%% 2��
jnt = 2;                  %�ĸ��ؽ�
load time_grav_fric_ident_J_test_dualArmV22.mat
filename = 'arm_0_joint_2_results.txt';
txt2data_dualArmV2_grav_fric;
dualArm_FricGravRipIdent;

%% 3��
jnt = 3;                  %�ĸ��ؽ�
load time_grav_fric_ident_J_test_dualArmV23.mat
filename = 'arm_0_joint_3_results.txt';
txt2data_dualArmV2_grav_fric;
dualArm_FricGravRipIdent;

%% 4��
jnt = 4;                  %�ĸ��ؽ�
load time_grav_fric_ident_J_test_dualArmV24.mat
filename = 'arm_0_joint_4_results.txt';
txt2data_dualArmV2_grav_fric;
dualArm_FricGravRipIdent;

%% 5��
jnt = 5;                  %�ĸ��ؽ�
load time_grav_fric_ident_J_test_dualArmV25.mat
filename = 'arm_0_joint_5_results.txt';
txt2data_dualArmV2_grav_fric;
dualArm_FricGravRipIdent;

%% 6��
jnt = 6;                  %�ĸ��ؽ�
load time_grav_fric_ident_J_test_dualArmV26.mat
filename = 'arm_0_joint_6_results.txt';
txt2data_dualArmV2_grav_fric;
dualArm_FricGravRipIdent;

%% 7��
jnt = 7;                  %�ĸ��ؽ�
load time_grav_fric_ident_J_test_dualArmV27.mat
filename = 'arm_0_joint_7_results.txt';
txt2data_dualArmV2_grav_fric;
dualArm_FricGravRipIdent;
