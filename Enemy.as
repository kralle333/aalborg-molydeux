package  
{
	import org.flixel.*;
	
	public class Enemy extends FlxSprite
	{	
		[Embed(source = 'assets/enemy1.png')] private var texture:Class;
		public function Enemy()
		{
			super(-200, 0, texture);
			alive = false;
		}
		public function spawn():void
		{
			velocity.x = -Math.random() * 300+200;
			x = FlxG.width;
			y = FlxG.height-height;
			alive = true;
			health = 100;
		}
		override public function update():void 
		{
			super.update();
		}
	}

}