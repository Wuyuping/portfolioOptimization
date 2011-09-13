% compute rate of return basic statistics
% for low, medium, high volatilbility periods 

function ror_stats()
  load Partition_Feb05_Sep11;

  while (true) 
      disp(' 1) compute stats for 3 volatility periods');
      disp(' 2) show stats for 3 volatility periods');
      disp(' 3) export stats (to excel) for 3 volatility periods');
      disp(' 9) box plots of return rate for 3 volatility periods');
      disp('-1) for exit');

      option_id = input('Enter option id: ');
      
      switch option_id
        case -1
          break;
        case 1
          compute_stats(ETF14.Rate);
        case 3
          export_stats();          
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
  
  stat_vars = {'mean', 'sem', 'std', 'min', 'max', 'range', 'median', 'meanci', 'predci'};
  stats.statvars = stat_vars;
  
  group = {'volatile'};
  stats.group = group;
  
  volatile_stat = grpstats(data,group,stat_vars, 'DataVars',data_vars);
  volatile_stat(:,{'volatile'})=[];  
  all_stat = grpstats(data,[],stat_vars, 'DataVars',data_vars);  
  stat = [volatile_stat; all_stat];
  
  for stat_var = stat_vars 
    new_data_vars = strcat(stat_var, '_', data_vars);
    new_data_vars{15} = 'GroupCount';
    newdataset = stat(:, new_data_vars);
    fname = char(strcat('stat_', stat_var));
    stats.(fname) = newdataset;
  end
  
  low_vol_dat = data(data.volatile=='low', data_vars);
  low_cov = cov(double(low_vol_dat(2:end,:)));
  low_cov_dataset = dataset({low_cov,data_vars{:}},'ObsNames',data_vars);  
  stats.low_cov = low_cov_dataset;   
  [~, low_corr] = cov2corr(low_cov);
  low_corr_dataset = dataset({low_corr,data_vars{:}},'ObsNames',data_vars);
  stats.low_corr = low_corr_dataset;
  
  med_vol_dat = data(data.volatile=='medium', data_vars);
  med_cov = cov(double(med_vol_dat));  
  med_cov_dataset = dataset({med_cov,data_vars{:}},'ObsNames',data_vars);
  stats.med_cov = med_cov_dataset;
  [~, med_corr] = cov2corr(med_cov);
  med_corr_dataset = dataset({med_corr,data_vars{:}},'ObsNames',data_vars);
  stats.med_corr = med_corr_dataset;

  
  hi_vol_dat = data(data.volatile=='high', data_vars);
  hi_cov = cov(double(hi_vol_dat));
  hi_cov_dataset = dataset({hi_cov,data_vars{:}},'ObsNames',data_vars);
  stats.hi_cov = hi_cov_dataset;
  [~, hi_corr] = cov2corr(hi_cov);
  hi_corr_dataset = dataset({hi_corr,data_vars{:}},'ObsNames',data_vars);
  stats.hi_corr = hi_corr_dataset;

  all_dat = data(2:end, data_vars);
  all_cov = cov(double(all_dat));
  cov_dataset = dataset({all_cov,data_vars{:}},'ObsNames',data_vars);
  stats.all_cov = cov_dataset;
  [~, all_corr] = cov2corr(all_cov);
  corr_dataset = dataset({all_corr,data_vars{:}},'ObsNames',data_vars);
  stats.all_corr = corr_dataset;
    
  save('stats_feb05_sep11','-v7.3','stats');
end
       
function export_stats()
  load stats_feb05_sep11;
  
  fnames=fieldnames(stats);
  file_names = strcat(fnames, '.csv');
  
  for i=5:length(fnames)
    mydataset = stats.(fnames{i});
    file_name = file_names{i};
    export(mydataset,'file',file_name,'Delimiter',',');
  end
end

