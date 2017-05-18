numOfVert = 60;
vertsPolarAngle = linspace(0, 2 * pi, numOfVert + 1)';
vertsX = cos(vertsPolarAngle);
vertsY = sin(vertsPolarAngle);
vertsZ = zeros([numOfVert+1, 1]);
circleVertsX = [];
circleVertsY = [];
circleVertsZ = [];
color = [];
for i = 1 : numOfVert
%     circleVertsX = [circleVertsX; vertsX(i); vertsX(i); vertsX(i+1); vertsX(i); vertsX(i+1); vertsX(i+1);];
%     circleVertsY = [circleVertsY; vertsY(i); vertsY(i);vertsY(i+1); vertsY(i); vertsY(i+1);vertsY(i+1);];
%     circleVertsZ = [circleVertsZ; 0.5; -0.5; 0.5; -0.5; 0.5; -0.5];
%     color = [color; (i - 1) / numOfVert 1 1; (i - 1)  / numOfVert 1 0; i / numOfVert 1 1; (i - 1) / numOfVert 1 0; i / numOfVert 1 1; i / numOfVert 1 0;];
    circleVertsX = [circleVertsX; vertsX(i); vertsX(i); vertsX(i+1); vertsX(i);  vertsX(i+1); vertsX(i+1);];
    circleVertsY = [circleVertsY; vertsY(i); vertsY(i);vertsY(i+1); vertsY(i); vertsY(i+1); vertsY(i+1);];
    circleVertsZ = [circleVertsZ; 0.5; -0.5; 0.5; -0.5; -0.5; 0.5];
    color = [color; (i - 1) / numOfVert 1 1; (i - 1)  / numOfVert 1 0; i / numOfVert 1 1; (i - 1) / numOfVert 1 0; i / numOfVert 1 0; i / numOfVert 1 1;];
end

for i = 1 : numOfVert
    circleVertsX = [circleVertsX; vertsX(i); vertsX(i + 1); 0];
    circleVertsY = [circleVertsY; vertsY(i); vertsY(i + 1); 0];
    circleVertsZ = [circleVertsZ; -0.5; -0.5; -0.5];
    color = [color; (i - 1) / numOfVert 1 0; i  / numOfVert 1 0; 0 0 0;];
    
end


for i = 1 : numOfVert
    circleVertsX = [circleVertsX; vertsX(i); vertsX(i+ 1); 0];
    circleVertsY = [circleVertsY; vertsY(i); vertsY(i + 1); 0];
    circleVertsZ = [circleVertsZ; 0.5; 0.5; 0.5];
    color = [color; (i - 1) / numOfVert 1 1; i  / numOfVert 1 1; 0 0 1;];
end

faces = [];
for i = 0 : 239
   faces = [faces; 3 * i + 1 3 * i + 2 3 * i + 3]; 
end
% color = rgb2hsv(color);
b = hsv2rgb(color);
trisurf(faces,circleVertsX,circleVertsY, circleVertsZ,'FaceVertexCData', hsv2rgb(color),'FaceColor','interp', 'EdgeAlpha', 0);