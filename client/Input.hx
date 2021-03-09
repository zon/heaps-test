package client;

import client.Dispatcher;
import client.Player;
import common.Entity;

class Input {
	var dispatcher: Dispatcher;
	var player: Player;

	public function new(dispatcher) {
		this.dispatcher = dispatcher;
	}

	public function addEntity(key: String, entity: Entity) {
		if (key == dispatcher.client.sessionId) {
			player = new Player(dispatcher, entity);
		}
	}

	public function update(dt: Float) {
		if (player != null) {
			player.update(dt);
		}
	}

}
