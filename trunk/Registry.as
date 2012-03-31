package  
{
	import org.flixel.FlxGroup;
	public class Registry 
	{
		public static var player:Player;
		public static var enemies:EnemyManager;
		public static var bullets:BulletManager;
		public static var groundTiles:FlxGroup;
		public static var platforms:FlxGroup;
		
		public static function init():void
		{
			player = new Player("Dudebro");
			enemies = new EnemyManager();
			bullets = new BulletManager();
			groundTiles = new FlxGroup();
			platforms = new FlxGroup();
		}
		
	}

}