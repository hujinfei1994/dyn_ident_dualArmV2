%% syms def
clear;clc;
syms q1 q2 q3 q4 real
syms qd1 qd2 qd3 qd4 real
syms qdd1 qdd2 qdd3 qdd4 real
syms L1 L2 L3 L4 real
syms g real

% DoF
DOF = 4;

%% obtain the regression of base parameter set
% M
m1 = sym(0);m2 = sym(0);m3 = sym(0);m4 = sym(0);
% MX
mx1=sym(0);mx2=sym(0);mx3=sym(0);mx4=sym(0);
% MY
my1=sym(0);my2=sym(0);my3=sym(0);my4=sym(0);
% MZ
mz1=sym(0);mz2=sym(0);mz3=sym(0);mz4=sym(0);
% XX
I1xx=sym(0);I2xx=sym(0);I3xx=sym(0);I4xx=sym(0);
% XY
I1xy=sym(0);I2xy=sym(0);I3xy=sym(0);I4xy=sym(0);
% XZ
I1xz=sym(0);I2xz=sym(0);I3xz=sym(0);I4xz=sym(0);
% YZ
I1yy=sym(0);I2yy=sym(0);I3yy=sym(0);I4yy=sym(0);
% YZ
I1yz=sym(0);I2yz=sym(0);I3yz=sym(0);I4yz=sym(0);
% ZZ
I1zz=sym(0);I2zz=sym(0);I3zz=sym(0);I4zz=sym(0);
% IA
Ia1=sym(0);Ia2=sym(0);Ia3=sym(0);Ia4=sym(0);


% payload = 0
% mL= 0;mxL= 0;myL= 0;mzL= 0;ILxx= 0;ILxy= 0;ILxz= 0;ILyy= 0;ILyz= 0;ILzz= 0;
syms mL mxL myL mzL ILxx ILxy ILxz ILyy ILyz ILzz real

%% Dynamic Model：hydraulic_load_dyn.m
S2=sin(q2);
C2=cos(q2);
S3=sin(q3);
C3=cos(q3);
S4=sin(q4);
C4=cos(q4);
DV331=-qd1.^2;
No31=I1zz.*qdd1;
WI12=qd1.*S2;
WI22=C2.*qd1;
WP12=qdd1.*S2 + qd2.*WI22;
WP22=C2.*qdd1 - qd2.*WI12;
DV112=-WI12.^2;
DV222=-WI22.^2;
DV332=-qd2.^2;
DV122=WI12.*WI22;
DV132=qd2.*WI12;
DV232=qd2.*WI22;
U112=DV222 + DV332;
U122=DV122 - qdd2;
U132=DV132 + WP22;
U212=DV122 + qdd2;
U232=DV232 - WP12;
U312=DV132 - WP22;
U322=DV232 + WP12;
U332=DV112 + DV222;
VSP12=DV331.*L1;
VSP22=L1.*qdd1;
VP12=-(g.*S2) + C2.*VSP12;
VP22=-(C2.*g) - S2.*VSP12;
F32=mx2.*U312 + my2.*U322 + mz2.*U332 - m2.*VSP22;
PIS12=-I2yy + I2zz;
PIS22=I2xx - I2zz;
PIS32=-I2xx + I2yy;
No12=(-DV222 + DV332).*I2yz + DV232.*PIS12 + I2xz.*U212 - I2xy.*U312 + I2xx.*WP12;
No22=(DV112 - DV332).*I2xz + DV132.*PIS22 - I2yz.*U122 + I2xy.*U322 + I2yy.*WP22;
No32=(-DV112 + DV222).*I2xy + DV122.*PIS32 + I2zz.*qdd2 + I2yz.*U132 - I2xz.*U232;
WI13=C3.*WI12 + S3.*WI22;
WI23=-(S3.*WI12) + C3.*WI22;
W33=qd2 + qd3;
WP13=qd3.*WI23 + C3.*WP12 + S3.*WP22;
WP23=-(qd3.*WI13) - S3.*WP12 + C3.*WP22;
WP33=qdd2 + qdd3;
DV113=-WI13.^2;
DV223=-WI23.^2;
DV333=-W33.^2;
DV123=WI13.*WI23;
DV133=W33.*WI13;
DV233=W33.*WI23;
U113=DV223 + DV333;
U123=DV123 - WP33;
U133=DV133 + WP23;
U213=DV123 + WP33;
U223=DV113 + DV333;
U233=DV233 - WP13;
U313=DV133 - WP23;
U323=DV233 + WP13;
U333=DV113 + DV223;
VSP13=L2.*U112 + VP12;
VSP23=L2.*U212 + VP22;
VSP33=L2.*U312 - VSP22;
VP13=C3.*VSP13 + S3.*VSP23;
VP23=-(S3.*VSP13) + C3.*VSP23;
F13=mx3.*U113 + my3.*U123 + mz3.*U133 + m3.*VP13;
F23=mx3.*U213 + my3.*U223 + mz3.*U233 + m3.*VP23;
F33=mx3.*U313 + my3.*U323 + mz3.*U333 + m3.*VSP33;
PIS13=-I3yy + I3zz;
PIS23=I3xx - I3zz;
PIS33=-I3xx + I3yy;
No13=(-DV223 + DV333).*I3yz + DV233.*PIS13 + I3xz.*U213 - I3xy.*U313 + I3xx.*WP13;
No23=(DV113 - DV333).*I3xz + DV133.*PIS23 - I3yz.*U123 + I3xy.*U323 + I3yy.*WP23;
No33=(-DV113 + DV223).*I3xy + DV123.*PIS33 + I3yz.*U133 - I3xz.*U233 + I3zz.*WP33;
WI14=C4.*WI13 + S4.*WI23;
WI24=-(S4.*WI13) + C4.*WI23;
W34=qd4 + W33;
WP14=qd4.*WI24 + C4.*WP13 + S4.*WP23;
WP24=-(qd4.*WI14) - S4.*WP13 + C4.*WP23;
WP34=qdd4 + WP33;
DV114=-WI14.^2;
DV224=-WI24.^2;
DV334=-W34.^2;
DV124=WI14.*WI24;
DV134=W34.*WI14;
DV234=W34.*WI24;
U114=DV224 + DV334;
U124=DV124 - WP34;
U134=DV134 + WP24;
U214=DV124 + WP34;
U224=DV114 + DV334;
U234=DV234 - WP14;
U314=DV134 - WP24;
U324=DV234 + WP14;
U334=DV114 + DV224;
VSP14=L3.*U113 + VP13;
VSP24=L3.*U213 + VP23;
VSP34=L3.*U313 + VSP33;
VP14=C4.*VSP14 + S4.*VSP24;
VP24=-(S4.*VSP14) + C4.*VSP24;
F14=mx4.*U114 + my4.*U124 + mz4.*U134 + m4.*VP14;
F24=mx4.*U214 + my4.*U224 + mz4.*U234 + m4.*VP24;
F34=mx4.*U314 + my4.*U324 + mz4.*U334 + m4.*VSP34;
PIS14=-I4yy + I4zz;
PIS24=I4xx - I4zz;
PIS34=-I4xx + I4yy;
No14=(-DV224 + DV334).*I4yz + DV234.*PIS14 + I4xz.*U214 - I4xy.*U314 + I4xx.*WP14;
No24=(DV114 - DV334).*I4xz + DV134.*PIS24 - I4yz.*U124 + I4xy.*U324 + I4yy.*WP24;
No34=(-DV114 + DV224).*I4xy + DV124.*PIS34 + I4yz.*U134 - I4xz.*U234 + I4zz.*WP34;
DV115=-WI14.^2;
DV225=-W34.^2;
DV335=-WI24.^2;
DV125=-(W34.*WI14);
DV135=WI14.*WI24;
DV235=-(W34.*WI24);
U115=DV225 + DV335;
U125=DV125 - WP24;
U135=DV135 - WP34;
U215=DV125 + WP24;
U225=DV115 + DV335;
U235=DV235 - WP14;
U315=DV135 + WP34;
U325=DV235 + WP14;
U335=DV115 + DV225;
VSP15=L4.*U114 + VP14;
VSP25=L4.*U214 + VP24;
VSP35=L4.*U314 + VSP34;
F15=mxL.*U115 + myL.*U125 + mzL.*U135 + mL.*VSP15;
F25=mxL.*U215 + myL.*U225 + mzL.*U235 - mL.*VSP35;
F35=mxL.*U315 + myL.*U325 + mzL.*U335 + mL.*VSP25;
PIS15=-ILyy + ILzz;
PIS25=ILxx - ILzz;
PIS35=-ILxx + ILyy;
No15=(-DV225 + DV335).*ILyz + DV235.*PIS15 + ILxz.*U215 - ILxy.*U315 + ILxx.*WP14;
No25=(DV115 - DV335).*ILxz + DV135.*PIS25 - ILyz.*U125 + ILxy.*U325 - ILyy.*WP34;
No35=(-DV115 + DV225).*ILxy + DV125.*PIS35 + ILyz.*U135 - ILxz.*U235 + ILzz.*WP24;
N15=No15 + myL.*VSP25 + mzL.*VSP35;
N25=No25 + mzL.*VSP15 - mxL.*VSP25;
N35=No35 - myL.*VSP15 - mxL.*VSP35;
E14=F14 + F15;
E24=F24 + F35;
E34=-F25 + F34;
N14=N15 + No14 - mz4.*VP24 + my4.*VSP34;
N24=F25.*L4 + N35 + No24 + mz4.*VP14 - mx4.*VSP34;
N34=F35.*L4 - N25 + No34 - my4.*VP14 + mx4.*VP24;
FDI14=C4.*E14 - E24.*S4;
FDI24=C4.*E24 + E14.*S4;
E13=F13 + FDI14;
E23=F23 + FDI24;
E33=E34 + F33;
N13=C4.*N14 + No13 - N24.*S4 - mz3.*VP23 + my3.*VSP33;
N23=-(E34.*L3) + C4.*N24 + No23 + N14.*S4 + mz3.*VP13 - mx3.*VSP33;
N33=FDI24.*L3 + N34 + No33 - my3.*VP13 + mx3.*VP23;
FDI23=C3.*E23 + E13.*S3;
E32=E33 + F32;
N12=C3.*N13 + No12 - N23.*S3 - mz2.*VP22 - my2.*VSP22;
N22=-(E33.*L2) + C3.*N23 + No22 + N13.*S3 + mz2.*VP12 + mx2.*VSP22;
N32=FDI23.*L2 + N33 + No32 - my2.*VP12 + mx2.*VP22;
N31=-(E32.*L1) + C2.*N22 + No31 + N12.*S2;
GAM1=N31 + Ia1.*qdd1;
GAM2=N32 + Ia2.*qdd2;
GAM3=N33 + Ia3.*qdd3;
GAM4=N34 + Ia4.*qdd4;
% *=*
% Number of operations : 230 '+' or '-', 226 '*' or '/'

H1 = simplify(GAM1);
H2 = simplify(GAM2);
H3 = simplify(GAM3);
H4 = simplify(GAM4);



%% generate tau_diff = YL*betaL;
tau_diff = [H1;H2;H3;H4];
betaL = [mL;mxL;myL;mzL;ILxx;ILxy;ILxz;ILyy;ILyz;ILzz];
YL = jacobian(tau_diff,betaL);

simplify(tau_diff-YL*betaL)
% Generate MATLAB function file
matlabFunction(YL,'File','getYL_hydraulic.m');


%% 
% 不用1轴：力矩为0
old = [qd2 qd3 qd4 qdd1 qdd2 qdd3 qdd4];
new = [sym(0),sym(0),sym(0),sym(0),sym(0),sym(0),sym(0)];
TauDiff1= subs(H1,old,new)

old = [qd1 qd3 qd4 qdd1 qdd2 qdd3 qdd4];
new = [sym(0),sym(0),sym(0),sym(0),sym(0),sym(0),sym(0)];
TauDiff2= subs(H2,old,new)

old = [qd1 qd2 qd4 qdd1 qdd2 qdd3 qdd4];
new = [sym(0),sym(0),sym(0),sym(0),sym(0),sym(0),sym(0)];
TauDiff3= subs(H3,old,new)

old = [qd1 qd2 qd3 qdd1 qdd2 qdd3 qdd4];
new = [sym(0),sym(0),sym(0),sym(0),sym(0),sym(0),sym(0)];
TauDiff4= subs(H4,old,new)
