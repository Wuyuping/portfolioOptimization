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
    
    % SPY IJH IJR	IYY
    SPY_mat = fetching('SPY');
    SPY_dat = convert_toDS(SPY_mat);
    
    IJH_mat = fetching('IJH');
    IJH_dat = convert_toDS(IJH_mat);
    
    IJR_mat = fetching('IJR');
    IJR_dat = convert_toDS(IJR_mat);
    
    IYY_mat = fetching('IYY');
    IYY_dat = convert_toDS(IYY_mat);
    
    % XLE	EWZ	EWJ	EWH	
    XLE_mat = fetching('XLE');
    XLE_dat = convert_toDS(XLE_mat);
    
    EWZ_mat = fetching('EWZ');
    EWZ_dat = convert_toDS(EWZ_mat);
    
    EWJ_mat = fetching('EWJ');
    EWJ_dat = convert_toDS(EWJ_mat);
    
    EWH_mat = fetching('EWH');
    EWH_dat = convert_toDS(EWH_mat);

    % EEM	EZU	EFA	AGG	
    EEM_mat = fetching('EEM');
    EEM_dat = convert_toDS(EEM_mat);
    
    EZU_mat = fetching('EZU');
    EZU_dat = convert_toDS(EZU_mat);
    
    EFA_mat = fetching('EFA');
    EFA_dat = convert_toDS(EFA_mat);
    
    AGG_mat = fetching('AGG');
    AGG_dat = convert_toDS(AGG_mat);

    % IAU IYR
    IAU_mat = fetching('IAU');
    IAU_dat = convert_toDS(IAU_mat);
    
    IYR_mat = fetching('IYR');
    IYR_dat = convert_toDS(IYR_mat);
    
    save('ETF14_Feb05_Dec10.mat');
end

function datamat = fetching(etf_symbol) 
    y = yahoo;
    datamat = fetch(y, etf_symbol,{'Close', 'High', 'Low', 'Open', 'Volume', 'Adj Close'},'Jan 31 2005', 'Jan 3 2011');
end

function myds = convert_toDS(data_mat)
    myds = dataset({cellstr(datestr(data_mat(:,1),'mm/dd/yyyy')),'Date'},{data_mat(:,2:7), 'Close', 'High', 'Low', 'Open', 'Volume', 'Adj_Close'});
end
