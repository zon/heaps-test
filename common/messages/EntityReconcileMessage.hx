package common.messages;

import haxe.io.Bytes;

@:build(bytetype.ByteTypeBuilder.build())
abstract EntityReconcileMessage(Bytes) to Bytes {
	var commandIndex: Int;
	var x: Float;
	var y: Float;
	var vx: Float;
	var vy: Float;

	public function toString() {
		return 'EntityReconcileMessage { $commandIndex, $x, $y, $vx, $vy }';
	}

}
