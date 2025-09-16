/* (********************************************) */
/* (** SYMORO+ : SYmbolic MOdelling of RObots **) */
/* (**========================================**) */
/* (**      IRCCyN-ECN - 1, rue de la Noe     **) */
/* (**      B.P.92101                         **) */
/* (**      44321 Nantes cedex 3, FRANCE      **) */
/* (**      www.irccyn.ec-nantes.fr           **) */
/* (********************************************) */


/*    Name of file : C:/Users/73183/Desktop/SYMORO_WS/dual_armV2_left_load/dual_armv2_left_load.inm */




/*      Geometric parameters    */


/* j        ant      mu       sigma    gamma    b        alpha    d        theta    r */

/*                                                       -Pi               Pi */
/* 1        0        1        0        0        0        ---      0        -- + q1  L1 */
/*                                                        2                2 */
/*                                                       -Pi */
/* 2        1        1        0        0        0        ---      0        q2       0 */
/*                                                        2 */
/*                                                       Pi */
/* 3        2        1        0        0        0        --       0        q3       L2 */
/*                                                       2 */
/*                                                       -Pi */
/* 4        3        1        0        0        0        ---      L3       q4       0 */
/*                                                        2 */
/*                                                       Pi */
/* 5        4        1        0        0        0        --       0        q5       L4 */
/*                                                       2 */
/*                                                       -Pi               -Pi */
/* 6        5        1        0        0        0        ---      0        --- + q6 0 */
/*                                                        2                 2 */
/*                                                       Pi */
/* 7        6        1        0        0        0        --       L5       q7       0 */
/*                                                       2 */

/* 8        7        0        2        0        0        0        L6       0        0 */




/*              Inertial parameters */

/* j      XX     XY     XZ     YY     YZ     ZZ     MX     MY     MZ     M      Ia */

/* 1      I1xx   I1xy   I1xz   I1yy   I1yz   I1zz   mx1    my1    mz1    m1     Ia1 */

/* 2      I2xx   I2xy   I2xz   I2yy   I2yz   I2zz   mx2    my2    mz2    m2     Ia2 */

/* 3      I3xx   I3xy   I3xz   I3yy   I3yz   I3zz   mx3    my3    mz3    m3     Ia3 */

/* 4      I4xx   I4xy   I4xz   I4yy   I4yz   I4zz   mx4    my4    mz4    m4     Ia4 */

/* 5      I5xx   I5xy   I5xz   I5yy   I5yz   I5zz   mx5    my5    mz5    m5     Ia5 */

/* 6      I6xx   I6xy   I6xz   I6yy   I6yz   I6zz   mx6    my6    mz6    m6     Ia6 */

/* 7      I7xx   I7xy   I7xz   I7yy   I7yz   I7zz   mx7    my7    mz7    m7     Ia7 */

/* 8      ILxx   ILxy   ILxz   ILyy   ILyz   ILzz   mxL    myL    mzL    mL     0 */

/*                       Inertia matrix */
/* Equations: */

#include <stdio.h>
#include <math.h>

#define sign(x) (x<0.0 ? -1.0 : (x==0.0 ? 0.0 : 1.0))

/* Declaration of global input variables */
extern double q2, q3, q4, q5, q6, q7, L6, myL, mxL, mzL;
extern double I7xx, ILxx, I7xy, ILxy, I7xz, ILxz, I7yy, ILyy, mL, I7yz;
extern double ILyz, I7zz, ILzz, mx7, my7, mz7, m7, L5, I6xx, I6xy;
extern double I6xz, I6yy, I6yz, I6zz, mx6, my6, mz6, m6, I5xx, I5xy;
extern double I5xz, I5yy, I5yz, I5zz, mx5, my5, mz5, m5, L4, I4xx;
extern double I4xy, I4xz, I4yy, I4yz, I4zz, mx4, my4, mz4, m4, L3;
extern double I3xx, I3xy, I3xz, I3yy, I3yz, I3zz, mx3, my3, mz3, m3;
extern double L2, I2xx, I2xy, I2xz, I2yy, I2yz, I2zz, I1zz, Ia1, Ia2;
extern double Ia3, Ia4, Ia5, Ia6, Ia7;

/* Declaration of global output variables */
extern double A[9][9];

/* Declaration of the function */
void dual_armv2_left_load_inm()
{
double S2, C2, S3, C3, S4, C4, S5, C5, S6, C6;
double S7, C7, PAS218, PAS228, PAS318, PAS338, XXP7, XYP7, XZP7, YYP7;
double YZP7, ZZP7, MXP7, MYP7, MZP7, MP7, AS17, AS37, AJ117, AJ127;
double AJ137, AJ217, AJ227, AJ317, AJ327, AJ337, AJA117, AJA217, AJA317, AJA337;
double PAS217, PAS227, PAS317, PAS337, XXP6, XYP6, XZP6, YYP6, YZP6, ZZP6;
double MXP6, MYP6, MZP6, MP6, AS16, AS36, AJ116, AJ126, AJ136, AJ216;
double AJ226, AJ316, AJ326, AJ336, AJA116, AJA216, AJA316, AJA336, XXP5, XYP5;
double XZP5, YYP5, YZP5, ZZP5, MXP5, MYP5, MZP5, MP5, AS15, AS35;
double AJ115, AJ125, AJ135, AJ215, AJ225, AJ315, AJ325, AJ335, AJA115, AJA215;
double AJA315, AJA335, PAS115, PAS125, PAS325, PAS335, XXP4, XYP4, XZP4, YYP4;
double YZP4, ZZP4, MXP4, MYP4, MZP4, MP4, AS14, AS34, AJ114, AJ124;
double AJ134, AJ214, AJ224, AJ314, AJ324, AJ334, AJA114, AJA214, AJA314, AJA334;
double PAS214, PAS224, PAS314, PAS334, XXP3, XYP3, XZP3, YYP3, YZP3, ZZP3;
double MXP3, MYP3, MZP3, MP3, AS13, AS33, AJ113, AJ123, AJ133, AJ213;
double AJ223, AJ313, AJ323, AJ333, AJA113, AJA213, AJA313, AJA333, PAS113, PAS123;
double PAS323, PAS333, XXP2, XYP2, XZP2, YYP2, YZP2, ZZP2, AJ312, AJ322;
double AJ332, AJA332, ZZP1, EC12, EC32, NC12, NC32, NC33, ED12, ED32;
double ND22, ED13, ED33, ND13, ND33, ND34, EE12, EE32, NE12, NE32;
double EE13, EE33, NE13, NE23, NE33, EE14, EE34, NE14, NE34, NE35;
double EF12, EF32, EF13, EF33, NF13, NF33, EF14, EF34, NF14, NF24;
double NF34, EF15, EF35, NF15, NF35, NF36, EG12, EG32, NG22, EG13;
double EG33, NG13, NG33, EG14, EG34, NG14, NG34, EG15, EG35, NG15;
double NG25, NG35, EG16, EG36, NG16, NG36, NG37;

	S2=sin(q2);
	C2=cos(q2);
	S3=sin(q3);
	C3=cos(q3);
	S4=sin(q4);
	C4=cos(q4);
	S5=sin(q5);
	C5=cos(q5);
	S6=-cos(q6);
	C6=sin(q6);
	S7=sin(q7);
	C7=cos(q7);
	PAS218=L6*myL;
	PAS228=-(L6*mxL);
	PAS318=L6*mzL;
	PAS338=-(L6*mxL);
	XXP7=I7xx + ILxx;
	XYP7=I7xy + ILxy - PAS218;
	XZP7=I7xz + ILxz - PAS318;
	YYP7=I7yy + ILyy + (L6*L6)*mL - 2*PAS228;
	YZP7=I7yz + ILyz;
	ZZP7=I7zz + ILzz + (L6*L6)*mL - 2*PAS338;
	MXP7=L6*mL + mx7 + mxL;
	MYP7=my7 + myL;
	MZP7=mz7 + mzL;
	MP7=m7 + mL;
	AS17=C7*MXP7 - MYP7*S7;
	AS37=C7*MYP7 + MXP7*S7;
	AJ117=-((I7xy + ILxy - PAS218)*S7) + C7*XXP7;
	AJ127=C7*XYP7 - S7*YYP7;
	AJ137=C7*XZP7 - S7*YZP7;
	AJ217=-I7xz - ILxz + PAS318;
	AJ227=-I7yz - ILyz;
	AJ317=C7*(I7xy + ILxy - PAS218) + S7*XXP7;
	AJ327=S7*XYP7 + C7*YYP7;
	AJ337=S7*XZP7 + C7*YZP7;
	AJA117=AJ117*C7 - AJ127*S7;
	AJA217=AJ217*C7 - AJ227*S7;
	AJA317=AJ317*C7 - AJ327*S7;
	AJA337=AJ327*C7 + AJ317*S7;
	PAS217=-(L5*MZP7);
	PAS227=-(AS17*L5);
	PAS317=AS37*L5;
	PAS337=-(AS17*L5);
	XXP6=AJA117 + I6xx;
	XYP6=AJA217 + I6xy - PAS217;
	XZP6=AJA317 + I6xz - PAS317;
	YYP6=I6yy + (L5*L5)*MP7 - 2*PAS227 + ZZP7;
	YZP6=-AJ337 + I6yz;
	ZZP6=AJA337 + I6zz + (L5*L5)*MP7 - 2*PAS337;
	MXP6=AS17 + L5*MP7 + mx6;
	MYP6=my6 - MZP7;
	MZP6=AS37 + mz6;
	MP6=m6 + MP7;
	AS16=C6*MXP6 - MYP6*S6;
	AS36=-(C6*MYP6) - MXP6*S6;
	AJ116=-((AJA217 + I6xy - PAS217)*S6) + C6*XXP6;
	AJ126=C6*XYP6 - S6*YYP6;
	AJ136=C6*XZP6 - S6*YZP6;
	AJ216=AJA317 + I6xz - PAS317;
	AJ226=-AJ337 + I6yz;
	AJ316=-(C6*(AJA217 + I6xy - PAS217)) - S6*XXP6;
	AJ326=-(S6*XYP6) - C6*YYP6;
	AJ336=-(S6*XZP6) - C6*YZP6;
	AJA116=AJ116*C6 - AJ126*S6;
	AJA216=AJ216*C6 - AJ226*S6;
	AJA316=AJ316*C6 - AJ326*S6;
	AJA336=-(AJ326*C6) - AJ316*S6;
	XXP5=AJA116 + I5xx;
	XYP5=AJA216 + I5xy;
	XZP5=AJA316 + I5xz;
	YYP5=I5yy + ZZP6;
	YZP5=AJ336 + I5yz;
	ZZP5=AJA336 + I5zz;
	MXP5=AS16 + mx5;
	MYP5=my5 + MZP6;
	MZP5=AS36 + mz5;
	MP5=m5 + MP6;
	AS15=C5*MXP5 - MYP5*S5;
	AS35=C5*MYP5 + MXP5*S5;
	AJ115=-((AJA216 + I5xy)*S5) + C5*XXP5;
	AJ125=C5*XYP5 - S5*YYP5;
	AJ135=C5*XZP5 - S5*YZP5;
	AJ215=-AJA316 - I5xz;
	AJ225=-AJ336 - I5yz;
	AJ315=C5*(AJA216 + I5xy) + S5*XXP5;
	AJ325=S5*XYP5 + C5*YYP5;
	AJ335=S5*XZP5 + C5*YZP5;
	AJA115=AJ115*C5 - AJ125*S5;
	AJA215=AJ215*C5 - AJ225*S5;
	AJA315=AJ315*C5 - AJ325*S5;
	AJA335=AJ325*C5 + AJ315*S5;
	PAS115=-(L4*MZP5);
	PAS125=-(AS15*L4);
	PAS325=-(AS35*L4);
	PAS335=-(L4*MZP5);
	XXP4=AJA115 + I4xx + (L4*L4)*MP5 - 2*PAS115;
	XYP4=AJA215 + I4xy - PAS125;
	XZP4=AJA315 + I4xz;
	YYP4=I4yy + ZZP5;
	YZP4=-AJ335 + I4yz - PAS325;
	ZZP4=AJA335 + I4zz + (L4*L4)*MP5 - 2*PAS335;
	MXP4=AS15 + mx4;
	MYP4=-(L4*MP5) + my4 - MZP5;
	MZP4=AS35 + mz4;
	MP4=m4 + MP5;
	AS14=C4*MXP4 - MYP4*S4;
	AS34=-(C4*MYP4) - MXP4*S4;
	AJ114=-((AJA215 + I4xy - PAS125)*S4) + C4*XXP4;
	AJ124=C4*XYP4 - S4*YYP4;
	AJ134=C4*XZP4 - S4*YZP4;
	AJ214=AJA315 + I4xz;
	AJ224=-AJ335 + I4yz - PAS325;
	AJ314=-(C4*(AJA215 + I4xy - PAS125)) - S4*XXP4;
	AJ324=-(S4*XYP4) - C4*YYP4;
	AJ334=-(S4*XZP4) - C4*YZP4;
	AJA114=AJ114*C4 - AJ124*S4;
	AJA214=AJ214*C4 - AJ224*S4;
	AJA314=AJ314*C4 - AJ324*S4;
	AJA334=-(AJ324*C4) - AJ314*S4;
	PAS214=L3*MZP4;
	PAS224=-(AS14*L3);
	PAS314=AS34*L3;
	PAS334=-(AS14*L3);
	XXP3=AJA114 + I3xx;
	XYP3=AJA214 + I3xy - PAS214;
	XZP3=AJA314 + I3xz - PAS314;
	YYP3=I3yy + (L3*L3)*MP4 - 2*PAS224 + ZZP4;
	YZP3=AJ334 + I3yz;
	ZZP3=AJA334 + I3zz + (L3*L3)*MP4 - 2*PAS334;
	MXP3=AS14 + L3*MP4 + mx3;
	MYP3=my3 + MZP4;
	MZP3=AS34 + mz3;
	MP3=m3 + MP4;
	AS13=C3*MXP3 - MYP3*S3;
	AS33=C3*MYP3 + MXP3*S3;
	AJ113=-((AJA214 + I3xy - PAS214)*S3) + C3*XXP3;
	AJ123=C3*XYP3 - S3*YYP3;
	AJ133=C3*XZP3 - S3*YZP3;
	AJ213=-AJA314 - I3xz + PAS314;
	AJ223=-AJ334 - I3yz;
	AJ313=C3*(AJA214 + I3xy - PAS214) + S3*XXP3;
	AJ323=S3*XYP3 + C3*YYP3;
	AJ333=S3*XZP3 + C3*YZP3;
	AJA113=AJ113*C3 - AJ123*S3;
	AJA213=AJ213*C3 - AJ223*S3;
	AJA313=AJ313*C3 - AJ323*S3;
	AJA333=AJ323*C3 + AJ313*S3;
	PAS113=-(L2*MZP3);
	PAS123=-(AS13*L2);
	PAS323=-(AS33*L2);
	PAS333=-(L2*MZP3);
	XXP2=AJA113 + I2xx + (L2*L2)*MP3 - 2*PAS113;
	XYP2=AJA213 + I2xy - PAS123;
	XZP2=AJA313 + I2xz;
	YYP2=I2yy + ZZP3;
	YZP2=-AJ333 + I2yz - PAS323;
	ZZP2=AJA333 + I2zz + (L2*L2)*MP3 - 2*PAS333;
	AJ312=-(C2*(AJA213 + I2xy - PAS123)) - S2*XXP2;
	AJ322=-(S2*XYP2) - C2*YYP2;
	AJ332=-(S2*XZP2) - C2*YZP2;
	AJA332=-(AJ322*C2) - AJ312*S2;
	ZZP1=AJA332 + I1zz;
	EC12=-(C3*MYP3) - MXP3*S3;
	EC32=C3*MXP3 - MYP3*S3;
	NC12=AJ133 - EC32*L2;
	NC32=AJ333 + EC12*L2;
	NC33=-(NC12*S2) + C2*ZZP3;
	ED12=-(C4*MYP4) - MXP4*S4;
	ED32=-(C4*MXP4) + MYP4*S4;
	ND22=-(ED32*L3) + ZZP4;
	ED13=C3*ED12;
	ED33=ED12*S3;
	ND13=AJ134*C3 - ED33*L2 - ND22*S3;
	ND33=ED13*L2 + C3*ND22 + AJ134*S3;
	ND34=AJ334*C2 - ND13*S2;
	EE12=-(C5*MYP5) - MXP5*S5;
	EE32=C5*MXP5 - MYP5*S5;
	NE12=AJ135 - EE32*L4;
	NE32=AJ335 + EE12*L4;
	EE13=C4*EE12;
	EE33=-(EE12*S4);
	NE13=C4*NE12 + S4*ZZP5;
	NE23=-(EE33*L3) + NE32;
	NE33=EE32*L3 - NE12*S4 + C4*ZZP5;
	EE14=C3*EE13 - EE32*S3;
	EE34=C3*EE32 + EE13*S3;
	NE14=-(EE34*L2) + C3*NE13 - NE23*S3;
	NE34=EE14*L2 + C3*NE23 + NE13*S3;
	NE35=C2*NE33 - NE14*S2;
	EF12=-(C6*MYP6) - MXP6*S6;
	EF32=-(C6*MXP6) + MYP6*S6;
	EF13=C5*EF12;
	EF33=EF12*S5;
	NF13=AJ136*C5 - EF33*L4 - S5*ZZP6;
	NF33=EF13*L4 + AJ136*S5 + C5*ZZP6;
	EF14=C4*EF13 + EF32*S4;
	EF34=C4*EF32 - EF13*S4;
	NF14=C4*NF13 + AJ336*S4;
	NF24=-(EF34*L3) + NF33;
	NF34=AJ336*C4 + EF33*L3 - NF13*S4;
	EF15=C3*EF14 - EF33*S3;
	EF35=C3*EF33 + EF14*S3;
	NF15=-(EF35*L2) + C3*NF14 - NF24*S3;
	NF35=EF15*L2 + C3*NF24 + NF14*S3;
	NF36=C2*NF34 - NF15*S2;
	EG12=-(C7*MYP7) - MXP7*S7;
	EG32=C7*MXP7 - MYP7*S7;
	NG22=-(EG32*L5) - ZZP7;
	EG13=C6*EG12;
	EG33=-(EG12*S6);
	NG13=AJ137*C6 - NG22*S6;
	NG33=-(C6*NG22) - AJ137*S6;
	EG14=C5*EG13 - EG32*S5;
	EG34=C5*EG32 + EG13*S5;
	NG14=-(EG34*L4) + C5*NG13 - AJ337*S5;
	NG34=AJ337*C5 + EG14*L4 + NG13*S5;
	EG15=C4*EG14 + EG33*S4;
	EG35=C4*EG33 - EG14*S4;
	NG15=C4*NG14 + NG33*S4;
	NG25=-(EG35*L3) + NG34;
	NG35=EG34*L3 + C4*NG33 - NG14*S4;
	EG16=C3*EG15 - EG34*S3;
	EG36=C3*EG34 + EG15*S3;
	NG16=-(EG36*L2) + C3*NG15 - NG25*S3;
	NG36=EG16*L2 + C3*NG25 + NG15*S3;
	NG37=C2*NG35 - NG16*S2;
	A[1][1]=Ia1 + ZZP1;
	A[2][1]=AJ332;
	A[3][1]=NC33;
	A[4][1]=ND34;
	A[5][1]=NE35;
	A[6][1]=NF36;
	A[7][1]=NG37;
	A[2][2]=Ia2 + ZZP2;
	A[3][2]=NC32;
	A[4][2]=ND33;
	A[5][2]=NE34;
	A[6][2]=NF35;
	A[7][2]=NG36;
	A[3][3]=Ia3 + ZZP3;
	A[4][3]=AJ334;
	A[5][3]=NE33;
	A[6][3]=NF34;
	A[7][3]=NG35;
	A[4][4]=Ia4 + ZZP4;
	A[5][4]=NE32;
	A[6][4]=NF33;
	A[7][4]=NG34;
	A[5][5]=Ia5 + ZZP5;
	A[6][5]=AJ336;
	A[7][5]=NG33;
	A[6][6]=Ia6 + ZZP6;
	A[7][6]=AJ337;
	A[7][7]=Ia7 + ZZP7;
}

/* *=* */
/* Number of operations : 267 '+' or '-', 308 '*' or '/' */

/*  QDP=  */
/* {qdd1, qdd2, qdd3, qdd4, qdd5, qdd6, qdd7} */

