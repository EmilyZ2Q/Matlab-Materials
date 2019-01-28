% CSCI5521 HW1
% Q3D-dimensional independent Bernoulli density (c)
% Peixuan Zhang
function[pr] = berf(x,pc1)
pr = [0,0];
p = [0.6,0.1;0.6,0.9];
n = length(x);

pr(1) = (p(1,1)^(1-x(1))*(1-p(1,1))^x(1)*p(1,2)^(1-x(2))*(1-p(1,2))^(x(2)))*pc1;
pr(2) =  (p(2,1)^(1-x(1))*(1-p(2,1))^x(1)*p(2,2)^(1-x(2))*(1-p(2,2))^(x(2)))*(1-pc1);
pr = pr/(pr(1)+pr(2));

