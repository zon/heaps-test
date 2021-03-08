package common;

import h2d.Interactive;
import h2d.Graphics;
import hxbit.NetworkSerializable;

class Cursor implements NetworkSerializable {
	@:s var color: Int;
	@:s public var uid: Int;
	@:s public var x(default, set): Float;
	@:s public var y(default, set): Float;

	var net: Network;
	var bmp: Graphics;

	public function new(color, uid = 0) {
		this.color = color;
		this.uid = uid;
		init();
		x = 0;
		y = 0;
	}

	public function networkAllow(op: NetworkSerializable.Operation, prodId: Int, client: NetworkSerializable) {
		return client == this;
	}

	function set_x(v: Float) {
		if (v == x) return v;
		if (bmp != null) bmp.x = v;
		return this.x = v;
	}

	function set_y(v: Float) {
		if (v == y) return v;
		if (bmp != null) bmp.y = v;
		return this.x = y;
	}

	public function toString() {
		return "Cursor "+ StringTools.hex(color, 6) + (enableReplication ? ":ALIVE" : "");
	}

	function init() {
		net = Network.inst;
		net.log("Init " + this);

		bmp = new Graphics(net.s2d);
		bmp.beginFill(color, 0.5);
		bmp.drawCircle(0, 0, 10);
		bmp.beginFill(color);
		bmp.drawCircle(0, 0, 5);

		enableReplication = true;

		var i = new Interactive(10, 10, bmp);
		i.x = i.y = -5;
		i.isEllipse = true;
		i.onClick = function(_) blink(2 + Math.random() * 2);
	}

	@:rpc function blink(s: Float) {
		bmp.scale(s);
		net.event.waitUntil(function(dt) {
			bmp.scaleX *= Math.pow(0.9, dt * 60);
			bmp.scaleY *= Math.pow(0.9, dt * 60);
			if (bmp.scaleX < 1) {
				bmp.scaleX = bmp.scaleY = 1;
				return true;
			}
			return false;
		});
	}

	public function alive() {
		init();
		// refresh bmp
		this.x = x;
		this.y = y;
		if( uid == net.uid ) {
			net.cursor = this;
			net.host.self.ownerObject = this;
		}
	}
}
