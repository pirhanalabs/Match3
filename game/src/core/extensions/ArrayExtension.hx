package core.extensions;

class ArrayExtension
{
	/**
		Fast way to filter the array without allocating a new array.
		This method is fastest, but does not keep the array order.
		Speed 0(n)
	**/
	public inline static function fastUnsortedFilter<T>(a:Array<T>, cond:T->Bool)
	{
		var i = 0;
		while (i < a.length)
		{
			if (!cond(a[i]))
			{
				a[i] = a[a.length - 1];
				a.pop();
			}
			else
			{
				i++;
			}
		}
	}

	/**
		Fast way to filter the array without allocating a new array.
		This method is fastest, and keeps the array order.
		Speed 0(n)
	**/
	public inline static function fastOrderedFilter<T>(a:Array<T>, cond:T->Bool)
	{
		var write = 0;
		for (read in 0...a.length)
		{
			if (cond(a[read]))
			{
				a[write++] = a[read];
			}
		}
		a.resize(write);
	}
}
