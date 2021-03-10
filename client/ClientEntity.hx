package client;

import common.Movement;
import common.Stage;
import common.Entity;
import common.messages.CommandMessage;
import common.messages.EntityAddMessage;
import common.messages.EntityMoveMessage;

class ClientEntity extends Entity {
	public var active = true;
	public var pending = new Array<CommandMessage>();
	
	var autoId = 1;

	public function move(x: Float, y: Float, dt: Float) {
		autoId += 1;
		command = new CommandMessage(autoId, x, y, dt);
		pending.push(command);
		update();
		return command;
	}

	public function apply(message: EntityMoveMessage) {
		x = message.x;
		y = message.y;
		vx = message.vx;
		vy = message.vy;
	}

	public function reconcile(stage: Stage, message: EntityMoveMessage) {
		
		// apply message state
		apply(message);

		var i = 0;
		while (i < pending.length) {
			var command = pending[i];

			// drop commands under message index
			if (command.index <= message.command) {
				pending.shift();

			// reapply commands that are still pending
			} else {
				this.command = command;
				update();
				Movement.update(stage, this, command.dt);
				i++;
			}
		}
	}

	public static function parse(msg: EntityAddMessage) {
		var e = new ClientEntity(msg.id);
		e.player = msg.player;
		e.radius = msg.radius;
		e.speed = msg.speed;
		e.x = msg.x;
		e.y = msg.y;
		e.vx = msg.vx;
		e.vy = msg.vy;
		return e;
	}

}
