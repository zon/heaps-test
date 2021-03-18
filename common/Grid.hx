package common;

import common.TilemapData;
import common.TilesetData;
import haxe.xml.Access;
import sys.io.File;
import haxe.Json;
import haxe.ds.Vector;
import common.Bounds;
import common.GridSection;
import common.Entity;

class Grid {
	public var sectionSize: Int;
	public var sections: Vector<Vector<GridSection>>;

	public function new(width: Int, height: Int, sectionSize = 32) {
		this.sectionSize = sectionSize;
		var sw = Math.ceil(width / sectionSize);
		var sh = Math.ceil(height / sectionSize);
		sections = new Vector<Vector<GridSection>>(sh);
		for (sy in 0...sh) {
			sections[sy] = new Vector<GridSection>(sw);
			for (sx in 0...sw) {
				sections[sy][sx] = new GridSection(sx, sy, sectionSize);
			}
		}
	}

	public function addEntity(entity: Entity) {
		var left = Bounds.left(entity);
		var right = Bounds.right(entity);
		var bottom = Bounds.bottom(entity);
		var top = Bounds.top(entity);
		for (y in top...bottom + 1) {
			for (x in left...right + 1) {
				getNode(x, y).entities.push(entity);
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
				getNode(x, y).entities.remove(entity);
			}
		}
	}

	function getNode(x, y) {
		var sx = Math.floor(x / sectionSize);
		var sy = Math.floor(y / sectionSize);
		var nx = x % sectionSize;
		var ny = y % sectionSize;
		return sections[sy][sx].nodes[ny][nx];
	}

	public static function load(file) {
		var data = TilemapData.load(file);
		var grid = new Grid(data.width, data.height);
		for (y in 0...data.height) {
			for (x in 0...data.width) {
				grid.getNode(x, y).solid = data.get(x, y).solid;
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
