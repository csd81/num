% Legacy Hungarian educational script
% Part of historical problem set for fixed-point iteration transformation
% Alternative form for fixed-point iteration

function y = fixfg_a5(x)
y = (1-exp(x)./(x.^4-3*x.^3+2*x-1)).^3;
end
