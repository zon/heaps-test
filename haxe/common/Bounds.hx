class Bounds {

	public static function left(entity: EntityState) {
		return Math.floor(entity.x - entity.radius);
	}

	public static function right(entity: EntityState) {
		return Math.ceil(entity.x + entity.radius) - 1;
	}

	public static function top(entity: EntityState) {
		return Math.floor(entity.y - entity.radius);
	}

	public static function bottom(entity: EntityState) {
		return Math.ceil(entity.y + entity.radius) - 1;
	}

}
