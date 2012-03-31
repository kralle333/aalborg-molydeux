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
		private var maxHeight:int = 100;
		private var jumpHeight:int = 0;
		public var gun:FlxSprite;
		public var startBar:FlxSprite;
		[Embed(source = 'assets/player.png')] private var bodyTexture:Class;
		[Embed(source = 'assets/startBar.png')] private var startBarTexture:Class;
		[Embed(source = 'assets/gun.png')] private var gunTexture:Class;
		public function Player(userName:String) 
		{
			this.userName = userName;
			super(0, 0, bodyTexture);
			startBar = new FlxBar(0, 0, 2, 100, 10, Player, "Health");
			gun = new FlxSprite(0, 0, gunTexture);
			gun.origin = new FlxPoint(x, y);
			y = FlxG.height - height;
		}
		
		override public function update():void 
		{
			super.update();
			gun.x = this.x + width / 2;
			gun.y = this.y + height / 2 - 5;
			gun.angle = FlxMath.atan2( FlxG.mouse.y - gun.y, FlxG.mouse.x - gun.x) * (180 / 3.14);
			if (FlxG.keys.A && x-xSpeed>0)
			{
				x -= xSpeed;
			}
			if (FlxG.keys.D && x + width + xSpeed < FlxG.width)
			{
				x += xSpeed;
			}
			if (FlxG.keys.W && !isJumping)
			{
				isJumping = true;
			}
			if (FlxG.keys.SPACE && !isJumping)
			{
				isJumping = true;
			}
			if (isJumping)
			{
				if (jumpHeight < maxHeight)
				{
					y -= ySpeed;
					jumpHeight += ySpeed;
				}
				else if(y+height+ySpeed<FlxG.height)
				{
					y += ySpeed;
				}
				else
				{
					isJumping = false;
					jumpHeight = 0;
				}
			}
			if (FlxG.mouse.justReleased())
			{
				var bulletX:int = Math.round(gun.x + gun.width * Math.cos(FlxMath.asRadians(gun.angle)));
				var bulletY:int = Math.round(gun.y + gun.width * Math.sin(FlxMath.asRadians(gun.angle)));
				var velocityX:Number =Math.cos(FlxMath.asRadians(gun.angle));
				var velocityY:Number =Math.sin(FlxMath.asRadians(gun.angle));
				Registry.bullets.fire(bulletX, bulletY,velocityX,velocityY);
			} 
		}
				
	}

}