package client.views;

import client.ClientEntity;
import h2d.SpriteBatch;

class EntityView extends SpriteBatch.BatchElement {
	public var entity: ClientEntity;

	public function new(entity: ClientEntity, res: ResMap) {
		var tile = res.entity.getTile(0);
		tile.dx = tile.width / -2;
		tile.dy = -tile.height;
		super(tile);
		this.entity = entity;
	}

	override function update(dt:Float):Bool {
		super.update(dt);
		x = entity.x * View.tile;
		y = (entity.y + entity.radius) * View.tile;
		return entity.active;
	}

}
