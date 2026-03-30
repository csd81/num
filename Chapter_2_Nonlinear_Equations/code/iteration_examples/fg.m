% Legacy Hungarian educational script - function definition
% Part of historical problem set for iterative root-finding methods

function y=fg(x)
  y=exp(x)*atan(x)-(x^4+2*x-1);
end