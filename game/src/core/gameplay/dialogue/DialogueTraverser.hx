package core.gameplay.dialogue;

class DialogueTraverser
{
	private var dialogue:Dialogue;
	private var current:IDialogueNode;

	public function new(dialogue:Dialogue)
	{
		this.dialogue = dialogue;
		this.current = this.dialogue.getNode(this.dialogue.getStart());
	}

	public function getNextNode(pointer:Int)
	{
		if (!current.hasPointers())
		{
			return null;
		}
		var nextnode = dialogue.getNode(current.getPointers()[pointer]);
		current = nextnode;
		return nextnode;
	}

	public function getNode()
	{
		return this.current;
	}
}
