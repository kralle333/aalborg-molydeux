package  
{
	import org.flixel.*;
	public class MainMenuState extends FlxState 
	{
		private var playButton:FlxButton;
		private var highScoreButton:FlxButton;
		[Embed(source = 'assets/gameTitle.png')] private var gameTitleTexture:Class;
		override public function create():void
		{
			FlxG.mouse.show();
			var title:FlxText = new FlxText(FlxG.width / 2 - 325, 0, 1000, "Molydeux Game 2012!");
			title.size = 50;
			add(title);
			playButton = new FlxButton(0, 80, "Play Game", clickPlayGame)
			playButton.x = FlxG.width / 2 - playButton.width / 2;
			add(playButton);
			highScoreButton = new FlxButton(0, 110, "High Score", clickHighScore);
			highScoreButton.x = playButton.x;
			add(highScoreButton);
		}
		private function clickPlayGame():void
		{
			FlxG.switchState(new PlayState());
		}
		
		private function clickHighScore():void
		{
	
		}
	}
}