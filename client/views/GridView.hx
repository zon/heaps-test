package client.views;

import common.Grid;
import h2d.TileGroup;
import client.views.View;

class GridView {
	public var grid: Grid;
	public var group: TileGroup;

	public function new(grid: Grid, res: ResMap) {
		this.grid = grid;
		group = new TileGroup(res.general);
		for (scol in grid.sections) {
			for (section in scol) {
				for (ncol in section.nodes) {
					for (node in ncol) {
						var x = node.x * View.tile;
						var y = node.y * View.tile;
						var tile = node.solid ? res.getTile(1) : res.getTile(0);
						group.add(x, y, tile); 
					}
				}
			}
		}
	}

	public function remove() {
		group.remove();
	}

}
