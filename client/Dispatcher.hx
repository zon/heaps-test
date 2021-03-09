package client;

import common.Config;
import client.Main;
import client.Input;
import client.Client;
import client.Game;
import client.views.GameView;

class Dispatcher {
	public var app: Main;
	public var input: Input;
	public var client: Client;
	public var game: Game;
	public var view: GameView;

	public function new(app) {
		this.app = app;
		input = new Input(this);
		client = new Client(Config.host, Config.port);
		client.dispatcher = this;
		game = new Game(this);
		view = new GameView(this, game);
	}

	public function init() {
		client.connect();
	}

	public function update(dt: Float) {
		input.update(dt);
		client.update();
		game.update(dt);
	}

	public function dispose() {
		client.disconnect();
	}

	public function onStage(stage) {
		game.onStage(stage);
		view.onStage(stage);
	}

	public function addEntity(key, entity) {
		game.addEntity(key, entity);
		view.addEntity(key, entity);
	}

	public function onPlayerMove(x, y) {
		client.onPlayerMove(x, y);
	}

}
