package match3.screens;

class GameScreen extends engine.Screen
{
	public var pp:match3.gameplay.Player;
	public var context:match3.gameplay.MatchContext;
	public var events:pirhana.utils.state.EventStateManager;

	public function new() {}

	override function ready()
	{
		super.ready();

		match3.Initializer.initialize();

		pp = new match3.gameplay.Player();

		// add initial cards
		pp.addCard(new match3.gameplay.Card(), Deck);
		pp.addCard(new match3.gameplay.Card(), Deck);
		pp.addCard(new match3.gameplay.Card(), Deck);
		pp.addCard(new match3.gameplay.Card(), Deck);
		pp.addCard(new match3.gameplay.Card(), Deck);
		pp.addCard(new match3.gameplay.Card(), Deck);
		pp.addCard(new match3.gameplay.Card(), Deck);
		pp.addCard(new match3.gameplay.Card(), Deck);
		pp.addCard(new match3.gameplay.Card(), Deck);
		pp.addCard(new match3.gameplay.Card(), Deck);

		pp.clearCards();
		pp.initDeck();
		pp.shuffle();

		events = new pirhana.utils.state.EventStateManager();
		context = new match3.gameplay.MatchContext(pp, events);
	}

	override function dispose()
	{
		super.dispose();
	}

	override function update(frame:engine.Frame)
	{
		super.update(frame);
	}

	override function postupdate()
	{
		super.postupdate();
	}
}
