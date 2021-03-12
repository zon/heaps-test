package server;

import haxe.io.Bytes;
import common.messages.PlayerMessage;
import common.messages.CommandMessage;
import server.ServerEntity;
import bytetype.ByteType;
import udprotean.server.UDProteanClientBehavior;

class ClientBehavior extends UDProteanClientBehavior {
	public var id: Int;
	public var dispatcher: Dispatcher;
	public var entity: ServerEntity;

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
			case CommandMessage.code:
				var command: CommandMessage = cast message;
				dispatcher.reconcileEntity(entity, command);
		}
	}

	override function onDisconnect() {
		dispatcher.game.removeEntity(entity);
	}
 
}
