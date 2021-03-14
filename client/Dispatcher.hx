package client;

import common.messages.CommandMessage;
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
		view.update(dt);
	}

	public function dispose() {
		client.disconnect();
	}

	public function setStage(stage: Stage) {
		trace('Set stage '+ stage.length);
		game.setStage(stage);
		view.setStage(stage);
	}

	public function addOther(entity: OtherEntity) {
		trace('Add other ${entity.id}');
		game.addOther(entity);
		view.addEntity(entity);
	}

	public function addPlayer(entity: PlayerEntity) {
		trace('Add player ${entity.id}');
		input.addPlayer(entity);
		game.addPlayer(entity);
		view.addEntity(entity);
	}

	public function positionOther(message) {
		game.positionOther(message);
	}

	public function reconcilePlayer(message) {
		game.reconcilePlayer(message);
	}

	public function removeOther(id: Int) {
		trace('Remove other $id');
		game.removeOther(id);
		view.removeEntity(id);
	}

	public function removePlayer(id: Int) {
		trace('Remove player $id');
		input.removePlayer();
		game.removePlayer();
		view.removeEntity(id);
	}

	public function sendCommand(command) {
		client.sendCommand(command);
	}

}
