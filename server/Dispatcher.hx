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

	public function update(dt) {
		game.update(dt);
		server.update();
	}

	public function stop() {
		server.stop();
	}

}
