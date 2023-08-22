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
p=1:nmax;
fib=fibonacci(p);
l=b-a;
l=l*(fib(nmax-n)/fib(nmax-n+1));
x2=a+l;
x1=b-l;
fx1=subs(f,x,x1);
fx2=subs(f,x,x2);
n=n+1;
while n < nmax
    l=l*(fib(nmax-n)/fib(nmax-n+1));
    if fx1>=fx2
        b=x2;
        x2=x1;
        fx2=fx1;
        x1=b-l;
        fx1=subs(f,x,x1);
    else
        a=x1;
        x1=x2;
        fx1=fx2;
        x2=a+l;
        fx2=subs(f,x,x2);
    end
    if b-a < e
        fm=subs(f,x,(a+b)/2);
        fprintf('Approximate maximum is %f and number of iterations %f\n', fm,n);
        profile viewer
        return
    end
    n = n + 1;
end
fm=subs(f,x,(a+b)/2);
fprintf('Approximate maximum is %f and number of iterations %f\n', fm,n);
profile viewer
fprintf('Error: Please enter a bigger number of maximum iterations to approximate the maximum with an error less than %f\n', e);

