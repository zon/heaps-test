package common;

class Movement {

	public static function update(stage: Stage, entity: Entity, dt: Float) {
		var dx = entity.vx * dt;
		entity.x += dx;

		var left = Bounds.left(entity);
		var right = Bounds.right(entity);
		var bottom = Bounds.bottom(entity);
		var top = Bounds.top(entity);

		if (entity.vx > 0) {
			if (stage.solidArea(right, top, right, bottom)) {
				entity.x = right - entity.radius;
			}

		} else if (entity.vx < 0) {
			if (stage.solidArea(left, top, left, bottom)) {
				entity.x = left + 1 + entity.radius;
			}
		}

		var dy = entity.vy * dt;
		entity.y += dy;

		left = Bounds.left(entity);
		right = Bounds.right(entity);
		bottom = Bounds.bottom(entity);
		top = Bounds.top(entity);

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
