import {Schema, type} from '@colyseus/schema';

export class StageTileState extends Schema {
	@type('int64')
	x = 0
	@type('int64')
	y = 0
	@type('boolean')
	solid = false
}
