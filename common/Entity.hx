package common;

import haxe.Int32;

class Entity {
	public var id: Int32;
	public var radius: Float;
	public var speed: Float;
	public var x: Float = 0;
	public var y: Float = 0;
	public var vx: Float = 0;
	public var vy: Float = 0;
	public var mx: Float = 0;
	public var my: Float = 0;
	public var active = true;

	public function new(id) {
		this.id = id;
		this.radius = 0.25;
		this.speed = 4;
	}

}
