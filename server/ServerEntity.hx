package server;

import common.Entity;
import common.messages.EntityAddMessage;
import common.messages.EntityRemoveMessage;
import common.messages.EntityMoveMessage;

class ServerEntity extends Entity {

	public function toAddMessage() {
		return new EntityAddMessage(
			id,
			player,
			radius,
			speed,
			x,
			y,
			vx,
			vy
		);
	}

	public function toMoveMessage() {
		return new EntityMoveMessage(id, command.index, x, y, vx, vy);
	}

	public function toRemoveMessage() {
		return new EntityRemoveMessage(id);
	}

}
