


function bestfit=amoeba5(funk,xguess,iterations)
% A simple implementation of the downhill simplex method of
% Nelder & Meade (1963), a.k.a. "amoeba". The function funk
% should be a scalar, real-valued function of a vector argument
% of the same size as xguess.
%Standard scale values for the reflect function
reflect = 1;
expand = -0.5;
contract = 0.25;
[M,N] = size(xguess); %N will be the number of dimensions.
if M~=1
 error('xguess is not a row vector!')
end
%Define the N+1 'feet' of the amoeba
basis = eye(N);
feet = [xguess;ones(N,1)*xguess+basis];
%Evaluate funk at each of the 'feet'
f=zeros(1,N+1);
for i=1:N+1
 f(i)=feval(funk,feet(i,1),feet(i,2),feet(i,3),feet(i,4),feet(i,5));
end
for persistence=1:iterations %The main loop
    disp(num2str(persistence))
 [P,Q,R] = pickPQR(f); %Identify highest, second highest, lowest feet
 [feet,f]=reflect_foot(funk,feet,f,P,reflect); %Reflect
 if f(P) < f(R)
 [feet,f]=reflect_foot(funk,feet,f,P,expand); %Expand
 elseif f(P) > f(Q)
 w = f(P); %Keep track of the current worst value of f
 [feet,f]=reflect_foot(funk,feet,f,P,contract); %1-dim Contract
 if f(P) < w
 [feet,f]=ndcontract(funk,feet,f,R); %N-dim contract
 end
 end
end
[P,Q,R] = pickPQR(f); %Identify highest, second highest, lowest feet
bestfit = feet(R,:); %Use lowest foot as best fit.
%end amoeba
%--------------------------------------------------------------------
function [P,Q,R]=pickPQR(f)
% Identify indices of highest (P), second highest (Q),
% and lowest (R) feet.
[foo,Nfeet]=size(f);
if foo ~=1
 error('f has wrong dimensions!')
end
P=1; Q=2; R=1; % Initial guess, certainly wrong
if f(Q) > f(P) % Correct the P/Q order for first 2 feet
 P=2; Q=1;
end
for i=1:Nfeet % Loop thru feet, finding P,Q,R
 if f(i) > f(P)
 Q=P; P=i;
 elseif (f(i) > f(Q)) & (i ~= P)
 Q=i;
 end
 if f(i) < f(R)
 R=i;
 end
end
%end pickPQR
%--------------------------------------------------------------------
function [feet,f]=reflect_foot(funk,feet,f,j,scale)
% Reflect the jth foot through the centroid of the other
% feet of the amoeba. The displacement may be scaled by
% using scale, whose default value of 1 results in a
% reflection that preserves the volume of the amoeba.
% A scale of 0.5 should never be used, as this would result
% in a degenerate simplex. Typical scale values:
% 1 ...... reflect through amoeba's opposite face
% -0.5 .... stretch the foot outward, doubling amoeba size
% 0.25 ... shrink inward, halving amoeba size
% The following variables get updated:
% feet(j,:) -- location of the jth foot
% f(j) -- value of funk at the jth foot
if nargin ~= 5
 scale=1; %default
end
if scale == 0.5
 error('Oops, you squashed the amoeba!')
end
[Nfeet,N]=size(feet); %Get amoeba dimensions
if Nfeet ~= N+1
 error('Not an amoeba: wrong number of feet!')
end
% Calculate displacement vector
cent = ( sum(feet,1) - feet(j,:) )/N; %centroid of the feet, except the
%jth foot.
disp = 2*(cent - feet(j,:));
% Move the foot, and update f
feet(j,:) = feet(j,:) + (scale*disp); %scaled displacement
f(j) = feval(funk,feet(j,1),feet(j,2),feet(j,3),feet(j,4),feet(j,5)); %evaluate funk
%end reflection
%---------------------------------------------------------------------
function [feet,f]=ndcontract(funk,feet,f,j)
% Contract all feet, except jth, toward the jth foot.
% The following variables get updated:
% feet -- location of each foot
% f -- value of funk at each foot
[Nfeet,N]=size(feet); %Get amoeba dimensions
if Nfeet ~= N+1
 error('Not an amoeba: wrong number of feet!')
end
for i=1:Nfeet
 if i ~= j
 feet(i,:) = ( feet(i,:) + feet(j,:) )/2;
 f(i) = feval(funk,feet(i,1),feet(i,2),feet(i,3),feet(i,4),feet(i,5));
 end
end
%end ndcontract