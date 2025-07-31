package match3;

/**
	Handles all the strings in the game.

	TODO should load a root english file, and then load the current saved language setting on top.
	This makes it so if there are missing strings, they are simply in english instead of missing.

	TODO should have a way to regerenate lang files from the root english file. That way, translations
	can be updated appropriately by the translators.
**/
class Lang
{
	private static final strings:Map<String, String> = new Map();

	/**
		Initializes the Lang file and read its csv file.

		created: 30/07/2025
	**/
	public static function load(input:String)
	{
		var data = utils.CSVParser.parse(input);

		var i = 1;
		while (i < data.length)
		{
			strings.set(data[i][0], data[i][1]);
			i++;
		}
	}

	/**
		Returns the requested id. If the id does not exist, a null string is returned.

		created: 30/07/2025
	**/
	public static function get(id:String)
	{
		return strings.get(id) ?? "null";
	}
}
