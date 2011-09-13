% compute rate of return basic statistics
% for low, medium, high volatilbility periods 

function ror_stats()
  load Partition_Feb05_Sep11;

  while (true) 
      disp('1) compute stats for 3 volatility periods');
      disp('9) box plots of return rate for 3 volatility periods');
      disp('-1) for exit');

      option_id = input('Enter option id: '); 
      
      switch option_id
        case -1
          break;
        case 1
          compute_stats(ETF14.Rate);
        case 9
          box_plots(ETF14.Rate);
        otherwise
          continue;
      end
  end
end

function box_plots(data)
  for i = 2:15    
    h = figure; 
    boxplot(double(data(:,i)), data.volatile);
    title(data.Properties.VarDescription{i}, 'FontSize',20,'FontWeight','b');
    xlabel([data.Properties.VarNames{i} ' - Volatility'],'FontSize',16);
    ylabel([data.Properties.VarNames{i} ' - rate of return (%)'],'FontSize',16);
    saveas(h,data.Properties.VarNames{i},'jpg');
  end  
end

function compute_stats(data)
  load Variables;
  
  stats.data =  data;
  
  data_vars = Variables(2:15,1);
  stats.datavars = data_vars;
  
  stat_vars = {@mean, 'sem', @std, @min, @max, @range, @median, 'meanci', 'predci'};
  stats.statvars = stat_vars;
  
  group = {'volatile'};
  stats.group = group;
  
  volatile_stat = grpstats(data,group,stat_vars, 'DataVars',data_vars);
  volatile_stat(:,{'volatile'})=[];  
  all_stat = grpstats(data,[],stat_vars, 'DataVars',data_vars);    
  stats.stat = [volatile_stat; all_stat];
  
  low_corr = 
  save('ror_feb05_sep11_stats','-v7.3','stats');
  correctairspeed
end
       

