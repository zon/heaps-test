package client.views;

import h2d.SpriteBatch;
import h2d.Object;
import client.Dispatcher;
import client.views.StageView;
import client.Console;

class GameView {
	public var dispatcher: Dispatcher;
	public var game: Game;
	public var res: ResMap;
	public var obj: Object;
	public var stage: StageView;
	public var entityLayer: Object;
	public var entities: Array<EntityView>;
	public var console: Console;

	public function new(dispatcher, game) {
		this.dispatcher = dispatcher;
		this.game = game;

		res = new ResMap();

		obj = new Object(dispatcher.app.s2d);
		obj.x = 0;
		obj.y = 0;
		obj.scale(8);

		entityLayer = new Object(obj);
		entities = new Array<EntityView>();

		console = new Console(dispatcher.app.s2d);
	}

	public function update(dt) {
		for (entity in entities) {
			entity.update(dt);
		}
		console.update();
	}

	public function setStage(stage) {
		if (this.stage != null) {
			this.stage.remove();
		}
		this.stage = new StageView(stage, res);
		obj.addChildAt(this.stage.group, 0);
	}

	public function addEntity(entity) {
		var view = new EntityView(entity, res);
		entityLayer.addChild(view.obj);
		entities.push(view);
	}

	public function removeEntity(id) {
		for (i in 0...entities.length) {
			var view = entities[i];
			if (view.entity.id == id) {
				view.obj.remove();
				entities.slice(i, 1);
				return true;
			}
		}
		return false;
	}

}
