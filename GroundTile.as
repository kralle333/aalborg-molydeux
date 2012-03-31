package  
{
	import org.flixel.FlxSprite;
	public class GroundTile extends FlxSprite
	{
		[Embed(source = 'assets/ground1.png')] private var ground1Texture:Class;
		public function GroundTile(x:int,y:int) 
		{
			super(x, y);
			loadGraphic(ground1Texture, true, true, 48, 48);
			addAnimation("lava", [0, 1], 5);
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