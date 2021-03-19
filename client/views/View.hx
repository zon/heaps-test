package client.views;

class View {
	public static final tile = 8;

	public static function toGrid(v: Float) {
		return Math.floor(v / tile);
	}

	public static function fromGrid(g: Int) {
		return (g + 0.5) * tile;
	}

}
