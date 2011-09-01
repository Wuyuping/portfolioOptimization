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

y = yahoo('http://download.finance.yahoo.com');
start_date = 'Jan 31 2005';
end_date = 'Aug 30 2011';

% SPY IJH IJR	IYY	
SPY_mat = fetch(y,'SPY',{'Close', 'High', 'Low', 'Open', 'Volume', 'Adj Close'},start_date, end_date );
IJH_mat = fetch(y,'IJH',{'Close', 'High', 'Low', 'Open', 'Volume', 'Adj Close'},start_date, end_date);
IJR_mat = fetch(y,'IJR',{'Close', 'High', 'Low', 'Open', 'Volume', 'Adj Close'},start_date, end_date);
IYY_mat = fetch(y,'IYY',{'Close', 'High', 'Low', 'Open', 'Volume', 'Adj Close'},start_date, end_date);

% XLE	EWZ	EWJ	EWH	
XLE_mat = fetch(y,'XLE',{'Close', 'High', 'Low', 'Open', 'Volume', 'Adj Close'},start_date, end_date);
EWZ_mat = fetch(y,'EWZ',{'Close', 'High', 'Low', 'Open', 'Volume', 'Adj Close'},start_date, end_date);
EWJ_mat = fetch(y,'EWJ',{'Close', 'High', 'Low', 'Open', 'Volume', 'Adj Close'},start_date, end_date);
EWH_mat = fetch(y,'EWH',{'Close', 'High', 'Low', 'Open', 'Volume', 'Adj Close'},start_date, end_date);

% EEM	EZU	EFA	AGG	
EEM_mat = fetch(y,'EEM',{'Close', 'High', 'Low', 'Open', 'Volume', 'Adj Close'},start_date, end_date);
EZU_mat = fetch(y,'EZU',{'Close', 'High', 'Low', 'Open', 'Volume', 'Adj Close'},start_date, end_date);
EFA_mat = fetch(y,'EFA',{'Close', 'High', 'Low', 'Open', 'Volume', 'Adj Close'},start_date, end_date);
AGG_mat = fetch(y,'AGG',{'Close', 'High', 'Low', 'Open', 'Volume', 'Adj Close'},start_date, end_date);

%IAU IYR
IAU_mat = fetch(y,'IAU',{'Close', 'High', 'Low', 'Open',  'Volume', 'Adj Close'},start_date, end_date);
IYR_mat = fetch(y,'IYR',{'Close', 'High', 'Low', 'Open',  'Volume', 'Adj Close'},start_date, end_date);

save('ETF_14_Feb05_Aug11.mat');