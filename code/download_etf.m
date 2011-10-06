%% download etf data 
% 

function download_etf()    
  y = yahoo('http://download.finance.yahoo.com');
  load Variables;
  data_vars = Variables(2:15,1);
  download_fields = {'Close', 'High', 'Low', 'Open', 'Volume', 'Adj Close'};
  dataset_fields  = ['Date', download_fields]; 
  disp('Please enter date range of the historical data ');
  start_date = input('From date (31-jan-2005):  ', 's');
  end_date   = input('To date   (30-sep-2011):  ', 's');
  period     = input('Period    (d/w/m):        ', 's');  
  datafile = strcat(period,'data');
  asset.start_date = start_date;
  asset.end_date = end_date;
  asset.period = period;
  
  for i = 1:size(data_vars,1)
    symbol = data_vars{i};
    myds = download(y, symbol,download_fields, start_date, end_date, period, dataset_fields);
    asset.(symbol) = myds;
  end
  
  asset.DJI = download(y, '^DJI',download_fields, start_date, end_date, period, dataset_fields);
  asset.SP500 = download(y, '^GSPC',download_fields, start_date, end_date, period, dataset_fields);
  save(datafile, 'asset');
end

function myds = download(varargin) 
  y = varargin{1};
  symbol = varargin{2};
  download_fields = varargin{3};
  start_date = varargin{4};
  end_date = varargin{5};
  period = varargin{6};
  dataset_fields = varargin{7};
  
  datamat    = fetch(y, symbol,download_fields, start_date, end_date, period);
  n = size(datamat, 1);
  reverse_idx = n : -1 : 1;
  datamat = datamat(reverse_idx, :);
  myds = dataset({datamat,dataset_fields{:}});
  myds.Date = datestr(myds.Date, 'mm/dd/yy');  
end