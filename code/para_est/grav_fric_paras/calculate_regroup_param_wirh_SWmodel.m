clear;clc;

m7=0.75;x7=1.234/1e3;y7=0.003/1e3;z7=9.177/1e3;

I7xx=736.697/1e6;I7yy=753.754/1e6;I7zz=320.146/1e6;I7xy=-0.023/1e6;I7xz=-2.746/1e6;I7yz=0.124/1e6;
mx7=m7*x7;my7=m7*y7;mz7=m7*z7;

m6=0.857;x6=7.438/1e3;y6=0.865/1e3;z6=-8.053/1e3;

I6xx=995.205/1e6;I6yy=1124.033/1e6;I6zz=873.805/1e6;I6xy=46.484/1e6;I6xz=0.00/1e6;I6yz=0.108/1e6;
mx6=m6*x6;my6=m6*y6;mz6=m6*z6;

m5=0.929;x5=-0.022/1e3;y5=0.792/1e3;z5=-90.679/1e3;
I5xx=9416.991/1e6;I5yy=9231.303/1e6;I5zz=624.886/1e6;I5xy=-0.019/1e6;I5xz=1.237/1e6;I5yz=-1.512/1e6;
mx5=m5*x5;my5=m5*y5;mz5=m5*z5;

m4=1.096;x4=-0.094/1e3;y4=-2.353/1e3;z4=-9.950/1e3;
I4xx=1396.650/1e6;I4yy=1266.299/1e6;I4zz=793.671/1e6;I4xy=-1.520/1e6;I4xz=-3.727/1e6;I4yz=9.337/1e6;
mx4=m4*x4;my4=m4*y4;mz4=m4*z4;

m3=1.619;x3=2.656/1e3;y3=1.056/1e3;z3=-128.419/1e3;
I3xx=33248.328/1e6;I3yy=32877.342/1e6;I3zz=1702.698/1e6;I3xy=63.721/1e6;I3xz=-117.687/1e6;I3yz=-8.586/1e6;
mx3=m3*x3;my3=m3*y3;mz3=m3*z3;

m2=0.419;x2=-4.550/1e3;y2=-31.695/1e3;z2=4.619/1e3;
I2xx=1528.474/1e6;I2yy=1175.640/1e6;I2zz=976.356/1e6;I2xy=59.489/1e6;I2xz=-1.428/1e6;I2yz=-26.682/1e6;
mx2=m2*x2;my2=m2*y2;mz2=m2*z2;

m1=1.960;x1=0.004/1e3;y1=12.718/1e3;z1=-33.668/1e3;
I1xx=7349.372/1e6;I1yy=6162.807/1e6;I1zz=2742.345/1e6;I1xy=0.176/1e6;I1xz=0.242/1e6;I1yz=9.036/1e6;
mx1=m1*x1;my1=m1*y1;mz1=m1*z1;

ILxx=0;ILyy=0;ILzz=0;ILxy=0;ILxz=0;ILyz=0;mxL=0;myL=0;mzL=0;mL=0;
Fc1=0;Fc2=0;Fc3=0;Fc4=0;Fc5=0;Fc6=0;Fc7=0;
Fv1=0;Fv2=0;Fv3=0;Fv4=0;Fv5=0;Fv6=0;Fv7=0;
Ia1=0;Ia2=0;Ia3=0;Ia4=0;Ia5=0;Ia6=0;Ia7=0;

% syms L1 L2 L3 L4 L5
L1=0.18;L2=0.27;L3=0.03857;L4=0.20;L5=0.065;L6=0.041;

ZZ1R=I1zz + I2yy + Ia1;	
MY1R=my1 + mz2;
XX2R=I2xx - I2yy + I3yy + L3^2*(m4 + m5 + m6 + m7 + mL) + L2^2*(m3 + m4 + m5 + m6 + m7 + mL) + 2*L2*mz3;	
ZZ2R=I2zz + I3yy + Ia2 + L3^2*(m4 + m5 + m6 + m7 + mL) + L2^2*(m3 + m4 + m5 + m6 + m7 + mL) + 2*L2*mz3;	
MY2R=-(L2*(m3 + m4 + m5 + m6 + m7 + mL)) + my2 - mz3;	
XX3R=I3xx - I3yy + I4yy - L3^2*(m4 + m5 + m6 + m7 + mL);	
XY3R=I3xy - L3*mz4;	
ZZ3R=I3zz + I4yy + L3^2*(m4 + m5 + m6 + m7 + mL);	
MX3R=L3*(m4 + m5 + m6 + m7 + mL) + mx3;	
MY3R=my3 + mz4;	
XX4R=I4xx - I4yy + I5yy + L4^2*(m5 + m6 + m7 + mL) + 2*L4*mz5;	
ZZ4R=I4zz + I5yy + L4^2*(m5 + m6 + m7 + mL) + 2*L4*mz5;	
MY4R=-(L4*(m5 + m6 + m7 + mL)) + my4 - mz5;	
XX5R=I5xx - I5yy + I6yy + L5^2*(m7 + mL);	
ZZ5R=I5zz + I6yy + L5^2*(m7 + mL);	
MY5R=my5 + mz6;	
XX6R=I6xx - I6yy + I7yy + ILyy + L6^2*mL - L5^2*(m7 + mL) + 2*L6*mxL;	
XY6R=I6xy + L5*(mz7 + mzL);	
ZZ6R=I6zz + I7yy + ILyy + L6^2*mL + L5^2*(m7 + mL) + 2*L6*mxL;	
MX6R=L5*(m7 + mL) + mx6;	
MY6R=my6 - mz7 - mzL;	
XX7R=I7xx - I7yy + ILxx - ILyy - L6^2*mL - 2*L6*mxL;	
XY7R=I7xy + ILxy - L6*myL;	
XZ7R=I7xz + ILxz - L6*mzL;	
YZ7R=I7yz + ILyz;	
ZZ7R=I7zz + ILzz + L6^2*mL + 2*L6*mxL;	
MX7R=L6*mL + mx7 + mxL;	
MY7R=my7 + myL;	

betasw1=XX2R;betasw2=XX3R;betasw3=XX4R;betasw4=XX5R;betasw5=XX6R;betasw6=XX7R;
betasw7=I2xy;betasw8=XY3R;betasw9=I4xy;betasw10=I5xy;betasw11=XY6R;betasw12=XY7R;
betasw13=I2xz;betasw14=I3xz;betasw15=I4xz;betasw16=I5xz;betasw17=I6xz;betasw18=XZ7R;
betasw19=I2yz;betasw20=I3yz;betasw21=I4yz;betasw22=I5yz;betasw23=I6yz;betasw24=YZ7R;
betasw25=ZZ1R;betasw26=ZZ2R;betasw27=ZZ3R;betasw28=ZZ4R;betasw29=ZZ5R;betasw30=ZZ6R;
betasw31=ZZ7R;betasw32=mx1;betasw33=mx2;betasw34=MX3R;betasw35=mx4;betasw36=mx5;
betasw37=MX6R;betasw38=MX7R;betasw39=MY1R;betasw40=MY2R;betasw41=MY3R;betasw42=MY4R;
betasw43=MY5R;betasw44=MY6R;betasw45=MY7R;

%% 存入mat文件
save('beta_dualArm_SWmodel.mat', ...
    'betasw1','betasw2','betasw3','betasw4','betasw5','betasw6','betasw7',...
    'betasw8','betasw9','betasw10','betasw11','betasw12','betasw13','betasw14','betasw15',...
    'betasw16','betasw17','betasw18','betasw19','betasw20','betasw21','betasw22',...
    'betasw23','betasw24','betasw25','betasw26','betasw27','betasw28','betasw29',...
    'betasw30','betasw31',...
    'betasw32','betasw33','betasw34','betasw35','betasw36','betasw37','betasw38', ...
    'betasw39','betasw40','betasw41','betasw42','betasw43','betasw44','betasw45')