%% Update rate of return by incoporating dividend data
function update_ror()   
  load Variables; 
  data_vars = Variables(2:17,1);
  load divdata;
  
  period = input('Period (d/w/m): ', 's');  
  
  %% Daily Rate of Returns
  if strcmpi(period, 'd')  
    load dreturn;  
    rds = dataset({asset.SPY.Date, 'Date'});
    
    for i = 1:size(data_vars,1)
      symbol = data_vars{i};
      
      if (strcmpi(symbol, 'DJI') || strcmpi(symbol, 'SP500') )
        asset.(symbol).Return = asset.(symbol).ror;
      elseif  (strcmpi(div.(symbol), 'no dividend'))
        asset.(symbol).Return = asset.(symbol).ror;
      else
        indx = ismember(asset.(symbol).Date, div.(symbol).Date);
        asset.(symbol).dividend = 0;
        asset.(symbol).dividend(indx) = div.(symbol).dividend;
        asset.(symbol).Return = asset.(symbol).ror + (100*asset.(symbol).dividend) ./ asset.(symbol).AdjClose;
      end      
      rds.(symbol) = asset.(symbol).Return;      
    end    
    asset.Return = rds;
    save('dReturns', 'asset');
  end

  %% Weekly Rate of Returns
  if strcmpi(period, 'w')
    load wreturn;  
    rds = dataset({asset.SPY.Date, 'Date'});
    
    for i = 1:size(data_vars,1)
      symbol = data_vars{i};    
      if (strcmpi(symbol, 'DJI') || strcmpi(symbol, 'SP500') )
        asset.(symbol).Return = asset.(symbol).ror;
      elseif  (strcmpi(div.(symbol), 'no dividend'))
        asset.(symbol).Return = asset.(symbol).ror;
      else
        asset.(symbol).dividend = 0;
        
        for j = 1:size(asset.(symbol), 1)
          fromDate = asset.(symbol).prevDate(j);
          toDate = asset.(symbol).Date(j);
          divDate = div.(symbol).Date;
          idx = divDate > fromDate & divDate <= toDate;
          asset.(symbol).dividend(j) = sum(div.(symbol).dividend(idx));
        end
        
        asset.(symbol).Return = asset.(symbol).ror + (100*asset.(symbol).dividend) ./ asset.(symbol).AdjClose;
      end      
      rds.(symbol) = asset.(symbol).Return;
    end    
    asset.Return = rds;
    save('wReturns', 'asset');
  end

  %% Monthly Rate of Returns
  if strcmpi(period, 'm')
    load mreturn;
    rds = dataset({asset.SPY.Date, 'Date'});
    
    for i = 1:size(data_vars,1)
      symbol = data_vars{i};    
      if (strcmpi(symbol, 'DJI') || strcmpi(symbol, 'SP500') )
        asset.(symbol).Return = asset.(symbol).ror;
      elseif  (strcmpi(div.(symbol), 'no dividend'))
        asset.(symbol).Return = asset.(symbol).ror;
      else
        asset.(symbol).dividend = 0;
        
        for j = 1:size(asset.(symbol), 1)
          fromDate = asset.(symbol).prevDate(j);
          toDate = asset.(symbol).Date(j);
          divDate = div.(symbol).Date;
          idx = divDate > fromDate & divDate <= toDate;
          asset.(symbol).dividend(j) = sum(div.(symbol).dividend(idx));
        end
        
        asset.(symbol).Return = asset.(symbol).ror + (100*asset.(symbol).dividend) ./ asset.(symbol).AdjClose;
      end      
      rds.(symbol) = asset.(symbol).Return;
    end    
    asset.Return = rds;
    save('mReturns', 'asset');
  end
  
end