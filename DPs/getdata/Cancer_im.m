function q=Cancer_im(name,T,proportion,f)   %----注意对比公式中的加减号，有些文献中水中分母为减号，有些文献中为正�?
% Reference Liquids name---water，Propan_1_ol，Ethanol，Methanol，Butan_1_ol,Ethanediol，Dimethyl sulphoxide,Propan_2_ol，Cyclohexane，Acetone


Liquid=name;
%temperature of reference Liquids (°C);
t=T;
X_v=proportion;   %Reference Liquids
% resonance frequence

% deionized water permittivity--2007
%1 is BCC 
if Liquid==1
	sgm = 0.05;
	eps_inf = 6;
	delta_eps = 43.04;
	tao_P = 7.66*1e-12;
    alf = 0.08;
	w = 2*pi*f;
	e = eps_inf+sgm./(1i*w*8.854187817*1e-12)+delta_eps./(1+(1i*w*tao_P).^(1-alf));
    p=e;
elseif Liquid==2   %2 is SCC
	sgm = 0.01;
	eps_inf = 10;
	delta_eps = 32.99;
	tao_P = 3.04*1e-12;
    alf = 0.11;
	w = 2*pi*f;
	e = eps_inf+sgm./(1i*w*8.854187817*1e-12)+delta_eps./(1+(1i*w*tao_P).^(1-alf));
    p=e;
elseif Liquid==3   %3 is MM
    b=0.638;a=0.491;
    water1 = RefEPfunc_re(1,37,100,f)+1i*RefEPfunc_im(1,37,100,f);
    skin_health1 = RefEPfunc_re(36,37,100,f)+1i*RefEPfunc_im(36,37,100,f);
	e = ((water1.^((b-a)/(1-a))).*(skin_health1).^((1-b)/(1-a)));
    p=e;
elseif Liquid==4   %4 is liver cancer
    sgm = 0.21;
	eps_inf = 4.60;
	delta_eps = 54.26;
	tao_P = 10.82*1e-12;
    alf = 0.1;
	w = 2*pi*f;
	e = eps_inf+sgm./(1i*w*8.854187817*1e-12)+delta_eps./(1+(1i*w*tao_P).^(1-alf));
    % e_50 = ones(50,181).*e;
    % idp = 20;
    % idp = idp/100; % ����20%�ĸ������
    % sd = e_50*idp;
    % dp_indi = e_50+sd.*randn([50,181]);
    % p=dp_indi;
    p = e;
elseif Liquid==5   %5 is �Խ�����
    conduct = 0.49488;
	eps_inf = 25.2631;
	amp_cc = 30.4806;
	tau_cc = 1.33239*1e-11;
    alpha_cc = 0.03526;
    amp_hn = 513.845;
    tau_hn = 1.25762*1e-8;
    alpha_hn = 0.881804;
	w = 2*pi*f;
	complex_epsilon=-1i*(conduct./(eps_0.*w))+eps_inf+amp_cc./(1+(1i*w*tau_cc).^(1-alpha_cc))+amp_hn./(1+(1i*w*tau_hn).^alpha_hn);
    p=complex_epsilon;
end



q = imag(p);
end