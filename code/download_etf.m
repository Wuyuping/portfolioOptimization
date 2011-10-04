%List of EFTs to download
% SPY IJH	IJR	IYY	XLE	EWZ	EWJ	EWH	EEM	EZU	EFA	AGG	IAU	IYR

% A partial list of supported values for historical data are:
% 'Close'
% 'Date'
% 'High'
% 'Low'
% 'Open'
% 'Volume'
% 'Adj Close'

function download_etf() 
  
  global y;
  global start_date;
  global end_date;
  
  y = yahoo('http://download.finance.yahoo.com');
  start_date = '31-jan-2005';
  end_date = '30-sep-2011';
  save_file = 'ETF_Feb05_Sep11.mat';

  % SPY IJH IJR	IYY
  SPY_mat = fetching('SPY');
  SPY = convert_toDS(SPY_mat);
  clear SPY_mat;
    
  IJH_mat = fetching('IJH');
  IJH = convert_toDS(IJH_mat);
  clear IJH_mat;

  IJR_mat = fetching('IJR');
  IJR = convert_toDS(IJR_mat);
  clear IJR_mat;

  IYY_mat = fetching('IYY');
  IYY = convert_toDS(IYY_mat);
  clear IYY_mat;

  % XLE	EWZ	EWJ	EWH	
  XLE_mat = fetching('XLE');
  XLE = convert_toDS(XLE_mat);
  clear XLE_mat; 

  EWZ_mat = fetching('EWZ');
  EWZ  = convert_toDS(EWZ_mat);
  clear EWZ_mat;

  EWJ_mat = fetching('EWJ');
  EWJ = convert_toDS(EWJ_mat);
  clear EWJ_mat;

  EWH_mat = fetching('EWH');
  EWH = convert_toDS(EWH_mat);
  clear EWH_mat;

  % EEM	EZU	EFA	AGG	
  EEM_mat = fetching('EEM');
  EEM = convert_toDS(EEM_mat);
  clear EEM_mat;

  EZU_mat = fetching('EZU');
  EZU = convert_toDS(EZU_mat);
  clear EZU_mat;

  EFA_mat = fetching('EFA');
  EFA = convert_toDS(EFA_mat);
  clear EFA_mat;

  AGG_mat = fetching('AGG');
  AGG = convert_toDS(AGG_mat);
  clear AGG_mat;

  % IAU IYR
  IAU_mat = fetching('IAU');
  IAU = convert_toDS(IAU_mat);
  clear IAU_mat;

  IYR_mat = fetching('IYR');
  IYR = convert_toDS(IYR_mat);
  clear IYR_mat;    

  DJI_mat = fetching('^DJI');
  DJI = convert_toDS(DJI_mat);
  clear DJI_mat;    

  SP500_mat = fetching('^GSPC');
  SP500 = convert_toDS(SP500_mat);
  clear SP500_mat;
  
  save(save_file);
end

function datamat = fetching(etf_symbol) 
  global y;
  global start_date;
  global end_date;

  datamat = fetch(y, etf_symbol,{'Close', 'High', 'Low', 'Open', 'Volume', 'Adj Close'}, start_date, end_date);
  
end

function myds = convert_toDS(data_mat)
  nrows = size(data_mat, 1);
  reverse_idx = nrows : -1 : 1;
  new_mat = data_mat(reverse_idx, :);
  myds = dataset({cellstr(datestr(new_mat(:,1),'mm/dd/yyyy')),'Date'},{new_mat(:,2:7), 'Close', 'High', 'Low', 'Open', 'Volume', 'Adj_Close'});
end