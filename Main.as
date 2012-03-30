package
{
	import org.flixel.*;
	[SWF(width="800", height="480", backgroundColor="#000000")] //Set the size and color of the Flash file
 
	public class Main extends FlxGame
	{
		public function Main()
		{
			super(320,240,MainMenuState,2); 
		}
	}
}