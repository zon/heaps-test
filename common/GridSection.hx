package common;

import haxe.ds.Vector;

class GridSection {
	public var x: Int;
	public var y: Int;
	public var nodes: Vector<Vector<GridNode>>;

	public function new(x, y, size) {
		this.x = x;
		this.y = y;
		
		nodes = new Vector<Vector<GridNode>>(size);
		for (cy in 0...size) {
			nodes[cy] = new Vector<GridNode>(size);
			for (cx in 0...size) {
				nodes[cy][cx] = new GridNode(x * size + cx, y * size + cy);
			}
		}
	}

}
