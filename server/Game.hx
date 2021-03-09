package server;

import haxe.Int64;
import common.Stage;
import common.Entity;
import common.Movement;
import server.Dispatcher;

class Game {
	public var dispatcher: Dispatcher;
	public var stage: Stage;
	public var entities = new Map<Int, Entity>();

	var autoId: Int = 0;

	public function new(dispatcher) {
		this.dispatcher = dispatcher;

		stage = new Stage(16);
		stage.enclose();
		stage.get(6, 6).solid = true;
	}

	public function update(dt: Float) {
		for (entity in entities) {
			Movement.update(stage, entity, dt);
		}
	}

	public function createEntity(player, x, y) {
		while (autoId == 0 || entities.exists(autoId)) {
			autoId += 1;
		}
		var entity = new Entity(autoId);
		entity.player = player;
		entity.x = x;
		entity.y = y;
		entities[entity.id] = entity;
		dispatcher.sendAll(entity.toAddMessage());
		return entity;
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

	public function removeEntity(entity: Entity) {
		entities.remove(entity.id);
		dispatcher.sendAll(entity.toRemoveMessage());
	}
	
}
