import { Room, Client } from 'colyseus'
import { Stage } from 'common'

export class StageRoom extends Room {
	stage: Stage;

	constructor() {
		super();
		this.stage = new Stage(16)
		this.stage.enclose();
		this.stage.get(6, 6).solid = true;
	}

}
