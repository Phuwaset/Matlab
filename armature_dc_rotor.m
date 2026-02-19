%% 1. กำหนดค่าคงที่ของระบบ (Physical Parameters)
J = 0.01;   % Moment of inertia of the rotor
b = 0.1;    % Motor viscous friction constant
K = 0.01;   % Electromotive force constant
R = 1;      % Electric resistance
L = 0.5;    % Electric inductance

%% 2. สร้าง State-Space Model
A = [-b/J K/J; -K/L -R/L];
B = [0; 1/L];
C = [1 0];
D = 0;

%% 3. แปลงจาก State-Space เป็น Transfer Function
[num, den] = ss2tf(A, B, C, D);

% --- เพิ่มส่วนโชว์ Plant TF ---
fprintf('\n--- Plant Transfer Function (G) ---\n');
Plant = tf(num, den) 

num_const = num(3); % เลือกค่าคงที่ที่เป็นเศษของระบบมาใช้ต่อ

%% 4. กำหนดค่าพารามิเตอร์ PID
Kp = 100;
Ki = 200;
Kd = 10;
numc = [Kd Kp Ki]; 
denc = [1 0];

%% 5. รวม Controller เข้ากับ Plant (Open-loop)
numa = conv(num_const, numc);
dena = conv(den, denc);

%% 6. สร้างระบบแบบ Closed-loop (Unity Feedback)
[numac, denac] = cloop(numa, dena);

% --- เพิ่มส่วนโชว์ Closed-loop TF ---
fprintf('\n--- Closed-loop Transfer Function (T) ---\n');
T_system = tf(numac, denac)

% พล็อตกราฟ
step(numac, denac);
grid on;
title('Closed-loop Step Response with PID');
