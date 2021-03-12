package client;

import haxe.io.Bytes;
import bytetype.ByteType;
import udprotean.client.UDProteanClient;
import common.messages.*;
import common.Player;
import common.Stage;
import client.Dispatcher;
import client.ClientEntity;
import client.PlayerEntity;
import client.OtherEntity;
import client.Console;

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
				if (isPlayer(m.id)) {
					dispatcher.addPlayer(PlayerEntity.parse(m));
				} else {
					dispatcher.addOther(OtherEntity.parse(m));
				}

			case EntityPositionMessage.code:
				var m: EntityPositionMessage = cast message;
				dispatcher.positionOther(m);

			case EntityReconcileMessage.code:
				var m: EntityReconcileMessage = cast message;
				dispatcher.reconcilePlayer(m);

			case EntityRemoveMessage.code:
				var m: EntityRemoveMessage = cast message;
				if (isPlayer(m.id)) {
					dispatcher.removePlayer(m.id);
				} else {
					dispatcher.removeOther(m.id);
				}
		} 
	}

	override function onDisconnect() {
		trace('Disconnected');
		Sys.exit(0);
	}

	public function sendCommand(command: CommandMessage) {
		send(command, false);
	}

	function isPlayer(id: Int) {
		return player != null && id == player.id;
	}

}
