package common;

import common.Entity;

class GridNode {
	public var x: Int;
	public var y: Int;
	public var solid = false;
	public var entities = new Array<Entity>();

	public function new(x, y) {
		this.x = x;
		this.y = y;
	}
}
