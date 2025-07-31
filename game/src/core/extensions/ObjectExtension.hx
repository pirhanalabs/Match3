package core.extensions;

class ObjectExtension
{
	public static function getPoint(d:h2d.Object)
	{
		if (d == null)
		{
			return new core.structs.Point(0, 0);
		}
		return new core.structs.Point(d.x, d.y);
	}

	public static function setPoint(d:h2d.Object, point:core.structs.Point)
	{
		if (d != null)
		{
			d.x = point.x;
			d.y = point.y;
		}
	}

	/**
		Centers on the horizontal axis.
		If ctx is null, Application.VIEW_WID_2 is used.
	**/
	public static function centerX(d:h2d.Object, ?ctx:h2d.Object)
	{
		var x:Float;
		var s = d.getSize();

		if (ctx == null)
		{
			x = Application.VIEW_WID_2;
		}
		else
		{
			var ss = ctx.getSize();
			x = (ss.getMin().x + ss.getMax().x) * 0.5;
		}

		try
		{
			var b:h2d.Bitmap = cast d;
			var p = (s.getMin().x + s.getMax().x);

			d.x = x - p * 0.5;

			if (p != 0)
			{
				d.x + b.tile.dx;
			}
		}
		catch (e)
		{
			d.x = x - (s.getMin().x + s.getMax().x) * 0.5;
		}
	}

	/**
		Centers on the vertical axis.
		If ctx is null, Application.VIEW_HEI_2 is used.
	**/
	public static function centerY(d:h2d.Object, ?ctx:h2d.Object)
	{
		var y:Float;
		var s = d.getSize();

		if (ctx == null)
		{
			y = Application.VIEW_HEI_2;
		}
		else
		{
			var ss = ctx.getSize();
			y = (ss.getMin().y + ss.getMax().y) * 0.5;
		}

		try
		{
			var b:h2d.Bitmap = cast d;
			var p = (s.getMin().y + s.getMax().y);

			d.y = y - p * 0.5;

			if (p != 0)
			{
				d.y + b.tile.dy;
			}
		}
		catch (e)
		{
			d.y = y - (s.getMin().y + s.getMax().y) * 0.5;
		}
	}
}
