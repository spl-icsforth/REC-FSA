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


%  function [SelectFeat HrIn HrOut]=RepEntFSalgCluster(origDataSet,k)
%  origDataSet is the original data set (NumInst x NumFeat)  
%  k is the scale parameter which decides the size of the reduced feature
%  set
%  SelectFeat is the reduced set, the features tha are choosen
%  HrIn is the array fill by the normalized representational entropyes of the clusters
%  HrOut is the normalized reprentational entropy ofthe reduced set 
%
%  The Algorithm for each value of k (starting from the one fixed by the
%  user and decreasing until 1) creates the cluster fixing the clusterhead
%  and including the k nearest features regarding to representation
%  entropy.
%  Written by Mikel Azkune (2014, Forth Greece)



function [SelectFeat HrIn HrOut]=RepEntFSalgCluster(origDataSet,k)
[numInst numFeat]=size(origDataSet);

DataSet=origDataSet;
alg=1;
GraphMode=0;%to make a graphical demostration of the algorithm
%Set up the Variables
RedSet=1:numFeat;
ActFeat=numFeat;
SelectFeat=[];
HrIn=[];
MeanSimCL=[];
HrOut=0;
PrevValue=99;
drift=1;%To change the criterium of the quality of the cluster



%Entropy MEASURE:(create the adjacency matrix)
EntropyMat=[];
for i=1:numFeat
    for j=1:i
        if j==i
            EntropyMat(i,i)=999;
        else
            TMPMAT=[origDataSet(:,i) origDataSet(:,j)];
            TMPENT=repent(TMPMAT);
            EntropyMat(j,i)=TMPENT(2);
        end
    end
end

for i=2:numFeat
    for j=1:i
        EntropyMat(i,j)=EntropyMat(j,i);
    end
end

%Display the features
if GraphMode==1
    SqNumFeat=ceil(sqrt(numFeat));
    [xx,yy] = meshgrid(1:SqNumFeat,1:SqNumFeat);
    xy = [reshape(xx, SqNumFeat^2,1) reshape(yy,SqNumFeat^2,1)];
    xy = xy(1:numFeat,:);
    xy(2:2:end) = xy(2:2:end)+0.5;
    minxY=min(xy(:,2))-0.5;
    maxxY=max(xy(:,2))+0.5;
    minXy=min(xy(:,1))-0.5;
    maxXy=max(xy(:,1))+0.5;
    figure;
    plot(xy(:,1),xy(:,2), 'ro', 'MarkerFaceColor','r')
    title('Display of the Features');
    ylim([minxY,maxxY]);
    xlim([minXy,maxXy]);
    pause
end

%If the value of k is too big , set the biggest one
if k>numFeat-2
    k=numFeat-2;
    disp('The value of K was too big');
    pause;
end

%the begining of the Algorithm
while(alg==1)
    
    Rank=repentropyfeatsel(DataSet);
    mntFeat=Rank(1);% Fix the clusterhead

    ClusterHr=[];
    for i=1:ActFeat%calculate the pairwise Hr with the clusterhead
        if RedSet(i) ~= RedSet(mntFeat)
            FeatMat=[origDataSet(:,RedSet(mntFeat)), origDataSet(:,RedSet(i))];
            mntHr=repent(FeatMat);
        else
            mntHr=[99 99];
        end
        ClusterHr=[ClusterHr, mntHr(2)];
    end
   ClusterHr;
    
    [Values,Index]=sort(ClusterHr);
    
    removeFeat=Index(1:k);
    
        
    if Values(k) < PrevValue %The cluster is good enough to remove
        PrevValue=Values(k);%Set the new PrevValue
        RealRem=[];
        Cluster=[];
        for i=1:size(removeFeat,2) %Take the real features of the Cluster           
            RealRem=[RealRem, RedSet(removeFeat(i))];
            Cluster=[Cluster, origDataSet(:,RealRem(i))];
        end
        RealmntFeat=RedSet(mntFeat);
        Cluster=[Cluster, origDataSet(:,RealmntFeat)];
        
        
        %%%%%%%%Graphic display!
        if GraphMode==1
            RealCluster=[RealRem, RealmntFeat];            
            WhiteFeat=setdiff(RedSet,RealCluster);
            ClAdj=zeros(numFeat, numFeat);
            ClAdj(:,RealmntFeat)=EntropyMat(:,RealmntFeat);ClAdj(RealmntFeat,:)=EntropyMat(RealmntFeat,:);
            ClAdj(:,WhiteFeat)=0;ClAdj(WhiteFeat,:)=0;
            xy2=xy;
            xy2=xy(RedSet,:);
        
            gplot(ClAdj, xy, 'b--')
            hold on
            plot(xy2(:,1),xy2(:,2), 'ro', 'MarkerFaceColor','r')
            plot(xy(RealmntFeat,1),xy(RealmntFeat,2), 'go', 'MarkerFaceColor','g')
            title('The Cluster according to the pairwise Entropy');
            ylim([minxY,maxxY]);
            xlim([minXy,maxXy]);
            pause
            EntropyMat(RealRem,:)=0;EntropyMat(:,RealRem)=0;
        end
           
        %Remove the features from the reduced set
        for i=1:k
            RedSet(removeFeat(i))=0;
        end
        RedSize=size(RedSet,2);
        for i=1:RedSize
                if RedSet(RedSize-i+1)==0
                 RedSet(RedSize-i+1)=[];
                 DataSet(:,RedSize-i+1)=[];
                end
        end
        
        ActFeat=ActFeat-k;
        

        %Fill the Hrin
        ClusterInHr=repent(Cluster);
        ClusterInHr=ClusterInHr(2);
        ClusterInHr;
        HrIn=[HrIn ClusterInHr];
        
        

        %Set the next k parameter
        k=k-1;
        if k>ActFeat-1
            k=ActFeat-1;
        end
        if GraphMode==1
            xy2=xy;
            xy2=xy(RedSet,:);
            hold off;
            plot(xy2(:,1),xy2(:,2), 'ro', 'MarkerFaceColor','r')
            title('The Active Features')
            ylim([minxY,maxxY]);
            xlim([minXy,maxXy]);
            pause;
        end
        
    else%The cluster is not good enough to remove
        k=k-1;
    end

    if k==1% end of the algorithm
        alg=0;
    end
    
end
%Fill the output variables
SelectFeat=RedSet;
OutData=[];

for i=1:size(SelectFeat,2)
    OutData=[OutData, origDataSet(:,SelectFeat(i))];
end
    
HrOut=repent(OutData);
HrOut=HrOut(2);
if GraphMode==1
    RemovedFeat=setdiff(1:numFeat,SelectFeat);
    xy(RemovedFeat,:)=[];
    hold off
    plot(xy(:,1),xy(:,2), 'ro', 'MarkerFaceColor','r')
    title('The Output Display of the features');
    ylim([minxY,maxxY]);
    xlim([minXy,maxXy]);
    pause;
    close;
end

end
