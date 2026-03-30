function y = fixfg_a1(x)
y = log((1-nthroot(x,3)).*(x.^4-3*x.^3+2*x-1));
end

