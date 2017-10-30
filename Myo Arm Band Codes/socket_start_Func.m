function socket_start_Func (~, event)

global socket;

socket = tcpip('localhost', 2000, 'NetworkRole', 'client');
set(socket, 'InputBufferSize', 10000);
fopen(socket);

end

