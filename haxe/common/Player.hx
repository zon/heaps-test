import hxd.Key;

class Player {
	public var entity: Entity;

	public function new(entity) {
		this.entity = entity;
	}

	public function update(dt: Float) {
		if (Key.isDown(Key.A)) {
			entity.mx = -1;
		} else if (Key.isDown(Key.D)) {
			entity.mx = 1;
		} else {
			entity.mx = 0;
		}
		if (Key.isDown(Key.W)) {
			entity.my = -1;
		} else if (Key.isDown(Key.S)) {
			entity.my = 1;
		} else {
			entity.my = 0;
		}
	}

}
