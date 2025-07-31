package resources;

enum SheetID
{
	Exploration;
}

class SheetResources
{
	private static var sheets:Map<SheetID, String> = new Map();

	public static function Init() {}

	private static function addSheet(id:SheetID, path:String, tw:Int, th:Int, dx:Int, dy:Int)
	{
		sheets.set(id, path);
		Assets.addSheet(path, tw, th, dx, dy);
	}

	public static function getSprite(id:SheetID)
	{
		return Assets.getSprite(sheets.get(id));
	}

	public static function getTile(id:SheetID, index:Int)
	{
		return Assets.getSheetSprite(sheets.get(id), index);
	}

	public static function getSpritesheet(id:SheetID)
	{
		return Assets.getSpritesheet(sheets.get(id));
	}
}
