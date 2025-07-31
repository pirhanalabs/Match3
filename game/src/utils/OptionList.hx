package utils;

interface IOptionListItem
{
	var x(default, set):Float;
	var y(default, set):Float;
	function onOver():Void;
	function onOut():Void;
	function onSelect():Void;
	function update(frame:Frame):Void;
	function postupdate():Void;
}

abstract class OptionListItem extends h2d.Object implements IOptionListItem
{
	abstract public function onSelect():Void;

	public function onOver() {}

	public function onOut() {}

	public function update(frame:Frame) {}

	public function postupdate() {}
}

interface IOptionList
{
	var x(get, never):Int;
	var y(get, never):Int;
	function get():IOptionListItem;
	function up():Bool;
	function down():Bool;
	function left():Bool;
	function right():Bool;
	function select():Void;
	function update(frame:Frame):Void;
	function postupdate():Void;
	function getRows():Int;
	function getCols():Int;
	function set(x:Int, y:Int):Bool;
}

class OptionList<T:IOptionListItem> implements IOptionList
{
	public var wrap:Bool = false;
	public var list:Array<T> = [];
	public var cols(default, set):Int = 1;
	public var rows(default, set):Int = 1;
	public var x(get, never):Int;
	public var y(get, never):Int;
	public var index(default, null):Int = 0;

	private var count:Int;

	public function new()
	{
		count = 0;
	}

	public function setOptions(options:Array<T>)
	{
		if (count != 0)
		{
			for (i in 0...this.count)
			{
				onRemoveOption(this.list[i]);
			}
		}

		this.index = 0;
		this.list = options.copy();
		count = options.length;
		add();
		get().onOver();
		onMoved(get(), x, y);
	}

	public function addOption(option:T, pos:Int = -1)
	{
		this.list.insert(pos, option);
		count++;

		var i = pos == -1 ? count - 1 : pos;
		onAdded(option, getx(i), gety(i));

		if (pos != -1)
		{
			moved();
		}
	}

	public function removeOption(option:T)
	{
		if (list.remove(option))
		{
			onRemoveOption(option);
			moved();
		}
	}

	private function add()
	{
		for (i in 0...this.count)
		{
			onAdded(this.list[i], getx(i), gety(i));
		}
	}

	private function moved()
	{
		for (i in 0...this.count)
		{
			onPositionSet(this.list[i], getx(i), gety(i));
		}
	}

	/** triggers when the player changed the active item. **/
	public dynamic function onMoved(item:T, x:Int, y:Int) {}

	/** called when an element is selected. Returns true if the item's onSelect should be triggered automatically. **/
	public dynamic function onSelect(item:T):Bool
	{
		return true;
	}

	/** called when an element is first added in the option list. **/
	public dynamic function onAdded(item:T, x:Int, y:Int) {}

	/** called when the position of one or more element is changed in the option list. **/
	public dynamic function onPositionSet(item:T, x:Int, y:Int) {}

	/** called when an element is removed from the option list **/
	public dynamic function onRemoveOption(item:T) {}

	private inline function getx(i:Int)
	{
		return i % cols;
	}

	private inline function gety(i:Int)
	{
		return Math.floor(i / cols);
	}

	private function set_cols(val:Int)
	{
		this.cols = val;
		if (count > 1)
		{
			add();
		}
		return this.cols;
	}

	private function set_rows(val:Int)
	{
		this.rows = val;
		if (count > 1)
		{
			add();
		}
		return this.rows;
	}

	private inline function get_x()
	{
		return cols > 1 ? index % cols : 0;
	}

	private inline function get_y()
	{
		return cols > 1 ? Math.floor(index / cols) : index;
	}

	public function get()
	{
		if (this.count == 0)
			return null;
		return this.list[index];
	}

	public function up()
	{
		return delta0(0, -1);
	}

	public function down()
	{
		return delta0(0, 1);
	}

	public function left()
	{
		return delta0(-1, 0);
	}

	public function right()
	{
		return delta0(1, 0);
	}

	public function select()
	{
		var c = get();
		if (c != null)
		{
			if (onSelect == null || onSelect(c))
			{
				c.onSelect();
			}
		}
	}

	private function wrapX(x:Int):Int
	{
		return wrap ? x.wrap(0, cols - 1) : x.clamp(0, cols - 1);
	}

	private function wrapY(y:Int):Int
	{
		if (rows > 0)
		{
			return wrap ? y.wrap(0, rows - 1) : y.clamp(0, rows - 1);
		}
		return wrap ? y.wrap(0, this.list.length - 1) : y.clamp(0, list.length - 1);
	}

	private function delta0(dx:Int, dy:Int)
	{
		var o = get();
		delta(dx, dy);
		var n = get();

		if (o != n)
		{
			o.onOut();
			n.onOver();
			onMoved(get(), x, y);
			return true;
		}

		return false;
	}

	private function delta(dx:Int, dy:Int)
	{
		var nx = x + dx;
		var ny = y + dy;

		ny = wrapY(ny);
		nx = wrapX(nx);

		index = ny * cols + nx;

		if (get() == null)
		{
			if (wrap)
			{
				delta(dx, dy);
			}
			else
			{
				delta(dx * -1, dy * -1);
			}
		}
	}

	public function update(frame:Frame)
	{
		if (count == 0)
			return;
		for (option in this.list)
		{
			option.update(frame);
		}
	}

	public function postupdate()
	{
		if (count == 0)
			return;
		for (option in this.list)
		{
			option.postupdate();
		}
	}

	public function getRows()
	{
		return rows;
	}

	public function getCols()
	{
		return cols;
	}

	public function set(x:Int, y:Int)
	{
		x = x.clamp(0, cols - 1);
		y = y.clamp(0, rows - 1);

		var dx = x - this.x;
		var dy = y - this.y;
		return delta0(dx, dy);
	}
}
