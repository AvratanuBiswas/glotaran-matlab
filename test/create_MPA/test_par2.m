clear all;
clc;
%% Excitation
strucm = struct();
strucp.Excitation{1} = 1;
strucp.Excitation{2} = 0;
strucp.Excitation{3} = 0;
strucp.Excitation{4} = '{vary: False, non-negative: False}';
% strucp.Excitation = [1; 0; 0];
%  strucp.Excitation = 1;
%  strucp.Excitation.b = 0;
% strucp.Excitation.c = 0
% strucp.Excitation.vary{1,4} = 'false'
% irf
strucp.irf = [68;4;12800] ;


% k
strucp.kinetic = [0.1; 0.05; 0.002];

%

WriteYaml('xyz_parameter.yaml',strucp,0)
% WriteYaml('xyz_parameter.txt',strucp,0)
open xyz_parameter.yaml
%%
  !glotaran print -p 'xyz_parameter.yaml' 
%  !glotaran validate -m xyz_model.yaml -p xyz_parameter2.yaml
%  !glotaran optimize xyz_analysis.yaml
