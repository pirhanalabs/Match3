package resources;

interface IResource
{
	public var id(default, null):String;
	public function load():Void;
}
