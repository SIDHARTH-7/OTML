syms x
eqn = input(sprintf('Enter a continuous function as a function of x: '));
a = input(sprintf('Enter the lower bound of the interval [a, b]: '));
b = input(sprintf('Enter the upper bound of the interval [a, b]: '));

if b <= a
    fprintf('Error: b must be bigger than a\n');
    return
end

u = input(sprintf('Enter a number u such that f(x) = u has a solution in the interval [a, b]: '));
k = solve(eqn == u, x, 'Real', true);
t = isempty(k);
g = max(size(k));
z = 0;

if t == 1
    fprintf('Error: Enter a number u such that f(x) = u has a solution in the interval [a, b]\n');
    return
end

for i = 1:g
    if k(i) > a && k(i) < b
        z = 1;
    end
end

if z == 0
    fprintf('Error: Enter a number u such that f(x) = u has a solution in the interval [a, b]\n');
    return
end

v = input(sprintf('Enter a number v bigger than u such that f(x) = v has no solution: '));
l = solve(eqn == v, x, 'Real', true);
r = isempty(l);
o = 0;

for i = 1:g
    if r == 0
        if l(i) > a && l(i) < b
            o = 1;
        end
    end
end

if r == 0 && o == 1
    fprintf('Error: Enter a number v bigger than u such that f(x) = v has no solution\n');
    return
end

if v <= u
    fprintf('Error: Enter a number u such that f(x) = u has a solution in the interval [a, b]\n');
    return
end

nmax = input(sprintf('Enter the maximum number of iterations: '));
e = input(sprintf('Enter the maximum error: '));

if nmax < 0 || e < 0
    fprintf('Error: Enter a positive number for the number of iterations and the error\n');
    return
end

n = 1;
profile on
while n <= nmax
    p = (u + v) / 2;
    k = solve(eqn == p, x, 'Real', true);
    t = isempty(k);
    g = max(size(k));
    z = 0;

    if t == 1
        v = p;
    else
        for i = 1:g
            if t == 0
                if k(i) > a && k(i) < b
                    z = 1;
                end
            end
        end
    end

    if z == 1
        u = p;
    else
        v = p;
    end

    if v - u < e
        fprintf('Approximate maximum is %f and number of iterations is %f\n', (u + v) / 2,n);
        profile viewer
        return
    end

    n = n + 1;
end

fprintf('Error: Please enter a bigger number of maximum iterations to approximate the maximum with an error less than %f\n', e);
