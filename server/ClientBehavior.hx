package server;

import haxe.io.Bytes;
import common.messages.TextMessage;
import bytetype.ByteType;
import udprotean.server.UDProteanClientBehavior;

class ClientBehavior extends UDProteanClientBehavior {
	var ctx: Main;

	override function onConnect() {
		trace('Connected '+ peerID);

		ctx = Main.current;

		ctx.stage.send(this);
	}

	override function onMessage(message: Bytes) {
		trace('Message:', message.toString());

		switch ByteType.getCode(message) {
			case TextMessage.code:
				var text: TextMessage = cast message;
				trace('Text: '+ text.body);
				send(new TextMessage(text.body));
		}
	}

	override function onDisconnect() {
		trace('Disconnected '+ peerID);
	}
 
}
