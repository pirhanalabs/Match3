package match3.gameplay;

import match3.data.EZone;

class MatchContext
{
	var pp:Player;
	var events:pirhana.utils.state.EventStateManager;

	public function new(pp:Player, events:pirhana.utils.state.EventStateManager)
	{
		this.pp = pp;
		this.events = events;
	}

	public function addScore(amount:Int)
	{
		trace('add score here');
	}

	public function filterZone(zone:EZone, f:Card->Bool)
	{
		return this.pp.getZone(zone).filter(f);
	}
}
