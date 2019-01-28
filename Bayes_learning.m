% CSCI HW1-4
% Bayes_learning
% Peixuan Zhang


function[sigma_min,p1,p2,pc1,pc2] =Bayes_learning(training_data, validation_data)
% calculate the P_ij as p1 and p2 for Bernoulli densities from training set
% i = 1, 2; j = 1,... n
% p1: learned Bernoulli parameters of the first class
% p2: learned Bernoulli parameters of the second class
n1 = size(training_data,2); % number of columns for the training data
p1 = zeros(n1-1,1);
p2 = zeros(n1-1,1);
sigma_min = 0;
for j = 1: n1-1
    p1(j) = p1(j)+sum( (training_data(:,j)==0)& (training_data(:,n1)==1) )/sum(sum(training_data(:,n1)==1));
end
for j = 1: size(training_data,2)-1
    p2(j)=p2(j)+sum( (training_data(:,j)==0)& (training_data(:,n1)==2) )/sum(sum(training_data(:,n1)==2));
end

% calculate prior p(C|sigma) for each sigma. 
% first initialize error rate matrix and prior

Prior=zeros(11,1);
valid_err=zeros(11,1);


for sigma=-5:5
% calculate the prior probability
    Prior(sigma+6)=Prior(sigma+6)+1/(1+exp(-sigma));

% p_c1: best prior of the first class
% p_c2: best prior of the second class
% calculate the posterior probability 
% treat valid set as a N by 2 matrix, N samples, 2 classes

    P_c_x=ones(size(validation_data, 1),2);
    n2 = size(validation_data,1);
    n3 = size(validation_data,2);
    for k= 1:n2
        for j=1:n3-1
            P_c_x(k,1)=P_c_x(k,1)* p1(j).^(1-validation_data(k,j))* (1-p1(j)).^(validation_data(k,j));
        end
    end
    P_c_x(:,1)=P_c_x(:,1)*Prior(sigma+6);

    for k = 1:n2
        for j=1:n3-1
            P_c_x(k,2)=P_c_x(k,2)* p2(j).^(1-validation_data(k,j))* (1-p2(j)).^(validation_data(k,j));
        end
    end
    P_c_x(:,2)=P_c_x(:,2).*(1-Prior(sigma+6));

% compare c1 and c2 column 
% choose the larger one and stored it in 3nd column
    for k=1:size(P_c_x,1)
        if P_c_x(k,1)>P_c_x(k,2)
            P_c_x(k,3)=1;
        else
            P_c_x(k,3)=2;
        end
    end
    
    
    valid_err(sigma+6)= valid_err(sigma+6)+sum(sum(P_c_x(:,3)~=validation_data(:,n3)))/n2;
    
end
% output the minmum fo the valid_error
% find the index of minimium error rate, I, 
% and then find the corresonding prior in class 1 and 2
sigma = -5:5;
[Min,I]=min(valid_err);
sigma_min = sigma(I)
pc1=Prior(I)
pc2=1-pc1
valid_err_out=sprintf('%.4f\n',valid_err)
end