package match3.views;

import hxd.Event;
import match3.gameplay.Card;

class CardView extends core.navigation.BasicNavigationInstance
{
	public var card:Card;
	public var sprite:h2d.Bitmap;

	public function new()
	{
		super();

		sprite = new h2d.Bitmap(null, this);
	}

	override function onInteractiveClick(e:Event)
	{
		super.onInteractiveClick(e);
		trace('clicked');
	}

	public function setCard(card:Card)
	{
		this.card = card;
		this.sprite.tile = MatchAssets.getTilesheetTile(card.atlas, card.spriteid);
		interactive.width = sprite.tile.width;
		interactive.height = sprite.tile.height;
		interactive.x = sprite.tile.dx;
		interactive.y = sprite.tile.dy;
	}
}
