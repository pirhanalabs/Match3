package match3;

class MatchAssets
{
	public static var item_frame:h2d.Tile;
	public static var items:Array<h2d.Tile>;
	public static var exp_anim:Array<h2d.Tile>;

	private static var tilesheets:Map<String, Array<h2d.Tile>>;

	public static function init()
	{
		MatchAssets.tilesheets = new Map<String, Array<h2d.Tile>>();
		MatchAssets.exp_anim = pirhana.AssetBuilder.subTilesheet(hxd.Res.sprites.experience_bar_end.toTile(), 3, 14, 0, 0);
		MatchAssets.item_frame = hxd.Res.sprites.item_frame.toTile();
		MatchAssets.item_frame.dx = -MatchAssets.item_frame.width * 0.5;
		MatchAssets.item_frame.dy = -MatchAssets.item_frame.height * 0.5;
	}

	public static function loadTilesheet(id:String, sheet:h2d.Tile, tw:Int, th:Int, dx:Int = 0, dy:Int = 0)
	{
		var tiles = pirhana.AssetBuilder.subTilesheet(sheet, tw, th, dx, dy);
		tilesheets.set(id, tiles);
	}

	public static function getTilesheetTile(id:String, index:Int)
	{
		var tiles = tilesheets.get(id);
		if (tiles == null || tiles.length <= index)
			return null;
		return tiles[index];
	}
}
