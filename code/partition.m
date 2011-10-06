% Partition the data into 3 sets using ^VIX index
% ETF.Rate.volatile = 1, 2, 3 

function partition() 
  load Variables;
  period     = input('Period (d/w/m): ', 's'); 
  loadfile = strcat(period,'return');
  load (loadfile);      
  
  savefile = strcat(period,'partition');  

  asset.ror.volatile = compute_volatile(asset.ror.Date);
  asset.ror.volatile  = ordinal(asset.ror.volatile, {'low' 'medium' 'high'});
  save(savefile,'-v7.3','asset');
end

function volatile = compute_volatile(trade_dates)
  %   Low VOLATILITY :  <= June 30, 2007
  %                  :  Oct 2010 - June 2011
  %   Med VOLATILITY :  July 2007 - Aug 2008
  %                  :  Dec 2009 - Apr 2010
  %   Hi  VOLATILITY :  Sep 2008 - Nov 2009
  %                  :  May 2010 - Sep 2010
  %                  :  July 2011 - Sep 2011
  
  june07 = datenum('06/30/2007','mm/dd/yyyy');
  oct10 = datenum('10/01/2010','mm/dd/yyyy');
  june11 = datenum('06/30/2011','mm/dd/yyyy');
  july07 = datenum('07/01/2007','mm/dd/yyyy');
  aug08 = datenum('08/31/2008','mm/dd/yyyy');
  dec09 = datenum('12/01/2009','mm/dd/yyyy');
  apr10 = datenum('04/30/2010','mm/dd/yyyy');
  sep08 = datenum('09/01/2008','mm/dd/yyyy');
  nov09 = datenum('11/30/2009','mm/dd/yyyy');
  may10 = datenum('05/01/2010','mm/dd/yyyy');
  sep10 = datenum('09/30/2010','mm/dd/yyyy');
  july11 = datenum('07/01/2011','mm/dd/yyyy');
  sep11 = datenum('09/30/2011','mm/dd/yyyy');
  
  n = size(trade_dates,1);
  volatile = zeros(n,1);
  for i = 1:n
    date_num = datenum(trade_dates(i,:));
    if (date_num <= june07 || (date_num >=  oct10 && date_num <= june11))
      volatile(i) = 1;
    elseif ((date_num >= july07 && date_num <= aug08) ...
        || (date_num >= dec09 && date_num <= apr10))
      volatile(i) = 2;
    elseif ((date_num >= sep08 && date_num <= nov09) ...
        || (date_num >= may10 && date_num <= sep10) ...
        ||  (date_num >= july11 && date_num <= sep11))
      volatile(i) = 3;
    else 
      volatile(i) = NaN;
    end;
  end
end
