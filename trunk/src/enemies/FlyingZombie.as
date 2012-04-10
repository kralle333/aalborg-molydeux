package enemies
{
	import org.flixel.*
	import gameclasses.*
	
	public class FlyingZombie extends Enemy
	{
		[Embed(source='../../assets/enemies/enemy2.png')]
		private var texture:Class;
		private var bouncing:Boolean = false;
		
		public function FlyingZombie()
		{
			super(texture);
			loadGraphic(texture);
		}
		
		override public function spawn(typesAvailable:int):void
		{
			super.spawn(typesAvailable);
			color = 0xFFFFFFFF;
			y = 100;
			loadGraphic(texture, false, false, 64, 64);
			angularVelocity = (Math.round(Math.random()) * -1) * Math.random() * 100 + 200;
			velocity.x = -Math.random() * 200 - 50;
		}
		
		override public function move():void
		{
			super.move();
			if (!isDead)
			{
				if (y + height > FlxG.height - 60)
				{
					bouncing = true;
				}
				if (bouncing)
				{
					y -= 5;
					if (y + height < FlxG.height / 2)
					{
						bouncing = false;
					}
				}
				else
				{
					y -= Math.random() * 2 - 2
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
			if (y > FlxG.height - height)
			{
				exists = false;
				alive = false;
				isDead = false;
				var corpsePosition:int = FlxG.height - height - 40 + 40;
				
				if (Registry.platforms != null)
				{
					Registry.platforms.add(new CorpsePlatform("corpseBounce", x, corpsePosition));
				}
			}
		}
	
	}

}