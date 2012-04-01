package  
{
	import org.flixel.FlxSprite;
	public class CorpsePlatform extends FlxSprite
	{
		public var added:Boolean;
		public var type:String = "";
		[Embed(source = 'assets/corpse.png')] var platformTexture:Class;
		[Embed(source = 'assets/corpseBounce.png')] var bouncyTexture:Class;
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
			super(x,y, chosenTexture);
			added = false;
		}
	}

}