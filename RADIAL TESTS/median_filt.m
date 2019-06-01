% LOAD UP TEST DATA



shielded = load('shielded 1000.txt');
unshielded = load('unshielded 1000.txt');

shielded = shielded(540:end,:);
unshielded = unshielded(652:end,:);

shielded = shielded(1:1685,:);
unshielded = unshielded(1:1685,:);

r_shield = shielded(:,2);
r_unshield = unshielded(:,2);

n = length(r_shield);

t = 0:0.008:(n-1)*0.008;

close all
figure(1)
subplot(2,1,1);
plot(t,r_shield+0.0913);
ylim([3.3 3.8]);
ylabel('Diameter (in)');
title('Shielded');
hold on
subplot(2,1,2);
plot(t,r_unshield);
ylim([3.3 3.8]);
title('Unshielded');
ylabel('Diameter (in)');
xlabel('Time (s)');

%%
M = load('LONG TEST.txt');

M = M(1000:end);

% Specify median window
y = medfilt1(M,11);

% First order filter
tau = 1;
s = tf('s');
F = 1/(tau*s+1);
dt = 0.008;
t = 0:dt:(length(y)-1)*dt;

[a,b,c,d]= tf2ss(1,[tau 1]);

F_ss = ss(a,b,c,d);

y0 = y(1);

x0 = 3.625/c;

y_f = lsim(F_ss,y,t,x0);

subplot(3,1,1);
plot(t,M)
ylim([2.6 3.8]);
title('Raw shielded');
ylabel('Diameter (in)');

subplot(3,1,2);
plot(t,y);
ylim([2.6 3.8]);
title('Median filtered');
ylabel('Diameter (in)');

subplot(3,1,3);
plot(t,y_f);
title('Median filtered and FO filter');
% ylim([2.6 3.8]);
% hold on
% plot(t,smooth(y,5))
ylabel('Diameter (in)');
xlabel('Time (s)');
ylim([2.6 3.8]);