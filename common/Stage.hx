package common;

import common.messages.StageTileMessage;
import common.messages.StageMessage;
import udprotean.shared.UDProteanPeer;
import haxe.ds.Vector;

class Stage {
	public var length: Int;
	public var tiles: Vector<StageTile>;
	
	var position = 0;

	public function new(length) {
		this.length = length;
		tiles = new Vector(length * length);
		for (i in 0...tiles.length) {
			var tile = new StageTile();
			tile.x = i % length;
			tile.y = Math.floor(i / length);
			tiles[i] = tile;
		}
	}

	public function index(x: Int, y: Int) {
		return y * length + x;
	}

	public function valid(x: Int, y: Int) {
		return x >= 0 && x < length && y >= 0 && y < length;
	}

	public function get(x, y) {
		if (valid(x, y)) {
			return tiles[index(x, y)];
		} else {
			return null;
		}
	}

	public function solid(x, y) {
		if (valid(x, y)) {
			return get(x, y).solid;
		} else {
			return true;
		}
	}

	public function solidArea(left, top, right, bottom) {
		for (y in top...bottom + 1) {
			for (x in left...right + 1) {
				if (solid(x, y)) {
					return true;
				}
			}
		}
		return false;
	}

	public function enclose() {
		for (y in 0...length) {
			for (x in 0...length) {
				if (y == 0 || x == 0 || y >= length -1 || x >= length - 1) {
					get(x, y).solid = true;
				}
			}
		}
	}

	public function send(peer: UDProteanPeer) {
		peer.send(toMessage());
		for (tile in tiles) {
			peer.send(tile.toMessage());
		}
	}

	public function toMessage() {
		return new StageMessage(length);
	}

	// load the next tile
	public function load(msg: StageTileMessage) {
		tiles[position].load(msg);
		position += 1;
		
		// true when the last tile is loaded
		if (position >= tiles.length) {
			position -= tiles.length;
			return true;
		} else {
			return false;
		}
	}

	public static function parse(msg: StageMessage) {
		return new Stage(msg.length);
	}

}
