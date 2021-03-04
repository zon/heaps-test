import haxe.ds.Vector;

class Stage {
	public var size: Int;
	public var tiles: Vector<Vector<StageTile>>;

	public function new(size) {
		this.size = size;
		this.tiles = new Vector<Vector<StageTile>>(size);
		for (y in 0...size) {
			this.tiles[y] = new Vector<StageTile>(size);
			for (x in 0...size) {
				this.tiles[y][x] = new StageTile(x, y);
			}
		}
	}

	public function valid(x: Int, y: Int) {
		return x >= 0 && x < this.size && y >= 0 && y < this.size;
	}

	public function get(x, y) {
		if (valid(x, y)) {
			return tiles[y][x];
		} else {
			return null;
		}
	}

	public function solid(x, y) {
		if (valid(x, y)) {
			return get(x, y).solid;
		} else {
			return true;
		}
	}

	public function solidArea(left, top, right, bottom) {
		for (y in top...bottom + 1) {
			for (x in left...right + 1) {
				if (solid(x, y)) {

					trace('solid', x, y);

					return true;
				}
			}
		}
		return false;
	}

	public function enclose() {
		for (y in 0...this.size) {
			for (x in 0...this.size) {
				if (y == 0 || x == 0 || y >= this.size -1 || x >= this.size - 1) {
					this.get(x, y).solid = true;
				}
			}
		}
	}

}
