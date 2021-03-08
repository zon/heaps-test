import h2d.Object;
import h2d.SpriteBatch;
import io.colyseus.Room;

class Game {
	public var room: Room<GameState>;

	public var player: Player;

	public var res: ResMap;
	public var obj: Object;
	public var stage: StageView;
	public var sprites: SpriteBatch;
	public var entities = new Map<String, EntityView>();

	public function new(parent, room, res) {
		this.res = res;
		this.room = room;

		obj = new Object(parent);
		obj.x = 0;
		obj.y = 0;
		obj.scale(8);

		room.state.entities.onAdd = createEntity;
		room.state.entities.onRemove = removeEntity;

		sprites = new SpriteBatch(res.general, obj);
		sprites.hasUpdate = true;
	}

	public function update(dt: Float) {
		if (player != null) {
			player.update(dt);
		}
		for (entity in room.state.entities) {
			Movement.update(room.state.stage, entity, dt);
		}
	}

	function createStage(state: StageState, key: String) {
		stage = new StageView(obj, state, res);
	}

	function createEntity(entity: EntityState, key: String) {
		if (key == room.sessionId) {
			player = new Player(room, entity);
		}

		var view = new EntityView(entity, res);
		sprites.add(view);
		entities[key] = view;
	}

	function removeEntity(entity: EntityState, key: String) {
		entities[key].active = false; 
		entities.remove(key);
	}

}
