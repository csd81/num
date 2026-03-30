% Legacy Hungarian educational script - function definition
% Part of historical problem set for iterative root-finding methods

function y=dfg(x)
  y=exp(x)*(atan(x)+1/(1+x^2))-(4*x^3+2);
end