clc
clear variables
for a_iniziale = 0.69
    for sezval = 50
        
        %a_iniziale=0.69; %originale 0.67
        a=a_iniziale;
        demand = 0.10;
        
        
        tStep = 50;  
        DeltaA = -0.1*a;

        %%
        scabrezza = 0.01;                % CARATTERISTICHE TOPOLOGICHE: scabrezza conduttura %
        Ddato = 0.45;                    % CARATTERISTICHE TOPOLOGICHE: diametro conduttura %
        c = 407.9;                       % CARATTERISTICHE TOPOLOGICHE: celerità delle onde %
        %sezval = 300;  %50 originalmente % CARATTERISTICHE TOPOLOGICHE: sezione nella quale viene posta la valvola %
        sezpiezo = 1000;
        Velreg = 1;                   % CARATTERISTICHE TOPOLOGICHE: Velocità massima di spostamento della valvola
        N = 2000;     
        deltaX = 5;         %CARATTERISTICHE TOPOLOGICHE: deltaX scelto per la discretizzazione del problema % 

        deltaT = deltaX/c;               % DATI DEL PROBLEMA : deltaT di integrazione, ricavato conoscendo c e dopo aver impostato deltaX %
        Nistanti = 80000;                % DATI DEL PROBLEMA : numero di instanti di tempo, ciscuno pari a deltaT, per i quali viene svolto l'esperimento % 
        Tfin=Nistanti.*deltaT;           % DATI DEL PROBLEMA : durata totale dell'esperimento %
        Tfin=350;
        dTpattern = 1;                   % DATI DEL PROBLEMA : intervalli di tempo per i quali viene valutata la portata richiesta ed il carico del serbatoio %
        g = 9.81;                        % DATI DEL PROBLEMA : modulo dell'accelerazione di gravità %
        %%
        load serbatoioCostante.txt
        serbatoio=serbatoioCostante; %H
        load portataAggregata.txt
        %portata=mean(portataAggregata)*ones(size(portataAggregata));                                                    % funzione che carica nel workspace il vettore colonna della portata richiesta durante un'intera giornata %
        portata=demand*ones(size(portataAggregata));                                                    % funzione che carica nel workspace il vettore colonna della portata richiesta durante un'intera giornata %
        
        %%
        Ndati=size(portata,1);

        %tpattern=cumsum(zeros(Ndati,1)+dTpattern)-dTpattern;
        tpattern=(0:(Ndati-1)*dTpattern)';
        deltaTcamp = 1;
        Tcamp=[0:deltaTcamp:Tfin]';

        Q=zeros(N+1,1)+portata(1,1);
        D=zeros(N+1,1)+Ddato;
        A=zeros(N+1,1)+((D./2).^2).*pi;
        n=zeros(N+1,1)+scabrezza;
                                                                            % gradi di apertura iniziale della valvola %
        E=10^(1.5-2.8*log10(1-a));

        nsez=1;
        n(sezval,1)=sqrt(0.008034.*E.*(D(sezval,1).^1.3333)./nsez./deltaX);


        J=10.29.*(n.^2).*(Q.*abs(Q))./(D.^(5.33));
        H=zeros(N+1,1);
        H(1,1) = serbatoio(1,1);
        Jmedia=J(1:(end-1));
        caricoperso=Jmedia.*deltaX;
        caricoperso=cumsum(caricoperso);
        Hagg=serbatoio(1)-caricoperso;
        H(2:end,1)=Hagg;

        T=0;
        kcont=0;
        spostrich=0;
        veta=[];
        vetT=[];
        vetH=[];
        hfullsat=25; 
        n(sezval)=n(sezval-1);
        n(sezval+1)=n(sezval-1);
        %%

        while T<Tfin
            Told=T;
            T=T+deltaT;

            Qtp=Q;
            Htp=H;
            %%
            %fase di predizione***************************************************

            Jold=10.29.*(n.^2).*(Qtp.*abs(Qtp))./(D.^(5.33)); %pipe friction slope

            % risoluzione della valvola
            E=10^(1.5-2.8*log10(1-a));

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% new
            Cv=sqrt(2.*9.81).*A(sezval)./sqrt(E);
            Qapv=Qtp(sezval-1);
            Hapv=Htp(sezval-1);
            qv=0;
            Jpiu=Jold(sezval-1);

            Dv=D(sezval-1);
            celv=c;
            nv=n(sezval-1);

            Qapm=Qtp(sezval+2);
            Hapm=Htp(sezval+2);
            qm=0;
            Jmeno=Jold(sezval+2);
            Dm=D(sezval+2);
            celm=c;
            nm=n(sezval+2);    

            [portatavalvola]=calvalCondottaSingola(Qapv,Hapv,qv,Jpiu,Dv,celv,nv,Qapm,Hapm,qm,Jmeno,Dm,celm,nm,Cv,deltaT);

            % pezzo a monte della valvola
            Hmonte=interp1(tpattern,serbatoio,Told);
            Hmonte0=Hmonte;
            Qvalle=portatavalvola;

            Htpmeno1=Htp(1:(sezval-2),1);
            Htppiu1=Htp(3:(sezval),1);
            Qtpmeno1=Qtp(1:(sezval-2),1);
            Qtppiu1=Qtp(3:(sezval),1);

            Jmedia=0.5.*(Jold(3:sezval)+Jold(1:(sezval-2)));
            Jdiff=0.5.*(Jold(3:sezval)-Jold(1:(sezval-2)));
            Amedia=0.5.*(A(3:sezval)+A(1:(sezval-2)));

            Qpre=0.5.*g./c.*Amedia.*(Htpmeno1-Htppiu1)+0.5.*(Qtpmeno1+Qtppiu1)-g.*Amedia.*deltaT.*Jmedia;
            Hpre=0.5./g.*c./Amedia.*(Qtpmeno1-Qtppiu1)+0.5.*(Htpmeno1+Htppiu1)+c.*deltaT.*Jdiff;

            Amediamonte=0.5.*(A(1)+A(2));
            Qmonte=g*Amediamonte/c*(Hmonte-Htp(2))+Qtp(2)-g*Amediamonte*(Jold(2))*deltaT;

            Amediavalle=0.5.*(A(sezval)+A(sezval-1));
            Hvalle=Htp(sezval-1)+c/g/Amediavalle*(Qtp(sezval-1)-Qvalle)-c*(Jold(sezval-1))*deltaT;

            Hprimopezzo=[Hmonte;Hpre;Hvalle];
            Qprimopezzo=[Qmonte;Qpre;Qvalle];

            % pezzo a valle della valvola
            Qmonte=portatavalvola;    
            Dvalle=interp1(tpattern,portata,Told);
            Dvalle0=Dvalle;
            Qvalle=Dvalle;

            Htpmeno1=Htp(sezval+1:(end-2),1);
            Htppiu1=Htp(sezval+3:(end),1);
            Qtpmeno1=Qtp(sezval+1:(end-2),1);
            Qtppiu1=Qtp(sezval+3:(end),1);

            Jmedia=0.5.*(Jold(sezval+3:end)+Jold(sezval+1:(end-2)));
            Jdiff=0.5.*(Jold(sezval+3:end)-Jold(sezval+1:(end-2)));
            Amedia=0.5.*(A(sezval+3:end)+A(sezval+1:(end-2)));

            Qpre=0.5.*g./c.*Amedia.*(Htpmeno1-Htppiu1)+0.5.*(Qtpmeno1+Qtppiu1)-g.*Amedia.*deltaT.*Jmedia;
            Hpre=0.5./g.*c./Amedia.*(Qtpmeno1-Qtppiu1)+0.5.*(Htpmeno1+Htppiu1)+c.*deltaT.*Jdiff;

            Amediamonte=0.5.*(A(sezval+1)+A(sezval+2));
            Hmonte=Htp(sezval+2)+c/g/Amediamonte*(Qmonte-Qtp(sezval+2))+c*(Jold(sezval+2))*deltaT;

            Amediavalle=0.5.*(A(end)+A(end-1));
            Hvalle=Htp(end-1)+c/g/Amediavalle*(Qtp(end-1)-Qvalle)-c*(Jold(end-1))*deltaT;

            Hpre=[Hprimopezzo;Hmonte;Hpre;Hvalle];
            Qpre=[Qprimopezzo;Qmonte;Qpre;Qvalle];

            H=Hpre;
            Q=Qpre;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     
        %%

            indice=find(Tcamp>=Told&Tcamp<T);
            if length(indice)>1
               errore
            end

            if length(indice)==1
                veta=[veta;a];
                vetT=[vetT;T];

                kcont=kcont+1;
                T
               dt1=Tcamp(indice)-Told;
               dt2=T-Tcamp(indice);
               X=[0;dt1+dt2];
               Y1=[Htp';H'];
               Y2=[Qtp';Q'];
               Hcampionato(:,indice)=(interp1(X,Y1,dt1))';
               Qcampionato(:,indice)=(interp1(X,Y2,dt1))'; 
               Apertura(indice,:) = a;
               vetH=[vetH;Hcampionato(1 + sezpiezo,indice)];
               trash = Hcampionato(1 + sezpiezo,indice);
                
               %salvare=[vetT,veta,vetH];
               %save salvare.txt salvare -ASCII

               if T>=tStep
                   %anew = 0.75;
                   anew = veta(1) + DeltaA;
                   spostrich=anew-a;
               end

            end
            %%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            spostmax=min(abs(spostrich),Velreg.*deltaT); %a ogni delta T il settaggio viene modificato
            spostmax=sign(spostrich).*spostmax; %sulla base della velocità dell'attuatore
            a=a+spostmax; %e sulla base di quanto suggerisce la PLC
            spostrich=spostrich-spostmax; %ecco la variazione che resta da fare alla fine del deltaT
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        end
        
        segno = '';
        if DeltaA<0
            segno = 'N';
        end
        
        
        %salvo nel formato WSsvXXaXXdXXspXXXX[N].mat
        filename = ['sv',num2str(sezval),'a',num2str(a_iniziale*100),'d',num2str(demand*100),'sp',num2str(sezpiezo),segno];
        save(['WS',filename,'.mat'])
    end
end
        %run salvarisultati.m;