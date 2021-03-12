package common;

class Calc {

	public static function lerp(a: Float, b: Float, p: Float) {
		return a + (b - a) * p;
	}
	
	public static function invLerp(a: Float, b: Float, v: Float) {
		return (v - a) / (b - a);
	}

}
