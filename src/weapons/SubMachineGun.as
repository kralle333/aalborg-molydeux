package weapons 
{
	import org.flixel.*;
	public class SubMachineGun extends Weapon
	{
		[Embed(source = '../../assets/weapons/submachinegun.png')]
		private var texture:Class;
		private var bulletOffset:Number = 0.1;
		public function SubMachineGun() 
		{
			super(texture);
			type = "SubMachineGun";
			bulletSpeed = 0.1;
		}
		override public function canShoot():Boolean 
		{
			return super.canShoot() && FlxG.mouse.pressed();
		}
		override public function shoot(x:int, y:int, velocityX:Number, velocityY:Number):void 
		{
			var randomVelocityX:Number = Math.random()*bulletOffset*2-bulletOffset;
			var randomVelocityY:Number = Math.random() * bulletOffset*2 - bulletOffset;
			trace(randomVelocityX);
			super.shoot(x - 15, y, velocityX + randomVelocityX, velocityY + randomVelocityY);
			bulletTimer = 0;
		}
	}

}