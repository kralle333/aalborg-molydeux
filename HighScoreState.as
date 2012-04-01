package  
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	public class HighScoreState extends FlxState
	{
		private var mainMenu:FlxButtonPlus;
		private var highScoreText:FlxText;
		override public function create():void 
		{
			super.create();
			var text:HighScore = new HighScore();
			var fda:FlxSave = new FlxSave();
			highScoreText = new FlxText(FlxG.width / 2, FlxG.height / 2, 1000, HighScore.levels.toString());
			highScoreText.size = 20;
			add(highScoreText);
			
			mainMenu = new FlxButtonPlus(0, 130, clickMainMenu, null, "Main Menu", 200, 20 );
			mainMenu.x = FlxG.width / 2 - 100;
			add(mainMenu);
		}
	
		private function clickMainMenu():void
		{
			
		FlxG.switchState(new MainMenuState);	
		}
		
	}

}