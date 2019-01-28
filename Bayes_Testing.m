% CSCI HW1-4
% Bayes_testing
% Peixuan Zhang


function [ test_err_out] = Bayes_Testing(test_data, p1,p2,pc1,pc2 )


% calculate the posterior probability 
% from a test set as a N by 2 matrix, 
% N samples, 2 classes
P_c_x=ones(size(test_data, 1),2);
n4 = size(test_data,1);
n5 = size(test_data,2);

for k= 1:n4
    for j=1:n5-1
        P_c_x(k,1)=P_c_x(k,1)* p1(j).^(1-test_data(k,j))* (1-p1(j)).^(test_data(k,j));
    end
end
P_c_x(:,1)=P_c_x(:,1)*pc1;

for k= 1:n4
    for j=1:n5-1
        P_c_x(k,2)=P_c_x(k,2)* p2(j).^(1-test_data(k,j))* (1-p2(j)).^(test_data(k,j));
    end
end
P_c_x(:,2)=P_c_x(:,2)*pc2;

% compare c1 and c2 column 
% choose the larger one and stored it in 3nd column
for k=1:size(P_c_x,1)
    if P_c_x(k,1)>P_c_x(k,2)
        P_c_x(k,3)=1;
    else
        P_c_x(k,3)=2;
    end
end
%calculate the error rate and print
test_err=sum(sum(P_c_x(:,3)~=test_data(:,end)))/size(test_data,1);
test_err_out=sprintf('%.4f',test_err)
end
