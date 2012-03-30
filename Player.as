package  
{
	import org.flixel.*;
	
	public class Player extends FlxSprite
	{
		private var userName:String;
		private var xSpeed:int = 5;
		private var ySpeed:int = 2;
		private var isJumping:Boolean = false;
		private var maxHeight:int = 100;
		private var jumpHeight:int = 0;
		[Embed(source = 'assets/player.png')] private var texture:Class;
		
		public function Player(userName:String) 
		{
			this.userName = userName;
			super(0, 0, texture);
			y = FlxG.height - height;
		}
		
		override public function update():void 
		{
			super.update();
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
		}
				
	}

}