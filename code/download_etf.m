%% download etf data 
% 

function download_etf()    
  y = yahoo('http://download.finance.yahoo.com');
  load Variables;
  data_vars = Variables(2:15,1);
  download_fields = {'Close', 'High', 'Low', 'Open', 'Volume', 'Adj Close'};
  dataset_fields = ['Date', download_fields]; 
  disp('Please enter date range of the historical data ');
  start_date = input('From date (01-jan-2005):  ', 's');
  end_date   = input('To date   (30-sep-2011):  ', 's');
  period     = input('Period    (d/w/m):        ', 's');  
  datafile = strcat(period,datestr(datenum(end_date), 'yyyymmmdd'));        
  for i = 1:size(data_vars,1)
    etf_symbol = data_vars{i};
    datamat    = fetch(y, etf_symbol,download_fields, start_date, end_date, period);
    n = size(datamat, 1);
    reverse_idx = n : -1 : 1;
    datamat = datamat(reverse_idx, :);
    myds = dataset({datamat,dataset_fields{:}});
    myds.Date = datestr(myds.Date, 'mm/dd/yy');
    asset.(etf_symbol) = myds;
  end 
  save(datafile, 'asset');
end