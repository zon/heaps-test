package common;

import common.messages.CommandMessage;

class Entity {
	public var id: Int;
	public var playerId: Int;
	public var radius: Float = 0.375;
	public var speed: Float = 4;
	public var command = new CommandMessage(0, 0, 0, 0);
	public var x(default, set): Float = 0;
	public var y(default, set): Float = 0;
	public var vx: Float = 0;
	public var vy: Float = 0;
	public var dirty = false;

	function set_x(x) {
		dirty = dirty || this.x != x;
		return this.x = x;
	}

	function set_y(y) {
		dirty = dirty || this.y != y;
		return this.y = y;
	}

	public function new() {}

	public function update() {
		vx = command.x * speed;
		vy = command.y * speed;
	}

}
