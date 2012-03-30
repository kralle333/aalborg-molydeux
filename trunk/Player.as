package  
{
	import org.flixel.*;
	
	public class Player extends FlxSprite
	{
		
		private var kmRun:Number;
		private var userName:String;
		private var xSpeed:int = 5;
		[Embed(source = 'assets/player.png')] private var texture:Class;
		
		public function Player(userName:String) 
		{
			this.userName = userName;
			this.health = 1;
			this.kmRun = 0;
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
		}
		
	}

}