package common.messages;

import haxe.io.Bytes;

@:build(bytetype.ByteTypeBuilder.build())
abstract PlayerMoveMessage(Bytes) to Bytes {
	var x: Float;
	var y: Float;
}
