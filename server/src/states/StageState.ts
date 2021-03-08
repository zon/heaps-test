import {Schema, ArraySchema, type} from '@colyseus/schema';
import { StageQuery } from '../common/StageQuery';
import { StageTileState } from './StageTileState';

export class StageState extends Schema {
	@type('uint16')
	size: number;
	@type([StageTileState])
	tiles = new ArraySchema<StageTileState>();

	static create(size: number = 16) {

		const tiles = new Array<StageTileState>(size * size);
		for (let y = 0; y < size; y++) {
			for (let x = 0; x < size; x++) {
				const tile = new StageTileState();
				tile.x = x;
				tile.y = y;
				tiles[y * size + x] = tile;
			}
		}

		const state = new StageState();
		state.size = size;
		state.tiles = new ArraySchema(...tiles);
		
		StageQuery.enclose(state);
		StageQuery.get(state, 6, 6).solid = true;
		
		return state;
	}

}
