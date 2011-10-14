function compute_ror()   
  load Variables; 
  data_vars = Variables(2:17,1);  
  period     = input('Period (d/w/m): ', 's'); 
  loadfile = strcat(period,'data');
  load (loadfile);      

  savefile = strcat(period,'return');  
  
  for i = 1:size(data_vars,1)
    symbol = data_vars{i};
    asset.(symbol) = computeRate(asset.(symbol));
    asset.(symbol)(1,:) = [];
  end
  save(savefile, 'asset');
end

function data = computeRate(data)
  n = size(data,1);
  data.prevDate = [NaN;data.Date(1:n-1)];
  data.prevAdjClose = [NaN;data.AdjClose(1:n-1)];
  data.ror = (100*(data.AdjClose - data.prevAdjClose))./data.prevAdjClose;
end