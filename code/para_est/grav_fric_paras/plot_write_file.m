close all;clear all; clc;
filename = 'write_filedualarm_data_write_grav_fric_ident_J7.txt';
txt2data_dualArm;

ratio=[121,121,101,101,101,101,101];
sign=[1,1,1,1,1,1,1];

jnt=7;
figure(1)
plot(t,qd(:,jnt));
hold on
plot(t,q(:,jnt));

figure(2)
plot(t,qd_dot(:,jnt));
hold on
plot(t,q_dot(:,jnt)/ratio(jnt)*sign(jnt));

figure(3)
plot(t,jointacttorque(:,jnt));
hold on;
plot(t,torqueSensor(:,jnt));

% 
% figure(4)
% plot(t,rad2deg(qd(:,jnt)-q(:,jnt)));
