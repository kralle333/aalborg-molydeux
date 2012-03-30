package  
{
	import org.flixel.*;
	
	public class Player extends FlxSprite
	{

		private var kmRun:Number;		
		private var userName:String;

		public function Player(userName:String) 
		{
			this.userName = userName;
			this.health = 1;
			this.kmRun = 0;
			
		}
		
		override public function update():void 
		{
			var x:int = FlxG.mouse.screenX;
			var y:int = FlxG.mouse.screenY;
			
			if (FlxG.mouse.justPressed)
			{
				
			}
			
			super.update();
		}
		
	}

}