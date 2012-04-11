package enemies
{
	
	import gameclasses.*;
	import org.flixel.*;
	
	public class BouncyZombie extends Enemy
	{
		private var inAir:Boolean = false;
		private var jumpHeight:int = 0;
		private var maxHeight:int = 100;
		private var currentMaxHeight:int = 0;
		[Embed(source='../../assets/enemies/enemy3.png')]
		private var texture:Class;
		
		public function BouncyZombie()
		{
			type = 2;
			super(texture);
			loadGraphic(texture, true, true, 24, 64);
			addAnimation("moveEnemy", [0, 1], 2, true);
			play("moveEnemy");
		}
		
		override public function spawn(maxStrength:int):void
		{
			super.spawn(maxStrength);
			velocity.x = -Math.random() * 100 - 50;
			y = FlxG.height - height - 40;
			x = FlxG.width;
		}
		
		override public function move():void
		{
			super.move();
			if (!inAir && y == FlxG.height - height - 40)
			{
				inAir = true;
				currentMaxHeight = Math.random() * maxHeight + 100
			}
			else if (inAir)
			{
				if (currentMaxHeight > jumpHeight)
				{
					jumpHeight += 2;
					y -= 2;
				}
				else if (y < FlxG.height - height - 40)
				{
					y += 2;
				}
				else
				{
					y = FlxG.height - height - 40
					inAir = false;
					jumpHeight = 0;
				}
			}
		
		}
		
		override public function kill():void
		{
			super.kill();
			velocity.y += 500;
			flicker(2);
			velocity.x = 0;
		}
		
		override public function die():void
		{
			angle += 10;
			alpha -= 0.1;
			if (y > FlxG.height - height && angle >= 90)
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