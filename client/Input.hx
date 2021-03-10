package client;

import hxd.Key;
import client.Dispatcher;
import client.ClientEntity;
import common.Player;

class Input {
	var dispatcher: Dispatcher;
	var entity: ClientEntity;

	var player(get, never): Player;

	function get_player() {
		return dispatcher.client.player;
	}

	public function new(dispatcher) {
		this.dispatcher = dispatcher;
	}

	public function addEntity(entity: ClientEntity) {
		if (player == null) return;
		if (entity.player == player.id) {
			this.entity = entity;
		}
	}

	public function removeEntity(id: Int) {
		if (entity == null || entity.id != id) return;
		entity = null;
	}

	public function update(dt: Float) {
		if (entity == null) return;
		
		final x: Float = if (Key.isDown(Key.A)) {
			-1;
		} else if (Key.isDown(Key.D)) {
			1;
		} else {
			0;
		}
		final y: Float = if (Key.isDown(Key.W)) {
			-1;
		} else if (Key.isDown(Key.S)) {
			1;
		} else {
			0;
		}
		
		dispatcher.sendCommand(entity.move(x, y, dt));
	}

}
