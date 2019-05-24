%function [portata]=calval(k1,k2,AA,Hnew,Qnew,Hold,Qold,D,cel,n,Dt,nodi,zeta,alfa,enne,tiponodo,Ninte,gni,itipoformula,moltiplicativo,caricovecchio,itipoperdita,L,stringa,Qcarp,Hcarp,qcarp,Jcarp,Qcarm,Hcarm,qcarm,Jcarm,lambdam,lambdap,kappa,orifizio,tempo,hmin,hdes,volcassa,Cv)
%MODIFICATA PER SIMULINK!!!!
function [portata]=calvalCondottaSingola(Qapv,Hapv,qv,Jpiu,Dv,celv,nv,Qapm,Hapm,qm,Jmeno,Dm,celm,nm,Cv,Dt)


A=zeros(0,0);
B=zeros(0,0);

kappa=0;
Qact=Qapv;
Hact=Hapv;
Dact=Dv;

qct=qv;

celact=celv;
nact=nv;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
lambdaact=+9.81./celact;
csugam=(1+9.81.*kappa)./(3.14.*Dact.*Dact./4)./lambdaact;
tnotom=Hact+csugam(1).*Qact-9.81.*Dt.*Jpiu./lambdaact+celact.^2.*Dt.*qct./9.81./(3.14.*Dact.*Dact./4);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

matriceA1=[ones(1,1),zeros(1,1),diag(csugam),zeros(1,1)];
matriceB1=tnotom;
A=[A;matriceA1];
B=[B;matriceB1];


Qact=Qapm;
Hact=Hapm;
Dact=Dm;
qct=qm;

celact=celm;
nact=nm;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
lambdaact=-9.81./celact;
csugav=(1+9.81.*kappa)./(3.14.*Dact.*Dact./4)./lambdaact;
tnotomv=Hact+csugav(1).*Qact-9.81.*Dt.*Jmeno./lambdaact+celact.^2.*Dt.*qct./9.81./(3.14.*Dact.*Dact./4);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

matriceA2=[zeros(1,1),ones(1,1), zeros(1,1), diag(csugav)];
matriceB2=tnotomv;
A=[A;matriceA2];
B=[B;matriceB2];
matriceA3=[0,0,ones(1,1),-ones(1,1)];
matriceB3=0;
A=[A;matriceA3];
B=[B;matriceB3];


deltaH=1;
errore=1000;
X=0;
while errore>1e-6
    Ab=A;
    Bb=B;
    coef=Cv./sqrt(abs(deltaH));
    Ab=[Ab;[-coef,coef,1,0]];
    Bb=[Bb;0]; 
    X=Ab\Bb;
    deltaHold=deltaH;
    deltaH=X(1)-X(2);
    errore=abs(deltaH-deltaHold);
    
end

portata=X(3);








