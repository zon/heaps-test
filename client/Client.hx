package client;

import haxe.io.Bytes;
import bytetype.ByteType;
import udprotean.client.UDProteanClient;
import common.messages.*;
import common.Player;
import common.Stage;
import client.Dispatcher;
import client.ClientEntity;

class Client extends UDProteanClient {
	public var dispatcher: Dispatcher;
	public var player: Player;

	var loadingStage: Stage;

	override function onConnect() {
		trace('Connected');
	}

	override function onMessage(message:Bytes) {
		switch ByteType.getCode(message) {

			case PlayerMessage.code:
				var m: PlayerMessage = cast message;
				player = Player.parse(m);
				trace('Player '+ player.id);

			case StageMessage.code:
				var m: StageMessage = cast message;
				loadingStage = new Stage(m.length);

			case StageTileMessage.code:
				var m: StageTileMessage = cast message;
				if (loadingStage.load(m)) {
					dispatcher.setStage(loadingStage);
					loadingStage = null;
				}

			case EntityAddMessage.code:
				var m: EntityAddMessage = cast message;
				dispatcher.addEntity(ClientEntity.parse(m));

			case EntityMoveMessage.code:
				var m: EntityMoveMessage = cast message;
				if (player != null && m.id == player.id) {
					dispatcher.reconcilePlayerEntity(m);
				} else {
					dispatcher.moveEntity(m);
				}

			case EntityRemoveMessage.code:
				var m: EntityRemoveMessage = cast message;
				dispatcher.removeEntity(m.id);
		} 
	}

	override function onDisconnect() {
		trace('Disconnected');
	}

	public function sendCommand(command) {
		send(command, false);
	}

}
