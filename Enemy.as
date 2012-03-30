package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxBasic;
	
	
	public class Enemy extends FlxSprite
	{	
		[Embed(source = 'assets/enemy1.png')] private var texture:Class;
		public function Enemy() 
		{
			super(0, 0, texture);
			alive = false;
		}
		public function spawn():void
		{
			velocity.x = -50;
			x = -Math.random() * 100 - 50;
			alive = true;
		}
	}

}