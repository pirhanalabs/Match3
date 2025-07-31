package core.gameplay.dialogue;

class CallbackNode implements IDialogueNode
{
	var id:Int;
	var pointers:Array<Int>;
	var count:Int;
	var cb:Void->Void;

	public function new(id:Int, cb:Void->Void)
	{
		this.id = id;
		this.text = text;
		this.pointers = [];
		this.cb = cb;
	}

	public function setPointer(id:Int)
	{
		pointers.push(id);
		count++;
	}

	public function execute()
	{
		cb();
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
