package client.views;

import client.ClientEntity;
import h2d.Object;
import h2d.Bitmap;
import h2d.Anim;
import h2d.Tile;

class EntityView {
	public var entity: ClientEntity;
	public var obj: Object;
	public var standRight: Bitmap;
	public var standDown: Bitmap;
	public var standUp: Bitmap;
	public var walkRight: Anim;
	public var walkDown: Anim;
	public var walkUp: Anim;
	public var animation(default, set): EntityAnimation;

	var dx = 0.0;
	var dy = 1.0;

	function set_animation(v) {
		if (v != animation) {
			standRight.visible = v == StandLeft || v == StandRight;
			standDown.visible = v == StandDown;
			standUp.visible = v == StandUp;
			walkRight.visible = v == WalkLeft || v == WalkRight;
			walkDown.visible = v == WalkDown;
			walkUp.visible = v == WalkUp;
			obj.scaleX = v == StandRight || v == WalkRight ? 1 : -1;
		}
		return animation = v;
	}

	public function new(entity: ClientEntity, res: ResMap) {
		this.entity = entity;

		obj = new Object();

		standRight = new Bitmap(res.entity.getTileByTag('stand side'), obj);
		align(standRight, standRight.tile);
		standDown = new Bitmap(res.entity.getTileByTag('stand down'), obj);
		align(standDown, standDown.tile);
		standUp = new Bitmap(res.entity.getTileByTag('stand up'), obj);
		align(standUp, standUp.tile);

		var speed = 10;
		walkRight = res.entity.getAnim('walk side');
		walkRight.speed = speed;
		align(walkRight, walkRight.getFrame());
		walkDown = res.entity.getAnim('walk down');
		walkDown.speed = speed;
		align(walkDown, walkDown.getFrame());
		walkUp = res.entity.getAnim('walk up');
		walkUp.speed = speed;
		align(walkUp, walkUp.getFrame());

		animation = StandDown;
	}

	function align(child: Object, tile: Tile) {
		obj.addChild(child);
		child.x = tile.width / -2;
		child.y = -tile.height;
	}

	public function update(dt: Float) {
		obj.x = entity.x * View.tile;
		obj.y = (entity.y + entity.radius) * View.tile;

		var walking = entity.vx != 0 || entity.vy != 0;
		if (walking) {
			dx = entity.vx;
			dy = entity.vy;
		}

		if (walking) {
			if (dx != 0) {
				animation = dx < 0 ? WalkLeft : WalkRight;
			} else {
				animation = dy < 0 ? WalkUp : WalkDown;
			}
		} else {
			if (dy != 0) {
				animation = dy < 0 ? StandUp : StandDown;
			} else {
				animation = dx < 0 ? StandLeft : StandRight;
			}
		}
	}

}

enum EntityAnimation {
	StandLeft;
	StandRight;
	StandUp;
	StandDown;
	WalkLeft;
	WalkRight;
	WalkUp;
	WalkDown;
}
