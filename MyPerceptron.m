% CSCI 5521 Homework
% Peixuan Zhang
% Perceptron function 


function [w,step] = MyPerceptron(X,y,w)

k=length(y);
mxx = max(X(1,:));
mnx = min(X(1,:)); 
mxy = max(X(2,:));
mny = min(X(2,:));

%plot the data point based on the initial w  
figure;
for j=1:k
    if y(j)==1
     scatter(X(j,1),X(j,2),'o','b','filled');
     hold on
    end
    if y(j)==-1
     scatter(X(j,1),X(j,2),'x','r');
     hold on
    end 
end     
hold on
xt1 = -1:0.01:1;
yt1 = (-w(1)*xt1)/w(2);
plot(xt1,yt1);

%initialize the parameters  
r=1;  %learningrate

%con=0;  %set the condition
step = 0;    %record the number of iterations
err = 1;

while err > 0  
    for i=1:k
     if (y(i)*(dot(w,X(i,:))))<= 0    % wrong decision or not
      w =w +r*y(i)*X(i,:)       
      step = step +1
      err = sum(sign(w.*X)~=y)/k;
     end
    end
end

figure;
for j=1:k
    if y(j)==1
     scatter(X(j,1),X(j,2),'o','b', 'filled');
     hold on
    end
    if y(j)==-1
     scatter(X(j,1),X(j,2),'x','r');
     hold on
    end 
end     
hold on
xt = -1:0.01:1;
yt = (-w(1)*xt)/w(2);
plot(xt,yt);
axis([-1,1,-1,1])
end