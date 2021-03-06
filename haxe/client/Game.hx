import haxe.ds.Map;

class Game {
	public var stage: Stage;
	public var entities: Map<String, Entity>;

	public function new() {
		this.stage = new Stage(16);
		this.stage.enclose();
		this.stage.get(6, 6).solid = true;
		this.entities = [];
	}

	public function createEntity(id, x, y) {
		var entity = new Entity(id, x, y);
		entities[id] = entity;
		return entity;
	}

	public function removeEntityById(id) {
		return entities.remove(id);
	}

	public function update(dt: Float) {
		for (entity in this.entities) {
			entity.update(dt);
		}
		Movement.update(this, dt);
	}

}
