% compute rate of return basic statistics
% for low, medium, high volatilbility periods 

function ror_stats()
  load Variables;
  load Partition_Feb05_Sep11;

  while (true) 
      disp('1) compute stats for low volatility period');
      disp('2) compute stats for medium volatility period');
      disp('3) compute stats for high volatility period');
      disp('4) compute stats for all periods ');      
      disp('9) box plots of return rate for 3 volatility periods');
      disp('-1) for exit');

      option_id = input('Enter option id: '); 
      if option_id == -1
          break;
      end

      if option_id == 9
          box_plots(ETF14.Rate);
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