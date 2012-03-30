package  
{
	import org.flixel.*;
	public class MainMenuState extends FlxState 
	{
		private var playButton:FlxButton;
		private var highScoreButton:FlxButton;
		override public function create():void
		{
			FlxG.mouse.show();
			add(new FlxText(FlxG.width / 2-55, 0, 500, "Molydeux Game 2012!"));
			playButton = new FlxButton(0, 80, "Play Game", clickPlayGame)
			playButton.x = FlxG.width/2 - playButton.width/2;
			add(playButton);
			highScoreButton = new FlxButton(0, 110, "High Score", clickHighScore);
			highScoreButton.x = playButton.x;
			add(highScoreButton);
		}
		private function clickPlayGame()
		{
			FlxG.switchState(new PlayState());
		}
		
		private function clickHighScore()
		{
			
		}
	}
}