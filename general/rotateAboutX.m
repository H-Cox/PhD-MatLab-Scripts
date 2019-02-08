function [data] = rotateAboutX(data,angle)

rotationMatrix = [1,    0,             0;
                  0,    cos(angle),    -sin(angle);
                  0,    sin(angle),    cos(angle)];
              
data = rotationMatrix*data';

data = data';

end

function [data] = rotateAboutY(data,angle)

rotationMatrix = [cos(angle),   0,    sin(angle);
                  0,            1,    0;
                  -sin(angle),  0,    cos(angle)];
              
data = rotationMatrix*data';

data = data';

end

function [data] = rotateAboutZ(data,angle)

rotationMatrix = [cos(angle),   -sin(angle),    0;
                  sin(angle),   cos(angle),     0;
                  0,            0,              1];
              
data = rotationMatrix*data';

data = data';

end