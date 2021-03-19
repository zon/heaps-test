package temp;

import client.Debug;
import hxd.Event;
import client.views.GridView;
import common.Grid;
import client.views.ResMap;
import hxd.App;

class Main extends App {
	var res: ResMap;
	var grid: Grid;
	var view: GridView;

	var startX = 0.0;
	var startY = 0.0;
	var stopX = 0.0;
	var stopY = 0.0;

	override function init() {
		res = new ResMap();
		
		grid = Grid.load('entry.tmx');
		
		view = new GridView(grid, res);
		s2d.addChild(view.group);
		s2d.scale(8);

		Debug.setup(s2d);

		s2d.addEventListener(onEvent);
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
				startX = s2d.mouseX;
				startY = s2d.mouseY;
			case 1:
				stopX = s2d.mouseX;
				stopY = s2d.mouseY;
		}

		updateLine();
	}

	function updateLine() {
		Debug.clear();
		Debug.lineStyle(0.2, 0x0000ff);
		Debug.moveTo(startX, startY);
		Debug.lineTo(stopX, stopY);
	}

	static function main() {
		new Main();
	}

}
