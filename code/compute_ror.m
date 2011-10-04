function compute_ror() 
    % compute daily rate of returns for 14 ETFs
    load ETF_Feb05_Sep11;
    load Variables; 
    data_vars = Variables(2:17,1);

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

    % IAU	IYR DJI SP500    
    IAU = computeRate(IAU);
    IYR = computeRate(IYR);    
    DJI = computeRate(DJI);
    SP500 = computeRate(SP500);
    
    % Combine rate into one datasdet
    dateVec = SPY.Date;
    [n, ~] = size(SPY);
    dayRateMat = zeros(n,16);
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
    dayRateMat(:,15) = DJI.Rate;
    dayRateMat(:,16) = SP500.Rate;
    
    dayRateSet = dataset({dateVec,'Date'}, {dayRateMat, data_vars{:}});

    ETF.SPY =   SPY;
    ETF.IJH =   IJH;
    ETF.IJR =   IJR;
    ETF.IYY =   IYY;
    ETF.XLE =   XLE;
    ETF.EWZ =   EWZ;
    ETF.EWJ =   EWJ;
    ETF.EWH =   EWH;
    ETF.EEM =   EEM;
    ETF.EZU =   EZU;
    ETF.EFA =   EFA;
    ETF.AGG =   AGG;
    ETF.IAU =   IAU;
    ETF.IYR =   IYR;
    ETF.DJI =   DJI;
    ETF.SP500 =   SP500;    
    ETF.Rate = dayRateSet;
    
    ETF.Rate.Properties.VarDescription =  Variables(1:17,2);
    save('ROR_Feb05_Sep11','-v7.3','ETF');
end

function newdataset = computeRate(data) 
    [n, ~] = size(data);
    data.Prev_Adj_Close = [NaN; data.Adj_Close(1:n-1)];    
    data.Rate = 100*(data.Adj_Close - data.Prev_Adj_Close)./data.Prev_Adj_Close;    
    newdataset = data;
end