package server;

import haxe.Int32;
import udprotean.server.UDProteanClientBehavior;
import udprotean.server.UDProteanServer;
import common.Config;
import server.ClientBehavior;

class Server {
	public var dispatcher: Dispatcher;
	public var peer: UDProteanServer;
	public var clients = new Map<Int32, ClientBehavior>();

	var autoId: Int32 = 0;

	public function new(dispatcher) {
		this.dispatcher = dispatcher;
		peer = new UDProteanServer('0.0.0.0', Config.port, ClientBehavior);
		peer.onClientConnected(onConnected);
		peer.onClientDisconnected(onDisconnected);
	}

	public function start() {
		peer.start();
		trace('Listening on: '+ Config.port);
	}

	public function update() {
		peer.update();
	}

	public function stop() {
		peer.stop();
	}

	function onConnected(udpc: UDProteanClientBehavior) {
		while (autoId == 0 || clients.exists(autoId)) {
			autoId += 1;
		}
		trace('Connected: '+ autoId);
		var client: ClientBehavior = cast udpc;
		client.id = autoId;
		client.dispatcher = dispatcher;
		clients[autoId] = client;
	}

	function onDisconnected(udpc: UDProteanClientBehavior) {
		var client: ClientBehavior = cast udpc;
		trace('Disconnected: '+ client.id);
		clients.remove(client.id);
	}
	
}
