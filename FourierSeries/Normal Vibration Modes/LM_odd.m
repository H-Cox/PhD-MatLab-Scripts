function [value] = LM_odd(n,l)

alpha = Mnl_alpha(l);

value = 4*sqrt(2)/(1-(n*pi()/alpha)^4);