import {Schema, type} from '@colyseus/schema';
import { Entity } from 'common';

export class EntityState extends Schema implements Entity {
	@type('string')
	id: string;
	@type('float64')
	radius: number;
	@type('float64')
	speed: number;
	@type('float64')
	x = 0;
	@type('float64')
	y = 0;
	@type('float64')
	vx = 0;
	@type('float64')
	vy = 0;
	@type('float64')
	mx = 0;
	@type('float64')
	my = 0;

	static create(id: string, radius: number = 0.25, speed: number = 4) {
		const state = new EntityState();
		state.id = id;
		state.radius = radius;
		state.speed = speed;
		return state;
	}
}
