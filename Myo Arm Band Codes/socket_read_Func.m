function socket_read_Func (~, event)

global  nCh collectionInterval isCollecting buffer socket doubleTap MyoDataSize vart;

gesture = struct('rest', 0, 'fist', 1, 'wavein', 2, 'waveout', 3, 'fingersSpread', 4, 'doubleTap', 5 );

windowSize = collectionInterval;
maxChannel = nCh;

if (isCollecting)
    if(socket.BytesAvailable ~= 0)
        [data, n]= fscanf(socket, '%f,' , [8, 1000]);
        
        % If size is equal 51 then it means there is a pose user
        if length(data) == MyoDataSize + 1;
            switch data(1, 1)
                case gesture.rest
                    disp('rest');
                case gesture.fist
                    disp('fist');
                case gesture.wavein
                    disp('wavein');
                case gesture.waveout
                    disp('waveout');
                case gesture.fingersSpread
                    disp('fingersSpread');
                case gesture.doubleTap
                    disp('doubleTap');
            end
            
            data = data(:, 2:end);
        end
        
        temp = zeros(0, 8);
        temp = vertcat(temp, data');
        
        % append the buffer
        dataWindow = horzcat(buffer, temp');
        tSize= length(dataWindow(1,:));
        
        if windowSize > tSize % Pad with zeros
            buffer = horzcat( zeros(maxChannel, windowSize - tSize), dataWindow );
        else % Resize data to specified window size padding zeros if need be
            buffer = dataWindow(:, tSize-windowSize+1:tSize);
        end
        
        %clear socket
        flushinput(socket);
        
        % Plotting the EMG data
        figure(1)
       
        for i=1:8  % 8 channells
            subplot(4,2, i);
            
            plot(buffer(i, :)')
            
            title(['Channel ', num2str(i)])
            axis([0 collectionInterval -200 200])
            drawnow;
        end
%         for i=1:8
%             vart(i) = [vart(i) buffer(i, :)];
%         end
       end
end

end

