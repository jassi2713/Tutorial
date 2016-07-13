clc;
clear all;
close all;

d = 1:1:10;
Hte = input('Enter the height of the transmitter height:  ');
%Hte = 30:1:100;
fc = input('Enter the frequency:  ');
%d = input('Enter the distance from Base station:  ');
hr = input('Enter the height of the receiver antenna:  ');

ahr = ((1.1*log(fc) - 0.7)*hr - (1.56*log(fc) - 0.8));

%Hata Model
PL  = ((69.55) + (26.16*log(fc)) - (13.82*log(Hte)) - ahr + ((44.9- 6.55*log(Hte))*log(d)));

%Cost 231 Model
PLc = 46.3 + (33.9*log(fc)) - (13.82*log(Hte)) - ahr + ((44.9- 6.55*log(Hte))*log(d));

%okumura
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


plot(d,PL,':','LineWidth',1.5);
hold on;
plot (d,PLc,'-','LineWidth',1.5);
hold on;
plot(d,L50,'LineWidth',1.5);
hold on;
plot(d,PLe);
legend ('Hata Model','COST231 Model','Okumura Model','Egli Model')
title ('Path Loss Propagation Model');
xlabel('Distance in Km');
ylabel('Propagation Loss in dB');