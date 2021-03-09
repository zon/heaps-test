package client;

import client.Dispatcher;
import common.Stage;
import common.messages.*;
import bytetype.ByteType;
import haxe.io.Bytes;
import udprotean.client.UDProteanClient;

class Client extends UDProteanClient {
	public var dispatcher: Dispatcher;
	public var sessionId: String;

	var loadingStage: Stage;

	override function onConnect() {
		trace('Connected');
	}

	override function onMessage(message:Bytes) {
		trace('Message: '+ message.toString());

		switch ByteType.getCode(message) {
			case TextMessage.code:
				var m: TextMessage = cast message;
				trace('Text: '+ m.body);

			case StageMessage.code:
				var m: StageMessage = cast message;
				loadingStage = new Stage(m.length);

			case StageTileMessage.code:
				var m: StageTileMessage = cast message;
				if (loadingStage.load(m)) {
					dispatcher.onStage(loadingStage);
					loadingStage = null;
				}
		}
	}

	override function onDisconnect() {
		trace('Disconnected');
	}

	public function onPlayerMove(x, y) {
		send(new MoveMessage(x, y), false);
	}

}
