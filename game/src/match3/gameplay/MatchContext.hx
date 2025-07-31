package match3.gameplay;

import core.structs.Queue;
import match3.data.EZone;

class MatchContext
{
	var pp:Player;
	var messages:Queue<IMessage>;

	/**
		Context of the game. Each gameplay request should go through here.

		created: 31/07/2025
	**/
	public function new(pp:Player, messages:Queue<IMessage>)
	{
		this.pp = pp;
		this.messages = messages;
	}

	/**
		Adds score to the board.
	**/
	public function addScore(amount:Int)
	{
		messages.enqueue(new match3.messages.MSG_IncreaseScore(amount));
	}

	/**
		filters a zone.
	**/
	public function filterZone(zone:EZone, f:Card->Bool)
	{
		return this.pp.getZone(zone).filter(f);
	}
}
