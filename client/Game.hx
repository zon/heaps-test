package client;

import common.messages.EntityMoveMessage;
import common.Stage;
import common.Movement;
import client.Dispatcher;
import client.ClientEntity;

class Game {
	public var dispatcher: Dispatcher;
	public var stage: Stage;
	public var entities = new Map<Int, ClientEntity>();

	public function new(dispatcher: Dispatcher) {
		this.dispatcher = dispatcher;
	}

	public function update(dt) {
		for (entity in entities) {
			Movement.update(stage, entity, dt);
		}
	}

	public function setStage(stage) {
		this.stage = stage;
	}

	public function addEntity(entity: ClientEntity) {
		entities[entity.id] = entity;
	}

	public function moveEntity(msg: EntityMoveMessage) {
		var entity = entities.get(msg.id);
		if (entity == null) return;
		entity.apply(msg);
	}

	public function reconcilePlayerEntity(msg: EntityMoveMessage) {
		var entity = entities.get(msg.id);
		if (entity == null) return;
		entity.reconcile(stage, msg);
	}

	public function removeEntity(id: Int) {
		var entity = entities.get(id);
		if (entity != null) {
			entity.active = false;
		}
		entities.remove(id);
	}

}
