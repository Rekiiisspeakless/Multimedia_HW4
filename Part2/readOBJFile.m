clear all
close all
%% show the obj file at 3D figure
al = fopen('al7KC.obj');

vertex_al = fscanf(al,'v %f %f %f %f %f %f\n',[6, Inf])';
faces_al = fscanf(al,'f %f %f %f\n',[3, Inf])';

fclose(al);

vertex = vertex_al(:,1:3);
faces = faces_al;
colors = vertex_al(:,4:6);
centerX = (max(vertex(:, 1)) + min(vertex(:, 1))) / 2;
centerY = (max(vertex(:, 2)) + min(vertex(:, 2))) / 2;
centerZ = (max(vertex(:, 3)) + min(vertex(:, 3))) / 2;

%trisurf(faces,vertex(:,1) - centerX,vertex(:,2) - centerY,vertex(:,3) -centerZ,'FaceVertexCData', colors,'FaceColor','interp', 'EdgeAlpha', 0);

%% Adding the HSV color cylinder onto the same world space as al7KC.obj, and then do some transformation
% (Hint) You can try to combine 2 objects' vertices, faces together
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
circleVertsX = circleVertsX + 0;
circleVertsY = circleVertsY + 2.5;
circleVertsZ = circleVertsZ - 2.5;

faces = [];
for i = 0 : 239
   faces = [faces; 3 * i + 1 3 * i + 2 3 * i + 3]; 
end
% color = rgb2hsv(color);
faces_al = faces_al + 720;
faces = [faces; faces_al];
colors = [hsv2rgb(color); colors];
x =[circleVertsX; vertex(:,1) - centerX];
y = [circleVertsY; vertex(:,2) - centerY];
z = [circleVertsZ; vertex(:,3) - centerZ];
trisurf(faces,x,y, z,'FaceVertexCData', colors,'FaceColor','interp', 'EdgeAlpha', 0);
% trisurf([faces; faces_al],[circleVertsX; vertex(:,1) - centerX],[circleVertsY; vertex(:,2) - centerY], [circleVertsZ; vertex(:,3) -centerZ],'FaceVertexCData', [hsv2rgb(color); colors],'FaceColor','interp', 'EdgeAlpha', 0);


%% Lighting (You may need to modify the lighting here)
% h = light;
%% position
% light('style', 'local', 'Position',[0.0,0.0,5.0]);
%% directional
light('style', 'infinite', 'Position',[0.0,0.0,5.0]);

%% ka kd ks
% material([1.0, 0.0, 0.0]);
% material([0.1, 1.0, 0.0]);
% material([0.1, 0.1, 1.0]);
% material([0.1, 0.8, 1.0]);

lighting phong;