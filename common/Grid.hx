package common;

import common.GridNode;
import common.TilemapData;
import haxe.xml.Access;
import sys.io.File;
import haxe.ds.Vector;
import common.Bounds;
import common.GridSection;
import common.Entity;

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
