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

load ETF_14_Feb05_Dec10.mat;

% SPY IJH	IJR	IYY	
SPY_dat = dataset({cellstr(datestr(SPY_mat(:,1),'mm/dd/yyyy')),'Date'},{SPY_mat(:,2:7), 'Close', 'High', 'Low', 'Open', 'Volume', 'Adj_Close'});
clear SPY_mat;
IJH_dat = dataset({cellstr(datestr(IJH_mat(:,1),'mm/dd/yyyy')),'Date'},{IJH_mat(:,2:7), 'Close', 'High', 'Low', 'Open', 'Volume', 'Adj_Close'});
clear IJH_mat;
IJR_dat = dataset({cellstr(datestr(IJR_mat(:,1),'mm/dd/yyyy')),'Date'},{IJR_mat(:,2:7), 'Close', 'High', 'Low', 'Open', 'Volume', 'Adj_Close'});
clear IJR_mat;
IYY_dat = dataset({cellstr(datestr(IYY_mat(:,1),'mm/dd/yyyy')),'Date'},{IYY_mat(:,2:7), 'Close', 'High', 'Low', 'Open', 'Volume', 'Adj_Close'});
clear IYY_mat;

% XLE	EWZ	EWJ	EWH	
XLE_dat = dataset({cellstr(datestr(XLE_mat(:,1),'mm/dd/yyyy')),'Date'},{XLE_mat(:,2:7), 'Close', 'High', 'Low', 'Open', 'Volume', 'Adj_Close'});
clear XLE_mat;
EWZ_dat = dataset({cellstr(datestr(EWZ_mat(:,1),'mm/dd/yyyy')),'Date'},{EWZ_mat(:,2:7), 'Close', 'High', 'Low', 'Open', 'Volume', 'Adj_Close'});
clear EWZ_mat;
EWJ_dat = dataset({cellstr(datestr(EWJ_mat(:,1),'mm/dd/yyyy')),'Date'},{EWJ_mat(:,2:7), 'Close', 'High', 'Low', 'Open', 'Volume', 'Adj_Close'});
clear EWJ_mat;
EWH_dat = dataset({cellstr(datestr(EWH_mat(:,1),'mm/dd/yyyy')),'Date'},{EWH_mat(:,2:7), 'Close', 'High', 'Low', 'Open', 'Volume', 'Adj_Close'});
clear EWH_mat;

% EEM	EZU	EFA	AGG	
EEM_dat = dataset({cellstr(datestr(EEM_mat(:,1),'mm/dd/yyyy')),'Date'},{EEM_mat(:,2:7), 'Close', 'High', 'Low', 'Open', 'Volume', 'Adj_Close'});
clear EEM_mat;
EZU_dat = dataset({cellstr(datestr(EZU_mat(:,1),'mm/dd/yyyy')),'Date'},{EZU_mat(:,2:7), 'Close', 'High', 'Low', 'Open', 'Volume', 'Adj_Close'});
clear EZU_mat;
EFA_dat = dataset({cellstr(datestr(EFA_mat(:,1),'mm/dd/yyyy')),'Date'},{EFA_mat(:,2:7), 'Close', 'High', 'Low', 'Open', 'Volume', 'Adj_Close'});
clear EFA_mat;
AGG_dat = dataset({cellstr(datestr(AGG_mat(:,1),'mm/dd/yyyy')),'Date'},{AGG_mat(:,2:7), 'Close', 'High', 'Low', 'Open', 'Volume', 'Adj_Close'});
clear AGG_mat;

% IAU	IYR
IAU_dat = dataset({cellstr(datestr(IAU_mat(:,1),'mm/dd/yyyy')),'Date'},{IAU_mat(:,2:7), 'Close', 'High', 'Low', 'Open', 'Volume', 'Adj_Close'});
clear IAU_mat;
IYR_dat = dataset({cellstr(datestr(IYR_mat(:,1),'mm/dd/yyyy')),'Date'},{IYR_mat(:,2:7), 'Close', 'High', 'Low', 'Open', 'Volume', 'Adj_Close'});
clear IYR_mat;

save('Dataset_ETF_14_Feb05_Dec10.mat');