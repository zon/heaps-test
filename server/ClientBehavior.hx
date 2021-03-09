package server;

import haxe.Int32;
import haxe.io.Bytes;
import common.messages.TextMessage;
import bytetype.ByteType;
import udprotean.server.UDProteanClientBehavior;

class ClientBehavior extends UDProteanClientBehavior {
	public var id: Int32;
	public var dispatcher: Dispatcher;

	override function onConnect() {
		dispatcher.game.stage.send(this);
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

	}
 
}
