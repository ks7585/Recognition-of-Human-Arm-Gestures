function socket_stop_Func (~,event)

global socket;

disp('end');
fclose(socket);

end

