
num = [100];
den = [1 10 31 30];

req_overshoot    = 20;   
req_settling     = 6;    
req_ss_error     = 1;    


sys = tf(num, den);


[Gm, Pm, Wgm, Wpm] = margin(sys);
Kc = Gm;
Pc = 2 * pi / Wgm;

fprintf('=== Ziegler-Nichols Parameters ===\n')
fprintf('Kc = %.4f\n', Kc)
fprintf('Pc = %.4f\n', Pc)

Kp = 0.6 * Kc;
Ki = 0.6 * Kc / (0.5 * Pc);
Kd = 0.6 * Kc * 0.125 * Pc;

fprintf('\n=== PID Gains (Z-N Initial) ===\n')
fprintf('Kp = %.4f\n', Kp)
fprintf('Ki = %.4f\n', Ki)
fprintf('Kd = %.4f\n', Kd)

numc      = [Kd, Kp, Ki];
denc      = [1, 0];
sys_open   = tf(conv(num, numc), conv(den, denc));
sys_closed = feedback(sys_open, 1);

info = stepinfo(sys_closed);

dcgain_val = dcgain(sys_closed);
ss_error   = abs(1 - dcgain_val) * 100;

result_overshoot = info.Overshoot;
result_settling  = info.SettlingTime;
result_ss_error  = ss_error;

fprintf('\n=== Step Response Results ===\n')
fprintf('Overshoot     = %.2f %%\n', result_overshoot)
fprintf('Settling time = %.2f s\n',  result_settling)
fprintf('Steady-state error = %.4f %%\n', result_ss_error)

fprintf('\n=== Requirements Check ===\n')

if result_overshoot <= req_overshoot
    fprintf('Overshoot     : PASS (%.2f%% <= %.2f%%)\n', result_overshoot, req_overshoot)
else
    fprintf('Overshoot     : FAIL (%.2f%% > %.2f%%) → เพิ่ม Kd\n', result_overshoot, req_overshoot)
end

if result_settling <= req_settling
    fprintf('Settling time : PASS (%.2f s <= %.2f s)\n', result_settling, req_settling)
else
    fprintf('Settling time : FAIL (%.2f s > %.2f s) → เพิ่ม Kp\n', result_settling, req_settling)
end

if result_ss_error <= req_ss_error
    fprintf('SS error      : PASS (%.4f%% <= %.2f%%)\n', result_ss_error, req_ss_error)
else
    fprintf('SS error      : FAIL (%.4f%% > %.2f%%) → เพิ่ม Ki\n', result_ss_error, req_ss_error)
end
