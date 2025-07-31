package match3.messages;

class MSG_IncreaseScore implements pirhana.utils.message.IMessage
{
	public static final TYPE = 'match.messages.increase_score';

	public var amount(default, null):Int;

	public function new(amount:Int)
	{
		this.amount = amount;
	}

	public function getType()
	{
		return TYPE;
	}
}
