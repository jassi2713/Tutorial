clc;
clear all;
close all;

%Variables required for Path Loss Model
%d = 1:1:10;
%d= [0.002 0.05 0.03 0.05 0.1 0.15 .2 .25 .3 .35 .4 .6];
d = [0.05 0.1 0.25 0.27	0.3	0.4	0.45 0.5 0.55 0.6 0.7 0.8 0.85 0.9 1 1.25 2];
%d = [0.002	0.005	0.03	0.05	0.1	0.15	0.2	0.25	0.3	0.35	0.4	0.6];


Hte = input('Enter the height of the transmitter height:  ');
%Hte = 30:1:100;
fc = input('Enter the frequency:  ');
%d = input('Enter the distance from Base station:  ');
hr = input('Enter the height of the receiver antenna:  ');
%E =  input('Enter the Field strength in dB uV/m:  ');
%Pt = input('Enter the Tx power in dBW in dB uV/m:  ');

%Hata Model
K=35.94;
ahr = ((1.1*log(fc) - 0.7)*hr - (1.56*log(fc) - 0.8));
PL  = ((69.55) + (26.16*log(fc)) - (13.82*log(Hte)) - ahr + ((44.9- 6.55*log(Hte))*log(d)));
PLo = PL- 4.79*(log(fc)^2)+18.33*log(fc)-K;
PLr = PL - 2*(log(fc/28))^2-5.4;
PLm = [115.74	112.97	113.67	118.93	112.64	113.36	114.84	113.74	119.74	116.37	120.45	121.07	124.43	124.2	125.29	123.44	126.8 ];

%Hata Propagation loss between isotropic antenna's
c = 3*10^8;
pi = 3.142;
Aeff = ((c^2/fc^2)/4*pi);

%LP = Pt - E  - (10*log(Aeff)) + 145.8;

%Cost 231 Model
PLc = 46.3 + (33.9*log(fc)) - (13.82*log(Hte)) - ahr + ((44.9- 6.55*log(Hte))*log(d));

%Okumura
c=3*10^8;
lamda=(c)/(fc*10^6);
Lf = 10*log((lamda^2)/((4*pi)^2)*d.^2); %   Free Space Propagation Loss
Amu = 35;       % Median Attenuation Relative to Free Space (900 MHz and 30 Km)
Garea = 9;      % Gain due to the Type of Environment (Suburban Area)
Ghte = 20*log(Hte/200); % Base Station Antenna Height Gain Factor
if(hr>3)
Ghre = 20*log(hr/3);
else
Ghre = 10*log(hr/3);
end
%   Propagation Path Loss
L50 = Lf+Amu-Ghte-Ghre-Garea;

%display('Propagation pathloss is : ');
%disp(L50);
%disp(PL);

%Egli Model
%Po = ((40*log(fc))- (20*log(Hte)*10*log(hr)));
%PLe = 20*log(fc)+Po+76.3

PLe = 117 + (40*log(d))+ (20*log(fc))-(20*log(Hte*hr)); 


plot(d,PL);
hold on;
plot(d,PLm);
%plot(d,PLo);
%plot (d,PLc);
hold on;
%plot(d,L50);
hold on;
%plot(d,PLe);
hold on;
%plot(d,LP);
%grid on;
%legend ('Hata Model','COST231 Model','Okumura Model','Egli Model');
legend ('Hata Model','Hata Rural');
title ('Path Loss Propagation Model');
xlabel('Distance in Km');
ylabel('Propagation Loss in dB');