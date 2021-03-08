package server;

import bytetype.ByteType;
import udprotean.server.UDProteanServer;
import haxe.io.Bytes;
import udprotean.server.UDProteanClientBehavior;
import common.Config;
import common.TextMessage;

class EchoBehavior extends UDProteanClientBehavior {

	override function onConnect() {
		trace('Connected');
	}

	override function onMessage(message:Bytes) {
		trace('Message:', message.toString());

		switch ByteType.getCode(message) {
			case TextMessage.code:
				var text: TextMessage = cast message;
				trace('Text: '+ text.body);
				send(new TextMessage(text.body));
		}
	}

	override function onDisconnect() {
		trace('Disconnected');
	}

}

class Main {

	static function main() {
		var server = new UDProteanServer('0.0.0.0', Config.port, EchoBehavior);
		server.start();

		trace('Listening: '+ Config.port);
		
		var running = true;
		while(running) {
			server.update();
		}
		
		server.stop();
	}

}
