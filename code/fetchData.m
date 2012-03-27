%% download yahoo data 
% 

function plot_data = fetchData(symbols, start_date, end_date, period)    
  y = yahoo('http://download.finance.yahoo.com');
  download_fields = {'Close', 'High', 'Low', 'Open', 'Volume', 'Adj Close'};
  dataset_fields  = ['Date', download_fields]; 
  datafile = strcat(period,'data');
  asset.start_date = start_date;
  asset.end_date = end_date;
  asset.period = period;
  plot_data = [];
  
  for i=1:length(symbols)
    symbol = symbols{i};
    myds = download(y, symbol,download_fields, start_date, end_date, period, dataset_fields);
    asset.(symbol) = myds;
    plot_data(:,i) = myds.AdjClose;
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
  
  datamat = fetch(y, symbol,download_fields, start_date, end_date, period);
  n = size(datamat, 1);
  reverse_idx = n : -1 : 1;
  datamat = datamat(reverse_idx, :);
  myds = dataset({datamat,dataset_fields{:}});
end