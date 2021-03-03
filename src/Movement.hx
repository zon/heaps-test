class Movement {

	public static function update(world: World, dt: Float) {
		for (entity in world.entities) {
			updateEntity(world.stage, entity, dt);
		}
	}

	static function updateEntity(stage: Stage, entity: Entity, dt: Float) {
		var dx = entity.vx * dt;
		var dy = entity.vy * dt;

		entity.x += dx;

		var left = entity.left();
		var right = entity.right();
		var bottom = entity.bottom();
		var top = entity.top();

		if (entity.vx > 0) {
			if (stage.solidArea(right, top, right, bottom)) {
				entity.x = right - entity.radius;
			}

		} else if (entity.vx < 0) {
			if (stage.solidArea(left, top, left, bottom)) {
				entity.x = left + 1 + entity.radius;
			}
		}

		entity.y += dy;

		left = entity.left();
		right = entity.right();
		bottom = entity.bottom();
		top = entity.top();

		if (entity.vy > 0) {
			if (stage.solidArea(left, bottom, right, bottom)) {
				entity.y = bottom - entity.radius;
			}

		} else if (entity.vy < 0) {
			if (stage.solidArea(left, top, right, top)) {
				entity.y = top + 1 + entity.radius;
			}
		}
	}

}
