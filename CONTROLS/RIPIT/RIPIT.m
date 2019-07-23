% Import into M
M = xlsread('2000ipm.csv');
M = M(19:end,1:2);

xr = 1.0;

t = M(:,1);
y = M(:,2)/12700-xr;
dt = t(2)-t(1);
dy = numderiv(y)/dt;
ddy = numderiv(dy)/dt;
dddy = numderiv(ddy)/dt;

Y = zeros(length(y),4);

Y(:,1) = y;
Y(:,2) = dy;
Y(:,3) = ddy;
Y(:,4) = dddy;

%% Loop to construct the velocity profiles
Z = zeros(length(y),2);
Z(1,1) = 2000/60;
ke = 7;
for i=1:length(y)-1
    % Calculate the acceleration
    if( i == 1)
        Z(i,2) = 0;
    else
        Z(i,2) = 2*(ddy(i)+2*ke*dy(i)+ke^2*y(i)-ke*Z(i,1));
    end
    % Update the velocity prediction
    Z(i+1,1) = Z(i,1)+Z(i,2)*dt;
end

%% Step response

v0 = 2000/60;
a0 = -1773;
t0 = 0.904;
tau = 0.001;

x0 = [t0,v0,a0,tau];
x = x0;
indices = find( t > t0-0.005 & t < t0+0.015);

v = Z(:,1);
% Using Jacobians and newtons
for i=1:10
   [J,r] = residualGradient(x,t,Z(:,1),indices);
   
   dx = inv(J'*J)*J'*r;
   
   x = x-dx';
   % Plots
   [f,y]= cutVel(x,t,Z(:,1),indices);

  
end