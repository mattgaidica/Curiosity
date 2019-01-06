noveltyMap = NaN(1,20);
noveltyMap(5) = 5;
noveltyMap(12) = -2;
noveltyMap(14) = 1;
noveltyInterp  = noveltyMap;

% scoutMap is pseudo-binary
noveltyBinary = NaN(size(noveltyMap));
noveltyBinary(~isnan(noveltyMap)) = 1;
closedMission = true;
if closedMission
    if isnan(noveltyBinary(1))
        noveltyBinary(1) = 1;
        noveltyInterp(1) = 0;
    end
    if isnan(noveltyBinary(end))
        noveltyBinary(end) = 1;
        noveltyInterp(end) = 0;
    end
end

noveltyInterp = fillmissing(noveltyInterp,'linear');

distanceMap = NaN(numel(noveltyBinary),numel(noveltyBinary));
for ii = 1:numel(noveltyBinary)
    for jj = 1:numel(noveltyBinary)
%         if ii == jj
%             continue;
%         end
        if ~isnan(noveltyBinary(ii)) || ~isnan(noveltyBinary(jj))
            distanceMap(ii,jj) = abs(ii - jj);
        end
    end
end
scoutingMap = min(distanceMap);
scoutingMap_adj = scoutingMap .* noveltyInterp;

close all;
h = ff(450,900);
rows = 4;
cols = 1;

lns = [];
subplot(rows,cols,1);
lns(1) = plot(noveltyMap,'bo');
hold on;
lns(2) = plot(noveltyInterp,'b:');
lns(3) = plot(noveltyBinary,'rx');
xlim([1 numel(noveltyMap)]);
xticks([1:numel(noveltyMap)]);
ylim([min(noveltyMap)-1 max(noveltyMap)+1]);
yticks(sort([0 ylim]));
title('Novelty');
grid on;
legend(lns,{'Novelty','Interp','Binary'});
legend boxoff;

lns = [];
subplot(rows,cols,2);
plot(scoutingMap,'k:');
hold on;
lns(1) = plot(scoutingMap,'ko');
lns(2) = plot(scoutingMap_adj,'r-');
xlim([1 numel(scoutingMap)]);
xticks([1:numel(scoutingMap)]);
ylim([min(ylim)-1 max(ylim)+1]);
yticks(sort([0 ylim]));
title('Scouting');
grid on;
legend(lns,{'Scouting','Adj. Scouting'});
legend boxoff;

subplot(rows,cols,[3,4]);
imagesc(distanceMap','AlphaData',~isnan(distanceMap));
xticks([1:numel(noveltyBinary)]);
yticks([1:numel(noveltyBinary)]);
set(gca,'ydir','normal');
colormap(magma);
title('Distance');

set(gcf,'color','w');

% % function z = undefinedZ(noveltyMap)
% %     definedValues = noveltyMap(find(~isnan(noveltyMap)));
% %     z = 
% % end