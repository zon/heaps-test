// 
// THIS FILE HAS BEEN GENERATED AUTOMATICALLY
// DO NOT CHANGE IT MANUALLY UNLESS YOU KNOW WHAT YOU'RE DOING
// 
// GENERATED USING @colyseus/schema 1.0.13
// 


import io.colyseus.serializer.schema.Schema;
import io.colyseus.serializer.schema.types.*;

class EntityState extends Schema {
	@:type("string")
	public var id: String = "";

	@:type("float64")
	public var radius: Float = 0;

	@:type("float64")
	public var speed: Float = 0;

	@:type("float64")
	public var x: Float = 0;

	@:type("float64")
	public var y: Float = 0;

	@:type("float64")
	public var vx: Float = 0;

	@:type("float64")
	public var vy: Float = 0;

	@:type("float64")
	public var mx: Float = 0;

	@:type("float64")
	public var my: Float = 0;

}
