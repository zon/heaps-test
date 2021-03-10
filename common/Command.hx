package common;

import common.messages.CommandMessage;

class Command {
	public var d: Float;
	public var x: Float;
	public var y: Float;

	public function new(d: Float, x: Float, y: Float) {
		this.d = d;
		this.x = x;
		this.y = y;
	}

	public static function parse(msg: CommandMessage) {
		return new Command(msg.d, msg.x, msg.y);
	}

}
