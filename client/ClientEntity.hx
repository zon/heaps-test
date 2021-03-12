package client;

import common.Entity;
import common.messages.EntityAddMessage;

class ClientEntity extends Entity {
	public var active = true;

	public function populate(msg: EntityAddMessage) {
		id = msg.id;
		playerId = msg.playerId;
		radius = msg.radius;
		speed = msg.speed;
		x = msg.x;
		y = msg.y;
		vx = msg.vx;
		vy = msg.vy;
	}

}
