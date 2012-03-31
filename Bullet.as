package  
{
	import org.flixel.*;
	public class Bullet extends FlxSprite
	{
		[Embed(source = 'assets/bullet.png')]private var texture:Class;
		
		private var speed:int = 10;
		public var damage:int;
		public function Bullet() 
		{
			speed = 100;
			damage = 2;
			super(0, 0, texture);
			exists = false;
			
		}
		public function fire(fx:int, fy:int,velocityX:Number,velocityY:Number):void
		{
			x = fx;
			y = fy;
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
		public function hit():void
		{
			
			velocity.y = 0;
			velocity.x = 0;
			exists = false;
			
		}
	}		
}