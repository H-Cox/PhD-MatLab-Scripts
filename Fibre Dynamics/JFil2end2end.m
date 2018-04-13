
JFil2Lp

mean_modes = nanmean(a,2);

points = size(tang,1);

[Theta,s] = modes_to_angle(mean_modes,points,Lcval);

[x,y] = angle_to_position(Theta,Lcval);

[end2end] = square_dist(x,y);
