package server;

import haxe.io.Bytes;
import common.Entity;
import common.messages.PlayerMessage;
import common.messages.PlayerMoveMessage;
import bytetype.ByteType;
import udprotean.server.UDProteanClientBehavior;

class ClientBehavior extends UDProteanClientBehavior {
	public var id: Int;
	public var dispatcher: Dispatcher;
	public var entity: Entity;

	override function onConnect() {
		send(new PlayerMessage(id));
		dispatcher.game.stage.send(this);
		for (entity in dispatcher.game.entities) {
			send(entity.toAddMessage());
		}
		entity = dispatcher.game.createEntity(id, 8, 8);
	}

	override function onMessage(message: Bytes) {
		switch ByteType.getCode(message) {
			case PlayerMoveMessage.code:
				var move: PlayerMoveMessage = cast message;
				entity.mx = move.x;
				entity.my = move.y;
		}
	}

	override function onDisconnect() {
		dispatcher.game.removeEntity(entity);
	}
 
}
