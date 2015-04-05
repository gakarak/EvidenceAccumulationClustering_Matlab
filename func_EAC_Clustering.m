function [ cls, cooMat, Z ] = func_EAC_Clustering( dataX, numIter, listK )
%FUN_EAC_CLUSTERING Evidence Accumulation Clustering
%   dataX:      data samples
%   numIter:    number of k-means iterations
%   listK:      number of classes for k-mens alrogithm
    numData=size(dataX,1);
    numK=numel(listK);
    cooMat=zeros(numData,numData);
    for ii=1:numIter
        tmpK=listK(randi(numK,1,1));
        tmpIDX=kmeans(dataX,tmpK);
        cooMat=cooMat+double((repmat(tmpIDX,1,numData)-repmat(tmpIDX',numData,1))==0);
% %         fprintf('%d/%d\n',ii,numIter);
    end
    cooMat=max(cooMat(:))-cooMat;
    cooMat(eye(size(cooMat))==1)=0;
    cooDst=squareform(cooMat,'tovector');
    Z=linkage(cooDst,'single');
    dZ=abs(diff(flip(Z(:,3))));
    [RR,~]=find(dZ==max(dZ));
    numC=1+RR;
    cls = cluster(Z,'maxclust', numC);
end
