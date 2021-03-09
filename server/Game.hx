package server;

import haxe.Int32;
import common.Stage;
import common.Entity;
import common.Movement;
import server.Dispatcher;

class Game {
	public var dispatcher: Dispatcher;
	public var stage: Stage;
	public var entities = new Map<Int32, Entity>();

	var autoId: Int32 = 0;

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

	public function createEntity(x, y) {
		while (autoId == 0 || entities.exists(autoId)) {
			autoId += 1;
		}
		var entity = new Entity(autoId);
		entity.x = x;
		entity.y = y;
		entities[entity.id] = entity;
		return entity;
	}

	public function removeEntity(key, entity) {
		entities[key].active = false; 
		entities.remove(key);
	}
	
}
