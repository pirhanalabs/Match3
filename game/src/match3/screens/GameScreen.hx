package match3.screens;

import match3.views.CardView;

class GameScreen extends engine.Screen
{
	public var pp:match3.gameplay.Player;
	public var context:match3.gameplay.MatchContext;

	public var messages:core.structs.Queue<pirhana.utils.message.IMessage>;
	public var dispatcher:pirhana.utils.message.MessageDispatcher;

	// navigation managers
	public var navigation_hand:core.navigation.NavigationManager;
	public var navigation_play:core.navigation.NavigationManager;
	public var navigation_group:core.navigation.NavigationGroupManager;

	public var handCards:Array<CardView>;
	public var playCards:Array<CardView>;
	public var cardSelector:h2d.Bitmap;
	public var cardSelectorX:Float = 0;
	public var cardSelectorY:Float = 0;

	public function new() {}

	override function ready()
	{
		super.ready();

		match3.Initializer.initialize();

		pp = new match3.gameplay.Player();

		// add initial cards
		pp.addCard(new match3.gameplay.Card().setData(CardRegistry.get('match_cards_apple')), Deck);
		pp.addCard(new match3.gameplay.Card().setData(CardRegistry.get('match_cards_apple')), Deck);
		pp.addCard(new match3.gameplay.Card().setData(CardRegistry.get('match_cards_apple')), Deck);
		pp.addCard(new match3.gameplay.Card().setData(CardRegistry.get('match_cards_apple')), Deck);
		pp.addCard(new match3.gameplay.Card().setData(CardRegistry.get('match_cards_apple')), Deck);
		pp.addCard(new match3.gameplay.Card().setData(CardRegistry.get('match_cards_banana')), Deck);
		pp.addCard(new match3.gameplay.Card().setData(CardRegistry.get('match_cards_banana')), Deck);
		pp.addCard(new match3.gameplay.Card().setData(CardRegistry.get('match_cards_banana')), Deck);
		pp.addCard(new match3.gameplay.Card().setData(CardRegistry.get('match_cards_banana')), Deck);
		pp.addCard(new match3.gameplay.Card().setData(CardRegistry.get('match_cards_banana')), Deck);

		pp.clearCards();
		pp.initDeck();
		pp.shuffle();

		dispatcher = new pirhana.utils.message.MessageDispatcher();
		dispatcher.addListener(match3.messages.MSG_IncreaseScore.TYPE, onIncreaseScore);

		messages = new core.structs.Queue(64);
		context = new match3.gameplay.MatchContext(pp, messages);

		navigation_hand = new core.navigation.NavigationManager();
		navigation_hand.onCurrentChanged = onHandCurrentChanged;
		navigation_play = new core.navigation.NavigationManager();
		navigation_play.onCurrentChanged = onPlayCurrentChanged;
		navigation_group = new core.navigation.NavigationGroupManager();
		navigation_group.addGroup(navigation_hand);
		navigation_group.addGroup(navigation_play);

		playCards = [];
		handCards = [];

		for (i in 0...8)
			pp.draw();

		// debug
		for (i in 0...3)
		{
			var card = pp.getZone(Hand).pop();
			pp.moveToZone(card, Play);
		}

		// show cards in hand
		var hand = pp.getZone(Hand);
		for (i in 0...hand.length)
		{
			var view = new match3.views.CardView();
			view.setCard(hand[i]);

			view.x = app.vw2 + MathTools.layout(24, hand.length, i);
			view.y = app.vh2 + app.vh2 * 0.5 - 40;
			handCards.push(view);
			navigation_hand.add(view);
			root.add(view, 1);
		}

		var play = pp.getZone(Play);
		for (i in 0...play.length)
		{
			var view = new match3.views.CardView();
			view.setCard(play[i]);

			view.x = app.vw2 + MathTools.layout(24, play.length, i);
			view.y = app.vh2 - 40;
			playCards.push(view);
			navigation_play.add(view);
			root.add(view, 1);
		}

		cardSelector = new h2d.Bitmap(hxd.Res.sprites.item_selector.toTile());
		cardSelector.tile.dx = -cardSelector.tile.width * 0.5;
		cardSelector.tile.dy = -cardSelector.tile.height * 0.5;
		root.add(cardSelector, 2);

		linkNavigation();
	}

	private function onHandCurrentChanged()
	{
		cardSelectorX = navigation_hand.current.x;
		cardSelectorY = navigation_hand.current.y;
	}

	private function onPlayCurrentChanged()
	{
		trace('current changed', navigation_group.getCurrentGroupIndex());
	}

	private function clearHandNavigation()
	{
		navigation_hand.clearLinks();
		navigation_group.clearInstancePortals(handCards);
	}

	private function linkNavigation()
	{
		core.navigation.NavigationHelper.buildLinear(navigation_hand, engine.Direction.W, cast handCards);
		core.navigation.NavigationHelper.buildLinear(navigation_hand, engine.Direction.W, cast playCards);

		core.navigation.NavigationHelper.buildPortalToNav(navigation_group, navigation_play, engine.Direction.N, handCards);
		core.navigation.NavigationHelper.buildPortalToNav(navigation_group, navigation_hand, engine.Direction.S, playCards);
	}

	private function onIncreaseScore(message:match3.messages.MSG_IncreaseScore)
	{
		trace('score increased by ${message.amount}');
	}

	override function dispose()
	{
		super.dispose();
	}

	private function updateEvents()
	{
		if (messages.any())
		{
			while (!animator.isAnimating && messages.any())
			{
				dispatcher.dispatch(messages.dequeue());
			}
		}
	}

	function moveNav(direction:engine.Direction)
	{
		if (navigation_group == null || navigation_group.currentGroup == null)
			return false;

		var currentNav = navigation_group.currentGroup;
		var currentNode = currentNav.current;

		// try move via a portal first
		if (!navigation_group.tryMove(currentNode, direction))
		{
			// then try to move in the current navigation manager
			return currentNav.tryMove(direction);
		}
		return true;
	}

	override function update(frame:engine.Frame)
	{
		super.update(frame);
		updateEvents();
	}

	override function postupdate()
	{
		super.postupdate(); //

		var distx = cardSelectorX - cardSelector.x;
		var disty = cardSelectorY - cardSelector.y;
		cardSelector.x += distx * 0.3;
		cardSelector.y += disty * 0.3;
	}
}
