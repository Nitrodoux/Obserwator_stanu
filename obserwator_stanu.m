% zestaw b
%% Zapisanie uk³adu w przestrzeni stanu
A=[2 -4 -1;
   4 -2 -1;
   -4 0 -1];
B=[0;0;-2];
C=[1 0 0];
D=[0]
sys=ss(A,B,C,D);
figure(1)
step(sys)
xlabel('Czas [s]');ylabel('Amplituda');
title('OdpowiedŸ uk³adu otwartego na wymuszenie skokowe')
figure(2)
pzmap(sys)
xlabel('Oœ rzeczywista');ylabel('Oœ urojona');
title('Mapa zer i biegunów uk³adu otwartego')

%% sterowalnoœc i obserwowalnoœæ uk³adu 
rank(A)
S=ctrb(sys)
ster=rank(S)
O=obsv(A,C)
obser=rank(O)
%% regulator od stanu//przesuwanie biegunów
p=[-0.5+2.5i -0.5-2.5i -2 ]

K=acker(A,B,p);
Ac=A-(B*K);
%Cc=C-D*K
%G_cl=ss(Ac,B,C,D);
h1=[A B; C D];
h2=[0;0;0;1] % pod wymiar h1
h1_1=inv(h1)
Npom=h1_1*h2 %%3.27 instrukcja
Nx=Npom(1:3,1);%rozmiar wekotra stanu uk³adu
Nu=Npom(4,1);%rozmiar wekotra wejœæ
N=K*Nx+Nu;%zgodnie z 3.29 instrukcja
sys_c=ss(Ac,B*N,C,D);
figure(3)
pzmap(sys_c)
%% wyznaczenie macierzy wzmocnieñ regulatora stanu K oraz Ki
Apom=A;
Apom(:,4)=0;
Cpom=-C;
Cpom(1,4)=0;
A1=[Apom;Cpom]; %% 3.37 instrukcja
B1=[B;-D];
p1=[-2+2.5i -2-2.5i -8 -10 ];
K1=acker(A1,B1,p1)
Ki=K1(1,4)
KK=K1(1,1:3)
 %% Obserwator pe³nego rzêdu
 %p skopowianie
 %2-6 razy
 p_obsv=[-2+2.5i -2-2.5i -8 ]
 L=acker(A',C',p_obsv)%macierz wspó³czynników wzmocnieñ
 H=L'%wyznaczenie H-trans mac L
 Aobsv=A-H*C%wyzn mac st obser
 Bobsv=[B,H]%wyznaczenie wejœæ macierzy obserwatora
 Cobsv=C
 Dobsv=D
 obserw=ss(Aobsv,Bobsv,Cobsv,Dobsv)
 figure(4)
 step(obserw,'r')
 figure(5)
 pzmap(obserw,'r')
 title('Mapa zer i biegunów uk³adu z obserwatorem pe³nego rzêdu')
 xlabel('Oœ rzeczywista');ylabel('Oœ urojona');
 %% obserwator zredukowany
 % w i) 1w z 5w i 5k z 1k w A i 1k z 5k w C
 %4.47 instr
Ca=C(1,1);
Cb=C(1,2:3);

Aa=Ac(1,1);
Aab=Ac(1,2:3);
Aba=Ac(2:3,1);
Ab=Ac(2:3,2:3);

Ba=B(1,1);
Bb=B(2:3,1);

p_red=[-2+2.5i -2-2.5i];

L_new=acker(Ab',Aab',p_red);
Hb=L_new';
Aor=Ab-Hb*Aab;
Bor=[Bb Hb];
Cor=eye(2);
Obsl=ss(Aor,Bor,Cor,D);
Ka=K(1,1);
Kb=K(1,2:3);
figure(6)
pzmap(Obsl);
title('Mapa zer i biegunów uk³adu z obserwatorem zredukowanego rzêdu')
xlabel('Oœ rzeczywista');ylabel('Oœ urojona');
%%wykresy z Simulinka
figure(7)
plot(st.Time,st.Data,yp.Time,yp.Data);
title('OdpowiedŸ na wymuszenie skokowe uk³adu z o. p. rz.');
xlabel('Czas [s]');ylabel('Amplituda');grid;
legend('Wymuszenie','OdpowiedŸ uk³adu regulacji');
figure(8)
plot(st1.Time,st1.Data,yzr.Time,yzr.Data);
title('OdpowiedŸ na wymuszenie skokowe uk³adu z o. zr. rz.');
xlabel('Czas [s]');ylabel('Amplituda');grid;
legend('Wymuszenie','OdpowiedŸ uk³adu regulacji');
figure(9)
plot(ep.Time,ep.Data);grid;
title('B³¹d estymacji uk³adu z o. p. rz.');
xlabel('Czas [s]');ylabel('Amplituda');
figure(10)
plot(ezr.Time,ezr.Data);grid;
title('B³¹d estymacji uk³adu z o. zr. rz.');
xlabel('Czas [s]');ylabel('Amplituda');
legend('x1','x2');
figure(11)
plot(z1.Time,z1.Data);
xlabel('Czas [s]');ylabel('Amplituda');grid;
title('Losowy sygna³ zak³ócenia')
figure(12)
plot(zsb.Time,zsb.Data);
xlabel('Czas [s]');ylabel('Amplituda');grid;
title('Sygna³ zak³ócenia')
save
