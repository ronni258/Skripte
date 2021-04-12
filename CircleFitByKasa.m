function [A,B,R] = CircleFitByKasa(x,y,j,h)

XY=[];
XY(:,1)=x(1,j:1:h)';
XY(:,2)=y(1,j:1:h)';

%--------------------------------------------------------------------------
%  
%     Simple algebraic circle fit (Kasa method)
%      I. Kasa, "A curve fitting procedure and its error analysis",
%      IEEE Trans. Inst. Meas., Vol. 25, pages 8-14, (1976)
%
%     Input:  XY(n,2) is the array of coordinates of n points x(i)=XY(i,1), y(i)=XY(i,2)
%
%     Output: Par = [a b R] is the fitting circle:
%                           center (a,b) and radius R
%
%--------------------------------------------------------------------------

P = [XY ones(size(XY,1),1)] \ [XY(:,1).^2 + XY(:,2).^2];
Par = [P(1)/2 , P(2)/2 , sqrt((P(1)^2+P(2)^2)/4+P(3))];
A = Par(1,1);
B = Par(1,2);
R = Par(1,3);

end   %  CircleFitByKasa

