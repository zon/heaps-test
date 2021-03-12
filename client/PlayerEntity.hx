package client;

import common.Movement;
import common.Stage;
import common.messages.CommandMessage;
import common.messages.EntityAddMessage;
import common.messages.EntityReconcileMessage;

class PlayerEntity extends ClientEntity {
	public var pending = new Array<CommandMessage>();
	
	var autoId = 1;

	public function move(x: Float, y: Float, dt: Float) {
		autoId += 1;
		command = new CommandMessage(autoId, x, y, dt);
		pending.push(command);
		update();
		return command;
	}

	public function reconcile(stage: Stage, message: EntityReconcileMessage) {
		
		// apply message state
		x = message.x;
		y = message.y;
		vx = message.vx;
		vy = message.vy;

		var i = 0;
		while (i < pending.length) {
			var command = pending[i];

			// drop commands under message index
			if (command.index <= message.commandIndex) {
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
		var e = new PlayerEntity();
		e.populate(msg);
		return e;
	}

}
