package client.views;

import h2d.TileGroup;
import h2d.Object;
import common.Stage;
import client.views.View;

class StageView {
	public var stage: Stage;
	public var group: TileGroup;

	public function new(stage: Stage, res: ResMap) {
		this.stage = stage;
		group = new TileGroup(res.general);
		for (t in stage.tiles) {
			var x = t.x * View.tile;
			var y = t.y * View.tile;
			var tile = if (t.solid) res.getTile(1) else res.getTile(0);
			group.add(x, y, tile);
		}
	}

	public function remove() {
		group.remove();
	}

}
