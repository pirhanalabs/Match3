package core.gameplay.dialogue;

class ChoiceNode implements IDialogueNode
{
	var id:Int;
	var pointers:Array<Int>;
	var count:Int;

	public function new(id:Int, yes:Int, no:Int)
	{
		this.id = id;
		this.text = text;
		this.count = 2;
		this.pointers = [yes, no];
	}

	public function setPointer(id:Int)
	{
		pointers.push(id);
		count++;
	}

	public function getId()
	{
		return id;
	}

	public function getPointers()
	{
		return pointers;
	}

	public function hasPointers()
	{
		return count > 0;
	}
}
