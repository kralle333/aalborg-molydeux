package states
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	import gameclasses.*
	import enemies.*;
	public class MainMenuState extends FlxState 
	{
		private var playButton:FlxButtonPlus;
		private var highScoreButton:FlxButtonPlus;
		[Embed(source = '../../assets/molymusic.mp3')] private var molyMusic:Class;
		private var background:Background;
		private var enemiesGroup:EnemyManager;
		override public function create():void
		{
			
			background = new Background(400, 0);
			add(background);
			enemiesGroup = new EnemyManager(10);
			enemiesGroup.typesAvaible = 10;
			add(enemiesGroup);
			for (var enemy in enemiesGroup.members) 
			{
				enemiesGroup.members[enemy].x = FlxG.width;
			}
			HighScoreState._save = new FlxSave();
			HighScoreState._save.bind("MolyHighscores");
			FlxG.mouse.show();
			var title:FlxText = new FlxText(60, 20, 400, "What would Molydeux 2012 \ngame entry!");
			title.size = 30;
			add(title);
			playButton = new FlxButtonPlus(80, 160, clickPlayGame, null, "Play Game", 200, 20 )
			add(playButton);
			highScoreButton = new FlxButtonPlus(80, 200, clickHighScore,null,"High Score",200,20 );
			highScoreButton.x = playButton.x;
			add(highScoreButton);
		}
		private function clickPlayGame():void
		{
			FlxG.switchState(new PlayState());
			FlxG.playMusic(molyMusic);
		}
		
		private function clickHighScore():void
		{
			
			FlxG.switchState(new HighScoreState());
			
		}
		override public function update():void 
		{
			
			for (var enemy in enemiesGroup.members) 
			{
				if (enemiesGroup.members[enemy].x <= 400)
				{
					enemiesGroup.members[enemy].kill();
					enemiesGroup.members[enemy].x = FlxG.width+30;
				}
			}
			super.update();
		}
	}
}