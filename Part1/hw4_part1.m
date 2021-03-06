clear all; close all; clc;

rbImage = im2double(imread('icon_back.png'));
[h, w, ~] = size(rbImage);
imshow(rbImage);

%% Mouse input
xlabel ('Select at most 100 points along the outline', 'FontName', '�L�n������', 'FontSize', 14);
[ ctrlPointX, ctrlPointY ] = ginput(100);
ctrlPointList = [ctrlPointX ctrlPointY];
clickedN = size(ctrlPointList,1);

promptStr = sprintf('%d points selected', clickedN);
xlabel (promptStr, 'FontName', '�L�n������', 'FontSize', 14);

%% Calculate Bazier Curve (Your efforts here)
ctrlPointList2 = ctrlPointList * 4;
outlineVertexList1 = [];
outlineVertexList2 = [];
outlineVertexList3 = [];
for i = 1  : 3 : clickedN - 2
    for t = 0 : 0.2 : 1
        if i == clickedN - 2
            curPoint = (1 - t) ^ 3 * ctrlPointList(i, :) + 3 * t * (1 - t) ^ 2 * ctrlPointList(i + 1, :) ...
            + 3 * t ^ 2 * (1 - t) * ctrlPointList(i + 2, :) + t ^ 3 * ctrlPointList(1, :); 
            outlineVertexList1 = [outlineVertexList1; curPoint];
        else
            curPoint = (1 - t) ^ 3 * ctrlPointList(i, :) + 3 * t * (1 - t) ^ 2 * ctrlPointList(i + 1, :) ...
            + 3 * t ^ 2 * (1 - t) * ctrlPointList(i + 2, :) + t ^ 3 * ctrlPointList(i + 3, :); 
            outlineVertexList1 = [outlineVertexList1; curPoint];
        end
    end
    for t = 0 : 0.01 : 1
        if i == clickedN - 2
            curPoint = (1 - t) ^ 3 * ctrlPointList(i, :) + 3 * t * (1 - t) ^ 2 * ctrlPointList(i + 1, :) ...
            + 3 * t ^ 2 * (1 - t) * ctrlPointList(i + 2, :) + t ^ 3 * ctrlPointList(1, :); 
            outlineVertexList2 = [outlineVertexList2; curPoint];
            curPoint = (1 - t) ^ 3 * ctrlPointList2(i, :) + 3 * t * (1 - t) ^ 2 * ctrlPointList2(i + 1, :) ...
            + 3 * t ^ 2 * (1 - t) * ctrlPointList2(i + 2, :) + t ^ 3 * ctrlPointList2(1, :); 
            outlineVertexList3 = [outlineVertexList3; curPoint];
        else
            curPoint = (1 - t) ^ 3 * ctrlPointList(i, :) + 3 * t * (1 - t) ^ 2 * ctrlPointList(i + 1, :) ...
            + 3 * t ^ 2 * (1 - t) * ctrlPointList(i + 2, :) + t ^ 3 * ctrlPointList(i + 3, :); 
            outlineVertexList2 = [outlineVertexList2; curPoint];
            curPoint = (1 - t) ^ 3 * ctrlPointList2(i, :) + 3 * t * (1 - t) ^ 2 * ctrlPointList2(i + 1, :) ...
            + 3 * t ^ 2 * (1 - t) * ctrlPointList2(i + 2, :) + t ^ 3 * ctrlPointList2(i + 3, :); 
            outlineVertexList3 = [outlineVertexList3; curPoint];
        end
    end
end
%%outlineVertexList = ctrlPointList; %Enrich outlineVertexList


%% Draw and fill the polygon  Last 3 input arguments: (ctrlPointScattered, polygonPlotted, filled)

figure; result1 = drawAndFillPolygon( rbImage, ctrlPointList, outlineVertexList1, true, true, true );
imwrite(result1, 'result_low_LoD.png');
figure; result2 = drawAndFillPolygon( rbImage, ctrlPointList, outlineVertexList2, true, true, true );
imwrite(result2, 'result_high_LoD.png');
rbImage2 = imresize(rbImage, 4);
figure; result3 = drawAndFillPolygon( rbImage2, ctrlPointList2, outlineVertexList3, true, true, true );
imwrite(result3, 'result_high_LoD_enlarge_ctrlPoint.png');
result4 = imresize(result2, 4, 'nearest');
imwrite(result4, 'result_high_LoD_enlarge_nearest.png');
