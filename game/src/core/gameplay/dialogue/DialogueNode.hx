package core.gameplay.dialogue;

class DialogueNode implements IDialogueNode
{
	var id:Int;
	var pointers:Array<Int>;
	var count:Int;
	var text:String;

	public function new(id:Int, text:String)
	{
		this.id = id;
		this.text = text;
		this.count = 0;
		this.pointers = [];
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
