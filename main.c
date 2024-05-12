#include <stdio.h>
#include <math.h>
#include <string.h>

double func1(double x);
double func2(double x);


double f1(double x) {
    return 1 + 4 / (x * x + 1);
}

double f2(double x) {
    return x * x * x;
}

double f3(double x) {
    return pow(2, -x);
}

int showIterations = 0;
int showRoot = 0;

double root(double (*f)(double), double (*g)(double), double a, double b, double eps1) {
    double xl = a, xr = b;
    int iterCount = 0;
    while (xr - xl > eps1) {
        double xm = (xl + xr) / 2;
        double Fm = f(xm) - g(xm);
        if (fabs(Fm) <= eps1) {
            if (showRoot) {
                printf("Root: %lf\n", xm);
            }
            if (showIterations) {
                printf("Iterations: %d\n", iterCount);
            }
            return xm;
        } else {
            if ((f(xl) - g(xl)) * (f(xm) - g(xm)) < 0) {
                xr = xm;
            } else {
                xl = xm;
            }
        }
        iterCount++;
    }
    return -1;
}

double integral(double (*f)(double), double a, double b, double eps2) {
    double res = 0;
    for (double i = a; i < b; i+=eps2) {
        double s = (f(i) + f(i + eps2)) / 2;
        s *= eps2;
        res += s;
    }
    return res;
}

// TODO check odz

double test_f1(double x) {
    return pow(x + 1, 3) + 1;
}

double test_f2(double x) {
    return 3 * x * x + 5 * x + 1;
}

double test_f3(double x) {
    return 2 + 6 / (x + 3);
}

void test_root(int f1, int f2, double a, double b, double eps, double res) {
    double (*func1)(double) = test_f1;
    double (*func2)(double) = test_f2;

    if (f1 == 1) {
        func1 = test_f1;
    } else if (f1 == 2) {
        func1 = test_f2;
    } else if (f1 == 3) {
        func1 = test_f3;
    }
    if (f2 == 1) {
        func2 = test_f1;
    } else if (f2 == 2) {
        func2 = test_f2;
    } else if (f2 == 3) {
        func2 = test_f3;
    }
    double val = root(func1, func2, a, b, eps);
    printf("test roots: %lf %lf %lf\n", val, res, val - res);
}

void test_integral(int f1, double a, double b, double eps, double res) {
    double (*func)(double) = test_f1;

    if (f1 == 1) {
        func = test_f1;
    }
    else if (f1 == 2) {
        func = test_f2;
    }
    else if (f1 == 3) {
        func = test_f3;
    }
   
    double val = integral(func, a, b, eps);
    printf("test integral: %lf %lf %lf\n", val, res, val - res);
}

int main(int argc, char* argv[]) {    
    for (int i = 0; i < argc; i++) {
        if (strcmp(argv[i], "--help") == 0 || strcmp(argv[i], "-h") == 0) {
            printf("Options:\n  --iterations -i\n  --root -r\n  --test-root -R\n  --test-integral -I\n");
        }
        if (strcmp(argv[i], "--iterations") == 0 || strcmp(argv[i], "-i") == 0) {
            showIterations = 1;
        }
        if (strcmp(argv[i], "--root") == 0 || strcmp(argv[i], "-r") == 0) {
            showRoot = 1;
        }
        if (strcmp(argv[i], "--test-root") == 0 || strcmp(argv[i], "-R") == 0) {
            char* opt = argv[i + 1];
            int f_1, f_2;
            double A, B, E, R;
            sscanf(opt, "%d:%d:%lf:%lf:%lf:%lf", &f_1, &f_2, &A, &B, &E, &R);
            test_root(f_1, f_2, A, B, E, R);
            i += 1;
        } 
        if (strcmp(argv[i], "--test-integral") == 0 || strcmp(argv[i], "-I") == 0) {
            char* opt = argv[i + 1];
            int f_1;
            double A, B, E, R;
            sscanf(opt, "%d:%lf:%lf:%lf:%lf", &f_1, &A, &B, &E, &R);
            test_integral(f_1, A, B, E, R);
            i += 1;
        }
    }
    printf("->>>>>>>>>>>>>FUNC1: %lf\n", func1(2.5));
    printf("->>>>>>>>>>>>>FUNC2: %lf\n", func2(2.5));

    double eps1 = 0.000001;
    double eps2 = 0.000001;
    double f23 = root(f2, f3, 0, 1, eps1);
    double f12 = root(f1, f2, 1, 2, eps1);
    double f13 = root(f1, f3, -2, -1, eps1);
    double intf1 = integral(f1, f13, f12, eps2);
    double intf2 = integral(f2, f23, f12, eps2);
    double intf3 = integral(f3, f13, f23, eps2);
    double intres = intf1 - intf2 - intf3;

    printf("Result: %lf\n", intres);
    return 0;
}
