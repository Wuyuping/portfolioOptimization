period     = input('Period (d/w/m): ', 's');
loadfile = strcat(period,'partition');
load (loadfile);      

if strcmpi(period, 'd')
  period = 'Daily';
elseif strcmpi(period, 'w')  
  period = 'Weekly';
elseif strcmpi(period, 'm')
  period = 'Monthly';  
end

AssetList = asset.Return.Properties.VarNames(2:end-3);
pReturns = double(asset.Return(:,AssetList));

DJReturns = asset.Return.DJI;
SP500Returns = asset.Return.SP500;

% market return and risk
djRet = mean(DJReturns);  
djRsk = std(DJReturns);   

spRet = mean(SP500Returns);  
spRsk = std(SP500Returns);   

p = Portfolio('AssetList', AssetList);
p = p.estimateAssetMoments(pReturns);

% Set up an equal-weight initial portfolio
p = p.setInitPort(1/p.NumAssets);
[ersk, eret] = p.estimatePortMoments(p.InitPort);

% Set up a portfolio optimization problem using setDefaultConstraints method.
% here fully-invested long-only portfolios . 
p = p.setDefaultConstraints;

% Estimate the efficient frontier 
pwgt = p.estimateFrontier(7);

% estimatePortMoments estimates risks and returns for portfolios. 
[prsk, pret] = p.estimatePortMoments(pwgt);

%% Subclassing the Portfolio Object
p = PortfolioDemo('AssetList', AssetList, 'RiskFreeRate', 0);
p = p.estimateAssetMoments(pReturns, 'missingdata', true);
p = p.setDefaultConstraints;
% p = p.setInitPort(1/p.NumAssets);

%  Maximize the Sharpe Ratio 1
swgt = p.maximizeSharpeRatio;
[srsk, sret] = p.estimatePortMoments(swgt);
ssratio = (sret - p.RiskFreeRate) / srsk;

% Plot efficient frontier with portfolio that attains maximum Sharpe ratio
% 	{'line', prsk, pret, {'Unconstrained'}, ':b'}, ...
mv_plot('Optimal portfolios (Unconstrained)', ...
	{'line', prsk, pret, {'Unconstrained'}, '--rs'}, ...
	{'scatter', srsk, sret, {'Sharpe'}}, ...  
	{'scatter', [djRsk, spRsk, ersk], [djRet, spRet, eret], {'Dow Jones', 'SP 500', 'Equal'}}, ...
	{'scatter', sqrt(diag(p.AssetCovar)), p.AssetMean, p.AssetList, '.r'});

% Assets in the maximum Sharpe ratio portfolio
Blotter = dataset({100*swgt(swgt > 0),'Weight'}, 'obsnames', AssetList(swgt > 0));
fprintf('Portfolio with Maximum Sharpe Ratio (Unconstrained) \n');
fprintf('(Return, Risk, Ratio) = (%5.3f, %5.3f, %5.3f) \n', sret, srsk, ssratio);
disp(Blotter);


%% efficient frontier 2
AssetIndex2 = ones(18,1);
excluded2 = [1,7, 16,17,18];
AssetIndex2(excluded2) = 0;
AssetIndex2 = logical(AssetIndex2);

AssetList2 = asset.Return.Properties.VarNames(AssetIndex2);
pReturns2 = double(asset.Return(:,AssetList2));

% Create a Portfolio object and estimate the mean and covariance of asset returns
p2 = Portfolio('AssetList', AssetList2);
p2 = p2.setDefaultConstraints;
p2 = p2.estimateAssetMoments(pReturns2);

A2 = [ ones(1,11), 0, 1 ];
b2 = 0.95;
p2 = p2.setEquality(A2, b2);

% Estimate the efficient frontier 
pwgt2 = p2.estimateFrontier(7);

% estimatePortMoments estimates risks and returns for portfolios. 
[prsk2, pret2] = p2.estimatePortMoments(pwgt2);

p2 = PortfolioDemo('AssetList', AssetList2, 'RiskFreeRate', 0);
p2 = p2.estimateAssetMoments(pReturns2, 'missingdata', true);
p2 = p2.setDefaultConstraints;
p2 = p2.setEquality(A2, b2);

%  Maximize the Sharpe Ratio 2
swgt2 = p2.maximizeSharpeRatio;
[srsk2, sret2] = p2.estimatePortMoments(swgt2);
ssratio2 = (sret2 - p2.RiskFreeRate) / srsk2;

% Plot efficient frontier with portfolio that attains maximum Sharpe ratio
% 	{'line', prsk, pret, {'Unconstrained'}, ':b'}, ...
mv_plot('Optimal portfolios with varios constraints ', ...
	{'line', prsk, pret, {'Unconstrained'}, '--rs'}, ...
	{'line', prsk2, pret2, {'5% IAU, 0% EWZ'}, '--bs'}, ... 
	{'scatter', srsk, sret, {'Sharpe'}}, ...  
	{'scatter', srsk2, sret2, {'Sharpe'}}, ... 
	{'scatter', [djRsk, spRsk, ersk], [djRet, spRet, eret], {'Dow Jones', 'SP 500', 'Equal'}}, ...
	{'scatter', sqrt(diag(p.AssetCovar)), p.AssetMean, p.AssetList, '.r'});

% Assets in the maximum Sharpe ratio portfolio
Blotter2 = dataset({100*swgt2(swgt2 > 0),'Weight'}, 'obsnames', AssetList2(swgt2 > 0));
fprintf('Portfolio with Maximum Sharpe Ratio (5 perccent IAU, No EWZ) \n');
fprintf('(Return, Risk, Ratio) = (%5.3f, %5.3f, %5.3f) \n', sret2, srsk2, ssratio2);
disp(Blotter2);


%% efficient frontier 3
AssetIndex3 = ones(18,1);
excluded3 = [1,7,13, 16,17,18];
AssetIndex3(excluded3) = 0;
AssetIndex3 = logical(AssetIndex3);

AssetList3 = asset.Return.Properties.VarNames(AssetIndex3);
pReturns3 = double(asset.Return(:,AssetList3));

% Create a Portfolio object and estimate the mean and covariance of asset returns
p3 = Portfolio('AssetList', AssetList3);
p3 = p3.setDefaultConstraints;
p3 = p3.estimateAssetMoments(pReturns3);


A3 = [ ones(1,10), 0, 1 ];
b3 = 0.95;
p3 = p3.setEquality(A3, b3);

% Estimate the efficient frontier 
pwgt3 = p3.estimateFrontier(7);

% estimatePortMoments estimates risks and returns for portfolios. 
[prsk3, pret3] = p3.estimatePortMoments(pwgt3);

p3 = PortfolioDemo('AssetList', AssetList3, 'RiskFreeRate', 0);
p3 = p3.estimateAssetMoments(pReturns3, 'missingdata', true);
p3 = p3.setDefaultConstraints;
p3 = p3.setEquality(A3, b3);

%  Maximize the Sharpe Ratio 3
swgt3 = p3.maximizeSharpeRatio;
[srsk3, sret3] = p3.estimatePortMoments(swgt3);
ssratio3 = (sret3 - p3.RiskFreeRate) / srsk3;

% Plot efficient frontier with portfolio that attains maximum Sharpe ratio
% 	{'line', prsk, pret, {'Unconstrained'}, ':b'}, ...
title = strcat(period, ' Optimal portfolios in different situations ');
mv_plot(title, ...
	{'line', prsk, pret, {'Unconstrained'}, '--rs'}, ...
	{'line', prsk2, pret2, {'5% IAU, 0% EWZ'}, '--gs'}, ... 
	{'line', prsk3, pret3, {'5% IAU, 0% EWZ, 0% AGG'}}, ...   
	{'scatter', srsk, sret, {'Sharpe'}}, ...  
	{'scatter', srsk2, sret2, {'Sharpe'}}, ... 
	{'scatter', srsk3, sret3, {'Sharpe'}}, ...   
	{'scatter', [djRsk, spRsk, ersk], [djRet, spRet, eret], {'Dow Jones', 'SP 500', 'Equal'}}, ...
	{'scatter', sqrt(diag(p.AssetCovar)), p.AssetMean, p.AssetList, '.r'});

% Assets in the maximum Sharpe ratio portfolio
Blotter3 = dataset({100*swgt3(swgt3 > 0),'Weight'}, 'obsnames', AssetList3(swgt3 > 0));
fprintf('Portfolio with Maximum Sharpe Ratio (5 perccent IAU, No EWZ, No AGG) \n');
fprintf('(Return, Risk, Ratio) = (%5.3f, %5.3f, %5.3f) \n', sret3, srsk3, ssratio3);
disp(Blotter3);

stat = dataset({cellstr('Dow Jones'), 'Portfolio'},{djRet, 'Return'}, {djRsk, 'Risk'});
stat = vertcat(stat, dataset({cellstr('SP 500'), 'Portfolio'},{spRet, 'Return'}, {spRsk, 'Risk'}));
stat = vertcat(stat, dataset({cellstr('Equal-weight'), 'Portfolio'},{eret, 'Return'}, {ersk, 'Risk'}));
stat = vertcat(stat, dataset({p.AssetList', 'Portfolio'},{p.AssetMean, 'Return'}, {sqrt(diag(p.AssetCovar)), 'Risk'}));
stat = vertcat(stat, dataset({cellstr('Max Sharpe Ratio - Unconstrained'), 'Portfolio'}, {sret, 'Return'}, {srsk, 'Risk'}));
stat = vertcat(stat, dataset({cellstr('Max Sharpe Ratio - 5 perccent IAU - No EWZ'), 'Portfolio'},{sret2, 'Return'}, {srsk2, 'Risk'}));
stat = vertcat(stat, dataset({cellstr('Max Sharpe Ratio - 5 perccent IAU - No EWZ - No AGG'), 'Portfolio'},{sret3, 'Return'}, {srsk3, 'Risk'}));
file_name = strcat(period, 'SharpeRatio.csv');
export(stat,'file',file_name,'Delimiter',',');
display(stat);




