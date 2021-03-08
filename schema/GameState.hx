// 
// THIS FILE HAS BEEN GENERATED AUTOMATICALLY
// DO NOT CHANGE IT MANUALLY UNLESS YOU KNOW WHAT YOU'RE DOING
// 
// GENERATED USING @colyseus/schema 1.0.13
// 


import io.colyseus.serializer.schema.Schema;
import io.colyseus.serializer.schema.types.*;

class GameState extends Schema {
	@:type("ref", StageState)
	public var stage: StageState = new StageState();

	@:type("map", EntityState)
	public var entities: MapSchema<EntityState> = new MapSchema<EntityState>();

}
