class Entity {
	public var radius: Float;
	public var speed: Float;
	public var x: Float;
	public var y: Float;
	public var vx: Float;
	public var vy: Float;
	public var mx: Float;
	public var my: Float;

	public function new(x, y) {
		this.radius = 0.25;
		this.speed = 4;
		this.x = x;
		this.y = y;
	}

	public function left() {
		return Math.floor(x - radius);
	}

	public function right() {
		return Math.ceil(x + radius) - 1;
	}

	public function top() {
		return Math.floor(y - radius);
	}

	public function bottom() {
		return Math.ceil(y + radius) - 1;
	}

	public function update(dt: Float) {
		vx = mx * speed;
		vy = my * speed;
	}

}
