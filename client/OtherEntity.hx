package client;

import haxe.Timer;
import common.Config;
import common.messages.EntityAddMessage;
import common.messages.EntityPositionMessage;
import client.ClientEntity;

class OtherEntity extends ClientEntity {
	public var history = new Array<OtherHistory>();
	public var applied = 0.0;

	public function apply(message: EntityPositionMessage) {
		history.push(new OtherHistory(message));
	}

	public function interpolate(now: Float) {
		if (history.length < 1) return;

		// remove old history
		var stamp = now - 1 / Config.sendRate;
		while (history.length > 1 && history[1].stamp < stamp) {
			history.shift();
		}

		if (history.length < 2) {
			var l = history[0];
			x = l.x;
			y = l.y;
			vx = 0;
			vy = 0;
			return;
		}

		var a = history[history.length - 2];
		var b = history[history.length - 1];

		var px = x;
		var py = y;
		var dt = b.stamp - a.stamp;
		var p = (stamp - a.stamp) / dt;
		x = a.x + (b.x - a.x) * p;
		y = a.y + (b.y - a.y) * p;
		vx = (x - px) / dt;
		vy = (y - py) / dt;

		Console.status('p: $p');
		Console.status('vx: $vx');
	}

	public static function parse(msg: EntityAddMessage) {
		var e = new OtherEntity();
		e.populate(msg);
		return e;
	}

}

class OtherHistory {
	public var x: Float;
	public var y: Float;
	public var stamp: Float;

	public function new(message: EntityPositionMessage) {
		x = message.x;
		y = message.y;
		stamp = Timer.stamp();
	}
}
