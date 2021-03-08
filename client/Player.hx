import hxd.Key;
import io.colyseus.Room;

class Player {
	public var room: Room<GameState>;
	public var entity: EntityState;
	public var mx: Float = 0;
	public var my: Float = 0;

	public function new(room, entity) {
		this.room = room;
		this.entity = entity;
	}

	public function update(dt: Float) {
		final x: Float = if (Key.isDown(Key.A)) {
			-1;
		} else if (Key.isDown(Key.D)) {
			1;
		} else {
			0;
		}
		final y: Float = if (Key.isDown(Key.W)) {
			-1;
		} else if (Key.isDown(Key.S)) {
			1;
		} else {
			0;
		}
		if (x != mx || y != my) {
			mx = x;
			my = y;
			room.send('move', {x: x, y: y});
		}
	}

}
