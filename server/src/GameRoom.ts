import { Room, Client } from 'colyseus'
import { Movement } from './common/Movement';
import { EntityState } from './states/EntityState'
import { GameState } from './states/GameState'
import { StageState } from './states/StageState'

export class GameRoom extends Room<GameState> {

	onCreate(options: any) {
		const state = new GameState();
		state.stage = StageState.create();
		this.setState(state);
		this.setSimulationInterval(dt => this.update(dt));
		this.onMessage('move', (client, msg) => this.onMove(client, msg));
	}

	onJoin(client: Client, options: any) {
		console.log(`Client ${client.sessionId} joined`);
		const entity = EntityState.create(client.sessionId);
		this.state.entities.set(client.sessionId, entity);
	}

	onLeave(client: Client, consented: boolean) {
		if (consented) {
			console.log(`Client ${client.sessionId} left`);
		} else {
			console.log(`Client ${client.sessionId} disconnected`);
		}
		if (this.state.entities.has(client.sessionId)) {
			this.state.entities.delete(client.sessionId);
		}
	}

	onMove(client: Client, msg: any) {
		const entity = this.state.entities.get(client.sessionId);
		entity.mx = msg.x;
		entity.my = msg.y;
	}

	update(dt: number) {
		this.state.entities.forEach(entity => Movement.update(this.state.stage, entity, dt));
	}

}
