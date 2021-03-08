package client;

import common.TextMessage;
import bytetype.ByteType;
import haxe.io.Bytes;
import hxd.Key;
import common.Config;
import hxd.App;
import udprotean.client.UDProteanClient;

class Client extends UDProteanClient {

	override function onConnect() {
		trace('Connected');
	}

	override function onMessage(message:Bytes) {
		trace('Message: '+ message.toString());

		switch ByteType.getCode(message) {
			case TextMessage.code:
				var text: TextMessage = cast message;
				trace('Text: '+ text.body);
		}
	}

	override function onDisconnect() {
		trace('Disconnected');
	}

}

class Main extends App {
	var client: UDProteanClient;

	override function init() {
		client = new Client(Config.host, Config.port);
		client.connect();
	}

	override function update(dt: Float) {
		client.update();
		if (Key.isReleased(Key.SPACE)) {
			client.send(new TextMessage('hey'));
		}
	}

	override function dispose() {
		client.disconnect();
		super.dispose();
	}

	static function main() {
		new Main();
	}

}
