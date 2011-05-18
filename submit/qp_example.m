sig = [0.08 -.05 -.05 -.05
    -.05 0.16 -.02 -.02
    -.05 -.02 0.35 0.06
    -.05 -.02 0.06 0.35];

p_mean = [0.05 -.20 0.15 0.30]';

cvx_quiet(true);

cvx_begin
    variable y(4)
    minimize ( quad_form(y,sig) )
    p_mean'*y >= 0.1;
    ones(1,4)*y <= 1;
    y >= 0;
cvx_end

cvx_begin
    variable x1(4)
    minimize ( quad_form(x1,sig) )
    p_mean'*x1 >= 1000;
    ones(1,4)*x1 <= 10000;
    x1 >= 0;
cvx_end

cvx_begin
    variable x2(4)
    minimize ( quad_form(x2,sig) )
    p_mean'*x2 >= 1000;
    ones(1,4)*x2 == 10000;
    x2 >= 0;
cvx_end

cvx_begin
    variable x3(4)
    minimize ( quad_form(x3,sig) )
    p_mean'*x3 == 1000;
    ones(1,4)*x3 <= 10000;
    x3 >= 0;
cvx_end

cvx_begin
    variable x4(4)
    minimize ( quad_form(x4,sig) )
    p_mean'*x4 == 1000;
    ones(1,4)*x4 == 10000;
    x4 >= 0;
cvx_end

disp([y, x1, x2, x3, x4 ]);


