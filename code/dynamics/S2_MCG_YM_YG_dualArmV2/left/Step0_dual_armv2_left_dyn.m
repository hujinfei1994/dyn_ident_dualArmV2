%% syms def
clear;clc;
syms q1 q2 q3 q4 q5 q6 q7 real
syms qd1 qd2 qd3 qd4 qd5 qd6 qd7 real
syms qdd1 qdd2 qdd3 qdd4 qdd5 qdd6 qdd7 real
syms L1 L2 L3 L4 L5 L6 LL real
syms g real
syms beta1 beta2 beta3 beta4 beta5 beta6 beta7 beta8 beta9 beta10 real
syms beta11 beta12 beta13 beta14 beta15 beta16 beta17 beta18 beta19 beta20 real
syms beta21 beta22 beta23 beta24 beta25 beta26 beta27 beta28 beta29 beta30 real
syms beta31 beta32 beta33 beta34 beta35 beta36 beta37 beta38 beta39 beta40 real
syms beta41 beta42 beta43 beta44 beta45 beta46 beta47 beta48 beta49 beta50 real
% vel=0
q = [q1;q2;q3;q4;q5;q6;q7];
qd1 = sym(0);qd2 = sym(0);qd3 = sym(0);qd4 = sym(0);qd5 = sym(0);qd6 = sym(0);qd7 = sym(0);

% DoF
DOF = 7;

%% def betaM betaG
% beta_str    = {'beta1','beta2','beta3','beta4','beta5','beta6','beta7','beta8','beta9','beta10','beta11','beta12','beta13','beta14','beta15','beta16','beta17','beta18','beta19','beta20','beta21','beta22','beta23','beta24'};
% betaG_str   = {'beta19','beta20','beta21','beta22','beta23','beta24'};
% betaM_str   = {'beta1','beta2','besata3','beta4','beta5','beta6','beta7','beta8','beta9','beta10','beta11','beta12','beta13','beta14','beta15','beta16','beta17','beta18'};
% beta        = [beta1,beta2,beta3,beta4,beta5,beta6,beta7,beta8,beta9,beta10,beta11,beta12,beta13,beta14,beta15,beta16,beta17,beta18,beta19,beta20,beta21,beta22,beta23,beta24];
betaG       = [beta32,beta33,beta34,beta35,beta36,beta37,beta38,beta39,beta40,beta41,beta42,beta43,beta44,beta45];
% betaM       = [beta1,beta2,beta3,beta4,beta5,beta6,beta7,beta8,beta9,beta10,beta11,beta12,beta13,beta14,beta15,beta16,beta17,beta18];


%% obtain the regression of base parameter set
% XX
I1xx=sym(0);I2xx=beta1;I3xx=beta2;I4xx=beta3;I5xx=beta4;I6xx=beta5;I7xx=beta6;
% XY
I1xy=sym(0);I2xy=beta7;I3xy=beta8;I4xy=beta9;I5xy=beta10;I6xy=beta11;I7xy=beta12;
% XZ
I1xz=sym(0);I2xz=beta13;I3xz=beta14;I4xz=beta15;I5xz=beta16;I6xz=beta17;I7xz=beta18;
% YZ
I1yz=sym(0);I2yz=beta19;I3yz=beta20;I4yz=beta21;I5yz=beta22;I6yz=beta23;I7yz=beta24;
% ZZ
I1zz=beta25;I2zz=beta26;I3zz=beta27;I4zz=beta28;I5zz=beta29;I6zz=beta30;I7zz=beta31;
% MX
mx1=beta32;mx2=beta33;mx3=beta34;mx4=beta35;mx5=beta36;mx6=beta37;mx7=beta38;
% MY
my1=beta39;my2=beta40;my3=beta41;my4=beta42;my5=beta43;my6=beta44;my7=beta45;
% IA
Ia1=0;Ia2=0;Ia3=beta46;Ia4=beta47;Ia5=beta48;Ia6=beta49;Ia7=beta50;
% M = 0
m1 = sym(0);m2 = sym(0);m3 = sym(0);m4 = sym(0);m5 = sym(0);m6 = sym(0);m7 = sym(0);
% MZ = 0
mz1 = sym(0);mz2 = sym(0);mz3 = sym(0);mz4 = sym(0);mz5 = sym(0);mz6 = sym(0);mz7 = sym(0);
% YY = 0
I1yy = sym(0);I2yy = sym(0);I3yy = sym(0);I4yy = sym(0);I5yy =sym(0);I6yy = sym(0);I7yy = sym(0);
% payload = 0
mL= 0;mxL= 0;myL= 0;mzL= 0;ILxx= 0;ILxy= 0;ILxz= 0;ILyy= 0;ILyz= 0;ILzz= 0;



%% getM
%script_dual_armv2_left_load_inm;

%% CCG简化为G （速度设为0）
script_dual_armv2_left_load_ccg;


%% get simplified G and G_g : to identify betaG
tic
for i = 1:DOF
    G(i) = collect(G(i),'g');
    G_g(i) = simplify(G(i)/g);
    G_g(i) = collect(G_g(i),betaG);
end
toc
G1_g=G_g(1)
G2_g=G_g(2)
G3_g=G_g(3)
G4_g=G_g(4)
G5_g=G_g(5)
G6_g=G_g(6)
G7_g=G_g(7)

save G_g_symbolic.mat






