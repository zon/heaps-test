import h2d.Object;
import h2d.SpriteBatch;

class WorldView {
	public var res: ResMap;
	public var world: World;
	public var obj: Object;
	public var stage: StageView;
	public var sprites: SpriteBatch;

	public function new(parent, world, res) {
		this.res = res;
		this.world = world;
		this.obj = new Object(parent);
		this.obj.x = 0;
		this.obj.y = 0;
		this.obj.scale(8);
		this.stage = new StageView(this.obj, world.stage, res);
		this.sprites = new SpriteBatch(res.general, this.obj);
		this.sprites.hasUpdate = true;
	}

	public function createEntity(entity: Entity) {
		var e = new EntityView(entity, this.res);
		this.sprites.add(e);
	}

}
