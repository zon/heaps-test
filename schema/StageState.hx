// 
// THIS FILE HAS BEEN GENERATED AUTOMATICALLY
// DO NOT CHANGE IT MANUALLY UNLESS YOU KNOW WHAT YOU'RE DOING
// 
// GENERATED USING @colyseus/schema 1.0.13
// 


import io.colyseus.serializer.schema.Schema;
import io.colyseus.serializer.schema.types.*;

class StageState extends Schema {
	@:type("uint16")
	public var size: UInt = 0;

	@:type("array", StageTileState)
	public var tiles: ArraySchema<StageTileState> = new ArraySchema<StageTileState>();

}
