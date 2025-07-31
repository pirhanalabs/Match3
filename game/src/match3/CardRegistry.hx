package match3;

class CardRegistry
{
	private static final all:Array<match3.data.CardData> = [];
	private static final mapped:Map<String, match3.data.CardData> = [];
	private static final filterRarity:Map<match3.data.ERarity, Array<match3.data.CardData>> = [];

	/**
		Returns one of the card data that have been registered.

		created: 31/07/2025
	**/
	public static function get(id:String)
	{
		return mapped.get(id);
	}

	/**
		Registers a new card data.

		created: 31/07/2025
	**/
	public static function register(data:match3.data.CardData)
	{
		all.push(data);
		mapped.set(data.id, data);
		addToFilter(filterRarity, data.rarity, data);
	}

	/**
		Adds a card data to a specific card data filter.

		created: 31/07/2025
	**/
	private static function addToFilter<K>(filter:Map<K, Array<match3.data.CardData>>, key:K, val:match3.data.CardData)
	{
		var list = filter.get(key);
		if (list == null)
			filter.set(key, list = []);
		list.push(val);
	}
}
