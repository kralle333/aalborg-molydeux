package gameclasses
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*
	
	public class Player extends FlxSprite
	{
		private var currentAnimation:int = 0;
		private var userName:String;
		private var xSpeed:int = 5;
		private var ySpeed:int = 2;
		private var canJump:Boolean = true;
		public var falling:Boolean = false;
		public var jumping:Boolean = false;
		private var maxHeight:int = 100;
		private var jumpHeight:int = 0;
		public var gun:FlxSprite;
		public var xBounds:int = 100;
		public var isBouncing:Boolean = false;
		private var save:FlxSave = new FlxSave();
		
		[Embed(source='../../assets/player.png')]
		private var bodyTexture:Class;
		[Embed(source='../../assets/gun.png')]
		private var gunTexture:Class;
		
		public function Player(userName:String)
		{
			this.userName = userName;
			super(xBounds, 0);
			this.loadGraphic(bodyTexture, true, true, 24, 64);
			gun = new FlxSprite(0, 0, gunTexture);
			gun.origin = new FlxPoint(4, 4);
			y = FlxG.height - height - 48;
			addAnimation("Standing", [0]);
			addAnimation("Jumping", [1]);
			addAnimation("Walking", [2, 3, 4, 5], 10);
			play("Standing");
		}
		
		override public function update():void
		{
			super.update();
			gun.x = this.x + width / 2 - 5;
			gun.y = this.y + height / 2 - 10;
			gun.angle = FlxMath.atan2(FlxG.mouse.y - gun.y, FlxG.mouse.x - gun.x) * (180 / 3.14);
			if (FlxG.keys.A && x - xSpeed > 0)
			{
				x -= xSpeed;
				if ((!jumping && !falling) && currentAnimation != 2)
				{
					play("Walking");
					currentAnimation = 2;
				}
			}
			else if (FlxG.keys.D)
			{
				if (x + xSpeed < xBounds)
				{
					x += xSpeed;
				}
				else
				{
					Registry.moveAllObjects(-xSpeed);
					FlxG.score += xSpeed;
				}
				if ((!jumping && !falling) && currentAnimation != 2)
				{
					play("Walking");
					currentAnimation = 2;
				}
			}
			if (isBouncing)
			{
				y -= 5;
				jumpHeight += 5;
				canJump = false;
				jumping = true;
				if (currentAnimation != 1)
				{
					play("Jumping");
					currentAnimation = 1;
				}
			}
			if ((FlxG.keys.W || FlxG.keys.SPACE) && canJump)
			{
				jumping = true;
				if (currentAnimation != 1)
				{
					play("Jumping");
					currentAnimation = 1;
				}
				
				if (jumpHeight < maxHeight)
				{
					y -= ySpeed + 1;
					jumpHeight += ySpeed + 1;
				}
			}
			if (jumping&&((jumpHeight >= maxHeight) || !(FlxG.keys.W || FlxG.keys.SPACE)&&!isBouncing))
			{
				falling = true;
				jumping = false;
				canJump = false;
				isBouncing = false;
				jumpHeight = 0;
			}
			else if (falling)
			{
				y += ySpeed;
			}
			else if ((!jumping && !falling) && currentAnimation != 0)
			{
				play("Standing");
				currentAnimation = 0;
			}
			if (FlxG.mouse.justPressed())
			{
				var bulletX:int = Math.round(gun.x + gun.width * Math.cos(FlxMath.asRadians(gun.angle)));
				var bulletY:int = Math.round(gun.y + gun.height / 2 + gun.width * Math.sin(FlxMath.asRadians(gun.angle)));
				var velocityX:Number = Math.cos(FlxMath.asRadians(gun.angle));
				var velocityY:Number = Math.sin(FlxMath.asRadians(gun.angle));
				Registry.bullets.fire(bulletX, bulletY, velocityX, velocityY);
			}
		}
		public function landed(value:Boolean):void
		{
			if (value == true)
			{
				falling = false;
			}
			if (canJump == false && value)
			{
				canJump = true;
			}
		}
	}

}