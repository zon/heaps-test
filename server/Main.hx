package server;

import common.Stage;
import udprotean.server.UDProteanServer;
import common.Config;

class Main {
	public var stage: Stage;
	public var peer: UDProteanServer;
	
	var running = true;
	
	public static var current: Main;

	public function new() {
		stage = new Stage(16);
		stage.enclose();
		stage.get(6, 6).solid = true;
		
		peer = new UDProteanServer('0.0.0.0', Config.port, ClientBehavior);
	}

	public function start() {
		peer.start();
		trace('Listening on: '+ Config.port);
		
		while(running) {
			peer.update();
		}
		
		peer.stop();
	}

	public function stop() {
		running = false;
	}

	static function main() {
		var server = new Main();
		current = server;
		server.start();
	}

}
