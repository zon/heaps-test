package common.messages;

import haxe.io.Bytes;

@:build(bytetype.ByteTypeBuilder.build())
abstract EntityMoveMessage(Bytes) to Bytes {
	var id: Int;
	var command: Int;
	var x: Float;
	var y: Float;
	var vx: Float;
	var vy: Float;

	public function toString() {
		return 'EntityMoveMessage { '+ id +', '+ command +', '+ x +', '+ y +', '+ vx +', '+ vy +' }';
	}

}
