package match3.gameplay;

import match3.data.EZone;

class Player
{
	private var temp:Array<Card>; // temporary cards
	private var full:Array<Card>; // cards located in any zone
	private var deck:Array<Card>; // cards located in the deck zone
	private var hand:Array<Card>; // cards located in the hand zone
	private var play:Array<Card>; // cards located in the play zone

	public function new()
	{
		temp = new Array<Card>();
		full = new Array<Card>();
		deck = new Array<Card>();
		hand = new Array<Card>();
		play = new Array<Card>();
	}

	/**
		Puts all the cards in the deck, ready for play.

		created: 31/07/2025
	**/
	public function initDeck()
	{
		for (card in full)
			deck.push(card);
	}

	/**
		Removes all cards from each zone.

		created: 31/07/2025
	**/
	public function clearCards()
	{
		while (deck.length > 0)
			deck.pop();
		while (hand.length > 0)
			hand.pop();
		while (play.length > 0)
			play.pop();
	}

	/**
		Shuffle the cards in the deck.

		created: 31/07/2025
	**/
	public function shuffle()
	{
		hxd.Math.shuffle(deck);
	}

	/**
		Draws a card from the deck.

		created: 31/07/2025
	**/
	public function draw()
	{
		if (deck.length > 0)
		{
			var card = deck.pop();
			hand.push(card);
		}
	}

	/**
		Adds a card to the player's inventory, in the specified zone.

		created: 29/07/2025
	**/
	public function addCard(card:Card, zone:EZone = Full)
	{
		if (full.has(card))
			return;

		final list = getZone(zone);
		list.push(card);
		full.push(card);
		card.zone = zone;

		if (card.temp)
		{
			temp.push(card);
		}
	}

	/**
		Adds a card to the player's inventory, in the specified zone.

		created: 29/07/2025
	**/
	public function moveToZone(card:Card, zone:EZone)
	{
		if (!full.has(card))
			return;

		final from = getZone(card.zone);
		final to = getZone(zone);

		to.push(card);
		from.remove(card);
		card.zone = zone;
	}

	/**
		Returns the original array of cards of the requested zone.

		created: 29/07/2025
	**/
	public function getZone(zone:EZone)
	{
		return switch (zone)
		{
			case Full: full;
			case Deck: deck;
			case Hand: hand;
			case Play: play;
		}
	}

	/**
		Returns an array of cards copy of the requested zone.

		created: 30/07/2025
	**/
	public function getZoneCopy(zone:EZone)
	{
		return getZone(zone).copy();
	}
}
