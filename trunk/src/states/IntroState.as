package states
{
	import org.flixel.*;
	public class IntroState extends FlxState
	{
		private var title:FlxText;
		private var tweetSprite:FlxSprite;
		[Embed(source = '../../assets/gameTitle.png')] private var tweet:Class;
		private var timer:FlxTimer;
		private var titlesShown:Boolean = false;
		override public function create():void 
		{
			super.create();
			timer = new FlxTimer();
			title = new FlxText(20, 20, 1000, "Dan Duus Thøisen \nKristian Pilegaard Jensen\nPresents: ");
			title.size = 40;
			title.alpha = 0;
			add(title);
			tweetSprite = new FlxSprite(20, 200, tweet);
			tweetSprite.alpha = 0;
			add(tweetSprite);			
		}
		override public function update():void 
		{
			if (!titlesShown)
			{
				title.alpha += 0.01;
				if (title.alpha >= 1)
				{
					tweetSprite.alpha += 0.01;
				}
				if (tweetSprite.alpha == 1)
				{
					timer.start(5);
					titlesShown = true;
				}
			}
			if (timer.finished || FlxG.keys.ENTER || FlxG.keys.ESCAPE || FlxG.keys.SPACE || FlxG.mouse.justReleased())
			{
				FlxG.switchState(new MainMenuState());
			}
			super.update();
		}
	}

}