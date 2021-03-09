package client;

import client.Dispatcher;
import common.Entity;
import hxd.Key;

class Player {
	public var dispatcher: Dispatcher;
	public var entity: Entity;

	public function new(dispatcher, entity) {
		this.dispatcher = dispatcher;
		this.entity = entity;
	}

	public function update(dt: Float) {
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
		if (x != entity.mx || y != entity.my) {
			entity.mx = x;
			entity.my = y;
			dispatcher.onPlayerMove(x, y);
		}
	}

}
