package weapons
{
	import gameclasses.*;
	import org.flixel.FlxPoint;
	public class Pistol extends Weapon
	{
		[Embed(source='../../assets/weapons/pistol.png')]
		private var texture:Class;
		public function Pistol()
		{
			barrelPosition = new FlxPoint(28, 13);
			type = "Pistol";
			super(texture);
		}
		
		override public function canShoot():Boolean
		{
			if (!mouseReleased)
			{
				return false;
			}
			return super.canShoot();
		}
		
		override public function shoot(x:int, y:int, velocityX:Number, velocityY:Number):void
		{
			if (bulletTimer > 1)
			{
				Registry.bullets.fire(x, y, velocityX, velocityY);
				bulletTimer = 0;
			}
		}
	}

}