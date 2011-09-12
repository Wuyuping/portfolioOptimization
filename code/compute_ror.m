function compute_ror() 
    % compute daily rate of returns for 14 ETFs
    load ETF14_Feb05_Sep11;
    
    % SPY IJH	IJR	IYY	
    SPY = computeRate(SPY);
    IJH = computeRate(IJH);
    IJR = computeRate(IJR);
    IYY = computeRate(IYY);
  
    % XLE	EWZ	EWJ	EWH	    
    XLE = computeRate(XLE);
    EWZ = computeRate(EWZ);
    EWJ = computeRate(EWJ);
    EWH = computeRate(EWH);

    % EEM	EZU	EFA	AGG	    
    EEM = computeRate(EEM);
    EZU = computeRate(EZU);
    EFA = computeRate(EFA);
    AGG = computeRate(AGG);

    % IAU	IYR    
    IAU = computeRate(IAU);
    IYR = computeRate(IYR);
    
    % Combine rate into one datasdet
    dateVec = SPY.Date;
    [n, ~] = size(SPY);
    dayRateMat = zeros(n,14);
    dayRateMat(:,1) = SPY.Rate;
    dayRateMat(:,2) = IJH.Rate;
    dayRateMat(:,3) = IJR.Rate;
    dayRateMat(:,4) = IYY.Rate;
    
    dayRateMat(:,5) = XLE.Rate;
    dayRateMat(:,6) = EWZ.Rate;
    dayRateMat(:,7) = EWJ.Rate;
    dayRateMat(:,8) = EWH.Rate;
    
    dayRateMat(:,9) = EEM.Rate;
    dayRateMat(:,10) = EZU.Rate;
    dayRateMat(:,11) = EFA.Rate;
    dayRateMat(:,12) = AGG.Rate;
    dayRateMat(:,13) = IAU.Rate;
    dayRateMat(:,14) = IYR.Rate;
    
    dayRateSet = dataset({dateVec,'Date'}, {dayRateMat, 'SPY', 'IJH','IJR','IYY','XLE', 'EWZ','EWJ','EWH','EEM','EZU','EFA','AGG','IAU','IYR'});


    ETF14.SPY =   SPY;
    ETF14.IJH =   IJH;
    ETF14.IJR =   IJR;
    ETF14.IYY =   IYY;
    ETF14.XLE =   XLE;
    ETF14.EWZ =   EWZ;
    ETF14.EWJ =   EWJ;
    ETF14.EWH =   EWH;
    ETF14.EEM =   EEM;
    ETF14.EZU =   EZU;
    ETF14.EFA =   EFA;
    ETF14.AGG =   AGG;
    ETF14.IAU =   IAU;
    ETF14.IYR =   IYR;
    ETF14.Rate = dayRateSet;
    
    save('ROR14_Feb05_Sep11','-v7.3','ETF14');
end

function newdataset = computeRate(data) 
    [n, ~] = size(data);
    data.Prev_Adj_Close = [NaN; data.Adj_Close(1:n-1)];    
    data.Rate = 100*(data.Adj_Close - data.Prev_Adj_Close)./data.Prev_Adj_Close;    
    newdataset = data;
end