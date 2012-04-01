package  
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	public class MainMenuState extends FlxState 
	{
		private var playButton:FlxButtonPlus;
		private var highScoreButton:FlxButtonPlus;
		override public function create():void
		{
			HighScoreState._save = new FlxSave();
			HighScoreState._save.bind("MolyHighscores");
			FlxG.mouse.show();
			var title:FlxText = new FlxText(20, 20, 1000, "What would Molydeux 2012 game entry!");
			title.size = 30;
			add(title);
			playButton = new FlxButtonPlus(0, 100, clickPlayGame, null, "Play Game", 200, 20 )
			playButton.x = FlxG.width / 2 - playButton.width / 2;
			add(playButton);
			highScoreButton = new FlxButtonPlus(0, 130, clickHighScore,null,"High Score",200,20 );
			highScoreButton.x = playButton.x;
			add(highScoreButton);
		}
		private function clickPlayGame():void
		{
			FlxG.switchState(new PlayState());
		}
		
		private function clickHighScore():void
		{
			FlxG.switchState(new HighScoreState());
		}
	}
}