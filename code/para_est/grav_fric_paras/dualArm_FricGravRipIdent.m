
tau_cof=[4.2*0.9/2.8,4.2*0.9/2.8,4.2*1.462,4.2*1.462,1.6*3.6139,1.6*3.6139,1.6*3.2139];
% tau_cof=[1.0,1.0,1.0,1.0,1.0,1.0,1.0];
%% 读文件
pos_act = q(:,jnt);
vel_act = q_dot(:,jnt);

motor_current(:,jnt) = motor_current(:,jnt)*tau_cof(jnt);

%% 划分时间段
select_T_neg2pos_left  = zeros(vel_num,1);
select_T_neg2pos_right = zeros(vel_num,1);
select_T_pos2neg_left  = zeros(vel_num,1);
select_T_pos2neg_right = zeros(vel_num,1);
pos_neg2pos_left=zeros(vel_num,1);


save_delay = [0.01,0.01,0.01,0.01,0.01,0.01,0.01];
delay = save_delay(jnt);
tmp = delay+save_T0{1}.T;

for i = 1:vel_num
    select_T_neg2pos_left(i)=tmp+save_T_neg2pos{i}.Ta;
    select_T_neg2pos_right(i)=select_T_neg2pos_left(i)+save_T_neg2pos{i}.Tv;

    select_T_pos2neg_left(i)=tmp+save_T_neg2pos{i}.T + save_T_pos2neg{i}.Ta;
    select_T_pos2neg_right(i) = select_T_pos2neg_left(i) + save_T_pos2neg{i}.Tv;
    tmp = tmp + save_T_neg2pos{i}.T + save_T_pos2neg{i}.T;
end

%   取指引点
offset = 0;
sssss=10;
for i = 1:vel_num
    index_neg2pos{i} = find(t>=select_T_neg2pos_left(i)+offset&t<=select_T_neg2pos_right(i)-offset);
    index_pos2neg{i} = find(t>=select_T_pos2neg_left(i)+offset&t<=select_T_pos2neg_right(i)-offset);
    index_neg2pos{i}
    length(index_neg2pos{i})
    len = min(length(index_neg2pos{i}),length(index_pos2neg{i}));
    % if (abs(length(index_neg2pos{i})-length(index_pos2neg{i}))>1)
    %     error('dffdfd')
    % end
    index_neg2pos{i} = index_neg2pos{i}(1:len);
    index_pos2neg{i} = index_pos2neg{i}(1:len);
end



%% 按索引点取匀速段
figure(fig_cnt)
fig_cnt=fig_cnt+1;
for i = 1:vel_num
    t_select_neg2pos{i} = t(index_neg2pos{i});
    vel_select_neg2pos{i} = q_dot(index_neg2pos{i},jnt);
    pos_select_neg2pos{i} = q(index_neg2pos{i},jnt);
    tau_select_neg2pos{i} = motor_current(index_neg2pos{i},jnt);
    torque_sensor_select_neg2pos{i}=jointacttorque(index_neg2pos{i},jnt);
 
    t_select_pos2neg{i} = t(index_pos2neg{i});
    vel_select_pos2neg{i} = q_dot(index_pos2neg{i},jnt);
    pos_select_pos2neg{i} = q(index_pos2neg{i},jnt);
    tau_select_pos2neg{i} = motor_current(index_pos2neg{i},jnt);
    torque_sensor_select_pos2neg{i}=jointacttorque(index_pos2neg{i},jnt);

    plot(flip(pos_select_pos2neg{i})-pos_select_neg2pos{i});
    hold on
end
legend('1','2','3','4','5','6','7','8','9','10')





%% 存原始数据
grav_fric_raw_data.t_select_neg2pos   = t_select_neg2pos;
grav_fric_raw_data.vel_select_neg2pos = vel_select_neg2pos;
grav_fric_raw_data.pos_select_neg2pos = pos_select_neg2pos;
grav_fric_raw_data.tau_select_neg2pos = tau_select_neg2pos;
grav_fric_raw_data.torque_sensor_neg2pos=torque_sensor_select_neg2pos;
grav_fric_raw_data.t_select_pos2neg   = t_select_pos2neg;
grav_fric_raw_data.vel_select_pos2neg = vel_select_pos2neg;
grav_fric_raw_data.pos_select_pos2neg = pos_select_pos2neg;
grav_fric_raw_data.tau_select_pos2neg = tau_select_pos2neg;
grav_fric_raw_data.torque_sensor_pos2neg=torque_sensor_select_pos2neg;
grav_fric_raw_data.vel_num                = vel_num;
save(['grav_fric_raw_data_J',num2str(jnt),'.mat'],'grav_fric_raw_data')


