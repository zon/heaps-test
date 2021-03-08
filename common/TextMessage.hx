package common;

import haxe.io.Bytes;

@:build(bytetype.ByteTypeBuilder.build())
abstract TextMessage(Bytes) to Bytes {
	@length(16) var body: String;
}
