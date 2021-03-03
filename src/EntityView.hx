import h2d.SpriteBatch;

class EntityView extends SpriteBatch.BatchElement {
	public var entity: Entity;

	public function new (entity: Entity, res: ResMap) {
		var tile = res.getTile(2);
		tile.dx = View.tile / -2;
		tile.dy = -View.tile;
		super(tile);
		this.entity = entity;
	}

	override function update(dt:Float):Bool {
		super.update(dt);
		this.x = this.entity.x * View.tile;
		this.y = (this.entity.y + this.entity.radius) * View.tile;
		return true;
	}

}
