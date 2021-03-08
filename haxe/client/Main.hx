import hxd.App;
import io.colyseus.Client;
import io.colyseus.Room;

class Main extends App {
	var client = new Client('ws://localhost:3000');
	var res: ResMap;
	var game: Game;

	override function init() {
		res = new ResMap();

		client.joinOrCreate('entry', [], GameState, function(err, room) {
			if (err != null) {
				trace(err, err.code, err.message);
				return;
			}

			trace('room', room.id, 'joined');

			game = new Game(s2d, room, res);

			room.onLeave += function() {
				trace('room', room.id, 'left');
				game = null;
			};

			room.onError += function(code, message) {
				trace('room error', code, message);
			}
		});
	}

	override function update(dt: Float) {
		if (game != null) {
			game.update(dt);
		}
	}

	static function main() {
		new Main();
	}

}
