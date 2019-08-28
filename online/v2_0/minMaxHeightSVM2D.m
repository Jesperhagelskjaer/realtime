function [par] = minMaxHeightSVM2D(par,dataF,rez)

tic
fprintf('%-20s','Cutting amplitude started')

[par] = calMinMax(par,dataF,rez);
passed = par.passed;
count = 0;

%plot3D_minMax(par)


for i = 1:length(par.mainChannel)-1
    
    x = par.holder(:,i);
    
    for ii = (i+1):length(par.mainChannel)
        count = count + 1;
        y = par.holder(:,ii);
        
        h = scatter_kdeModified(x, y,i,ii, 'filled', 'MarkerSize', 20);
        
        if strcmp(par.useBitmVolt,'Y')
            binranges = -400:10:0;
            xString = 'Volt [uV]';
        else
            binranges = -2000:10:50;
            xString = '[Bits]';
        end
        [bincounts2] = histc(x,binranges);
        [bincounts1] = histc(y,binranges);
        
        hAxis(1) = subplot(2,2,1);
        barh(binranges,bincounts1,'histc')
        set(gca,'Xdir','reverse')
        %plotSettingsSub(i,3,xString)
        ylim([min(y)-10 0])
        hAxis(2) = subplot(2,2,4);
        bar(binranges,bincounts2,'histc')
        set(gca,'Ydir','reverse')
        %plotSettingsSub(i,5,xString)
        xlim([min(x)-10 0])
        pos = get( hAxis(1), 'Position' );
        pos(1) = 0.22;                         % Shift right
        set( hAxis(1), 'Position', pos );
        
        pos = get( hAxis(2), 'Position' );
        pos(2) = 0.22;                         % Shift down.
        set( hAxis(2), 'Position', pos );
        
        

    end
end



end 






