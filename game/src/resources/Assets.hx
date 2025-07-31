package resources;

class Assets
{
	private static final sprites:Map<String, h2d.Tile> = [];
	private static final sheets:Map<String, Array<h2d.Tile>> = [];
	private static final anims:Map<String, Array<h2d.Tile>> = [];

	private static var defaultTile(get, null):h2d.Tile;

	private static var fonts:Map<String, h2d.Font> = [];

	inline static function get_defaultTile()
	{
		if (defaultTile == null)
		{
			defaultTile = h2d.Tile.fromColor(0xff0000, 2, 2);
		}
		return defaultTile;
	}

	public static function registerFont(id:String, font:h2d.Font)
	{
		fonts.set(id, font);
	}

	public static function getFont(id:String)
	{
		if (fonts.exists(id))
		{
			return fonts.get(id);
		}
		return hxd.res.DefaultFont.get();
	}

	public static function loadSprite(path:String, dx:Float = 0, dy:Float = 0, isPercent:Bool = true)
	{
		if (sprites.exists(path))
		{
			return sprites.get(path);
		}
		try
		{
			var tile = hxd.Res.load(path).toTile();
			tile.dx = dx;
			tile.dy = dy;
			if (isPercent)
			{
				tile.dx = tile.width * dx;
				tile.dy = tile.height * dy;
			}
			sprites.set(path, tile);
			return tile;
		}
		catch (e)
		{
			trace('could not find sprite tile at [$path]');
		}
		return defaultTile;
	}

	public static function getSprite(path:String)
	{
		if (sprites.exists(path))
		{
			return sprites.get(path);
		}
		return loadSprite(path, 0, 0);
	}

	public static function addSheet(path:String, tw:Int, th:Int, dx:Int = 0, dy:Int = 0)
	{
		if (sheets.exists(path))
		{
			return;
		}

		try
		{
			var sheet:h2d.Tile = hxd.Res.load(path).toTile();
			sheets.set(path, pirhana.AssetBuilder.subTilesheet(sheet, tw, th, dx, dy));
			sprites.set(path, sheet);
		}
		catch (e)
		{
			trace('could not find tilesheet at [$path]');
		}
	}

	public static function getSpritesheet(path:String)
	{
		if (sheets.exists(path))
		{
			return sheets.get(path);
		}
		return [];
	}

	public static function getSheetSprite(path:String, index:Int)
	{
		if (sheets.exists(path))
		{
			return sheets.get(path)[index];
		}
		trace('tilesheet [$path] does not exist.');
		return defaultTile;
	}

	public static function makeAnim(sheet:String, name:String, frames:Array<Int>)
	{
		var sheet = getSpritesheet(sheet);
		var anim = [];
		for (f in frames)
			anim.push(sheet[f]);
		anims.set(name, anim);
		return anim;
	}

	public static function getAnim(name:String)
	{
		if (anims.exists(name))
		{
			return anims.get(name);
		}
		return [];
	}

	public static function loadResSpriteFolder(prefix:String, path:String, dx:Float = 0, dy:Float = 0)
	{
		var entry = hxd.Res.load(path);
		if (entry.entry.isDirectory)
		{
			loadResSpriteFiles(prefix, entry, dx, dy);
		}
		else
		{
			throw 'myst load sprites from a directory!';
		}
	}

	private static function loadResSpriteFiles(prefix:String, res:hxd.res.Any, dx:Float, dy:Float)
	{
		for (e in res.iterator())
		{
			if (e.entry.isDirectory)
			{
				loadResSpriteFiles(prefix + '/' + e.name, e, dx, dy);
			}
			else if (e.name.indexOf('.png') != -1)
			{
				var name = prefix + '/' + e.name.substring(0, e.name.length - 4);
				// trace(name);
				var tile = e.toTile();
				tile.dx = -tile.width * dx;
				tile.dy = -tile.height * dy;
				sprites.set(name, tile);
			}
		}
	}
}
