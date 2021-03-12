package common.messages;

import haxe.io.Bytes;

@:build(bytetype.ByteTypeBuilder.build())
abstract EntityPositionMessage(Bytes) to Bytes {
	var id: Int;
	var x: Float;
	var y: Float;

	public function toString() {
		return 'EntityPositionMessage { $id, $x, $y }';
	}

}
