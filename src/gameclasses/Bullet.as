package gameclasses
{
	import org.flixel.*;
	public class Bullet extends FlxSprite
	{
		[Embed(source = '../../assets/weapons/bullet.png')]private var texture:Class;
		
		private var speed:int = 10;
		public var damage:int;
		public function Bullet() 
		{
			speed = 400;
			damage = 2;
			super(0, 0, texture);
			exists = false;
			
		}
		public function fire(fx:int, fy:int,velocityX:Number,velocityY:Number):void
		{
			x = fx;
			y = fy;
			damage = 2;
			this.velocity.x = velocityX*speed;
			this.velocity.y = velocityY*speed;
			exists = true;
		}
		override public function update():void 
		{
			super.update();
			if (exists)
			{
				if (x > FlxG.width) { exists = false; }
				if (y > FlxG.height) { exists = false; }
				if (x < 0 || y < 0) { exists = false; }
			}
			
		}
	}		
}