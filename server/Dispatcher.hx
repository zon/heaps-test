package server;

import server.Main;
import server.Game;
import server.Server;

class Dispatcher {
	public var app: Main;
	public var game: Game;
	public var server: Server;

	public function new(app: Main) {
		this.app = app;
		game = new Game(this);
		server = new Server(this);
	}

	public function start() {
		server.start();
	}
	
	public function reconcileEntity(entity, command) {
		game.reconcileEntity(entity, command);
	}

	public function update(dt: Float) {
		server.update();
	}

	public function stop() {
		server.stop();
	}

	public function sendAll(message, sendNow = true) {
		server.sendAll(message, sendNow);
	}

	public function sendOthers(entityId, message, sendNow = true) {
		server.sendOthers(entityId, message, sendNow);
	}

	public function sendPlayer(playerId, message, sendNow = true) {
		server.sendPlayer(playerId, message, sendNow);
	}

}
