package gameclasses
{
	import org.flixel.FlxSprite;
	public class GroundTile extends FlxSprite
	{
		[Embed(source = '../../assets/gametextures/ground1.png')] private var ground1Texture:Class;
		var animationSpeed:Number = 0.5;
		public function GroundTile(x:int,y:int) 
		{
			super(x, y);
			loadGraphic(ground1Texture,true, true, 48, 48);
			if (Math.round(Math.random()) * 2 == 2)
			{
				addAnimation("lava", [0, 1], animationSpeed);
			}
			else
			{
				addAnimation("lava", [1, 0], 2*animationSpeed);
			}
			play("lava");
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