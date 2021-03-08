import h2d.TileGroup;
import h2d.Object;

class StageView {
	public var stage: StageState;
	public var group: TileGroup;

	public function new(parent: Object, stage: StageState, res: ResMap) {
		this.stage = stage;
		this.group = new TileGroup(res.general, parent);
		for (t in stage.tiles) {
			var x = t.x * View.tile;
			var y = t.y * View.tile;
			var tile = if (t.solid) res.getTile(1) else res.getTile(0);
			group.add(x, y, tile);
		}
	}

}
