package common.messages;

import haxe.io.Bytes;

@:build(bytetype.ByteTypeBuilder.build())
abstract EntityAddMessage(Bytes) to Bytes {
	var id: Int;
	var playerId: Int;
	var radius: Float;
	var speed: Float;
	var x: Float;
	var y: Float;
	var vx: Float;
	var vy: Float;
}
