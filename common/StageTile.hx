package common;

import common.messages.StageTileMessage;

class StageTile {
	public var x = 0;
	public var y = 0;
	public var solid = false;

	public function new() {}

	public function toMessage() {
		var msg = new StageTileMessage(solid ? 1 : 0);
		return msg;
	}

	public function load(msg: StageTileMessage) {
		solid = msg.solid != 0;
	}

}
