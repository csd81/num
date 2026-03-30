% Legacy Hungarian educational script
% Part of historical problem set for fixed-point iteration
% Test function: fixfg1(x) = exp(x) / (1 - x^(1/3))

function y = fixfg1(x)
y = exp(x)./(1-nthroot(x,3));
end

