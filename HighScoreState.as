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
			var scores:Array = (_save.data.highscores as Array).sort();
			scores = scores.reverse();
			_save.data.highscores = new Array();
			_save.data.highscores = scores;
			highScoreText = new FlxText(FlxG.width/2-90, 20, 1000, "High Scores: \n\n");
			highScoreText.size = 25;
			add(highScoreText);
			
			mainMenu = new FlxButtonPlus(0, FlxG.height-30, clickMainMenu, null, "Main Menu", 200, 20 );
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
				for (var i in _save.data.highscores) 
				{
					if (i > 9) { break; }
					highScoreText.text += "    "+(i+1) +": "+_save.data.highscores[i].toString() + "\n";
				}
			}
		}
		private function clickMainMenu():void
		{	
			FlxG.switchState(new MainMenuState);	
		}
		
	}

}