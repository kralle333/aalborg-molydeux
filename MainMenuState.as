package  
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	public class MainMenuState extends FlxState 
	{
		private var playButton:FlxButtonPlus;
		private var highScoreButton:FlxButtonPlus;
		[Embed(source = 'assets/gameTitle.png')] private var gameTitleTexture:Class;
		override public function create():void
		{
			FlxG.mouse.show();
			add(new FlxSprite(FlxG.width / 2 - 250, 0, gameTitleTexture));
			var title:FlxText = new FlxText(FlxG.width / 2 - 125, 0, 1000, "!");
			title.size = 50;
			//add(title);
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