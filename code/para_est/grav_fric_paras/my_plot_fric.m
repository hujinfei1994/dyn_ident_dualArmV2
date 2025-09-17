%% 画图初始化
%plot_init;
% tau_cof=[4.2,4.2,4.2,4.2,1.6,1.6,1.6];
sign=[1,-1,1,1,1,1,1];
%% 加载数据
load grav_fric_raw_data_J1.mat
raw_data{1} = grav_fric_raw_data;
load grav_fric_raw_data_J2.mat
raw_data{2} = grav_fric_raw_data;
load grav_fric_raw_data_J3.mat
raw_data{3} = grav_fric_raw_data;
load grav_fric_raw_data_J4.mat
raw_data{4} = grav_fric_raw_data;
load grav_fric_raw_data_J5.mat
raw_data{5} = grav_fric_raw_data;
load grav_fric_raw_data_J6.mat
raw_data{6} = grav_fric_raw_data;
load grav_fric_raw_data_J7.mat
raw_data{7} = grav_fric_raw_data;

%% 对齐匀速段计算摩檫力
DOF  = 7;
for jnt = 1:DOF
%     for i = 1:raw_data{jnt}.vel_low_num
%        raw_data{jnt}.fric_low{i}=(raw_data{jnt}.tau_select_low_neg2pos{i}-flip(raw_data{jnt}.tau_select_low_pos2neg{i}))/2;
%        raw_data{jnt}.fric_data(i)=mean(raw_data{jnt}.fric_low{i});
%        raw_data{jnt}.vel_data(i)=mean(raw_data{jnt}.vel_select_low_neg2pos{i});
%     end
    for i = 1:raw_data{jnt}.vel_num
       raw_data{jnt}.fric{i}=(raw_data{jnt}.tau_select_neg2pos{i}-flip(raw_data{jnt}.tau_select_pos2neg{i}))/2;
       raw_data{jnt}.fric_data(i)=mean(raw_data{jnt}.fric{i});
       raw_data{jnt}.vel_data(i)=mean(raw_data{jnt}.vel_select_neg2pos{i});
    end
end

%% 画1轴摩擦力图
figure(1)
for jnt = 1:DOF
    subplot(2,4,jnt)
    for i = 3:raw_data{jnt}.vel_num
        plot(raw_data{jnt}.fric{i})
        legend(num2str(raw_data{jnt}.vel_data(i)))
        hold on
    end
end

%% 画摩擦力速度图
figure(2)
for jnt = 1:DOF
    vel_data = (raw_data{jnt}.vel_data)';
    fric_data = (raw_data{jnt}.fric_data)';
    subplot(2,4,jnt)    
    %plot(vel_data,fric_data,'-o');
    %xlabel('vel(rad/s)')
    %ylabel('fric(Nm)')
    %title(['joint ',num2str(jnt),' friction identification'])
    f{jnt}=fit(vel_data,fric_data,'poly3');
    plot(f{jnt},vel_data,fric_data,'-o');
    if jnt == 1
        legend on
        legend('raw data','fitted','location','best')
    else
        legend off
    end
    xlabel(['$\dot{q}_',num2str(jnt),'(rad/s)$'],'Interpreter','latex')
    ylabel(['$\tau_{f',num2str(jnt),'}(Nm)$'],'Interpreter','latex')
    %title(['joint ',num2str(jnt),' friction curve'])
    title(['joint ',num2str(jnt)])
    grid on
    hold on
end





%% 生成表格
ORDER = 3 + 1; % poly3
table = zeros(ORDER,DOF);
for jnt = 1:DOF
    table(1,jnt)=f{jnt}.p1;
    table(2,jnt)=f{jnt}.p2;
    table(3,jnt)=f{jnt}.p3;
    table(4,jnt)=f{jnt}.p4;
end
format bank
table
format
fric_tab = table;
save fric_tab.mat fric_tab














