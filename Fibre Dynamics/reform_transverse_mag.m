function [new_c] = reform_transverse_mag(c,Lcval,step)


    [c_len,time_len] = size(c);

    current_steps = linspace(0,Lcval,c_len);

    new_steps = 0:step:Lcval;
    
    for s = 1:length(new_steps)
        
        [weights] = gaussweighting(current_steps,new_steps(s),step/2);
        
        weights = repmat(weights',[1,time_len]);
        new_c(s,:) = sum(weights.*c)./sum(weights);
    end



end