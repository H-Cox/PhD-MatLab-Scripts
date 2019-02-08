function [potential] = LennardJones(x,sigma,V0)

potential = V0.*((sigma./x).^12-(sigma./x).^6);
end