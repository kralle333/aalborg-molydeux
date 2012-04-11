package weapons 
{
	import org.flixel.*;
	public class MachineGun extends Weapon
	{
		[Embed(source='../../assets/weapons/machinegun.png')]
		private var texture:Class;
		private var bulletOffset:Number = 0.05;
		public function MachineGun() 
		{
			bulletSpeed = 0.2;
			barrelPosition = new FlxPoint(30, 13);
			super(texture);
		}
		override public function canShoot():Boolean 
		{
			return super.canShoot() && FlxG.mouse.pressed();
		}
		override public function shoot(x:int, y:int, velocityX:Number, velocityY:Number):void 
		{
			var randomVelocityX:Number = Math.random()*bulletOffset*2-bulletOffset;
			var randomVelocityY:Number = Math.random() * bulletOffset*2 - bulletOffset;
			super.shoot(x - 10, y, velocityX + randomVelocityX, velocityY + randomVelocityY);
			bulletTimer = 0;
		}
	}

}