function compute_ror()   
  load Variables; 
  data_vars = Variables(2:17,1);  
  period     = input('Period (d/w/m): ', 's'); 
  loadfile = strcat(period,'data');
  load (loadfile);      

  savefile = strcat(period,'return');  
  rds = dataset({asset.SPY.Date, 'Date'});
  
  for i = 1:size(data_vars,1)
    symbol = data_vars{i};    
    rds.(symbol) = computeRate(asset.(symbol));
  end
  asset.ror = rds;
  save(savefile, 'asset');
end

function ror = computeRate(data) 
    n = size(data,1);
    prevAdjClose = [NaN; data.AdjClose(1:n-1)];
    ror = (data.AdjClose - prevAdjClose)./prevAdjClose;
end