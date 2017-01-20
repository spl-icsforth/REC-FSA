%%%%%%%%%%%%%%%%%%%%%%%%%%
% This is the MATLAB version of the REC-FSA algorithm, described in the
%paper "Feature Selection for Performance Characterization in Multi-hop 
%Wireless Sensor Networks", by Panousopoulou, A; Azkune M.; and Tsakalides, P., 
%published at Ad Hoc Networks, 49 , pp. 70 - 89, 2016, ISSN: 1570-8705
%
%FORTH-ICS, Signal Processing Lab, 2014.

%Contact address: Nancy Panousopoulou, apanouso@ics.forth.gr

% If you find any of this dataset useful for your research, please give
% credit in your publications where it is due, using the following
% reference:
%@article{Panousopoulou_2016b,
%title = {Feature Selection for Performance Characterization in Multi-hop Wireless Sensor Networks},
%author = {Panousopoulou, Athanasia and Azkune, Mikel and Tsakalides, Panagiotis},
%issn = {1570-8705},
%year = {2016},
%date = {2016-06-21},
%journal = {Ad Hoc Networks},
%volume = {49},
%pages = {70 - 89}
%}


%%%%%%%%%%%%%%%%%%%%%%%%%
%The present main script demonstrates the use of the algorithm, which is
%implemented in the RepEntFSalgCluster.m file.
%
%Input data: Datasets of network features, extracted from WSN measurements
%at an industrial environment during the period 05-06/06/2014.
%Network monitoring traffic including, metrics from the Physical, MAC, and NWK layers, 
%as well as ambient sensors readings (temperature and humidity) and voltage threshold on each sensor node.
%The traffic recorded is related to the links established at the application layer between each node (id = 1,2,..10) and a sink node. 
%The traffic is recorded at the sink node.
%The data are available at https://github.com/apanouso/wsn-indfeat-dataset,
%where their format is also analytically described.
%
%Output: for each file with data attributes the indices of the dominant
%values are stored, along with the representation entropy of the compressed
%clusters and the representation entropy of the dominant attributes.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear;clc;close all;



%the directory where datasets are stored.
experiments={'../datasets/'};
normindex_feature = 11; %this attribute does not need z-score normalization.
method = 'hrcluster';
for ee=1:length(experiments)
tmp=[];
for i=1:10 %number of nodes
    disp('*********************************')
    disp(['current node: ' num2str(i)])
    tmp = [experiments{ee} 'node' num2str(i) '.csv'];
    if exist(tmp, 'file') == 2
        inputdata = csvread(tmp);
        disp('Data size before check:')
        disp(size(inputdata))
        disp('>>>>>>>>>>>Sanity check & z-score normalization:')
        %sanity check: data should not contain NaN values and should have
        %some variance (column-wise)
        checkNaN = isnan(inputdata);
        row2remove=[];
        for rr = 1:size(checkNaN,1)
            if isempty(nonzeros(any(checkNaN(rr,:)))) == 0
                row2remove = [row2remove;rr];
            end
        end
        %remove the rows that contain at least 1 NaN element.
        inputdata(row2remove,:) =[];
        %check the variance of the features.
        col2remove=[];
        for cc = 1:size(inputdata,2)-1
            if var(inputdata(:,cc),1) <=1e-6 
                col2remove=[col2remove cc];
            else
                  if cc ~= normindex_feature
                    inputdata(:,cc) = (inputdata(:,cc) - min(inputdata(:,cc))) / (max(inputdata(:,cc)) - min(inputdata(:,cc)));
           end
            end
        end
   
        disp('<<<<<<<<<<<<<<<<<')
        inputdata(:, col2remove)=[];
        disp('Data size after check:')
        disp(size(inputdata))
         disp('>>>>>>>>>>>Entering FSA:')

           k=8; %the value of the k parameter.
           disp(['Value of k parameter: '  num2str(k)])
           %and this is the function call to REC-FSA
           [r, hrin, hrout]=RepEntFSalgCluster(inputdata(:,1:end-1),k);
           %store the reduced feature set (relative with respect to the
           %col2remove contents)
            eval(['reduced_node' num2str(i) '_k' num2str(k) '= r;'])
            %store the representation entropy of the clusters
            eval(['hrin_node' num2str(i) '_k' num2str(k) '= hrin;'])
            %store the representation entropy of the dominant set.
            eval(['hrout_node' num2str(i) '_k' num2str(k) '= hrout;'])
            
        
        
    end
    disp('*********************************')
end
savepath = [experiments{ee}  method '_allks.mat'];
eval(['save ' savepath])
end
