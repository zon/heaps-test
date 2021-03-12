package server;

import common.Entity;
import common.messages.EntityAddMessage;
import common.messages.EntityReconcileMessage;
import common.messages.EntityPositionMessage;
import common.messages.EntityRemoveMessage;

class ServerEntity extends Entity {

	public function toAddMessage() {
		return new EntityAddMessage(
			id,
			playerId,
			radius,
			speed,
			x,
			y,
			vx,
			vy
		);
	}

	public function toReconcileMessage() {
		return new EntityReconcileMessage(command.index, x, y, vx, vy);
	}

	public function toPositionMessage() {
		return new EntityPositionMessage(id, x, y);
	}

	public function toRemoveMessage() {
		return new EntityRemoveMessage(id);
	}

}
