import { EntityState } from '../states/EntityState';

export class Bounds {

	public static left(entity: EntityState) {
		return Math.floor(entity.x - entity.radius);
	}

	public static right(entity: EntityState) {
		return Math.ceil(entity.x + entity.radius) - 1;
	}

	public static top(entity: EntityState) {
		return Math.floor(entity.y - entity.radius);
	}

	public static bottom(entity: EntityState) {
		return Math.ceil(entity.y + entity.radius) - 1;
	}

}
