clear all; close all;
clc;

L1 = 82;
L2 = 104;
L3 = 98;
L4 = 28;
L5 = 50;

E(1) = Link([0 L1 0  pi/2],  'standard');
E(2) = Link([0 0  L2 0],     'standard');
E(3) = Link([0 0  L3 0],     'standard');
E(4) = Link([0 0  L4  -pi/2],'standard');
E(5) = Link([0 L5 0  0],    ' standard');

E(1).offset = 210*pi/180;
E(2).offset = pi/6;
E(4).offset = -pi/2;

E(1).qlim = [0 120*pi/180];
E(2).qlim = [0 120*pi/180];
E(3).qlim = [0 120*pi/180];
E(4).qlim = [0 120*pi/180];
E(5).qlim = [0 120*pi/180];

robot = SerialLink(E, 'name', 'robo 5dof');

q0 = [0 0 0 0 0];
q1 = [0.2618 2.0944 1.633628 0.439823 1.0472];
qf = [2.0944 0.9110619 1.528908 1.67552 1.0472];

t = 0:0.03:5;
[Q1, Qd1, Qdd1] = jtraj(q0, q1, t);
%[Q2, Qd2, Qdd2] = jtraj(q1, qf, t);

L = {'r', 'LineWidth', 1.5};

figure(1)
robot.plot(Q1, 'trail', L);
%hold on;
%robot.plot(Q2, 'trail', L)

figure(2)
subplot(3,1,1);
plot(t, 180/pi*Q1);
legend('\theta_1','\theta_2','\theta_3','\theta_4','\theta_5');
ylabel('angulo [graus]')
subplot(3,1,2);
plot(t, 180/pi*Qd1)
legend('\omega_1','\omega_2','\omega_3','\omega_4','\omega_5')
ylabel('velocidade angular [º/s]')
subplot(3,1,3)
plot(t, 180/pi*Qdd1)
legend('\alpha_1','\alpha_2','\alpha_3','\alpha_4','\alpha_5')
ylabel('aceleração angular [º/s^2]')
xlabel('tempo [s]')

writematrix(Q1, "raw_trajectory1.csv", "WriteMode", "overwrite");
%writematrix(Q2, "raw_trajectory2.csv", "WriteMode", "overwrite");