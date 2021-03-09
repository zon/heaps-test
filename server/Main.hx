package server;

import haxe.Timer;
import server.Dispatcher;

class Main {
	public var dispatcher: Dispatcher;

	var previous: Float;
	var running = true;

	public function new() {
		dispatcher = new Dispatcher(this);
	}

	public function start() {
		previous = Timer.stamp();

		dispatcher.start();
		
		while(running) {
			var now = Timer.stamp();
			var dt = now - previous;
			previous = now;
			update(dt);
		}
		
		stop();
	}

	public function stop() {
		dispatcher.stop();
		running = false;
	}

	function update(dt) {
		dispatcher.update(dt);
	}

	static function main() {
		var app = new Main();
		app.start();
	}

}
