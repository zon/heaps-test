import h2d.TileGroup;
import h2d.Object;

class StageView {
	public var stage: Stage;
	public var group: TileGroup;

	public function new(parent: Object, stage: Stage, res: ResMap) {
		this.stage = stage;
		this.group = new TileGroup(res.general, parent);
		for (row in stage.tiles) {
			for (rt in row) {
				var x = rt.x * View.tile;
				var y = rt.y * View.tile;
				var tile = if (rt.solid) res.getTile(1) else res.getTile(0);
				group.add(x, y, tile);
			}
		}
	}

}
