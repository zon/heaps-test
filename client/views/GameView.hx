package client.views;

import h2d.SpriteBatch;
import h2d.Object;
import client.Dispatcher;
import client.views.StageView;

class GameView {
	public var dispatcher: Dispatcher;
	public var game: Game;
	public var res: ResMap;
	public var obj: Object;
	public var stage: StageView;
	public var entities: SpriteBatch;

	public function new(dispatcher, game) {
		this.dispatcher = dispatcher;
		this.game = game;

		res = new ResMap();

		obj = new Object(dispatcher.app.s2d);
		obj.x = 0;
		obj.y = 0;
		obj.scale(8);

		entities = new SpriteBatch(res.general, obj);
		entities.hasUpdate = true;
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
		entities.add(view);
	}

}
