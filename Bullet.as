package  
{
	import org.flixel.*;
	public class Bullet extends FlxSprite
	{
		[Embed(source = 'assets/bullet.png')]private var texture:Class;
		
		private var speed:int = 2;
		public var damage:int;
		public function Bullet() 
		{
			speed = 100;
			damage = 10;
			super(0, 0, texture);
			exists = false;
			
		}
		public function fire(fx:int, fy:int,velocityX:int,velocityY:int):void
		{
			x = fx;
			y = fy;
			this.velocity.x += velocityX;
			this.velocity.y += velocityY;
			
			exists = true;
			
		}
		override public function update():void 
		{
			super.update();
			
			
		}
		public function hit():void
		{

			velocity.y = 0;
			velocity.x = 0;
			exists = false;
			
			
		}
	}		
}