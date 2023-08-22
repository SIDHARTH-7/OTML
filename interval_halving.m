syms x
eqn = input(sprintf('Enter a continuous function as a function of x: '));
f=sym(eqn);
a = input(sprintf('Enter the lower bound of the interval [a, b]: '));
b = input(sprintf('Enter the upper bound of the interval [a, b]: '));
if b <= a
    fprintf('Error: b must be bigger than a\n');
    return
end
nmax = input(sprintf('Enter the maximum number of iterations: '));
e = input(sprintf('Enter the maximum error: '));
n = 1;
profile on
m=(a+b)/2;
fm=subs(f,x,m);
while n <= nmax
    l=b-a;
    x1=a+(l/4);
    x2=b-(l/4);
    fx1=subs(f,x,x1);
    fx2=subs(f,x,x2);
    if fx1>fm && fx2<fm
        b=m;
        fm=fx1;
    end
    if fx1<fm && fx2>fm
        a=m;
        fm=fx2;
    end
    if fx1<fm && fm>fx2
        a=x1;
        b=x2;
    end
    if b-a < e
        fprintf('Approximate maximum is %f and number of iterations %f\n', fm,n);
        profile viewer
        return
    end
    n = n + 1;
end
fprintf('Error: Please enter a bigger number of maximum iterations to approximate the maximum with an error less than %f\n', e);

