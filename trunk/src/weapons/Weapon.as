package weapons
{
	import org.flixel.*;
	import gameclasses.*;
	public class Weapon extends FlxSprite
	{
		protected var bulletTimer:Number = 0;
		protected var bulletSpeed:Number = 0.08;
		protected var mouseReleased:Boolean;
		public var type:String;
		
		public function Weapon(texture:Class)
		{
			super(Registry.player.x + width / 2 - 5, Registry.player.y + height / 2 - 10, texture);
		}
		
		public function canShoot():Boolean
		{
			if (bulletTimer > 1)
			{
				return true;
			}
			return false;
		}
		public function shoot(x:int, y:int, velocityX:Number, velocityY:Number):void
		{
			Registry.bullets.fire(x, y, velocityX, velocityY);
		}
		override public function update():void 
		{
			super.update();
			bulletTimer += bulletSpeed;
			mouseReleased = FlxG.mouse.justReleased();
		}
	}

}