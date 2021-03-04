// Generated by Haxe 4.1.5
(function ($global) { "use strict";
var Entity = function(x,y) {
	this.radius = 0.25;
	this.speed = 4;
	this.x = x;
	this.y = y;
};
Entity.__name__ = true;
Entity.prototype = {
	left: function() {
		return Math.floor(this.x - this.radius);
	}
	,right: function() {
		return Math.ceil(this.x + this.radius) - 1;
	}
	,top: function() {
		return Math.floor(this.y - this.radius);
	}
	,bottom: function() {
		return Math.ceil(this.y + this.radius) - 1;
	}
	,update: function(dt) {
		this.vx = this.mx * this.speed;
		this.vy = this.my * this.speed;
	}
};
Math.__name__ = true;
var Movement = function() { };
Movement.__name__ = true;
Movement.update = function(world,dt) {
	var _g_head = world.entities.h;
	while(_g_head != null) {
		var val = _g_head.item;
		_g_head = _g_head.next;
		var entity = val;
		Movement.updateEntity(world.stage,entity,dt);
	}
};
Movement.updateEntity = function(stage,entity,dt) {
	var dx = entity.vx * dt;
	var dy = entity.vy * dt;
	entity.x += dx;
	var left = entity.left();
	var right = entity.right();
	var bottom = entity.bottom();
	var top = entity.top();
	if(entity.vx > 0) {
		if(stage.solidArea(right,top,right,bottom)) {
			entity.x = right - entity.radius;
		}
	} else if(entity.vx < 0) {
		if(stage.solidArea(left,top,left,bottom)) {
			entity.x = left + 1 + entity.radius;
		}
	}
	entity.y += dy;
	left = entity.left();
	right = entity.right();
	bottom = entity.bottom();
	top = entity.top();
	if(entity.vy > 0) {
		if(stage.solidArea(left,bottom,right,bottom)) {
			entity.y = bottom - entity.radius;
		}
	} else if(entity.vy < 0) {
		if(stage.solidArea(left,top,right,top)) {
			entity.y = top + 1 + entity.radius;
		}
	}
};
var Stage = function(size) {
	this.size = size;
	var this1 = new Array(size);
	this.tiles = this1;
	var _g = 0;
	var _g1 = size;
	while(_g < _g1) {
		var y = _g++;
		var this1 = this.tiles;
		var this2 = new Array(size);
		this1[y] = this2;
		var _g2 = 0;
		var _g3 = size;
		while(_g2 < _g3) {
			var x = _g2++;
			this.tiles[y][x] = new StageTile(x,y);
		}
	}
};
Stage.__name__ = true;
Stage.prototype = {
	valid: function(x,y) {
		if(x >= 0 && x < this.size && y >= 0) {
			return y < this.size;
		} else {
			return false;
		}
	}
	,get: function(x,y) {
		if(this.valid(x,y)) {
			return this.tiles[y][x];
		} else {
			return null;
		}
	}
	,solid: function(x,y) {
		if(this.valid(x,y)) {
			return this.get(x,y).solid;
		} else {
			return true;
		}
	}
	,solidArea: function(left,top,right,bottom) {
		var _g = top;
		var _g1 = bottom + 1;
		while(_g < _g1) {
			var y = _g++;
			var _g2 = left;
			var _g3 = right + 1;
			while(_g2 < _g3) {
				var x = _g2++;
				if(this.solid(x,y)) {
					haxe_Log.trace("solid",{ fileName : "haxe/common/Stage.hx", lineNumber : 43, className : "Stage", methodName : "solidArea", customParams : [x,y]});
					return true;
				}
			}
		}
		return false;
	}
	,enclose: function() {
		var _g = 0;
		var _g1 = this.size;
		while(_g < _g1) {
			var y = _g++;
			var _g2 = 0;
			var _g3 = this.size;
			while(_g2 < _g3) {
				var x = _g2++;
				if(y == 0 || x == 0 || y >= this.size - 1 || x >= this.size - 1) {
					this.get(x,y).solid = true;
				}
			}
		}
	}
};
var StageTile = function(x,y) {
	this.x = x;
	this.y = y;
};
StageTile.__name__ = true;
var Std = function() { };
Std.__name__ = true;
Std.string = function(s) {
	return js_Boot.__string_rec(s,"");
};
var World = function() {
	this.stage = new Stage(16);
	this.stage.enclose();
	this.stage.get(6,6).solid = true;
	this.entities = new haxe_ds_List();
};
World.__name__ = true;
World.prototype = {
	createEntity: function(x,y) {
		var entity = new Entity(x,y);
		this.entities.add(entity);
		return entity;
	}
	,update: function(dt) {
		var _g_head = this.entities.h;
		while(_g_head != null) {
			var val = _g_head.item;
			_g_head = _g_head.next;
			var entity = val;
			entity.update(dt);
		}
		Movement.update(this,dt);
	}
};
var haxe_Log = function() { };
haxe_Log.__name__ = true;
haxe_Log.formatOutput = function(v,infos) {
	var str = Std.string(v);
	if(infos == null) {
		return str;
	}
	var pstr = infos.fileName + ":" + infos.lineNumber;
	if(infos.customParams != null) {
		var _g = 0;
		var _g1 = infos.customParams;
		while(_g < _g1.length) {
			var v = _g1[_g];
			++_g;
			str += ", " + Std.string(v);
		}
	}
	return pstr + ": " + str;
};
haxe_Log.trace = function(v,infos) {
	var str = haxe_Log.formatOutput(v,infos);
	if(typeof(console) != "undefined" && console.log != null) {
		console.log(str);
	}
};
var haxe_ds_List = function() {
	this.length = 0;
};
haxe_ds_List.__name__ = true;
haxe_ds_List.prototype = {
	add: function(item) {
		var x = new haxe_ds__$List_ListNode(item,null);
		if(this.h == null) {
			this.h = x;
		} else {
			this.q.next = x;
		}
		this.q = x;
		this.length++;
	}
};
var haxe_ds__$List_ListNode = function(item,next) {
	this.item = item;
	this.next = next;
};
haxe_ds__$List_ListNode.__name__ = true;
var haxe_iterators_ArrayIterator = function(array) {
	this.current = 0;
	this.array = array;
};
haxe_iterators_ArrayIterator.__name__ = true;
haxe_iterators_ArrayIterator.prototype = {
	hasNext: function() {
		return this.current < this.array.length;
	}
	,next: function() {
		return this.array[this.current++];
	}
};
var js_Boot = function() { };
js_Boot.__name__ = true;
js_Boot.__string_rec = function(o,s) {
	if(o == null) {
		return "null";
	}
	if(s.length >= 5) {
		return "<...>";
	}
	var t = typeof(o);
	if(t == "function" && (o.__name__ || o.__ename__)) {
		t = "object";
	}
	switch(t) {
	case "function":
		return "<function>";
	case "object":
		if(((o) instanceof Array)) {
			var str = "[";
			s += "\t";
			var _g = 0;
			var _g1 = o.length;
			while(_g < _g1) {
				var i = _g++;
				str += (i > 0 ? "," : "") + js_Boot.__string_rec(o[i],s);
			}
			str += "]";
			return str;
		}
		var tostr;
		try {
			tostr = o.toString;
		} catch( _g ) {
			return "???";
		}
		if(tostr != null && tostr != Object.toString && typeof(tostr) == "function") {
			var s2 = o.toString();
			if(s2 != "[object Object]") {
				return s2;
			}
		}
		var str = "{\n";
		s += "\t";
		var hasp = o.hasOwnProperty != null;
		var k = null;
		for( k in o ) {
		if(hasp && !o.hasOwnProperty(k)) {
			continue;
		}
		if(k == "prototype" || k == "__class__" || k == "__super__" || k == "__interfaces__" || k == "__properties__") {
			continue;
		}
		if(str.length != 2) {
			str += ", \n";
		}
		str += s + k + " : " + js_Boot.__string_rec(o[k],s);
		}
		s = s.substring(1);
		str += "\n" + s + "}";
		return str;
	case "string":
		return o;
	default:
		return String(o);
	}
};
String.__name__ = true;
Array.__name__ = true;
js_Boot.__toStr = ({ }).toString;
})({});
