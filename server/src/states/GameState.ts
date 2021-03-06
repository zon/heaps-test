import {Schema, MapSchema, type} from '@colyseus/schema';
import { EntityState } from './EntityState';
import { StageState } from './StageState';

export class GameState extends Schema {
	@type(StageState)
	stage: StageState;
	@type({ map: EntityState })
	entities = new MapSchema<EntityState>();
}
