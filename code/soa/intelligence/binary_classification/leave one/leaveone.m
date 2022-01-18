load  Competition_train.mat
X=permute(X,[3,2,1]);
N = size(X);
M = N(3);
K = fix(M/5);
X1=X(:,:,M-K+1:M);
X(:,:,M-K+1:M)=[];
Y1=Y(M-K+1:M,:);
Y(M-K+1:M,:)=[];
save('1_for_test.mat','X1');
save('1_result.mat','Y1');
save('4_for_train.mat','X','Y');