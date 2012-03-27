%% download etf data 
% 

function download_etf()    
  load Variables;
  symbols = Variables(2:15,1);
  disp('Please enter date range of the historical data ');
  start_date = input('From date (31-jan-2005):  ', 's');
  end_date   = input('To date   (30-sep-2011):  ', 's');
  period     = input('Period    (d/w/m):      ', 's');    
  fetchData(symbols, start_date, end_date, period);  
end
