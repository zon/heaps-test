package server;

import udprotean.server.UDProteanClientBehavior;
import udprotean.server.UDProteanServer;
import common.Config;
import server.ClientBehavior;

class Server {
	public var dispatcher: Dispatcher;
	public var peer: UDProteanServer;
	public var clients = new Map<Int, ClientBehavior>();

	var autoId: Int = 0;

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
		for (entity in dispatcher.game.entities) {
			if (entity.dirty) {
				entity.dirty = false;
				var msg = entity.toMoveMessage();
				sendAll(msg);
			}
		}
		peer.update();
	}

	public function stop() {
		peer.stop();
	}

	public function sendAll(message, sendNow = true) {
		for (client in clients) {
			client.send(message, sendNow);
		}
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
