function y = fixfg_a3(x)
y = exp(x)./(1-nthroot(x,3))-(x.^4-3*x.^3+x-1);
end
