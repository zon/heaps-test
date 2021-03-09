package common.messages;

import haxe.io.Bytes;

@:build(bytetype.ByteTypeBuilder.build())
abstract StageMessage(Bytes) to Bytes {
	var length: Int;
}
