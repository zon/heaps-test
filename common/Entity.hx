package common;

import common.messages.EntityAddMessage;
import common.messages.EntityRemoveMessage;
import common.messages.EntityMoveMessage;

class Entity {
	public var id: Int;
	public var player: Int;
	public var radius: Float;
	public var speed: Float;
	public var x(default, set): Float = 0;
	public var y(default, set): Float = 0;
	public var vx(default, set): Float = 0;
	public var vy(default, set): Float = 0;
	public var mx: Float = 0;
	public var my: Float = 0;
	public var dirty = false;
	public var active = true;

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

	public function load(msg: EntityMoveMessage) {
		x = msg.x;
		y = msg.y;
		vx = msg.vx;
		vy = msg.vy;
	}

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
		return new EntityMoveMessage(id, x, y, vx, vy);
	}

	public function toRemoveMessage() {
		return new EntityRemoveMessage(id);
	}

	public static function parse(msg: EntityAddMessage) {
		var e = new Entity(msg.id);
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
