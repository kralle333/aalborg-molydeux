package enemies
{
	import org.flixel.FlxSprite;
	public class CorpsePlatform extends FlxSprite
	{
		public var added:Boolean;
		public var type:String = "";
		[Embed(source = '../../assets/gametextures/corpse.png')] private var platformTexture:Class;
		[Embed(source = '../../assets/gametextures/corpseBounce.png')] private var bouncyTexture:Class;
		public function CorpsePlatform(type:String,x:int,y:int) 
		{
			var chosenTexture:Class;
			if (type == "Corpse")
			{
				chosenTexture = platformTexture;
			}
			else if (type == "corpseBounce")
			{
				chosenTexture = bouncyTexture;
			}
			this.type = type;
			super(x, y, chosenTexture);
			loadGraphic(chosenTexture, false, true);
			if (Math.round(Math.random()) * 2 == 2)
			{
				facing = RIGHT;
			}
			else
			{
				facing = LEFT;
			}
			
			added = false;
		}
	}

}