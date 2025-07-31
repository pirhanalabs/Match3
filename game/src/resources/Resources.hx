package resources;

class Resources
{
	public static var tilesheets:Map<String, TilesheetResource> = [];
	public static var resources:Array<IResource> = [];

	public static function addResource<T:IResource>(resource:T)
	{
		resources.push(resource);

		if (Std.isOfType(resource, TilesheetResource))
		{
			var tilesheet:TilesheetResource = cast resource;
			tilesheets.set(tilesheet.id, tilesheet);
		}
	}

	public static function loadResources()
	{
		for (resource in resources)
		{
			resource.load();
		}
	}

	public static function getTilesheet(id:String):TilesheetResource
	{
		return tilesheets.get(id);
	}
}
