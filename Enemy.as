package  
{
	import org.flixel.*;
	
	public class Enemy extends FlxSprite
	{	
		[Embed(source = 'assets/enemy1.png')] private var enemy1:Class;
		private var isDead:Boolean = false;
		public function Enemy()
		{
			super(-200, 0, enemy1);
			loadGraphic(enemy1, true,true,24, 64);
			addAnimation("moveEnemy", [0, 1], 2,true);
			play("moveEnemy");
			alive = false;
			origin.y = height;
		}
		public function spawn():void
		{
			velocity.x = -Math.random() * 300+200;
			x = FlxG.width;
			y = FlxG.height-height-40;
			alive = true;
			
			health = 2;
		}
		override public function hurt(damage:Number):void 
		{
			 super.hurt(damage);
		}
		override public function kill():void 
		{
			isDead = true;
		}
		override public function update():void 
		{
			super.update();
			if (isDead)
			{
				angle += 5;
				alpha -= 0.1;
				if (angle >=90)
				{
					exists = false;
					alive = false;
					isDead = false;
					Registry.platforms.add(new CorpsePlatform("corpse",x,y+50));
				}
			}
		}
	}

}