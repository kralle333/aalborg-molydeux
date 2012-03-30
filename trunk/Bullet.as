package  
{
	import org.flixel.*;
	public class Bullet extends FlxSprite
	{
		//[Embed(source = 'NAVNPÅFIL.png')]private var nBulletTexture:Class;
		
		private var speed:int;
		public var damage:int;
		public function Bullet() 
		{
			var texture:Class;
			texture = nBulletTexture;
			speed = 100;
			damage = 10;
			super(0, 0, texture);
			exists = false;
			
		}
		public function fire(fx:int, fy:int):void
		{
			this.velocity.x -= speed;
			this.velocity.y -= speed;
			this.angle = 50;
			
			this.
			
		}
		override public function update():void 
		{
			super.update();
			
			
		}
		public function hit():void
		{

			
		}
	}		
		
		
		
		
	}

}