package common;

import common.messages.CommandMessage;
import common.Movement;

class Entity {
	public var id: Int;
	public var player: Int;
	public var radius: Float;
	public var speed: Float;
	public var command = new CommandMessage(0, 0, 0, 0);
	public var x(default, set): Float = 0;
	public var y(default, set): Float = 0;
	public var vx(default, set): Float = 0;
	public var vy(default, set): Float = 0;
	public var dirty = false;

	function set_x(x) {
		dirty = dirty || this.x != x;
		return this.x = x;
	}

	function set_y(y) {
		dirty = dirty || this.y != y;
		return this.y = y;
	}

	function set_vx(vx) {
		dirty = dirty || this.vx != vx;
		return this.vx = vx;
	}

	function set_vy(vy) {
		dirty = dirty || this.vy != vy;
		return this.vy = vy;
	}

	public function new(id) {
		this.id = id;
		this.radius = 0.25;
		this.speed = 4;
	}

	public function update() {
		vx = command.x * speed;
		vy = command.y * speed;
	}

}
