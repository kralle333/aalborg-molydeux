package  
{
	import org.flixel.*;
	
	public class Player extends FlxSprite
	{
		
		
		
		private var kmRun:Number;		
		private var health:int;
		private var userName:String;
		
		public function Player() 
		{
			
		}
		public function Player(userName:String) 
		{
			this.userName = userName;
			this.health = 1;
			this.kmRun = 0;
			FlxSprite.RIGHT;
			
		}
		
		
		
	}

}