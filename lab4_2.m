close all; clear all;

xAP = 100; yAP = 100;
powerAP = 0.010; % [W]
freqAP = 3*10^9; % [Hz]
PT = powerAP / 4;

noise = -125; % [dBW]

% anteny sa oddalone o lambda/2
xAnt1 = 99.975;  yAnt1 = 100;
xAnt2 = 100.025; yAnt2 = 100;

xUser1 = 80;  yUser1 = 180;
xUser2 = 160; yUser2 = 120;

c = 3*10^8;
lambda = c / freqAP;

%
User1d1 = sqrt((xUser1-xAnt1)^2 + (yUser1-yAnt1)^2);
User1d2 = sqrt((xUser1-xAnt2)^2 + (yUser1-yAnt2)^2);
User1diff = abs(User1d1 - User1d2);
User2d1 = sqrt((xUser2-xAnt1)^2 + (yUser2-yAnt1)^2);
User2d2 = sqrt((xUser2-xAnt2)^2 + (yUser2-yAnt2)^2);
User2diff = abs(User2d1 - User2d2);

User1H1 = (lambda/(4*pi*User1d1)) * exp(-1i*(2*pi*User1d1)/lambda -1i*2*pi*(User2d2-User2d1)/lambda -1i*pi);
User1H2 = (lambda/(4*pi*User1d2)) * exp(-1i*(2*pi*User1d2)/lambda);

User2H1 = (lambda/(4*pi*User2d1)) * exp(-1i*(2*pi*User2d1)/lambda -1i*2*pi*(User1d2-User1d1)/lambda -1i*pi);
User2H2 = (lambda/(4*pi*User2d2)) * exp(-1i*(2*pi*User2d2)/lambda);

User1H = User1H1 + User1H2;
User1PR = 10*log10(PT) + 20*log10(abs(User1H));

User1SNR = User1PR - noise,

User2H = User2H1 + User2H2;
User2PR = 10*log10(PT) + 20*log10(abs(User2H));

User2SNR = User2PR - noise,
