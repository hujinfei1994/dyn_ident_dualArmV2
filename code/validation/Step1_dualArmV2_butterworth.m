
%% init
clear;clc;close all

filename = 'dualArm_data_write_validation_dualArmV2.txt';
txt2data_dualArmV2;

%%
dualArmV2_data_filtering_notsavemat;


%% save data
save('filter_paras.mat','a','b','Ts')
save('dualArmV2_data_write_validation.mat','jointacttorque_filtered','q_filtered','q_dot_filtered','q_ddot_filtered')



