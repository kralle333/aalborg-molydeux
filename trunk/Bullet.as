package  
{
	import org.flixel.*;
	public class Bullet extends FlxSprite
	{
		private var speed:int;
		public var enemiesHit:Array = new Array();
		public var damage:int;
		public function Bullet() 
		{
			
		}
		public function fire(fx:int, fy:int):void
		{
			
		}
		override public function update():void 
		{
			super.update();
			if (y < 0 && exists)
			{
				velocity.y = 0;
				exists = false;
				enemiesHit = new Array();
			}
		}
		public function explode():void
		{
			if (Registry.Player is NintendoShip) 
			{
				velocity.y = 0;
				exists = false;
				enemiesHit = new Array();
			}
		}
	}		
		
		
		
		
	}

}