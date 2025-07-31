package core.gameplay.dialogue;

interface IDialogueNode
{
	function getId():Int;
	function getPointers():Array<Int>;
	function hasPointers():Bool;
}
