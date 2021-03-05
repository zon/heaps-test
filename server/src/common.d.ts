declare module 'common' {
	export interface Entity {}
	export interface Movement {}
	export class Stage {
		size: number
		tiles: StageTile[][]
		constructor(size: number)
		valid(x: number, y: number): boolean
		get(x: number, y: number): StageTile | null
		solid(x: number, y: number): boolean
		solidArea(left: number, top: number, right: number, bottom: number): boolean
		enclose(): void
	}
	export class StageTile {
		x: number
		y: number
		solid: boolean
		constructor(x: number, y: number)
	}
	export interface World {}
}
