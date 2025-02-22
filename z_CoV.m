clear all;
clc;

% Load data from CSV file
data = readtable('C:\\Users\\eynolds.csv');

% Extract unique z_positions and Reynolds numbers
z_positions = unique(data.z_position);
Reynolds_numbers = unique(data.Reynolds_number);

% Initialize figure
figure;
hold on;

% Loop through each Reynolds number
for i = 1:length(Reynolds_numbers)
    % Filter data for the current Reynolds number
    Re_data = data(data.Reynolds_number == Reynolds_numbers(i), :);
    
    % Calculate CoV for the current Reynolds number
    CoV = sqrt(Re_data.s2Prime2Mean) ./ Re_data.s2Mean;
    
    % Plot CoV against z_positions
    plot(Re_data.z_position, CoV, '-o', 'DisplayName', ['Re = ' num2str(Reynolds_numbers(i))]);
end

% Add labels, legend, and title
xlabel('z Position');
ylabel('CoV');
title('CoV vs z Position for Different Reynolds Numbers');
legend('show', 'Location', 'Best');
grid on;
hold off;

% Save the plot (optional)
saveas(gcf, 'CoV_vs_z_Position.png');
