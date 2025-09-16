clear;clc;close all;
data = load('dualArmV2_data_read_excitation_13.5.txt');
q = data(1:7,:);
t = data(22,:);

figure
for jnt = 1:7
    subplot(2,4,jnt)
    plot(t,q(jnt,:)/100.0)
end

