package  
{
	import org.flixel.FlxSprite;
	public class CorpsePlatform extends FlxSprite
	{
		public var added:Boolean;
		
		public function CorpsePlatform(type:String,x:int,y:int) 
		{
			[Embed(source = 'assets/corpse.png')] var platformTexture:Class;
			super(x,y, platformTexture);
			added = false;
		}
	}

}