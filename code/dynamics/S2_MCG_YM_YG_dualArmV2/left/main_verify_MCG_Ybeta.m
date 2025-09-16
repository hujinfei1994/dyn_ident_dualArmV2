% q=rand(7,1);
% q_dot = rand(7,1);
% q_ddot = rand(7,1);
q=zeros(7,1);
q_dot = zeros(7,1);
q_ddot = zeros(7,1);
L = rand(6,1);


beta = rand(50,1);
M = getM_dualArmV2(q,beta,L)
ccg = getCCG_dualArmV2(q,q_dot,beta,L)
Y = getY_dualArmV2(q,q_dot,q_ddot,L);

tau_MCG = M*q_ddot+ccg;
tau_Ybeta = Y*beta;
tau_Ybeta-tau_MCG


