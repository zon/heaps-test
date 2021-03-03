import h2d.Tile;
import hxd.Res;

class ResMap {
	public var general: Tile;

	var tiles: Array<Tile>;

	public function new() {
		Res.initEmbed();
		this.general = Res.load('general.png').toTile();
		this.tiles = this.general.gridFlatten(View.tile);
	}

	public function getTile(index) {
		return this.tiles[index];
	}

}
