function [z,ybest,tr]=Amoeba(f,n,x)
%  Function z=Amoeba(f,n,x)


% from http://people.whitman.edu/~hundledr/courses/M467F06/


%    Implements the Nelder-Mead simplex algorithm (Duplication of fmins).
%    Input the scalar valued f, the input dimension and an initial guess, 
%    x (optional).  f should act columnwise on a matrix, so that if an nxp
%    matrix is passed, a 1 x p vector is returned.
%  The algorithm will either return an estimate of the minimum or will exit
%  due to an excess number of function iterations.  The function f can be
%  input either as an inline, or as an M-file.

%Initializations:
maxiters=5000;   %Max number of iterations allowed
solNotBdd=10000;
ftol=1e-14;  %Tolerance for exiting the algorithm
alpha=1;
beta=0.8;
gamma=1;

if nargin<3
    %No initial guess given.  Use a default about the origin
    x=randn(n,1);
end

P=[x repmat(x,1,n)+eye(n)];  %Initialize the simplex.  P is n x (n+1)
yold=10000000;
for i=1:maxiters
    y=f(P);
    [y,idx]=sort(y);
    P=P(:,idx);
    %*******************************************************
    %  Stopping Criteria:  Use trace(i) to measure goodness
    %*******************************************************
    tr(i)=abs(y(end)-y(1));  %Absolute change in the function over the
                              %simplex
    
    %Unfortunately, the main program exit condition needs to be tested at
    %the beginning of the "for" loop (how "continue" works);
    if tr(i)<ftol
        fprintf('Normal Termination after %d iterations\n',i);
        break
    end   
    %Might include something about the solution becoming unbounded:
    if norm(P(:,1))>solNotBdd
        fprintf('Abnormal Termination, %d iterations:  Solution becoming unbounded.\n',i);
        break
    end
    
    
    %NOTE:  The centroid does NOT include Phigh...
    Pbar=mean(P(:,1:n),2);
    Phigh=P(:,end);
    yhigh=y(end); ylow=y(1);
    
    Pstar=Pbar+alpha*(Pbar-Phigh);  %Reflect down the valley
    ystar=f(Pstar);
    
    %The goal of the following is to replace Phigh.  Every condition should
    %end by putting together a new matrix P.
    
    if ystar<ylow  %We're going in the right direction- Try to get better
        Pdstar=Pstar+gamma*(Pstar-Pbar);
        ydstar=f(Pdstar);
        if ydstar<ylow  %Pdstar is a keeper!
            P(:,end)=Pdstar;
            continue
        else  %Pdstar no good- Keep Pstar
            P(:,end)=Pstar;
            continue
        end
    else
        if ystar>y(n)  %Contraction stage
            if ystar<yhigh
               Phigh=Pstar;
               yhigh=ystar;
            end  
            %Move towards the centroid and check:
            Pdstar=Pbar+beta*(Pbar-Phigh);
            ydstar=f(Pdstar);
            if ydstar>yhigh
                %Contract all towards P_low=P(:,1)
                P=0.5*(P+repmat(P(:,1),1,n+1));
            else
                P(:,end)=Pdstar;
            end            
            continue
        else  %Do not contract- Leave Pstar alone.
            P(:,end)=Pstar;
            continue
        end
    end
    %Any commands here will not be executed....    
end %End of the main "for" loop
z=P(:,1);
ybest=y(1);
if i==maxiters
    fprintf('Abnormal Termination.  Maximum iterations reached.\n');
end
