package common.messages;

import haxe.io.Bytes;

@:build(bytetype.ByteTypeBuilder.build())
abstract StageTileMessage(Bytes) to Bytes {
	var solid: UInt;
}
