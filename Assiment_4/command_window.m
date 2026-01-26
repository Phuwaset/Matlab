function first(A, tau)
    % สร้างระบบ First-order G(s) = A / (tau*s + 1)
    num = [A];
    den = [tau 1];
    sys = tf(num, den);
    
    % หาค่าคุณลักษณะของระบบ 
    info = stepinfo(sys);
    pole_pos = -1/tau;
    
    % แสดงผลลัพธ์ใน Command Window สำหรับกรอกตาราง
    fprintf('--- ค่าสำหรับ A=%.1f, Tau=%.1f ---\n', A, tau);
    fprintf('Rise Time: %.4f s\n', info.RiseTime);
    fprintf('Settling Time: %.4f s\n', info.SettlingTime);
    fprintf('Final Value: %.1f\n', A);
    fprintf('Pole Position: %.1f\n\n', pole_pos);
    
    % พล็อตกราฟ Step Response 
    step(sys);
    hold on; % เพื่อให้พล็อตกราฟต่อไปทับในรูปเดียวกันได้
end


<!-- Command Window Script for Plotting Responses สร้างกราฟสำหรับตารางที่ 3.1 -->% 
figure; grid on; hold on;
% ตาราง 3.1: tau = 1, เปลี่ยนค่า A ตามโจทย์
A_vals = [0.5, 1, 2, 5, 10]; 
for a = A_vals
    first(a, 1); % เรียกใช้ฟังก์ชัน first.m ที่คุณสร้างไว้
end
legend('A=0.5','A=1','A=2','A=5','A=10');
title('ตารางที่ 3.1: การเปลี่ยนอัตราการขยาย A (\tau = 1)');
xlabel('Time (seconds)');
ylabel('Amplitude');

<!-- Command Window Script for Plotting Responses สร้างกราฟสำหรับตารางที่ 3.2 -->%
figure; grid on; hold on;
% ตาราง 3.2: กำหนดให้ A = 1 (หรือตามที่คุณกรอก) และเปลี่ยนค่า tau
tau_vals = [0.5, 1, 2, 5, 10]; 
for t = tau_vals
    first(1, t); % ใช้ A = 1 และเปลี่ยนค่า tau ตามตาราง
end
legend('tau=0.5','tau=1','tau=2','tau=5','tau=10');
title('ตารางที่ 3.2: การเปลี่ยนค่าคงตัวทางเวลา \tau (A = 1)');
xlabel('Time (seconds)');
ylabel('Amplitude');

<!-- Command Window Script for Plotting Responses สร้างกราฟสำหรับตารางที่ 3.3 -->%
figure; grid on; hold on;
% ตาราง 3.3: tau = 1, เปลี่ยนค่า A ตามโจทย์หน้า 2
A_list = [0.1, 0.5, 1, 3, 5, 10]; 
for a = A_list
    first(a, 1); 
end
legend('A=0.1','A=0.5','A=1','A=3','A=5','A=10');
title('ตารางที่ 3.3: ผลของอัตราการขยาย A ต่อพารามิเตอร์ทางเวลา (\tau = 1)');

<!-- Command Window Script for Plotting Responses สร้างกราฟสำหรับตารางที่ 3.4 -->%
figure; grid on; hold on;
% รันตามคู่ลำดับ [A, tau] จากตารางที่ 3.4
first(0.1, 0.1); % แถวที่ 1
first(0.5, 0.5); % แถวที่ 2
first(1, 1);     % แถวที่ 3
first(3, 3);     % แถวที่ 4
first(5, 5);     % แถวที่ 5
first(10, 10);   % แถวที่ 6
legend('A=0.1, tau=0.1','A=0.5, tau=0.5','A=1, tau=1','A=3, tau=3','A=5, tau=5','A=10, tau=10');
title('การทดลองที่ 3.4: ผลของการเปลี่ยนทั้ง A และ \tau');

<!-- Command Window Script for Plotting Responses สร้างกราฟสำหรับตารางที่ 3.5 -->%
figure; grid on; hold on;
% รันตามค่าในตาราง 3.5 [Time constant(tau), อัตราขยาย(A)]
first(1, 0.5);  % แถวที่ 1: tau=0.5, A=1
first(2, 1);    % แถวที่ 2: tau=1, A=2
first(4, 2);    % แถวที่ 3: tau=2, A=4
first(8, 5);    % แถวที่ 4: tau=5, A=8
first(10, 10);  % แถวที่ 5: tau=10, A=10
first(20, 20);  % แถวที่ 6: tau=20, A=12 (หมายเหตุ: ในใบงานบรรทัดสุดท้ายเขียน tau=20, A=12)
legend('tau=0.5, A=1','tau=1, A=2','tau=2, A=4','tau=5, A=8','tau=10, A=10','tau=20, A=12');
title('ใบงานที่ 4: ตารางที่ 3.5 (ศึกษาการเปลี่ยนค่า tau และ A)');