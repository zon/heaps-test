package client;

import common.messages.EntityMoveMessage;
import common.Stage;
import common.Config;
import common.Entity;
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

	public function setStage(stage: Stage) {
		trace('Set stage '+ stage.length);
		game.setStage(stage);
		view.setStage(stage);
	}

	public function addEntity(entity: Entity) {
		trace('Add entity '+ entity.id);
		input.addEntity(entity);
		game.addEntity(entity);
		view.addEntity(entity);
	}

	public function moveEntity(message: EntityMoveMessage) {
		game.moveEntity(message);
	}

	public function removeEntity(id: Int) {
		trace('Remove entity '+ id);
		input.removeEntity(id);
		game.removeEntity(id);
	}

	public function movePlayer(x, y) {
		client.movePlayer(x, y);
	}

}
