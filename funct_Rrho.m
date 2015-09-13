function Rrho = funct_Rrho(T,S,alpha,beta)
%size:
% T, S        : n
% alpha, beta : n-1

Rrho=beta.*diff(S)./(alpha.*diff(T));

end

