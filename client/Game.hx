package client;

import common.Stage;
import common.Entity;
import common.Movement;
import client.Dispatcher;

class Game {
	public var dispatcher: Dispatcher;
	public var stage: Stage;
	public var entities = new Map<String, Entity>();

	public function new(dispatcher: Dispatcher) {
		this.dispatcher = dispatcher;
	}

	public function update(dt: Float) {
		for (entity in entities) {
			Movement.update(stage, entity, dt);
		}
	}

	public function onStage(stage: Stage) {
		this.stage = stage;
	}

	public function addEntity(key: String, entity: Entity) {
		entities[key] = entity;
	}

	public function removeEntity(key: String, entity: Entity) {
		entities[key].active = false; 
		entities.remove(key);
	}

}
