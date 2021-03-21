package common;

import common.GridNode;
import common.TilemapData;
import haxe.xml.Access;
import sys.io.File;
import haxe.ds.Vector;
import common.Bounds;
import common.GridSection;
import common.Entity;
import common.Calc;

class Grid {
	public var width: Int;
	public var height: Int;
	public var sectionSize: Int;
	public var sections: Vector<Vector<GridSection>>;

	public function new(width: Int, height: Int, sectionSize = 32) {
		this.sectionSize = sectionSize;
		this.width = Math.ceil(width / sectionSize);
		this.height = Math.ceil(height / sectionSize);
		sections = new Vector<Vector<GridSection>>(this.height);
		for (sy in 0...this.height) {
			sections[sy] = new Vector<GridSection>(this.width);
			for (sx in 0...this.width) {
				sections[sy][sx] = new GridSection(sx, sy, sectionSize);
			}
		}
	}

	public function get(x, y): Null<GridNode> {
		var sy = Math.floor(y / sectionSize);
		if (sy < 0 || sy >= sections.length) return null;
		var row = sections[sy];

		var sx = Math.floor(x / sectionSize);
		if (sx < 0 || sx >= row.length) return null;
		
		var nx = x % sectionSize;
		var ny = y % sectionSize;
		return row[sx].get(nx, ny);
	}

	public function addEntity(entity: Entity) {
		var left = Bounds.left(entity);
		var right = Bounds.right(entity);
		var bottom = Bounds.bottom(entity);
		var top = Bounds.top(entity);
		for (y in top...bottom + 1) {
			for (x in left...right + 1) {
				get(x, y).entities.push(entity);
			}
		}
		entity.gl = left;
		entity.gr = right;
		entity.gb = bottom;
		entity.gt = top;
	}

	public function moveEntity(entity: Entity) {
		removeEntity(entity);
		addEntity(entity);
	}

	public function removeEntity(entity: Entity) {
		for (y in entity.gt...entity.gb + 1) {
			for (x in entity.gl...entity.gr + 1) {
				get(x, y).entities.remove(entity);
			}
		}
	}

	public function index(node: GridNode) {
		return node.y * width * sectionSize + node.x;
	}

	public function raycast(ax: Int, ay: Int, bx: Int, by: Int): GridNode {
		var vx = bx - ax;
		var vy = by - ay;
		var n = Calc.normal(vx, vy);
		var nx = n.x;
		var ny = n.y;
		var sx = 1 / Math.abs(nx);
		var sy = 1 / Math.abs(ny);

		var tx = Math.floor(ax);
		var ty = Math.floor(ay);
		var tsx = nx < 0 ? -1 : 1;
		var tsy = ny < 0 ? -1 : 1;
		var gx = Math.floor(bx);
		var gy = Math.floor(by);

		var dx = 0.0;
		var dy = 0.0;
		if (nx >= 0) {
			dx = 1 - (ax % 1);
		} else {
			dx = ax % 1;
		}
		if (ny >= 0) {
			dy = 1 - (ay % 1);
		} else {
			dy = ay % 1;
		}
		dx = dx * sx;
		dy = dy * sy;

		var td = 0.0;
		var m = Calc.mag(vx, vy);
		var s = 0.0;
		var tile = get(tx, ty);
		var lx = ax * 1.0;
		var ly = ay * 1.0;
		while (td < m) {
			var s = s + 1;

			if (dx < dy) {
				td = td + dx;
				dy = dy - dx;
				dx = sx;
				tx = tx + tsx;
			} else {
				td = td + dy;
				dx = dx - dy;
				dy = sy;
				ty = ty + tsy;
			}

			var px = ax + nx * td;
			var py = ay + ny * td;
			lx = px;
			ly = py;

			var last = tile;
			tile = get(tx, ty);
			if (tile == null || tile.solid) {
				return last;

			} else if (tile.x == gx && tile.y == gy) {
				return tile;
			}
		}

		return tile;
	}

	public static function load(file) {
		var data = TilemapData.load(file);
		var grid = new Grid(data.width, data.height);
		for (y in 0...data.height) {
			for (x in 0...data.width) {
				grid.get(x, y).solid = data.get(x, y).solid;
			}
		}
		return grid;
	}

	static function loadTileset(name) {
		var text = File.getContent('./res/map/$name.tsx');
		var xml = Xml.parse(text);
		var data = new Access(xml.firstElement());
	}

}
