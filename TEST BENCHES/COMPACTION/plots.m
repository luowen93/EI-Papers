load data.mat

% X time variation along rows
% Y pressure variation along columns
% Z is the measured distance of 20 tows
X(:,2) = [];
Y(:,2) = [];
Z(:,2) = [];

% Plots (constant time, pressure varies)

n = 2;
subplot(n,1,1)
hold on

for i=1:6
plot(Y(i,:),Z(i,:),'-o');
end

xlabel('Pressure (psi)');
ylabel('Thickness (mm)');
legend('5s','10s','15s','20s','25s','30s')

% Constant pressure, time varies
subplot(n,1,2)
hold on

for i=1:4
plot(X(:,i),Z(:,i),'-o');
end
xlim([0 35]);
xlabel('Time (s)');
ylabel('Thickness (mm)');
legend('1.9psi','6.3psi','10.4psi','22.2psi')

%% Rewritten as a percentage

n = 2;
subplot(n,1,1)
hold on

for i=1:size(Z,2)
ZT(:,i) = Z(:,i)/Z(1,i);
end

for i=1:6
plot(Y(i,:),ZT(i,:),'-o');
end

xlabel('Pressure (psi)');
ylabel('Thickness Fraction');
legend('5s','10s','15s','20s','25s','30s')

% Constant pressure, time varies
subplot(n,1,2)
hold on

for i=1:size(Z,1)
ZP(i,:) = Z(i,:)/Z(i,1);
end

for i=1:4
plot(X(:,i),ZP(:,i),'-o');
end
xlim([0 35]);
xlabel('Time (s)');
ylabel('Thickness Fraction');
legend('1.9psi','6.3psi','10.4psi','22.2psi')


