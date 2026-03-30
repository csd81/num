function y = fixfg_a2(x)
y = nthroot(exp(x)./(1-nthroot(x,3))-(-3*x.^3+2*x-1),4);
end