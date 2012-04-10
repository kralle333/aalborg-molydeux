package gameclasses
{
	import org.flixel.FlxSprite;
	public class Background extends FlxSprite 
	{
		
		[Embed(source = '../../assets/gametextures/background.png')] private var backgroundSprite:Class;
		public function Background(x:int, y:int) 
		{
			super(x, y);
			loadGraphic(backgroundSprite,true, true,400,480);
			addAnimation("Background", [0],0, true);
			play("Background");
		}
		override public function update():void 
		{
			super.update();
			if (x + width < 0)
			{
				exists = false;
			}
			
		}
		
	}

}