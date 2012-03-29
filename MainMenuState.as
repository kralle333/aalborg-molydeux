package  
{
	import org.flixel.*;
	public class MainMenuState extends FlxState 
	{
		override public function create():void
		{
			add(new FlxText(0, 0, 100, "Hej Dan"));
			add(new FlxButton(10, 10, "Hej Kristian!", null));
		}
	}
}