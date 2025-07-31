package resources;

class TilesheetResource implements IResource
{
	public var id(default, null):String;
	public var path(default, null):String;

	public var tiles(default, null):Array<h2d.Tile>;
	public var sourceTile(default, null):h2d.Tile;

	public var tw(default, null):Int;
	public var th(default, null):Int;

	public var dx(default, null):Int;
	public var dy(default, null):Int;

	public function new(id:String, path:String, tw:Int, th:Int, dx:Int = 0, dy:Int = 0)
	{
		this.id = id;
		this.path = path;
		this.tw = tw;
		this.th = th;
		this.dx = dx;
		this.dy = dy;
		this.tiles = [];
		this.sourceTile = null;
	}

	public function load()
	{
		try
		{
			sourceTile = hxd.Res.load(path).toTile();
			tiles = pirhana.AssetBuilder.subTilesheet(sourceTile, tw, th, dx, dy);
		}
		catch (e:Dynamic)
		{
			throw 'TilesheetResource: Could not load tilesheet at path: ' + path;
		}
	}
}
