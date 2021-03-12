package client;

import haxe.Timer;
import common.Stage;
import common.Movement;
import common.messages.EntityPositionMessage;
import common.messages.EntityReconcileMessage;
import client.Dispatcher;
import client.OtherEntity;
import client.PlayerEntity;

class Game {
	public var dispatcher: Dispatcher;
	public var stage: Stage;
	public var others = new Map<Int, OtherEntity>();
	public var player: PlayerEntity;

	public function new(dispatcher: Dispatcher) {
		this.dispatcher = dispatcher;
	}

	public function update(dt) {
		var now = Timer.stamp();
		for (other in others) {
			other.interpolate(now);
		}
		if (player != null) {
			Movement.update(stage, player, dt);
		}
	}

	public function setStage(stage) {
		this.stage = stage;
	}

	public function addOther(entity: OtherEntity) {
		others[entity.id] = entity;
	}

	public function addPlayer(entity: PlayerEntity) {
		player = entity;
	}

	public function positionOther(message: EntityPositionMessage) {
		var other = others.get(message.id);
		if (other == null) return;
		other.apply(message);
	}

	public function reconcilePlayer(message: EntityReconcileMessage) {
		if (player == null) return;
		player.reconcile(stage, message);
	}

	public function removeOther(id: Int) {
		var other = others.get(id);
		if (other != null) {
			other.active = false;
		}
		others.remove(id);
	}

	public function removePlayer() {
		if (player == null) return;
		player.active = false;
		player = null;
	}

}
