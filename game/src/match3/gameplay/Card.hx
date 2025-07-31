package match3.gameplay;

import match3.data.ECardTag;
import match3.data.ERarity;
import match3.data.EZone;

class Card
{
	public var id:String;
	public var atlas:String;
	public var spriteid:Int;
	public var rarity:ERarity;
	public var tags:Array<ECardTag>;
	public var zone:EZone;
	public var temp:Bool;
	public var effect:MatchContext->Card->Void;

	public function new()
	{
		this.id = 'null';
		this.rarity = Uncommon;
		this.temp = false;
		this.zone = Full;
		this.tags = [];
		this.effect = null;
		this.atlas = '';
		this.spriteid = -1;
	}

	public function setData(data:match3.data.CardData)
	{
		this.id = data.id;
		this.rarity = data.rarity;
		this.temp = false;
		this.zone = Full;
		this.tags = data.tags.copy();
		this.effect = data.effect;
		this.spriteid = data.spriteid;
		this.atlas = data.atlas;
		return this;
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
