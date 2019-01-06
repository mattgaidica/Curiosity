Io = 5;
theta = pi/6;
nThetas = 9;
thetas = linspace(0,2*pi,nThetas);

nPixels = 10;
noveltyMap = [Io zeros(1,nPixels-1)]; % knowns + scouting
noveltyMap(7) = -2;

close all;
h = ff(800,800);
for iTheta = 1:nThetas
    explorationMap = NaN(1,nPixels); % unknown right now
    d = [];
    for ii = 1:nPixels
        d(ii) = ii-1;
        W = devalue(d(ii),thetas(iTheta));
        explorationMap(ii) = noveltyMap(ii) - W;
    end

    subplot(3,3,iTheta);
    plot(d,noveltyMap,'ro','markerSize',10);
    hold on;
    plot(d,explorationMap,'k','lineWidth',2);
    % hill vector
    midx = 4.5;
    midy = 0;
    drawLength = 3;
    h = drawLength*sin(thetas(iTheta));
    w = drawLength*cos(thetas(iTheta));
    p1 = [midx midy];
    p2 = [midx+w midy+h];
    dp = p2-p1;  
    quiver(p1(1),p1(2),dp(1),dp(2),0,'linewidth',2,'MaxHeadSize',1);

    xlabel('distance');
    xlim(size(d)-1);
    xticks(1:numel(d)-1);
    ylabel('I_{pixel}');
    ylim([-10,10]);
    yticks(sort([0 ylim]));
    title(['\theta = ',num2str(thetas(iTheta),2)]);
    grid on;
end
legend({'Novelty Map','Exploration Map'});
set(gcf,'color','w');

function W = devalue(d,theta)
    W = d*sin(theta);
end