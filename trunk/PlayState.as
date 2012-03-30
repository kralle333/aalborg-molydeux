package  
{
	import org.flixel.*;
	public class PlayState extends FlxState 
	{
		
		override public function create():void 
		{
			super.create();
			Registry.init();
			add(Registry.player);
			add(Registry.enemies);
		}
		
	}

}