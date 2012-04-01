package  
{
	import org.flixel.*;
	
	public class Enemy extends FlxSprite
	{	
		[Embed(source = 'assets/enemy1.png')] private var enemy1:Class;
		[Embed(source = 'assets/enemy2.png')] private var enemy2:Class;
		private var isDead:Boolean = false;
		private var type:int = 0;
		private var inAir:Boolean = false;
		private var maxHeight:int = 100;
		private var currentMaxHeight:int = 0;
		private var jumpHeight:int = 0;
		public function Enemy()
		{
			super(-200, 0, enemy1);
			loadGraphic(enemy1, true,true,24, 64);
			addAnimation("moveEnemy", [0, 1], 2,true);
			play("moveEnemy");
			alive = false;
			origin.y = height;
		}
		public function spawn(typesAvailable:int):void
		{
			velocity.x = -Math.random() * 200-50;
			x = FlxG.width+Registry.player.x;
			y = FlxG.height - height - 40;
			inAir = false;
			jumpHeight = 0;
			alpha = 1;
			angle = 0;
			alive = true;
			exists = true;
			health = 2;
			angularVelocity = 0;
			type = Math.round(Math.random() * (typesAvailable-1));
			switch(type)
			{
				case 0: color = 0xFFFFFFFF;loadGraphic(enemy1, true,true,24, 64); break;
				case 1: color = 0xFFFF0000;loadGraphic(enemy1, true,true,24, 64); break;
				case 2: color = 0xFF00FFFF;loadGraphic(enemy1, true,true,24, 64); health = 8; break;
				case 3:  color = 0xFFFFFFFF;y = 100; loadGraphic(enemy2, false, false, 64, 64); angularVelocity = Math.random() * 100+100; break;
			}
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
			if (type == 1)
			{
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
					else if(y < FlxG.height - height - 40)
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
			if (type == 3)
			{
				y-=Math.random()*2-2
			}
			if (x + width < 0)
			{
				isDead = true;
			}
			if (isDead)
			{
				if (y < FlxG.height - height - 40)
				{
					y -= 10;
				}
				angle += 10;
				alpha -= 0.1;
				if (angle >=90)
				{
					
					exists = false;
					alive = false;
					isDead = false;
					var corpsePosition:int = FlxG.height - height - 40 + 50;
					var stringType:String = "Corpse";
					if (type == 3)
					{
						stringType = "corpseBounce";
						corpsePosition -= 10;
					}
					Registry.platforms.add(new CorpsePlatform(stringType,x,corpsePosition));
				}
			}
		}
	}

}