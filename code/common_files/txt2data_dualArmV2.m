data = load(filename);

sample = data(:,1);
%t = data(:,2);
% t = data(:,1)*0.01;
t = (0:length(data(:,1))-1)*0.01;

offset = 1;
q              = data(:,offset+1:offset+7);   offset = offset + 7;
q = deg2rad(q)*6;
q_dot          = data(:,offset+1:offset+7);   offset = offset + 7;   
q_dot = deg2rad(q_dot)*6;

motor_current  = data(:,offset+1:offset+7);   offset = offset + 7;
qd             = data(:,offset+1:offset+7);   offset = offset + 7;
qd_dot         = data(:,offset+1:offset+7);   offset = offset + 7;
qd_ddot        = data(:,offset+1:offset+7);   offset = offset + 7;
jointacttorque  = data(:,offset+1:offset+7);   offset = offset + 7;


clear data
