Wxh = -0.1;
Whh = 0.5;
Why = 0.25;
Bh  = 0.4;
By  = 0.0;

x = [18, 9, -8];

t = [0.1, -0.1, -0.2];

f_logistic = @(s) (1 / (1 + e^(-s)));

f_dZh_dSh = @(s) (f_logistic(s) * (1 - f_logistic(s)));

f_dE_dy = @(t,y) (t - y);

# Forward Step

Zh0 = Wxh * x(1) + Whh * 0 + Bh;
Hh0 = f_logistic(Zh0);

Y0  = Why * Hh0 + By;

Zh1 = Wxh * x(2) + Whh * Hh0 + Bh;
Hh1 = f_logistic(Zh1);

Y1  = Why * Hh1 + By;

Zh2 = Wxh * x(3) + Whh * Hh1 + Bh;
Hh2 = f_logistic(Zh2);

Y2  = Why * Hh2 + By;


Hh0 = 0.2;
Hh1 = 0.4;
Hh2 = 0.8;

Y0 = 0.05;
Y1 = 0.1;
Y2 = 0.2;

y = [Y0 Y1 Y2];

# Backward Step

dE0_dy0 = f_dE_dy(t(1),y(1));
dE1_dy1 = f_dE_dy(t(2),y(2));
dE2_dy2 = f_dE_dy(t(3),y(3));

dHh0_dZh0 = Hh0*(1-Hh0);
dHh1_dZh1 = Hh1*(1-Hh1);
dHh2_dZh2 = Hh2*(1-Hh2);

dy0_dHh0 = Why;
dy1_dHh1 = Why;
dy2_dHh2 = Why;

dZh2_dHh1 = Whh;
dZh1_dHh0 = Whh;

dE1_dZh1 = dE1_dy1 * dy1_dHh1 * dHh1_dZh1;
dE2_dZh1 = dE2_dy2 * dy2_dHh2 * dHh2_dZh2 * dZh2_dHh1 * dHh1_dZh1;

dE_dZh1 = dE1_dZh1 + dE2_dZh1;

dE2_dZh2 = dE2_dy2 * dy2_dHh2 * dHh2_dZh2;