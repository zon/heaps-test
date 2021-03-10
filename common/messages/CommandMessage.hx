package common.messages;

import haxe.io.Bytes;

@:build(bytetype.ByteTypeBuilder.build())
abstract CommandMessage(Bytes) to Bytes {
	var index: Int;
	var x: Float;
	var y: Float;
	var dt: Float;

	public function toString() {
		return 'CommandMessage {$index, $x, $y, $dt}';
	}

}
