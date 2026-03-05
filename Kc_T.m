num = [100];
den = [1 10 31 30];
sys = tf(num, den);

% หา Kc และ Pc
[Gm, Pm, Wgm, Wpm] = margin(sys);
Kc = Gm;
Pc = 2*pi/Wgm;

fprintf('Kc = %.4f\n', Kc)
fprintf('Pc = %.4f\n', Pc)

Kp = 0.6 * Kc;
Ki = 0.6 * Kc / (0.5 * Pc);
Kd = 0.6 * Kc * 0.125 * Pc;

fprintf('Kp = %.4f\n', Kp)
fprintf('Ki = %.4f\n', Ki)
fprintf('Kd = %.4f\n', Kd)

% Step Response
numc = [Kd, Kp, Ki];
denc = [1, 0];
sys_closed = feedback(tf(conv(num,numc), conv(den,denc)), 1);
%step(sys_closed)
info = stepinfo(sys_closed);
fprintf('Overshoot     = %.2f %%\n', info.Overshoot)
fprintf('Settling time = %.2f s\n',  info.SettlingTime)