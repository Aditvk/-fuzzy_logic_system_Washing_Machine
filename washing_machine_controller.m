%% Fuzzy Logic Washing Machine Controller
clc; clear; close all;

%% 1. Create Mamdani FIS Object
fis = mamfis('Name', 'WashingMachine', ...
               'AndMethod', 'min', ...
               'OrMethod', 'max', ...
               'ImplicationMethod', 'min', ...
               'AggregationMethod', 'max', ...
               'DefuzzificationMethod', 'centroid');

%% 2. Add Input 1: Dirt Level [0, 100]
fis = addInput(fis, [0 100], 'Name', 'DirtLevel');
fis = addMF(fis, 'DirtLevel', 'trapmf', [0 0 20 45],  'Name', 'Low');
fis = addMF(fis, 'DirtLevel', 'trimf',  [25 50 75],   'Name', 'Medium');
fis = addMF(fis, 'DirtLevel', 'trapmf', [55 80 100 100], 'Name', 'High');

%% 3. Add Input 2: Load Size [0, 10]
fis = addInput(fis, [0 10], 'Name', 'LoadSize');
fis = addMF(fis, 'LoadSize', 'trapmf', [0 0 2 4.5],  'Name', 'Small');
fis = addMF(fis, 'LoadSize', 'trimf',  [3 5 7],      'Name', 'Medium');
fis = addMF(fis, 'LoadSize', 'trapmf', [5.5 8 10 10], 'Name', 'Large');

%% 4. Add Output: Cycle Time [0, 60]
fis = addOutput(fis, [0 60], 'Name', 'CycleTime');
fis = addMF(fis, 'CycleTime', 'trapmf', [0 0 10 20],   'Name', 'Short');
fis = addMF(fis, 'CycleTime', 'trimf',  [20 30 40],    'Name', 'Medium');
fis = addMF(fis, 'CycleTime', 'trapmf', [35 50 60 60], 'Name', 'Long');

%% 5. Define Fuzzy Rules
% Format: [in1 in2 out weight connection(1=AND)]
% Indices: Dirt(1=Low,2=Med,3=High), Load(1=Small,2=Med,3=Large), Cycle(1=Short,2=Med,3=Long)
ruleList = [
    1 1 1 1 1;  % R1: Low & Small -> Short
    1 2 1 1 1;  % R2: Low & Med -> Short
    1 3 2 1 1;  % R3: Low & Large -> Med
    2 1 1 1 1;  % R4: Med & Small -> Short
    2 2 2 1 1;  % R5: Med & Med -> Med
    2 3 2 1 1;  % R6: Med & Large -> Med
    3 1 2 1 1;  % R7: High & Small -> Med
    3 2 3 1 1;  % R8: High & Med -> Long
    3 3 3 1 1;  % R9: High & Large -> Long
];
fis = addRule(fis, ruleList);

%% 6. Export FIS File
writeFIS(fis, 'WashingMachine');
disp('FIS successfully saved to WashingMachine.fis');

%% 7. Show Outputs (Requirement: Show MFs and Rule Viewer)
% Plot Membership Functions
figure('Name', 'Membership Functions', 'NumberTitle', 'off');
subplot(1,3,1); plotmf(fis, 'input', 1); title('Dirt Level');
subplot(1,3,2); plotmf(fis, 'input', 2); title('Load Size');
subplot(1,3,3); plotmf(fis, 'output', 1); title('Cycle Time');

% Open Interactive Rule Viewer
ruleview(fis);

%% 8. Console Output Tests
disp('--- Sample Test Evaluations ---');
tests = [10 2; 50 5; 85 9];
for i = 1:size(tests,1)
    result = evalfis(fis, tests(i,:));
    fprintf('Dirt Level: %2d, Load Size: %dkg --> Cycle Time: %.1f minutes\n', tests(i,1), tests(i,2), result);
end
