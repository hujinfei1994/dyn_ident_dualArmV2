
DOF = 7;

%%  generate butterworth filter paras a b vector
Ts = t(2)-t(1);
fs = 1/Ts;
% Wp = 40/(fs/2);     %Stopband corner frequency Ws, 1 corresponding to the normalized Nyquist frequency
% Ws = 160/(fs/2);    %Passband corner frequency Wp, normalized via dividing by nyquist frequency fs/2;
% Wp = 10/(fs/2);     %Stopband corner frequency Ws, 1 corresponding to the normalized Nyquist frequency
% Ws = 60/(fs/2);    %Passband corner frequency Wp, normalized via dividing by nyquist frequency fs/2;
Wp = 5/(fs/2);     %Stopband corner frequency Ws, 1 corresponding to the normalized Nyquist frequency
Ws = 10/(fs/2);    %Passband corner frequency Wp, normalized via dividing by nyquist frequency fs/2;
Rp = 3;             %Passband ripple in decibels
Rs = 30;            %Stopband attenuation in decibels. This value is the number of decibels the stopband is down from the passband.
[n,Wn] = buttord(Wp,Ws,Rp,Rs);
[b,a] = butter(n,Wn);       %cutoff frequencies Wn and the lowest order n of the digital Butterworth filter 

%% Plot The Butterworth Filter
% figure(10)
% [z,p,k] = butter(n,Wn);
% sos = zp2sos(z,p,k);
% freqz(sos,512,fs)
% title(sprintf('n = %d Butterworth Lowpass Filter',n))

%% filt jointTorque and jointPos
jointacttorque_filtered = filtfilt(b,a,jointacttorque(:,:));
q_filtered = q;


%% Central difference to get jointVel and jointAcc
% jointVel
q_dot_filtered = filtfilt(b,a,q_dot(:,:));


% jointAcc
q_ddot_filtered = zeros(size(q_dot_filtered));
for i = 2:size(q_dot_filtered,1)-1
    q_ddot_filtered_i = (q_dot_filtered(i+1,:) - q_dot_filtered(i-1,:))/(2*Ts); % central difference
    q_ddot_filtered(i,:) = q_ddot_filtered_i;
end
q_ddot_filtered(i,1) = q_ddot_filtered(i,2);
q_ddot_filtered(i,end) = q_ddot_filtered(i,end-1);


%% plot
figure(1)  %torque u
for i = 1:DOF
    subplot(3,3,i)
    plot(t,jointacttorque(:,i))
    hold on
    plot(t,jointacttorque_filtered(:,i))
    %plot(t,jointacttorque_filtered(:,i)-jointacttorque(:,i))
    xlabel('time/s');ylabel('torque/N*m');title('Lowpass Butterworth Filter Torque')
end
% 
figure(2) %joint pos q
for i = 1:DOF
    subplot(3,3,i)
    plot(t,q(:,i))
    hold on
    plot(t,q_filtered(:,i))
    %plot(t,q(:,i)-q_filtered(:,i))
    xlabel('time/s');ylabel('jointpos/rad');title('Lowpass Butterworth Filter JointPos')
end

figure(3) %joint vel q_dot
for i = 1:DOF
    subplot(3,3,i)
    plot(t,q_dot_filtered(:,i))
    xlabel('time/s');ylabel('jointvel/rad/s');title('Lowpass Butterworth Filter JointVel')
end
figure(4) %joint acc q_ddot
for i = 1:DOF
    subplot(3,3,i)
    plot(t,q_ddot_filtered(:,i))
    xlabel('time/s');ylabel('jointvel/rad/s^2');title('Lowpass Butterworth Filter JointAcc')
end

%% save data
% save('filter_paras.mat','a','b','Ts')
% save('filtered_data.mat','jointacttorque_filtered','q_filtered','q_dot_filtered','q_ddot_filtered','t')
% 


