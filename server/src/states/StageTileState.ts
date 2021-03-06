import {Schema, type} from '@colyseus/schema';
import { Solid } from 'common';

export class StageTileState extends Schema implements Solid {
	@type('boolean')
	solid = false
}
