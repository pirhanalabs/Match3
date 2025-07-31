package utils;

enum InputID
{
	Interact;
	Cancel;
	Settings;
	MoveUp;
	MoveDw;
	MoveRt;
	MoveLt;
}

class Inputs
{
	private static final inputs:Map<InputID, engine.InputBinding> = new Map();

	public static function Init(inputs:engine.InputManager)
	{
		registerInput(inputs, Interact, A, hxd.Key.SPACE, null);
		registerInput(inputs, Cancel, B, hxd.Key.ESCAPE, null);
		registerInput(inputs, Settings, SELECT, hxd.Key.ESCAPE, null);
		registerInput(inputs, MoveUp, DPAD_UP, hxd.Key.W, engine.Direction.N);
		registerInput(inputs, MoveDw, DPAD_DOWN, hxd.Key.S, engine.Direction.S);
		registerInput(inputs, MoveRt, DPAD_RIGHT, hxd.Key.D, engine.Direction.E);
		registerInput(inputs, MoveLt, DPAD_LEFT, hxd.Key.A, engine.Direction.W);
	}

	public inline static function pressed(id:InputID)
	{
		return inputs.get(id).isPressed();
	}

	public inline static function down(id:InputID)
	{
		return inputs.get(id).isDown();
	}

	public inline static function released(id:InputID)
	{
		return inputs.get(id).isReleased();
	}

	public static function getString(id:InputID)
	{
		return inputs.get(id).getName();
	}

	private static function registerInput(inputs:engine.InputManager, id:InputID, btn:engine.PadButton, key:Int, ?dir:engine.Direction)
	{
		var i = inputs.createBinding(key, btn);
		i.direction = dir;
		Inputs.inputs.set(id, i);
	}
}
