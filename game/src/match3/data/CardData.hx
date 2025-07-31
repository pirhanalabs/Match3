package match3.data;

import match3.data.ERarity;
import match3.gameplay.Card;
import match3.gameplay.MatchContext;

typedef CardData =
{
	id:String,
	atlas:String,
	spriteid:Int,
	rarity:ERarity,
	tags:Array<ECardTag>,
	effect:(ctx:MatchContext, card:Card) -> Void
}
