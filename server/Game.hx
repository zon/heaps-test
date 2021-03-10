package server;

import common.Movement;
import common.messages.CommandMessage;
import common.Stage;
import server.Dispatcher;
import server.ServerEntity;

class Game {
	public var dispatcher: Dispatcher;
	public var stage: Stage;
	public var entities = new Map<Int, ServerEntity>();

	var autoId: Int = 0;

	public function new(dispatcher) {
		this.dispatcher = dispatcher;

		stage = new Stage(16);
		stage.enclose();
		stage.get(6, 6).solid = true;
	}

	public function createEntity(player, x, y) {
		while (autoId == 0 || entities.exists(autoId)) {
			autoId += 1;
		}
		var entity = new ServerEntity(autoId);
		entity.player = player;
		entity.x = x;
		entity.y = y;
		entities[entity.id] = entity;
		dispatcher.sendAll(entity.toAddMessage());
		return entity;
	}

	public function updateEntity(entity: ServerEntity, command: CommandMessage) {
		entity.command = command;
		entity.update();
		Movement.update(stage, entity, command.dt);
		dispatcher.sendAll(entity.toMoveMessage());
	}

	public function removeEntityByPlayer(player) {
		for (entity in entities) {
			if (entity.player == player) {
				removeEntity(entity);
				return true;
			}
		}
		return false;
	}

	public function removeEntity(entity: ServerEntity) {
		entities.remove(entity.id);
		dispatcher.sendAll(entity.toRemoveMessage());
	}
	
}
