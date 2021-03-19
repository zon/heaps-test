package temp;

import common.GridNode;
import client.views.View;
import client.Debug;
import hxd.Event;
import client.views.GridView;
import common.Grid;
import common.Pathfinder;
import client.views.ResMap;
import hxd.App;

class Main extends App {
	var res: ResMap;
	var grid: Grid;
	var pathfinder: Pathfinder;
	var view: GridView;

	var start: GridNode;
	var stop: GridNode;

	override function init() {
		res = new ResMap();
		
		grid = Grid.load('entry.tmx');

		pathfinder = new Pathfinder(grid);
		
		view = new GridView(grid, res);
		s2d.addChild(view.group);
		s2d.scale(8);

		Debug.setup(s2d);

		s2d.addEventListener(onEvent);

		start = grid.get(1, 1);
		stop = grid.get(14, 14);
		updatePath();
	}

	// override function update(dt: Float) {
	// 	dispatcher.update(dt);
	// }

	// override function dispose() {
	// 	dispatcher.dispose();
	// 	super.dispose();
	// }

	function onEvent(event: Event) {
		if (event.kind != ERelease) return;

		switch (event.button) {
			case 0:
				start = getNode(s2d.mouseX, s2d.mouseY);
			case 1:
				stop = getNode(s2d.mouseX, s2d.mouseY);
		}

		updatePath();
	}

	function getNode(x, y) {
		return grid.get(View.toGrid(x), View.toGrid(y));
	}

	function updatePath() {
		if (start == null || start.solid || stop == null || stop.solid) return;

		Debug.clear();
		Debug.lineStyle(0.2, 0x0000ff);
		Debug.moveTo(
			View.fromGrid(start.x),
			View.fromGrid(start.y)
		);
		var path = pathfinder.travel(start, stop);
		for (node in path) {
			Debug.lineTo(
				View.fromGrid(node.x),
				View.fromGrid(node.y)
			);
		}

		Debug.lineStyle(0.2, 0x00ff00);
		Debug.drawCircle(
			View.fromGrid(start.x),
			View.fromGrid(start.y),
			2,
			16
		);
			
		Debug.lineStyle(0.2, 0xff0000);
		Debug.drawCircle(
			View.fromGrid(stop.x),
			View.fromGrid(stop.y),
			2,
			16
		);

	}

	static function main() {
		new Main();
	}

}
