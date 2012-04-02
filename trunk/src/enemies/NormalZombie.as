package enemies
{
	import org.flixel.*;
	import gameclasses.*;
	public class NormalZombie extends Enemy
	{
		[Embed(source='../../assets/enemy1.png')]
		private var texture:Class;
		public function NormalZombie() 
		{
			super(texture);
			loadGraphic(texture, true, true, 24, 64);
			addAnimation("moveEnemy", [0, 1], 2, true);
			play("moveEnemy");
		}
		override public function spawn(typesAvailable:int):void 
		{
			super.spawn(typesAvailable);
			velocity.x = -Math.random() * 200 - 50;
			y = FlxG.height - height - 40;
			x = FlxG.width;
		}
		override public function move():void 
		{
			super.move();
		}
		override public function die():void 
		{
			angle += 10;
			alpha -= 0.1;
			if (angle >= 90)
			{
				exists = false;
				alive = false;
				isDead = false;
				if (Registry.platforms != null)
				{
					Registry.platforms.add(new CorpsePlatform("Corpse", x, FlxG.height - height - 40 + 50));
				}
			}
		}
	}

}