function value = Bn(n,v1)

    costerm = cos((n+1)*atan(sqrt(v1)));
    firsterm = v1./((v1+1).^((n+1)./2));
    
    value = costerm*firsterm;
    
end