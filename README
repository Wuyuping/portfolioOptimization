08-23-11
  1. Update data through 8/31/11 (with volume, use volume to weight the price changed)
  2. Compute rate of returns
  3. Develop the methodology based on simulation to determine the probabilistic distribution 
      of the return rate for the portfolio allocation with specified risk

    Risk = x'Vx where x is the allocation vector 
    Find x so that x'Vx <= y (where y = specified risk)
    
09-01-11
  1. Partition the data into 3 periods of risks (low, medium, high valitility)
    -  Using ^VIX index 
  
  2. For each risk period compute the statistics
    - min, max, mean, std dev, cov (V), cor, eigen values, svd 

  3. Determine probability dist of mean return 
    - Compute the mean rate of return for each each ETF. Vector r = (r1, r2, ..., r14)
    - Specify the portfolio risk y 
    - Simulate the allocation vector x by solving the optimization problem 
        x'Vx <= y
    - Determine the expected return x'r 
    - Repeat it n times and compute the relative frequencies for x'r

        for each x s.t.  (y - e <= x'Vx <= y)
          compute x'r 
          plot a histogram of x'r 
