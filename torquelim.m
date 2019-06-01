function y = torquelim(w,T,g,v)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

F = [w,T]'; % Store data

G = [1/g, 0; 0 g]; % Gearing transform matrix

F = (G*F)'; % Transformed gear data

w_g = F(:,1);
T_g = F(:,2);

y = interp1(w_g,T_g,v);

end

