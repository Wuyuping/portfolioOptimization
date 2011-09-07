% partition the data into 3 sets
% ETF14.RateSet.VOLATILITY = 1, 2, 3 

%   Low VOLATILITY :  <= June 30, 2007
%                  :  Oct 2010 - June 2011
june07 = datenum('06/30/2007','mm/dd/yyyy');
ETF14.RateSet.volatility(datenum(ETF14.RateSet.Date,'mm/dd/yyyy') <= june07) = 1;

oct10 = datenum('10/01/2010','mm/dd/yyyy');
june11 = datenum('06/30/2011','mm/dd/yyyy');
ETF14.RateSet.volatility(datenum(ETF14.RateSet.Date,'mm/dd/yyyy') >= oct10 & datenum(ETF14.RateSet.Date,'mm/dd/yyyy') <= june11) = 1;

%   Med VOLATILITY :  July 2007 - Aug 2008
%                  :  Dec 2009 - Apr 2010
july07 = datenum('07/01/2007','mm/dd/yyyy');
aug08 = datenum('08/31/2008','mm/dd/yyyy');
ETF14.RateSet.volatility(datenum(ETF14.RateSet.Date,'mm/dd/yyyy') >= july07 & datenum(ETF14.RateSet.Date,'mm/dd/yyyy') <= aug08) = 2;

dec09 = datenum('12/01/2009','mm/dd/yyyy');
apr10 = datenum('04/30/2010','mm/dd/yyyy');
ETF14.RateSet.volatility(datenum(ETF14.RateSet.Date,'mm/dd/yyyy') >= dec09 & datenum(ETF14.RateSet.Date,'mm/dd/yyyy') <= apr10) = 2;

%   Hi  VOLATILITY :  Sep 2008 - Nov 2009
%                  :  May 2010 - Sep 2010
%                  :  July 2011 - Sep 2011
sep08 = datenum('09/01/2008','mm/dd/yyyy');
nov09 = datenum('11/30/2009','mm/dd/yyyy');
ETF14.RateSet.volatility(datenum(ETF14.RateSet.Date,'mm/dd/yyyy') >= sep08 & datenum(ETF14.RateSet.Date,'mm/dd/yyyy') <= nov09) = 3;

may10 = datenum('05/01/2010','mm/dd/yyyy');
sep10 = datenum('09/30/2010','mm/dd/yyyy');
ETF14.RateSet.volatility(datenum(ETF14.RateSet.Date,'mm/dd/yyyy') >= may10 & datenum(ETF14.RateSet.Date,'mm/dd/yyyy') <= sep10) = 3;

july11 = datenum('07/01/2011','mm/dd/yyyy');
sep11 = datenum('09/06/2011','mm/dd/yyyy');
ETF14.RateSet.volatility(datenum(ETF14.RateSet.Date,'mm/dd/yyyy') >= july11 & datenum(ETF14.RateSet.Date,'mm/dd/yyyy') <= sep11) = 3;
