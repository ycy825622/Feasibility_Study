% Gregory, AP;Clarke, RN 2012 --Tables of the complex permittivity of dielectric reference liquids at frequencies up to 5 GHz
% W. J. Ellison 2007 --Permittivity of Pure Water, at Standard Atmospheric Pressure, over the Frequency Range 0 – 25 THz and the Temperature Range 0 – 100 ° C
% Kroeger, MK 1987 --Clustering and dielectric behavior of alcohols 
% Bao, Jian‐Zhong Swicord, Mays L Davis, Christopher C 1996 -- Microwave dielectric characterization of binary mixtures of water, methanol, and ethanol
% http://baike.so.com/doc/765975-810486.html 当量浓度的定义
% 生理盐水的质量分数是0.9%,生理盐水的密度是1000g/L,溶质氯化钠的摩尔质量是58.5g/mol,通过以上数据得出生理盐水的量浓度是0.9/100 * 1000g/L / 58.5g/mol ≈ 0.1538mol/L
% one Debye---------------e=e8+(es-e8)./(1+1i*f/fr);
% duoble Debye------------e=e8+(es-eh)./(1+1i*f/fr1)+(eh-e8)./(1+1i*f/fr2);
% Debye-T-----------------e=eh+(es-eh)./(1+1i*f/fr)-1i*f*tail;
% Davidson-Cole-----------e=e8+(es-e8)./(1+1i*f/fr)^B;

%es     the static permittivity
%eh     the notional high frequency permittivity
%e8     the high-frequency permittivity
%fr     the relaxation frequency
%fr1    the first relaxation frequencies
%fr2    the second relaxation frequencies
%X_v    Reference Liquids proportion



function q=RefEPfunc_re(name,T,proportion,f)   %----注意对比公式中的加减号，有些文献中水中分母为减号，有些文献中为正号
% Reference Liquids name---water，Propan_1_ol，Ethanol，Methanol，Butan_1_ol,Ethanediol，Dimethyl sulphoxide,Propan_2_ol，Cyclohexane，Acetone


Liquid=name;
%temperature of reference Liquids (°C);
t=T;
X_v=proportion;   %Reference Liquids
% resonance frequence

% deionized water permittivity--2007
if Liquid==1
%Parameters for the three relaxations terms
a1=79.23882;b1=0.004300598;c1=1.382264*10^(-13);d1=652.7648;
a2=3.815866;b2=0.01117295;c2=3.510354*10^(-16);d2=1249.533;
a3=1.634967;b3=0.006841548;c3=6.30035*10^(-15);d3=405.5169;tc=133.1383;
%First resonance parameters
p0=0.8379692;p1=-0.006118594;p2=-0.000012936798;
p3=4235901000000;p4=-14260880000;p5=273815700;p6=-1246943;
p7=9.618642*10^(-14);p8=1.795786*10^(-16);p9=-9.310017*10^(-18);p10=1.655473*10^(-19);
%Second resonance parameters
p11=0.6165532;p12=0.007238523;p13=-0.00009523366;
p14=15983170000000;p15=-74413570000;p16=497448000;
p17=2.882476*10^(-14);p18=-3.142118*10^(-16);p19=3.528051*10^(-18);
%static permittivity
Es=87.9144-0.404399*t+9.58726*10^(-4)*t^(2)-1.32802*10^(-6)*t^(3);   
%relaxation time
   %Three Debye relaxations
s1=a1*exp(-b1*t);s2=a2*exp(-b2*t);s3=a3*exp(-b3*t);
t1=c1*exp(d1/(t+tc));t2=c2*exp(d2/(t+tc));t3=c3*exp(d3/(t+tc));
   %Two resonance relaxations
s4=p0+p1*t+p2*t^2;s5=p11+p12*t+p13*t^2;
t4=p7+p8*t+p9*t^2+p10*t^3;t5=p17+p18*t+p19*t^2;                     
%resonance frequence
f0=p3+p4*t+p5*t^2+p6*t^3;f1=p14+p15*t+p16*t^2;
%our final model for the permittivity of water uses three relaxation terms and two resonance terms
ES=Es+1i*2*pi*f.*(s1*t1./(1-1i*2*pi*f.*t1)+s2*t2./(1-1i*2*pi*f.*t2)+s3*t3./(1-1i*2*pi*f.*t3))+1i*pi.*f.*(s4*t4./(1-1i*2*pi*t4.*(f0+f))+s4*t4./(1+1i*2*pi*t4.*(f0-f)))+1i*pi*f.*(s5*t5./(1-1i*2*pi*t5.*(f1+f))+s5*t5./(1+1i*2*pi*t5.*(f1-f)));
p=conj(ES); 


%NaCl
elseif Liquid==2
% n为当量浓度，对于NaCl而言，当量浓度即为物质的量浓度 mol/L
% f=500*10^6
% proportion=0.1538
% t=25
n=proportion;
y=25-t;
es_zero=87.74-4.0008*10^(-1)*t+0.09398*10^(-2)*t^2-0.00141*10^(-3)*t^3; %+0.009;
re_zero=17.68703-6.2240692*10^(-1)*t+1.263*10^(-2)*t^2-0.1354*10^(-3)*t^3+0.005631*10^(-4)*t^4;
a_n=1-0.2551*n+5.151*10^(-2)*n^2-6.889*10^(-3)*n^3;
b_n=0.1463*10^(-2)*n*t+1-0.04896*n-2.967*10^(-2)*n^2+5.644*10^(-3)*n^3;
es_n=es_zero*a_n;
eh=4.5;
re_n=re_zero*b_n*10^(-12);
a=0.02;
conduct_25=n*(10.394-2.3776*n+0.68258*n^2-0.13538*n^3+1.0086*10^(-2)*n^4);
conduct=conduct_25*(1.0-1.962*10^(-2)*y+8.08*10^(-5)*y^2-y*n*(3.020*10^(-5)+3.922*10^(-5)*y+n*(1.721*10^(-5)-6.584*10^(-6)*y)));
free_space=8.854*10^(-12);  
w=2*pi*f;
% part_one=(es_n-eh)./(1+(1i*w.*re_n).^(1-a))
% part_two=conduct./(w.*free_space)
% permitivity=real(eh+part_one)
ES=eh+(es_n-eh)./(1+(1i*w.*re_n).^(1-a))-1i*conduct./(w.*free_space);
p=ES;
% perm=real(p)
% -imag(p)
% con=-imag(p).*w*free_space

% Double_Debye--Purities of the propan_1_ol (正丙醇) >99.5%---使用范围 Temperature range 15-30°C---2012
elseif Liquid==3
  
a=[-1.133e-06   0.0001327   -0.005892   0.1125   2.369];
e8=a(1)*t^4 + a(2)*t^3 + a(3)*t^2 + a(4)*t + a(5);
b=[-8.667e-06   0.00086  -0.03058   0.3185  21.52];
es_zero=b(1)*t^4 + b(2)*t^3 + b(3)*t^2 + b(4)*t + b(5);
c=[-4e-07  3.333e-05   -0.00091  0.005167  3.879];
eh=c(1)*t^4 + c(2)*t^3 + c(3)*t^2 + c(4)*t + c(5);
d=[6e-07   -5.8e-05  0.002365  -0.02825  0.385];
fr1=d(1)*t^4 + d(2)*t^3 + d(3)*t^2 + d(4)*t + d(5);
fr1=fr1*10^9;
e=[4.827e-05  -0.004911  0.1843  -2.898  23.43];
fr2=e(1)*t^4 + e(2)*t^3 + e(3)*t^2 + e(4)*t + e(5);
fr2=fr2*10^9;
e=e8+(es_zero-eh)./(1+1i*f/fr1)+(eh-e8)./(1+1i*f/fr2);
p=e;

% Debye_T--Purities of the Ethanol( 乙醇) >99.8% --- 使用范围 Temperature range15-35°C---2012   
elseif Liquid==4
    
   if X_v>=99.8 
              b=[1.133e-05   -0.001167   0.04372   -0.8568  32.33];
              es_zero=b(1)*t^4 + b(2)*t^3 + b(3)*t^2 + b(4)*t + b(5);
              c=[ 3.4e-06  -0.0003607   0.01405  -0.2445  6.14];
              eh=c(1)*t^4 + c(2)*t^3 + c(3)*t^2 + c(4)*t + c(5);
              k=[-1.667e-06  0.0001753  -0.006358  0.1226  -0.216];
              fr=k(1)*t^4 + k(2)*t^3 + k(3)*t^2 + k(4)*t + k(5);
              fr=fr*10^9;
              m=[5.333e-07  -5.867e-05   0.002407   -0.04403   0.361];
              tail=m(1)*t^4 + m(2)*t^3 + m(3)*t^2 + m(4)*t + m(5);
              tail=tail*10^(-9);
              e=eh+(es_zero-eh)./(1+1i*f/fr)-1i*f*tail;
              p=e;
    %转换不同浓度的酒精的介电常数 (不太准确)          
   else           %one Debye 根据2012年NPL数据拟合为one Debye 模型得到的es e8 fr
             Xv=X_v/100;  %酒精含量
             %水的介电常数
            a1= 80.69715;
            b1= 0.004415996;
            v_water=a1*exp(-b1*t); 
            %water 静态介电常数
            es_water=87.9144-0.404399*t+9.58726*10^(-4)*t^2-1.32892*10^(-6)*t^3;  
            %水的弛豫时间
            c1=1.367283*10^(-13); 
            d1=651.4728;
            tc=133.0699;
            relaxation_time_water=c1*exp(d1/(t+tc));
 
            %Ethanol 静态介电常数
            b=[  8.911e-06 -0.0008827    0.0323    -0.6716     31.34];
            es_Ethanol= b(1)*t^4 + b(2)*t^3 + b(3)*t^2 + b(4)*t + b(5); 
            %Ethanol 高频介电常数
            c=[  -9.04e-06  0.0009005    -0.03263   0.4967     1.729];
            eh_Ethanol = c(1)*t^4 + c(2)*t^3 + c(3)*t^2 + c(4)*t + c(5); 
            v_Ethanol=es_Ethanol-eh_Ethanol;
            % Ethanol relaxation time
             k=[ -2.139e-07  2.557e-05  -0.0006824    0.02902   0.3417];
            fr = k(1)*t^4 + k(2)*t^3 + k(3)*t^2 + k(4)*t + k(5);
            fr=fr*10^9;
            relaxation_time_Ethanol=1/(2*pi*fr);
            %relaxation time 混合弛豫时间 有差异 按照参考文献求出来的relaxation time 跟文献本身结果页不一致
            relaxation_time=relaxation_time_water*exp(Xv*log(relaxation_time_Ethanol/relaxation_time_water));
            %混合静态介电常数  es>>e8 的情况下才能用 Clustering and dielectric behavior of alcohols
            es_water_Ethanol=(1-Xv)*es_water+Xv*es_Ethanol;  
            %混合静态介电常数与高频静态介电常数差 Microwave dielectric characterization of binary mixtures of water, Ethanol, and ethanol
            v_water_Ethanol=(1-Xv)*v_water+Xv*v_Ethanol ;       
             %混合高频介电常数
            e8_water_Ethanol=es_water_Ethanol- v_water_Ethanol;                            
            %求出e8_water_Ethanol的值 Permittivity of Pure Water, at Standard Atmospheric Pressure, over the Frequency Range 0–25THz and the Temperature Range 0–100°
             e=e8_water_Ethanol+v_water_Ethanol./(1+1i*2*pi*f*relaxation_time);    
             p=e;
   end

% Single_Debye-----Purities of the Methanol (甲醇)>99.8% --- 使用范围 Temperature range 15-35°C---2012
elseif Liquid==5
    
    if X_v>=99.8
           b=[6.667e-06  -0.0006667  0.02503  -0.6133  40.16];
           es_zero=b(1)*t^4 + b(2)*t^3 + b(3)*t^2 + b(4)*t + b(5);
           a=[3.2e-06  -0.0002547  0.00658  -0.07353   6.018];
          e8=a(1)*t^4 + a(2)*t^3 + a(3)*t^2 + a(4)*t + a(5);
           k=[-5.333e-07  4.933e-05  -0.001087  0.06207  1.706];
           fr=k(1)*t^4 + k(2)*t^3 + k(3)*t^2 + k(4)*t + k(5);
           fr=fr*10^9;
           e=e8+(es_zero-e8)./(1+1i*f/fr);
           p=e;
    else 
        Xv=X_v/100;
             %水的介电常数
            a1= 80.69715;
            b1= 0.004415996;
            v_water=a1*exp(-b1*t);  
            es_water=87.9144-0.404399*t+9.58726*10^(-4)*t^2-1.32892*10^(-6)*t^3;  %water 静态介电常数
            %水的弛豫时间
            c1=1.367283*10^(-13); 
            d1=651.4728;
            tc=133.0699;
            relaxation_time_water=c1*exp(d1/(t+tc));
           % Methanol 静态介电常数
           b=[6.667e-06  -0.0006667  0.02503  -0.6133  40.16];
          es_Methanol=b(1)*t^4 + b(2)*t^3 + b(3)*t^2 + b(4)*t + b(5); 
          a=[3.2e-06  -0.0002547  0.00658  -0.07353   6.018];
          e8_Methanol=a(1)*t^4 + a(2)*t^3 + a(3)*t^2 + a(4)*t + a(5);
          v_Methanol=es_Methanol-e8_Methanol;
         k=[-5.333e-07  4.933e-05  -0.001087  0.06207  1.706];
         fr=k(1)*t^4 + k(2)*t^3 + k(3)*t^2 + k(4)*t + k(5);
         fr=fr*10^9;
         relaxation_time_Methanol=1/(2*pi*fr);      
         relaxation_time=relaxation_time_water*exp(Xv*log(relaxation_time_Methanol/relaxation_time_water)); %混合弛豫时间
         es_water_Methanol=(1-Xv)*es_water+Xv*es_Methanol ;                                   %混合静态介电常数  es>>e8 的情况下才能用
         v_water_Methanol=(1-Xv)*v_water+Xv*v_Methanol    ;                                 %混合静态介电常数与高频静态介电常数差
         e8_water_Methanol=es_water_Methanol- v_water_Methanol  ;                              %混合高频介电常数
         %求出e8_water_Methanol的值
         e=e8_water_Methanol+v_water_Methanol./(1+1i*2*pi*f*relaxation_time); 
         p=e;
    end
    
    % Single Debye--Purities of the Dimethyl sulphoxide(二甲基亚砜) >99.5%---使用范围 Temperature range 20-40°C---2012
elseif  Liquid==6
    
  if X_v>=99.5
             a=[5.547e-05  -0.006616  0.29  -5.577  46.42];
             e8=a(1)*t^4 + a(2)*t^3 + a(3)*t^2 + a(4)*t + a(5);
             b=[6.667e-06  -0.0008   0.03503  -0.792  54.29];
             es_zero=b(1)*t^4 + b(2)*t^3 + b(3)*t^2 + b(4)*t + b(5);
             k=[-1.587e-05  0.001888  -0.08198  1.695   -6.127];
            fr=k(1)*t^4 + k(2)*t^3 + k(3)*t^2 + k(4)*t + k(5);
            fr=fr*10^9;
            e=e8+(es_zero-e8)./(1+1i*f/fr);
            p=e;

  else
       Xv=X_v/100; 
                    %水的介电常数
            a1= 80.69715;
            b1= 0.004415996;
            v_water=a1*exp(-b1*t);  
            es_water=87.9144-0.404399*t+9.58726*10^(-4)*t^2-1.32892*10^(-6)*t^3;  %water 静态介电常数
            %水的弛豫时间
            c1=1.367283*10^(-13); 
            d1=651.4728;
            tc=133.0699;
            relaxation_time_water=c1*exp(d1/(t+tc));
          %  the Dimethyl sulphoxide
            a=[5.547e-05  -0.006616  0.29  -5.577  46.42];
            e8_Dimethyl=a(1)*t^4 + a(2)*t^3 + a(3)*t^2 + a(4)*t + a(5);
            b=[6.667e-06  -0.0008   0.03503  -0.792  54.29];
            es_Dimethyl=b(1)*t^4 + b(2)*t^3 + b(3)*t^2 + b(4)*t + b(5);
            v_Dimethyl=es_Dimethyl-e8_Dimethyl;         
             k=[-1.587e-05  0.001888  -0.08198  1.695   -6.127];
             fr=k(1)*t^4 + k(2)*t^3 + k(3)*t^2 + k(4)*t + k(5);
             fr=fr*10^9;
            relaxation_time_Dimethyl=1/(2*pi*fr);          
           relaxation_time=relaxation_time_water*exp(Xv*log(relaxation_time_Dimethyl/relaxation_time_water)); %混合弛豫时间
           v_water_Dimethyl=(1-Xv)*v_water+Xv*v_Dimethyl    ;                                 %混合静态介电常数与高频静态介电常数差
           es_water_Dimethyl=(1-Xv)*es_water+Xv*es_Dimethyl ;                                   %混合静态介电常数  es>>e8 的情况下才能用
           e8_water_Dimethyl=es_water_Dimethyl- v_water_Dimethyl  ;                              %混合高频介电常数
          %求出e8_water_Dimethyl的值
         e=e8_water_Dimethyl+v_water_Dimethyl./(1+1i*2*pi*f*relaxation_time); 
         p=e;
  end
  
% Double_Debye---Purities of the Butan_1_ol( 正丁醇 ) >99.5%---使用范围 Temperature range 15-35°C---2012 
elseif Liquid==7

a=[3.333e-06 -0.000372  0.01494  -0.2544  4.456];
e8=a(1)*t^4 + a(2)*t^3 + a(3)*t^2 + a(4)*t + a(5);

b=[-1.333e-06  0.0001333  -0.004567  -0.06833  20.53];
es_zero=b(1)*t^4 + b(2)*t^3 + b(3)*t^2 + b(4)*t + b(5);

c=[2.133e-06  -0.0002307  0.009127  -0.1571  4.501];
eh=c(1)*t^4 + c(2)*t^3 + c(3)*t^2 + c(4)*t + c(5);

d=[-1.333e-07  1.6e-05   -0.0004167   0.0127    0.063];
fr1=d(1)*t^4 + d(2)*t^3 + d(3)*t^2 + d(4)*t + d(5);
fr1=fr1*10^9;

e=[-5.5e-05  0.006059  -0.24   4.12  -20.21];
fr2=e(1)*t^4 + e(2)*t^3 + e(3)*t^2 + e(4)*t + e(5);
fr2=fr2*10^9;

e=e8+(es_zero-eh)./(1+1i*f/fr1)+(eh-e8)./(1+1i*f/fr2);
p=e;

% Double_Debye--Purities of the propan_2_ol(异丙醇) >99.7% ---使用范围 Temperature range 10-25°C---2012
elseif Liquid==8
  
a=[2.867e-06   -0.000262   0.008488   -0.113   3.56];
e8=a(1)*t^4 + a(2)*t^3 + a(3)*t^2 + a(4)*t + a(5);
b=[8.667e-06   -0.0007267   0.02198   -0.4428   24.6];
es_zero=b(1)*t^4 + b(2)*t^3 + b(3)*t^2 + b(4)*t + b(5);
c=[-1e-06   7.667e-05   -0.002115   0.02318  3.486];
eh=c(1)*t^4 + c(2)*t^3 + c(3)*t^2 + c(4)*t + c(5);
d=[-9.951e-21   5.333e-06   4e-05   0.008467  0.123];
fr1=d(1)*t^4 + d(2)*t^3 + d(3)*t^2 + d(4)*t + d(5);
fr1=fr1*10^9;
e=[-1.053e-05   0.001316   -0.05138   0.8465   0.499];
fr2=e(1)*t^4 + e(2)*t^3 + e(3)*t^2 + e(4)*t + e(5);
fr2=fr2*10^9;
e=e8+(es_zero-eh)./(1+1i*f/fr1)+(eh-e8)./(1+1i*f/fr2);
p=e;

% Davidson_Cole--Purities of the Ethanediol (乙二醇) >99.5% --- 使用范围 Temperature range 15-35°C---2012
elseif Liquid==9

a=[-2.14e-05   0.002298  -0.09042   1.543  -4.9];
e8=a(1)*t^4 + a(2)*t^3 + a(3)*t^2 + a(4)*t + a(5);
b=[-1.333e-06   0.00012   -0.002967  -0.216  46.65];
es_zero=b(1)*t^4 + b(2)*t^3 + b(3)*t^2 + b(4)*t + b(5);
k=[5.333e-07  -4.4e-05  0.001947  0.0005  0.44];
fr=k(1)*t^4 + k(2)*t^3 + k(3)*t^2 + k(4)*t + k(5);
fr=fr*10^9;
n=[-9.333e-07   0.0001027  -0.004137   0.07323  0.374];
B=n(1)*t^4 + n(2)*t^3 + n(3)*t^2 + n(4)*t + n(5);
e=e8+(es_zero-e8)./(1+1i*f/fr).^B; 
p=e;

else


    ht = {"Artery",0.700000000000000,4,60,8.37700000000000e-06,0.100000000000000,5204,0.132630000000000,0.100000000000000,4,159.155000000000,0.200000000000000,4,15915,0;"Brain_grey_matter",0.0200000000000000,4,49,7.95800000000000e-06,0.100000000000000,404,0.0159150000000000,0.150000000000000,200004,106.103000000000,0.220000000000000,45000000,5305,0;"Brain_white_matter",0.0200000000000000,4,36,7.95800000000000e-06,0.100000000000000,104,0.00795800000000000,0.100000000000000,40004,53.0520000000000,0.300000000000000,35000000,7958,0.0200000000000000;"Cartilage",0.150000000000000,4,42,1.32630000000000e-05,0.150000000000000,2504,0.144690000000000,0.150000000000000,100004,318.310000000000,0.100000000000000,40000000,15915,0;"Cerebellum",0.0400000000000000,4,44,7.95800000000000e-06,0.100000000000000,704,0.0159150000000000,0.150000000000000,200004,106.103000000000,0.220000000000000,45000000,5305,0;"Cerebrospinal_fluid",2,4,69,7.95800000000000e-06,0.100000000000000,44,0.00159200000000000,0,4,159.155000000000,0,4,15915,0;"Connective_tissue",0.250000000000000,4,46,1.22430000000000e-05,0.100000000000000,64,0.00636600000000000,0.100000000000000,60004,318.310000000000,0.220000000000000,20000000,1326,0;"Ear_cartilage",0.150000000000000,4,42,1.32630000000000e-05,0.150000000000000,2504,0.144690000000000,0.150000000000000,100004,318.310000000000,0.100000000000000,40000000,15915,0;"Ear_skin",0.000200000000000000,4,36,7.23400000000000e-06,0,1104,0.0324810000000000,0.200000000000000,4,159.155000000000,0.200000000000000,4,15915,0.200000000000000;"Eye_vitreous_humor",1.50000000000000,4,69,7.23400000000000e-06,0,34,0.159150000000000,0.100000000000000,4,159.155000000000,0,4,15915,0;"Eye_lens",0.200000000000000,3,35,8.84200000000000e-06,0.100000000000000,103,0.0106100000000000,0.200000000000000,1003,15.9150000000000,0.200000000000000,5003,15915,0;"Fat",0.0350000000000000,2.50000000000000,11.5000000000000,7.95800000000000e-06,0.200000000000000,37.5000000000000,0.0159150000000000,0.100000000000000,33002.5000000000,159.155000000000,0.0500000000000000,10000000,15915,0.0100000000000000;"Hippocampus",0.0200000000000000,4,49,7.95800000000000e-06,0.100000000000000,404,0.0159150000000000,0.150000000000000,200004,106.103000000000,0.220000000000000,45000000,5305,0;"Hypophysis",0.500000000000000,4,59,7.95800000000000e-06,0.100000000000000,2504,0.159150000000000,0.100000000000000,100004,159.155000000000,0.200000000000000,40000000,15915,0;"Hypothalamus",0.500000000000000,4,59,7.95800000000000e-06,0.100000000000000,2504,0.159150000000000,0.100000000000000,100004,159.155000000000,0.200000000000000,40000000,15915,0;"Intervertebral_disc",0.150000000000000,4,42,1.32630000000000e-05,0.150000000000000,2504,0.144690000000000,0.150000000000000,100004,318.310000000000,0.100000000000000,40000000,15915,0;"Larynx",0.150000000000000,4,42,1.32630000000000e-05,0.150000000000000,2504,0.144690000000000,0.150000000000000,100004,318.310000000000,0.100000000000000,40000000,15915,0;"Mandible",0.0200000000000000,2.50000000000000,12.5000000000000,1.32630000000000e-05,0.200000000000000,182.500000000000,0.0795770000000000,0.200000000000000,5002.50000000000,159.155000000000,0.200000000000000,100002,15915,0;"Marrow_red",0.100000000000000,2.50000000000000,11.5000000000000,1.44690000000000e-05,0.200000000000000,82.5000000000000,0.0159150000000000,0.100000000000000,10002.5000000000,1591.55000000000,0.100000000000000,2000000,15915,0.100000000000000;"Midbrain",0.0400000000000000,4,44,7.95800000000000e-06,0.100000000000000,704,0.0159150000000000,0.150000000000000,200004,106.103000000000,0.220000000000000,45000000,5305,0;"Muscle",0.200000000000000,4,54,7.23400000000000e-06,0.100000000000000,7004,0.353680000000000,0.100000000000000,1200000,318.310000000000,0.100000000000000,25000000,2274,0;"Bone",0.0200000000000000,2.50000000000000,12.5000000000000,1.32630000000000e-05,0.200000000000000,182.500000000000,0.0795770000000000,0.200000000000000,5002.50000000000,159.155000000000,0.200000000000000,100002,15915,0;"mucosa",0.000400000000000000,4,43,7.95800000000000e-06,0.100000000000000,284,0.0795770000000000,0,30004,1.59200000000000,0.160000000000000,30004,1592,0.200000000000000;"Nerve",0.00600000000000000,4,30,7.95800000000000e-06,0.100000000000000,504,0.106100000000000,0.150000000000000,70004,15.9150000000000,0.200000000000000,40000000,15915,0;"Pharynx",0,1,1,0,0,1,0,0,1,0,0,1,0,0;"Skin",0.000200000000000000,4,36,7.23400000000000e-06,0,1104,0.0324810000000000,0.200000000000000,4,159.155000000000,0.200000000000000,4,15915,0.200000000000000;"Skull",0.0200000000000000,2.50000000000000,12.5000000000000,1.32630000000000e-05,0.200000000000000,182.500000000000,0.0795770000000000,0.200000000000000,5002.50000000000,159.155000000000,0.200000000000000,100002,15915,0;"Spinal_cord",0.00600000000000000,4,30,7.95800000000000e-06,0.100000000000000,504,0.106100000000000,0.150000000000000,70004,15.9150000000000,0.200000000000000,40000000,15915,0;"SAT",0.0350000000000000,2.50000000000000,11.5000000000000,7.95800000000000e-06,0.200000000000000,37.5000000000000,0.0159150000000000,0.100000000000000,33002.5000000000,159.155000000000,0.0500000000000000,10000000,15915,0.0100000000000000;"Teeth",0.0200000000000000,2.50000000000000,12.5000000000000,1.32630000000000e-05,0.200000000000000,182.500000000000,0.0795770000000000,0.200000000000000,5002.50000000000,159.155000000000,0.200000000000000,100002,15915,0;"Tendon_Ligament",0.250000000000000,4,46,1.22430000000000e-05,0.100000000000000,64,0.00636600000000000,0.100000000000000,60004,318.310000000000,0.220000000000000,20000000,1326,0;"Thalamus",0.0200000000000000,4,49,7.95800000000000e-06,0.100000000000000,404,0.0159150000000000,0.150000000000000,200004,106.103000000000,0.220000000000000,45000000,5305,0;"Tongue",0.250000000000000,4,54,7.95800000000000e-06,0.100000000000000,4004,0.159150000000000,0.100000000000000,100004,159.155000000000,0.200000000000000,40000000,15915,0;"Vein",0.700000000000000,4,60,8.37700000000000e-06,0.100000000000000,5204,0.132630000000000,0.100000000000000,4,159.155000000000,0.200000000000000,4,15915,0;"Vertebrae",0.0200000000000000,2.50000000000000,12.5000000000000,1.32630000000000e-05,0.200000000000000,182.500000000000,0.0795770000000000,0.200000000000000,5002.50000000000,159.155000000000,0.200000000000000,100002,15915,0;"Pineal_body",0.500000000000000,4,59,7.95800000000000e-06,0.100000000000000,2504,0.159150000000000,0.100000000000000,100004,159.155000000000,0.200000000000000,40000000,15915,0;"Pons",0.0400000000000000,4,44,7.95800000000000e-06,0.100000000000000,704,0.0159150000000000,0.150000000000000,200004,106.103000000000,0.220000000000000,45000000,5305,0;"Medulla_oblongata",0.0400000000000000,4,44,7.95800000000000e-06,0.100000000000000,704,0.0159150000000000,0.150000000000000,200004,106.103000000000,0.220000000000000,45000000,5305,0;"cornea",0.400000000000000,4,52,7.95800000000000e-06,0.100000000000000,4004,0.159150000000000,0.0500000000000000,100004,15.9150000000000,0.200000000000000,40000000,15915,0;"Eye_Sclera",0.500000000000000,4,54,7.95800000000000e-06,0.100000000000000,4004,0.159150000000000,0.100000000000000,100004,159.155000000000,0.200000000000000,5000000,15915,0;"Commissura_anterior",0.0200000000000000,4,36,7.95800000000000e-06,0.100000000000000,104,0.00795800000000000,0.100000000000000,40004,53.0520000000000,0.300000000000000,35000000,7958,0.0200000000000000;"Commissura_posterior",0.0200000000000000,4,36,7.95800000000000e-06,0.100000000000000,104,0.00795800000000000,0.100000000000000,40004,53.0520000000000,0.300000000000000,35000000,7958,0.0200000000000000;"Bronchi",0.300000000000000,2.50000000000000,40.5000000000000,7.95800000000000e-06,0.100000000000000,402.500000000000,0.0636620000000000,0.100000000000000,50002.5000000000,15.9150000000000,0.200000000000000,1000000,15915,0;"Bronchi_lumen",0,1,1,0,0,1,0,0,1,0,0,1,0,0;"Bladder",0.200000000000000,2.50000000000000,18.5000000000000,8.84200000000000e-06,0.100000000000000,402.500000000000,0.159150000000000,0.100000000000000,100002,159.155000000000,0.200000000000000,10000000,15915,0;"Diaphragm",0.200000000000000,4,54,7.23400000000000e-06,0.100000000000000,7004,0.353680000000000,0.100000000000000,1200000,318.310000000000,0.100000000000000,25000000,2274,0;"Esophagus",0.500000000000000,4,64,7.95800000000000e-06,0.100000000000000,2004,0.0795770000000000,0.100000000000000,100004,159.155000000000,0.200000000000000,40000000,15915,0;"Esophagus_lumen",0,1,1,0,0,1,0,0,1,0,0,1,0,0;"Heart_lumen",0.700000000000000,4,60,8.37700000000000e-06,0.100000000000000,5204,0.132630000000000,0.100000000000000,4,159.155000000000,0.200000000000000,4,15915,0;"Heart_muscle",0.0500000000000000,4,54,7.95800000000000e-06,0.100000000000000,1204,0.159150000000000,0.0500000000000000,450004,72.3430000000000,0.220000000000000,25000000,4547,0;"Kidney_cortex",0.0500000000000000,4,51,7.95800000000000e-06,0.100000000000000,3504,0.198940000000000,0.220000000000000,250004,79.5770000000000,0.220000000000000,30000000,4547,0;"Adrenal_gland",0.500000000000000,4,59,7.95800000000000e-06,0.100000000000000,2504,0.159150000000000,0.100000000000000,100004,159.155000000000,0.200000000000000,40000000,15915,0;"Gallbladder",0.900000000000000,4,59,7.57900000000000e-06,0.0500000000000000,44,0.00159200000000000,0,1004,159.155000000000,0.200000000000000,10004,15915,0;"Kidney_medulla",0.0500000000000000,4,51,7.95800000000000e-06,0.100000000000000,3504,0.198940000000000,0.220000000000000,250004,79.5770000000000,0.220000000000000,30000000,4547,0;"Large_intestine",0.0100000000000000,4,54,7.95800000000000e-06,0.100000000000000,3004,0.159150000000000,0.200000000000000,100004,159.155000000000,0.200000000000000,40000000,1592,0;"Large_intestine_lumen",0.200000000000000,4,54,7.23400000000000e-06,0.100000000000000,7004,0.353680000000000,0.100000000000000,1200000,318.310000000000,0.100000000000000,25000000,2274,0;"Liver",0.0200000000000000,4,43,8.84200000000000e-06,0.100000000000000,6004,0.530520000000000,0.200000000000000,50004,22.7360000000000,0.200000000000000,30000000,15915,0.0500000000000000;"Lung",0.0300000000000000,2.50000000000000,20.5000000000000,7.95800000000000e-06,0.100000000000000,502.500000000000,0.0636620000000000,0.100000000000000,250002,159.155000000000,0.200000000000000,40000000,7958,0;"Ovary",0.300000000000000,4,44,8.84200000000000e-06,0.150000000000000,404,0.0159150000000000,0.250000000000000,100004,159.155000000000,0.270000000000000,40000000,15915,0;"Pancreas",0.500000000000000,4,59,7.95800000000000e-06,0.100000000000000,2504,0.159150000000000,0.100000000000000,100004,159.155000000000,0.200000000000000,40000000,15915,0;"Small_intestine",0.500000000000000,4,54,7.95800000000000e-07,0.100000000000000,10004,0.159160000000000,0.100000000000000,500004,159.156000000000,0.200000000000000,40000000,15915,0;"Small_intestine_lumen",0.200000000000000,4,54,7.23400000000000e-06,0.100000000000000,7004,0.353680000000000,0.100000000000000,1200000,318.310000000000,0.100000000000000,25000000,2274,0;"Spleen",0.0300000000000000,4,52,7.95800000000000e-06,0.100000000000000,2504,0.0636620000000000,0.150000000000000,200004,265.258000000000,0.250000000000000,50000000,6366,0;"Stomach",0.500000000000000,4,64,7.95800000000000e-06,0.100000000000000,2004,0.0795770000000000,0.100000000000000,100004,159.155000000000,0.200000000000000,40000000,15915,0;"Stomach_lumen",0.200000000000000,4,54,7.23400000000000e-06,0.100000000000000,7004,0.353680000000000,0.100000000000000,1200000,318.310000000000,0.100000000000000,25000000,2274,0;"Thymus",0.500000000000000,4,59,7.95800000000000e-06,0.100000000000000,2504,0.159150000000000,0.100000000000000,100004,159.155000000000,0.200000000000000,40000000,15915,0;"Thyroid_gland",0.500000000000000,4,59,7.95800000000000e-06,0.100000000000000,2504,0.159150000000000,0.100000000000000,100004,159.155000000000,0.200000000000000,40000000,15915,0;"Trachea",0.300000000000000,2.50000000000000,40.5000000000000,7.95800000000000e-06,0.100000000000000,402.500000000000,0.0636620000000000,0.100000000000000,50002.5000000000,15.9150000000000,0.200000000000000,1000000,15915,0;"Trachea_lumen",0,1,1,0,0,1,0,0,1,0,0,1,0,0;"Ureter_Urethra",0.250000000000000,4,44,8.84200000000000e-06,0.100000000000000,54,0.00318300000000000,0.100000000000000,100004,159.155000000000,0.200000000000000,10000000,1592,0;"Uterus",0.200000000000000,4,59,7.95800000000000e-06,0.100000000000000,804,0.0318310000000000,0.100000000000000,300004,159.155000000000,0.200000000000000,35000000,1061,0;"Vagina",0.0100000000000000,4,54,7.95800000000000e-06,0.100000000000000,3004,0.159150000000000,0.200000000000000,100004,159.155000000000,0.200000000000000,40000000,1592,0;"Meniscus",0.150000000000000,4,42,1.32630000000000e-05,0.150000000000000,2504,0.144690000000000,0.150000000000000,100004,318.310000000000,0.100000000000000,40000000,15915,0;"Patella",0.0200000000000000,2.50000000000000,12.5000000000000,1.32630000000000e-05,0.200000000000000,182.500000000000,0.0795770000000000,0.200000000000000,5002.50000000000,159.155000000000,0.200000000000000,100002,15915,0};

    for kn = 1:size(ht,1)
        if name == (kn+10)
            sgm = ht{kn,2};
            eps_inf = ht{kn,3};
            eps_s1 = ht{kn,4};
            tao1 = ht{kn,5}*1e-6;
            alf1 = ht{kn,6};
            eps_s2 = ht{kn,7};
            tao2 = ht{kn,8}*1e-6;
            alf2 = ht{kn,9};
            eps_s3 = ht{kn,10};
            tao3 = ht{kn,11}*1e-6;
            alf3 = ht{kn,12};
            eps_s4 = ht{kn,13};
            tao4 = ht{kn,14};
            alf4 = ht{kn,15};
            w = 2*pi*f;
            p = eps_inf+sgm./(1i*w*8.854187817e-12)+(eps_s1-eps_inf)./(1+(1i*w*tao1).^(1-alf1))+(eps_s2-eps_inf)./(1+(1i*w*tao2).^(1-alf2))+(eps_s3-eps_inf)./(1+(1i*w*tao3).^(1-alf3))+(eps_s4-eps_inf)./(1+(1i*w*tao4).^(1-alf4));
            % p_50 = ones(50,181).*p;
            % idp = 20;
            % idp = idp/100; % 加上20%的个体差异
            % sd = p_50*idp;
            % dp_indi = p_50+sd.*randn([50,181]);
            break;
        end
    end

    end
q = real(p);
% q = real(dp_indi);

end











