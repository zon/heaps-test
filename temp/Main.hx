package temp;

import client.views.GridView;
import common.Grid;
import client.views.ResMap;
import hxd.App;

class Main extends App {
	var res: ResMap;
	var grid: Grid;
	var view: GridView;

	override function init() {
		res = new ResMap();
		grid = Grid.load('entry.tmx');
		view = new GridView(grid, res);
		s2d.addChild(view.group);
		s2d.scale(8);
	}

	// override function update(dt: Float) {
	// 	dispatcher.update(dt);
	// }

	// override function dispose() {
	// 	dispatcher.dispose();
	// 	super.dispose();
	// }

	static function main() {
		new Main();
	}

}
