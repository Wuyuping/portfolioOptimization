%% download dividends data 
% 

function download_dividends()    
  y = yahoo('http://download.finance.yahoo.com');
  load Variables;
  data_vars = Variables(2:15,1);
  dataset_fields  = {'Date', 'Dividend'}; 
  disp('Please enter date range of the historical data ');
  start_date = input('From date (31-jan-2005):  ', 's');
  end_date   = input('To date   (30-sep-2011):  ', 's');
  datafile = 'divdata';
  div.start_date = start_date;
  div.end_date = end_date;
  
  for i = 1:size(data_vars,1)
    symbol = data_vars{i};
    myds = download(y, symbol, start_date, end_date, dataset_fields);
    div.(symbol) = myds;
  end
  save(datafile, 'div');
end

function myds = download(varargin) 
  y = varargin{1};
  symbol = varargin{2};
  start_date = varargin{3};
  end_date = varargin{4};
  dataset_fields = varargin{5};
  
  datamat = fetch(y, symbol, start_date, end_date, 'v');
  n = size(datamat, 1);
  reverse_idx = n : -1 : 1;
  datamat = datamat(reverse_idx, :);
  if ( size(datamat,1) > 0)
    myds = dataset({datamat,dataset_fields{:}});
    myds.Date = datestr(myds.Date, 'mm/dd/yy');
  else 
    myds = 'no dividend';
  end
end