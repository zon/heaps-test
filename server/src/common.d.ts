declare module 'common' {

	export namespace Bounds {
		export function left(entity: Entity): number
		export function right(entity: Entity): number
		export function top(entity: Entity): number
		export function bottom(entity: Entity): number
	}

	export interface Entity {
		id: string
		radius: number
		speed: number
		x: number
		y: number
		vx: number
		vy: number
		mx: number
		my: number
	}

	export namespace Movement {
		export function update(stage: Stage, entity: Entity, dt: number): void
	}

	export interface Solid {
		solid: boolean
	}

	export class Stage {
		size: number
		tiles: Iterable<Solid>
	}

	export namespace StageQuery {
		export function valid(stage: Stage, x: number, y: number): boolean
		export function get(stage: Stage, x: number, y: number): Solid | null
		export function solid(stage: Stage, x: number, y: number): boolean
		export function solidArea(stage: Stage, left: number, top: number, right: number, bottom: number): boolean
		export function enclose(stage: Stage): void
	}

}
