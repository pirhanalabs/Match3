package match3;

class Initializer
{
	public static function initialize()
	{
		match3.MatchAssets.init();
		defaultLoad();
	}

	private static function defaultLoad()
	{
		var entry = hxd.Res.load('data/match').entry;
		loadMod('match', entry);
	}

	private static function loadMod(modname:String, entry:hxd.fs.FileEntry)
	{
		var cards:hxd.fs.FileEntry = entry.get('cards');
		var langs:hxd.fs.FileEntry = entry.get('langs');
		var sheets:hxd.fs.FileEntry = entry.get('sheets');

		// load tilesheets dynamically
		if (sheets != null && sheets.isDirectory)
		{
			for (sheetfile in sheets)
			{
				if (sheetfile.extension != 'png')
					continue;

				var name = getFileName(sheetfile.name);
				var image = new hxd.res.Image(sheetfile);
				var tile = h2d.Tile.fromTexture(image.toTexture());
				match3.MatchAssets.loadTilesheet('${modname}_' + name, tile, 16, 16, -8, -8);
			}
		}

		// load card templates dynamically
		if (cards != null && cards.isDirectory)
		{
			var parser = new hscript.Parser();
			var interp = new hscript.Interp();

			parser.allowJSON = true;
			parser.allowMetadata = true;
			parser.allowTypes = true;

			var tags:haxe.DynamicAccess<Dynamic> = {};
			tags.set("Fruit", match3.data.ECardTag.Fruit);
			tags.set("Edible", match3.data.ECardTag.Edible);

			var zones:haxe.DynamicAccess<Dynamic> = {};
			tags.set('Full', match3.data.EZone.Full);
			tags.set('Deck', match3.data.EZone.Deck);
			tags.set('Play', match3.data.EZone.Play);
			tags.set('Hand', match3.data.EZone.Hand);

			var rarities:haxe.DynamicAccess<Dynamic> = {};
			rarities.set('Common', match3.data.ERarity.Common);
			rarities.set('Uncommon', match3.data.ERarity.Uncommon);
			rarities.set('Rare', match3.data.ERarity.Rare);
			rarities.set('Epic', match3.data.ERarity.Epic);

			interp.variables.set('ECardTag', tags);
			interp.variables.set('ECardZone', zones);
			interp.variables.set('ERarity', rarities);

			for (cardfile in cards)
			{
				if (cardfile.extension != 'hs')
					continue;

				var string = cardfile.getText();
				var ast = parser.parseString(string);
				var result:match3.data.CardData = interp.execute(ast);
				CardRegistry.register(result);
			}
		}

		// load lang strings dynamically
		if (langs != null && cards.isDirectory)
		{
			for (langfile in langs)
			{
				if (langfile.extension != 'csv')
					continue;

				match3.Lang.load(langfile.getText());
			}
		}
	}

	private static function getFileName(s:String)
	{
		final index = s.lastIndexOf('.');
		if (index == -1)
			return s;
		return s.substr(0, index);
	}
}
