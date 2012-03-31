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
			y = FlxG.height-height-40;
			alive = true;
			health = 2;
		}
		override public function hurt(damage:Number):void 
		{
			 super.hurt(damage);
		}
		override public function kill():void 
		{
			exists = false;
			alive = false;
			super.kill();
		}
		override public function update():void 
		{
			super.update();
		}
	}

}