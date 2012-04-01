package  
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	public class HighScoreState extends FlxState
	{
		private var mainMenu:FlxButtonPlus;
		public static var highScoreText:FlxText;
		public static var _save:FlxSave;
		public static var text:HighScore = new HighScore();
		override public function create():void 
		{
			super.create();
			
			highScoreText = new FlxText(FlxG.width / 2, FlxG.height / 2, 1000, "");
			highScoreText.size = 20;
			add(highScoreText);
			
			mainMenu = new FlxButtonPlus(0, 130, clickMainMenu, null, "Main Menu", 200, 20 );
			mainMenu.x = FlxG.width / 2 - 100;
			add(mainMenu);
			onLoad();
		}
	
		public static function onSave(highscore:int):void
		{
			if (_save.data.highscores == null)
			{
				_save.data.highscores = new Array();
			}
			FlxG.scores.push(highscore);
			(_save.data.highscores as Array).push(highscore);
		}
		public static function onLoad():void
		{
			if (_save.data.highscores == null)
			{
				highScoreText.text = "No saves found!";
			}
			else
			{
				(_save.data.highscores as Array).sort();
				(_save.data.highscores as Array).reverse();
				for (var i in _save.data.highscores) 
				{
					highScoreText.text += (i+1) +": "+_save.data.highscores[i].toString() + "\n";
				}
			}
		}
		private function clickMainMenu():void
		{	
			FlxG.switchState(new MainMenuState);	
		}
		
	}

}