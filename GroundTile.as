package  
{
	import org.flixel.FlxSprite;
	public class GroundTile extends FlxSprite
	{
		[Embed(source = 'assets/ground1.png')] private var ground1Texture:Class;
		public function GroundTile(x:int,y:int) 
		{
			super(x, y);
			loadGraphic(ground1Texture,true, true, 48, 48);
			if (Math.round(Math.random()) * 2 == 2)
			{
				addAnimation("lava", [0, 1], 3);
			}
			else
			{
				addAnimation("lava", [1, 0], 3);
			}
			play("lava");
		}
		override public function update():void 
		{
			super.update();
			if (x + width < Registry.cameraX)
			{
				exists = false;
			}
		}
	}

}