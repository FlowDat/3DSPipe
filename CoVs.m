% Define folder names and corresponding Reynolds numbers
folderNames = {'ico_75', 'ico_100' ,'ico_125', 'ico_175' }; % Add more folders as needed
ReynoldsNumbers = [75, 100, 125, 175] ; % Add corresponding Reynolds numbers

% Initialize arrays to store results for all scalar fields
Re_CoV_s1 = []; % To store CoV for s1 vs Reynolds
Re_CoV_s2 = []; % To store CoV for s2 vs Reynolds
Re_CoV_s3 = []; % To store CoV for s3 vs Reynolds
Re_CoV_s4 = []; % To store CoV for s4 vs Reynolds
Re_CoV_s5 = []; % To store CoV for s5 vs Reynolds
Re_CoV_s6 = []; % To store CoV for s6 vs Reynolds

for i = 1:length(folderNames)
    folder = folderNames{i};
    files = dir(fullfile(folder, 'overline_z*.csv')); % Get list of CSV files in folder

    % Initialize variables for averaging CoV across all CSV files in folder
    CoV_s1_vals = [];
    CoV_s2_vals = [];
    CoV_s3_vals = [];
    CoV_s4_vals = [];
    CoV_s5_vals = [];
    CoV_s6_vals = [];
    
    for j = 1:length(files)
        % Load data from each CSV file
        data = readtable(fullfile(folder, files(j).name));
        
        % Calculate CoV for s1 to s6, manually removing NaN values
        s1MeanValid = data.s1Mean(~isnan(data.s1Mean) & ~isnan(data.s1Prime2Mean));
        s1Prime2MeanValid = data.s1Prime2Mean(~isnan(data.s1Mean) & ~isnan(data.s1Prime2Mean));
        CoV_s1 = mean(sqrt(s1Prime2MeanValid) ./ s1MeanValid);
        
        s2MeanValid = data.s2Mean(~isnan(data.s2Mean) & ~isnan(data.s2Prime2Mean));
        s2Prime2MeanValid = data.s2Prime2Mean(~isnan(data.s2Mean) & ~isnan(data.s2Prime2Mean));
        CoV_s2 = mean(sqrt(s2Prime2MeanValid) ./ s2MeanValid);
        
        s3MeanValid = data.s3Mean(~isnan(data.s3Mean) & ~isnan(data.s3Prime2Mean));
        s3Prime2MeanValid = data.s3Prime2Mean(~isnan(data.s3Mean) & ~isnan(data.s3Prime2Mean));
        CoV_s3 = mean(sqrt(s3Prime2MeanValid) ./ s3MeanValid);
        
        s4MeanValid = data.s4Mean(~isnan(data.s4Mean) & ~isnan(data.s4Prime2Mean));
        s4Prime2MeanValid = data.s4Prime2Mean(~isnan(data.s4Mean) & ~isnan(data.s4Prime2Mean));
        CoV_s4 = mean(sqrt(s4Prime2MeanValid) ./ s4MeanValid);
        
        s5MeanValid = data.s5Mean(~isnan(data.s5Mean) & ~isnan(data.s5Prime2Mean));
        s5Prime2MeanValid = data.s5Prime2Mean(~isnan(data.s5Mean) & ~isnan(data.s5Prime2Mean));
        CoV_s5 = mean(sqrt(s5Prime2MeanValid) ./ s5MeanValid);
        
        s6MeanValid = data.s6Mean(~isnan(data.s6Mean) & ~isnan(data.s6Prime2Mean));
        s6Prime2MeanValid = data.s6Prime2Mean(~isnan(data.s6Mean) & ~isnan(data.s6Prime2Mean));
        CoV_s6 = mean(sqrt(s6Prime2MeanValid) ./ s6MeanValid);
        
        % Store CoV values for averaging later
        CoV_s1_vals = [CoV_s1_vals; CoV_s1];
        CoV_s2_vals = [CoV_s2_vals; CoV_s2];
        CoV_s3_vals = [CoV_s3_vals; CoV_s3];
        CoV_s4_vals = [CoV_s4_vals; CoV_s4];
        CoV_s5_vals = [CoV_s5_vals; CoV_s5];
        CoV_s6_vals = [CoV_s6_vals; CoV_s6];
    end
    
    % Compute mean CoV for the entire folder (Reynolds number), ignoring NaNs
    CoV_s1_vals = CoV_s1_vals(~isnan(CoV_s1_vals));
    CoV_s2_vals = CoV_s2_vals(~isnan(CoV_s2_vals));
    CoV_s3_vals = CoV_s3_vals(~isnan(CoV_s3_vals));
    CoV_s4_vals = CoV_s4_vals(~isnan(CoV_s4_vals));
    CoV_s5_vals = CoV_s5_vals(~isnan(CoV_s5_vals));
    CoV_s6_vals = CoV_s6_vals(~isnan(CoV_s6_vals));
    
    % Store the mean CoV for each scalar field
    Re_CoV_s1 = [Re_CoV_s1; mean(CoV_s1_vals)];
    Re_CoV_s2 = [Re_CoV_s2; mean(CoV_s2_vals)];
    Re_CoV_s3 = [Re_CoV_s3; mean(CoV_s3_vals)];
    Re_CoV_s4 = [Re_CoV_s4; mean(CoV_s4_vals)];
    Re_CoV_s5 = [Re_CoV_s5; mean(CoV_s5_vals)];
    Re_CoV_s6 = [Re_CoV_s6; mean(CoV_s6_vals)];
end
 
ANS= Re_CoV_s1+Re_CoV_s2+Re_CoV_s3+Re_CoV_s4+Re_CoV_s5+Re_CoV_s6;


% Plot CoV for all scalars vs. Reynolds numbers
figure;
%plot(ReynoldsNumbers, Re_CoV_s1, '-o', 'LineWidth', 1.5, 'DisplayName', 's1');
hold on;
plot(ReynoldsNumbers, Re_CoV_s2, '-^', 'LineWidth', 1.5, 'DisplayName', 's2');
%plot(ReynoldsNumbers, Re_CoV_s3, '-o', 'LineWidth', 1.5, 'DisplayName', 's3');
%plot(ReynoldsNumbers, Re_CoV_s4, '-s', 'LineWidth', 1.5, 'DisplayName', 's4');
%plot(ReynoldsNumbers, Re_CoV_s5, '-d', 'LineWidth', 1.5, 'DisplayName', 's5');
%plot(ReynoldsNumbers, Re_CoV_s6, '-x', 'LineWidth', 1.5, 'DisplayName', 's6');
%plot(ReynoldsNumbers, ANS/6/8, '-x', 'LineWidth', 1.5, 'DisplayName', 'CoV');
xlabel('Reynolds Number');
ylabel('Coefficient of Variance (CoV)');
title('CoV vs. Reynolds Number');
legend;
grid on;
