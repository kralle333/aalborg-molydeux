package gameclasses
{
	import adobe.utils.CustomActions;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*
	import weapons.Weapon;
	
	public class Player extends FlxSprite
	{
		private var currentAnimation:int = 0;
		private var userName:String;
		private var xSpeed:int = 5;
		private var ySpeed:int = 2;
		
		public var isLanded:Boolean = true;
		public var falling:Boolean = false;
		public var jumping:Boolean = false;
		
		private var maxHeight:int = 100;
		private var jumpHeight:int = 0;
		public var gun:FlxSprite;
		public var xBounds:int = 100;
		public var isBouncing:Boolean = false;
		private var save:FlxSave = new FlxSave();
		
		private var bulletTimer:Number = 0;
		private var bulletSpeed:Number = 0.05;
		
		public var currentWeapon:Weapon;
		private var ownedGuns:Array = new Array();
		
		[Embed(source='../../assets/gametextures/player.png')]
		private var bodyTexture:Class;
		
		public function Player(userName:String)
		{
			ownedGuns.push("Pistol");
			ownedGuns.push("SubMachineGun");
			this.userName = userName;
			super(xBounds, 0);
			this.loadGraphic(bodyTexture, true, true, 24, 64);
			y = FlxG.height - height - 48;
			addAnimation("Standing", [0]);
			addAnimation("Jumping", [1]);
			addAnimation("Walking", [2, 3, 4, 5], 10);
			play("Standing");
		}
		
		override public function update():void
		{
			super.update();
			handleMovement();
			handleShooting();
		}
		
		private function handleMovement():void
		{
			if (FlxG.keys.A && x - xSpeed > 0)
			{
				x -= xSpeed / 2;
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
			else if ((!jumping && !falling))
			{
				play("Standing");
				currentAnimation = 0;
			}
			if (isBouncing)
			{
				y -= 5;
				jumpHeight += 5;
				isLanded = false;
				jumping = true;
				if (currentAnimation != 1)
				{
					play("Jumping");
					currentAnimation = 1;
				}
			}
			if ((FlxG.keys.W || FlxG.keys.SPACE) && isLanded)
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
			if (jumping && ((jumpHeight >= maxHeight) || !(FlxG.keys.W || FlxG.keys.SPACE) && !isBouncing))
			{
				falling = true;
				jumping = false;
				isLanded = false;
				isBouncing = false;
				jumpHeight = 0;
			}
			else if (falling && !jumping)
			{
				y += ySpeed;
			}
		}
		
		private function handleShooting():void
		{
			currentWeapon.x = this.x + width / 2 - 5;
			currentWeapon.y = this.y + height / 2 - 10;
			currentWeapon.angle = FlxMath.atan2(FlxG.mouse.y - currentWeapon.y, FlxG.mouse.x - currentWeapon.x) * (180 / Math.PI);
			
			if (currentWeapon.canShoot())
			{
				
				var bulletX:int = Math.round(currentWeapon.x + currentWeapon.width * Math.cos(FlxMath.asRadians(currentWeapon.angle)));
				var bulletY:int = Math.round(currentWeapon.y + 12 + currentWeapon.width * Math.sin(FlxMath.asRadians(currentWeapon.angle)));
				var velocityX:Number = Math.cos(FlxMath.asRadians(currentWeapon.angle));
				var velocityY:Number = Math.sin(FlxMath.asRadians(currentWeapon.angle));
				currentWeapon.shoot(bulletX, bulletY, velocityX, velocityY);
			}
		}
		
		public function ownsGun(type:String):Boolean
		{
			for (var i:int = 0; i < ownedGuns.length; i++)
			{
				if (ownedGuns[i] == type)
				{
					return true;
				}
			}
			return false;
		}
	}

}