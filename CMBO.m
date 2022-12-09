clc
clear
close all

N = 20;  % Number of agent
Nc = 10; % Number of cats
Nm = 10; % Number of mice
T = 100; % iteration
fobj = @objectivefunction;
dim = 3;
lb=-1;
ub=1;

X = zeros(N,dim);
F = zeros(N,1);
Fs = zeros(N,1);
M = zeros(Nm,dim);
C = zeros(Nc,dim);
Mnew = zeros(Nm,dim);
Cnew = zeros(Nc,dim);
out = zeros(N,1);

for i=1:dim
    X(:,i)=rand(N,1).*(ub-lb)+lb;
end


for t=1:T
    
    for i=1:N
        F(i)=fobj(X(i,:));
    end
    
    [Fs,SortOrder] = sort(F(:,:),'descend');
    M(1:Nm,:) = X(SortOrder(1:Nm),:);
    C(1:Nc,:) = X(SortOrder(Nm+1:N),:);
    out(t) = Fs(1);
    for j=1:Nc
        for d = 1:dim
            I = round(1 + rand());
            Cnew(j,d) = C(j,d)+rand()*(M(j,d)-I*C(j,d));
        end
        temp = fobj(Cnew(j,:));
        if temp < F(j+Nm)
            C(j,:) = Cnew(j,:);
        end
        
    end
    
    for j=1:Nm
        
        r = randi(N);
        H(1,:) = X(r,:);
        temp1 = fobj(H(1,:));
        temp2 = fobj(M(j,:));
        for d = 1:dim
            I = round(1 + rand());
            Mnew(j,d) = M(j,d)+rand()*(H(1,d)-I*M(j,d))*sign(temp2 - temp1);
        end
        temp = fobj(Mnew(j,:));
        if temp < F(j)
            M(j,:) = Mnew(j,:);
        end
        
    end
    
    X = [M;C];  
       
end
figure,
plot(out)