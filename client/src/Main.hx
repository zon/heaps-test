import hxd.App;

class Main extends App {
	public var res: ResMap;
	public var world: World;
	public var view: WorldView;
	public var player: Player;

	override function init() {
		this.res = new ResMap();
		this.world = new World();
		this.view = new WorldView(s2d, world, res); 

		createPlayer();
	}

	function createPlayer(x = 8, y = 8) {
		var entity = this.world.createEntity(x, y);
		this.player = new Player(entity);
		this.view.createEntity(entity);
		return this.player;
	}

	override function update(dt: Float) {
		this.player.update(dt);
		this.world.update(dt);
		// this.view.update(dt);
	}

	static function main() {
		new Main();
	}

}
