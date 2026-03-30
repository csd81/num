% Legacy Hungarian educational script
% Part of historical problem set for fixed-point iteration transformation
% Alternative form for fixed-point iteration

function y = fixfg_a4(x)
y = nthroot((exp(x)./(1-nthroot(x,3))-(x^4+2*x-1))/3,3);
end
