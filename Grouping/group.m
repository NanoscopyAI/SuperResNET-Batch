addpath("Grouping");

% Options
% "numPnts", "minRc", "maxRc", "meanRc", "medianRc", "StdRc", "FA", ...
% "Cl", "Cp", "Cs", "Vol", "avgDeg", "maxDeg", "minDeg", "charPath", ...
% "avgEcc", "rad", "diam", "avgCC", "maxCC", "minCC", "density", "trans", "mod", ...
% "avgModOpt", "z_range", "y_range", "x_range", "hollowness", "blobArea"

    
%Fill with whatever features you want to use. Use double quotes. SRN doesnt have volume on default
used_features = ["numPnts", "minRc", "maxRc", "meanRc", "medianRc", "StdRc", "FA", ...
                "Cl", "Cp", "Cs", "avgDeg", "maxDeg", "minDeg", "charPath", ...
                "avgEcc", "rad", "diam", "avgCC", "maxCC", "minCC", "density", "trans", "mod", ...
                "avgModOpt", "z_range", "y_range", "x_range", "hollowness"]; 



%Example
% INFO: These contain the parent folders containing the batch output for a given condition
% cond1 = ["c:/document/data/destination/cond1_1", "c:/document/data/destination/cond1_2"];
% cond2 = ["c:/document/data/destination/cond2_1", "c:/document/data/destination/cond2_2"];            
% 
% INFO: Number of groups you want to be classified                        
% number_of_groups = 4;
% INFO: When classifying, whether or not to normalize the features.
% normalize_features = true;
%
% INFO: Only use files containing this key
% file_key = 'condition' 

% c2 = getGroupCenters(cond2, used_features, number_of_groups, normalize_features, file_key);
% applyGroupMembership('condition2', cond2, c2, file_key)
% 
% %or apply groups based on only cond1 features
% c = getGroupCenters(cond1, used_features, number_of_groups, normalize_features, file_key);
% applyGroupMembership('condition1', cond1, c, file_key)
% applyGroupMembership('condition2', cond2, c, file_key)
%
% %can then combine all csv within the given parent folder
%combine_csv('combined_csv_name.csv', 'c:/document/data/', file_key)
