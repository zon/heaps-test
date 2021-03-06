import {Schema, ArraySchema, type} from '@colyseus/schema';
import { Stage, StageQuery } from 'common';
import { StageTileState } from './StageTileState';

export class StageState extends Schema implements Stage {
	@type('uint16')
	size: number;
	@type([StageTileState])
	tiles = new ArraySchema<StageTileState>();

	static create(size: number = 16) {
		const state = new StageState();
		state.size = size;
		state.tiles = new ArraySchema(...new Array(size * size).map(_ => new StageTileState()));
		StageQuery.enclose(state);
		StageQuery.get(state, 6, 6).solid = true;
		return state;
	}

}
