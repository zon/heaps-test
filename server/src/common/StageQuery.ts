import { StageState } from '../states/StageState';

export class StageQuery {

	public static index(stage: StageState, x: number, y: number) {
		return y * stage.size + x;
	}

	public static valid(stage: StageState, x: number, y: number) {
		const size = stage.size;
		return x >= 0 && x < size && y >= 0 && y < size;
	}

	public static get(stage: StageState, x: number, y: number) {
		if (this.valid(stage, x, y)) {
			return stage.tiles[this.index(stage, x, y)];
		} else {
			return null;
		}
	}

	public static solid(stage: StageState, x: number, y: number) {
		if (this.valid(stage, x, y)) {
			return this.get(stage, x, y).solid;
		} else {
			return true;
		}
	}

	public static solidArea(stage: StageState, left: number, top: number, right: number, bottom: number) {
		for (let y = top; y <= bottom; y++) {
			for (let x = left; x <= right; x++) {
				if (this.solid(stage, x, y)) {
					return true;
				}
			}
		}
		return false;
	}

	public static enclose(stage: StageState) {
		var size = stage.size;
		for (let y = 0; y < size; y++) {
			for (let x = 0; x < size; x++) {
				if (y == 0 || x == 0 || y >= size -1 || x >= size - 1) {
					this.get(stage, x, y).solid = true;
				}
			}
		}
	}

}
