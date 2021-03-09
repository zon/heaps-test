package common.messages;

import haxe.io.Bytes;

@:build(bytetype.ByteTypeBuilder.build())
abstract EntityRemoveMessage(Bytes) to Bytes {
	var id: Int;
}
