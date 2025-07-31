package match3.gameplay;

import match3.data.ECardTag;
import match3.data.ERarity;
import match3.data.EZone;

class Card
{
	public var id:String;
	public var rarity:ERarity;
	public var tags:Array<ECardTag>;
	public var zone:EZone;
	public var temp(default, null):Bool;

	public function new()
	{
		this.id = 'null';
		this.rarity = Uncommon;
		this.temp = false;
		this.zone = Full;
		this.tags = [];
	}

	public function getName()
	{
		return match3.Lang.get(this.id + '_name');
	}

	public function getDesc()
	{
		return match3.Lang.get(this.id + '_desc');
	}
}
