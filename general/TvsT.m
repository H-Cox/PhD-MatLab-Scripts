% written to plot the tangent and fitted tangents calculated using fourier
% mode analysis.
% Written by Henry Cox 01/11/17

function TvsT(modefit)

figure;
plot(modefit.smid,modefit.tangents-mean(modefit.tangents(:))); hold on 
plot(modefit.s,modefit.Theta)

end
