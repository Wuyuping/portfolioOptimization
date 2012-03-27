function compute_returns()   
  load Variables; 
  data_vars = Variables(2:17,1);  
  period     = input('Period (d/w/m): ', 's'); 
  loadfile = strcat(period,'data');
  load (loadfile);      

  savefile = strcat(period,'Returns');
  
  for i = 1:size(data_vars,1)
    symbol = data_vars{i};
    asset.(symbol) = computeRate(asset.(symbol));
    asset.(symbol)(1,:) = [];
  end
  save(savefile, 'asset');
end


function data = computeRate(data)
  ret = 100*price2ret(data.AdjClose);
  data.ror= [NaN;ret];
  data.Return = [NaN;ret];
end
