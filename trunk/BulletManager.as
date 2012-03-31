package  
{
	import org.flixel.*;

	public class BulletManager extends FlxGroup
	{
		public function BulletManager() 
		{
			super();
			for (var i:int = 0; i < 40; i++)
			{
				add(new Bullet);
			}
		}
		
		public function fire(fx:int, fy:int,velocityX:int,velocityY:int):void
		{
			if (getFirstAvailable())
			{
				Bullet(getFirstAvailable()).fire(fx, fy,velocityX,velocityY);
			}
		}		
	}

}