package core.navigation;

class NavigationHelper
{
	public static function buildLinear(nav:NavigationManager, direction:engine.Direction, instances:Array<INavigationInstance>)
	{
		for (i in 0...instances.length - 1)
		{
			var a = instances[i];
			var b = instances[b];
			nav.link2(a, b, direction);
		}
	}
}
