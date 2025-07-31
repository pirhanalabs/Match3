package core.gameplay.dialogue;

class Dialogue
{
	private var map:Map<Int, IDialogueNode>;

	public function new()
	{
		map = new Map();
	}

	public function addNode<T:IDialogueNode>(node:T)
	{
		map.set(node.getId(), node);
		return node;
	}

	public function getNode(id:Int)
	{
		return map.get(id);
	}

	public function getStart()
	{
		return 0;
	}
}
