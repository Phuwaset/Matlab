num = [1];
den = [1 3 2];
sys = tf(num, den);

C = pidtune(sys, 'PID');
Kp = C.Kp;
Ki = C.Ki;
Kd = C.Kd;

fprintf('Kp = %.4f\n', Kp)
fprintf('Ki = %.4f\n', Ki)
fprintf('Kd = %.4f\n', Kd)

sys_closed = feedback(C*sys, 1);
step(sys_closed)