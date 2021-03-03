import haxe.ds.List;

class World {
	public var stage: Stage;
	public var entities: List<Entity>;

	public function new() {
		this.stage = new Stage(16);
		this.stage.enclose();
		this.stage.get(6, 6).solid = true;
		this.entities = new List<Entity>();
	}

	public function createEntity(x, y) {
		var entity = new Entity(x, y);
		this.entities.add(entity);
		return entity;
	}

	public function update(dt: Float) {
		for (entity in this.entities) {
			entity.update(dt);
		}
		Movement.update(this, dt);
	}

}
