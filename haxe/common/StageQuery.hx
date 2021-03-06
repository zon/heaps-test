class StageQuery {

	public static function index(stage: Stage, x: Int, y: Int) {
		return y * stage.size + x;
	}

	public static function valid(stage: Stage, x: Int, y: Int) {
		var size = stage.size;
		return x >= 0 && x < size && y >= 0 && y < size;
	}

	public static function get(stage: Stage, x, y) {
		if (valid(stage, x, y)) {
			return stage.tiles[index(stage, x, y)];
		} else {
			return null;
		}
	}

	public static function solid(stage: Stage, x, y) {
		if (valid(stage, x, y)) {
			return get(stage, x, y).solid;
		} else {
			return true;
		}
	}

	public static function solidArea(stage: Stage, left, top, right, bottom) {
		for (y in top...bottom + 1) {
			for (x in left...right + 1) {
				if (solid(stage, x, y)) {
					return true;
				}
			}
		}
		return false;
	}

	public static function enclose(stage: Stage) {
		var size = stage.size;
		for (y in 0...size) {
			for (x in 0...size) {
				if (y == 0 || x == 0 || y >= size -1 || x >= size - 1) {
					get(stage, x, y).solid = true;
				}
			}
		}
	}

}
