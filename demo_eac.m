close all;
clear all;

wdir='./Datasets/';

% % listData={'Aggregation.txt', 'Compound.txt', 'D31.txt',...
% %     'flame.txt', 'jain.txt', 'pathbased.txt',...
% %     'R15.txt', 'spiral.txt'};

listData={'Aggregation.txt', 'Compound.txt', 'jain.txt', 'R15.txt', 'spiral.txt'};

numData=numel(listData);

figure,
for ii=1:numData
    fnData=listData{ii};
    data=dlmread([wdir, fnData]);
    data=data(:,1:2);
    [CC, cooMat, Z]=func_EAC_Clustering(data,200,2:50);
    subplot(3,numData,ii+0*numData), scatter(data(:,1), data(:,2), 30, CC, 'filled'), title(fnData);
    subplot(3,numData,ii+1*numData), imagesc(cooMat),   title(fnData);
    subplot(3,numData,ii+2*numData), dendrogram(Z),     title(fnData);
    drawnow;
end
