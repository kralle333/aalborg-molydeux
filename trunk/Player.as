package  
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*
	
	public class Player extends FlxSprite
	{
		private var userName:String;
		private var xSpeed:int = 5;
		private var ySpeed:int = 2;
		private var isJumping:Boolean = false;
		public var falling:Boolean = false;
		private var maxHeight:int = 100;
		private var jumpHeight:int = 0;
		public var gun:FlxSprite;
		
		[Embed(source = 'assets/player.png')] private var bodyTexture:Class;
		[Embed(source = 'assets/gun.png')] private var gunTexture:Class;
		public function Player(userName:String) 
		{
			this.userName = userName;
			super(40, 0);
			this.loadGraphic(bodyTexture, true, true, 24, 64);
			gun = new FlxSprite(0, 0,gunTexture);
			gun.origin = new FlxPoint(4,4);
			y = FlxG.height - height - 48;
			addAnimation("Walking", [2,3,4],10);
			addAnimation("Standing", [0]);
			addAnimation("Jumping", [1]);
			
			play("Walking");
		}
		
		override public function update():void 
		{
			super.update();
			gun.x = this.x + width / 2-4;
			gun.y = this.y + height / 2-10;
			gun.angle = FlxMath.atan2( FlxG.mouse.y - gun.y, FlxG.mouse.x - gun.x) * (180 / 3.14);
			if (FlxG.keys.A )
			{
				play("Walking");
			}
			else if (FlxG.keys.D)
			{
				Registry.moveAllObjects( -xSpeed);
				FlxG.score += xSpeed;
				play("Walking");
			}
			else
			{
				play("Walking");
			}
			if ((FlxG.keys.W ||FlxG.keys.SPACE) && !isJumping)
			{
				isJumping = true;
				falling = true;
			}
			if (isJumping)
			{
				play("Jumping");
				if (jumpHeight < maxHeight)
				{
					y -= ySpeed;
					jumpHeight += ySpeed;
				}
				else
				{
					y += ySpeed;
				}
				if (!falling)
				{
					isJumping = false;
				}
			}
			else if (falling)
			{
				y += ySpeed;
			}
			else
			{
				play("Walking");
			}
			if (FlxG.mouse.justPressed())
			{
				var bulletX:int = Math.round(gun.x + gun.width * Math.cos(FlxMath.asRadians(gun.angle)));
				var bulletY:int = Math.round(gun.y+gun.height/2 + gun.width * Math.sin(FlxMath.asRadians(gun.angle)));
				var velocityX:Number =Math.cos(FlxMath.asRadians(gun.angle));
				var velocityY:Number =Math.sin(FlxMath.asRadians(gun.angle));
				Registry.bullets.fire(bulletX, bulletY,velocityX,velocityY);
			} 
		}
		public function landed(value:Boolean):void
		{
			falling = value;
			if (!value)
			{
				jumpHeight = 0;
			}
		}
	}

}