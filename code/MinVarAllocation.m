load ROR14_Feb05_Dec10;
dayRateMat = ETF14.RateMat;
dayRateMat(1,:)=[];

% estimated mean price change  
p_mean = mean(dayRateMat)';

% estimated covariance nmatrix of the price change random vector
sig = cov(dayRateMat);

% number of assets in the portfolio
n = 14;

% Budget (i.e. total investmed amount) 
B = 10000;
r_min = 20;

%r_min = 0.02;
cvx_quiet(true);

cvx_begin
    variable x1(n)
    minimize (quad_form(x1,sig))
    p_mean'*x1 >= r_min;
    ones(1,n)*x1 <= B;
    x1 >= 0;
cvx_end

cvx_begin
    variable x2(n)
    minimize (quad_form(x2,sig))
    p_mean'*x2 >= r_min;
    ones(1,n)*x2 == B;
    x2 >= 0;
cvx_end

cvx_begin
    variable x3(n)
    minimize (quad_form(x3,sig))
    p_mean'*x3 == r_min;
    ones(1,n)*x3 <= B;
    x3 >= 0;
cvx_end

cvx_begin
    variable x4(n)
    minimize (quad_form(x4,sig))
    p_mean'*x4 == r_min;
    ones(1,n)*x4 == B;
    x4 >= 0;
cvx_end

disp([x1,x2,x3, x4]);
