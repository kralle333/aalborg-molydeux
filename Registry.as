package  
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	public class Registry 
	{
		public static var player:Player;
		public static var enemies:EnemyManager;
		public static var bullets:BulletManager;
		public static var groundTiles:FlxGroup;
		public static var platforms:FlxGroup;
		public static var cameraX:int;
		public static var background:FlxGroup;
		
		public static function init():void
		{
			player = new Player("Dudebro");
			background = new FlxGroup();
			enemies = new EnemyManager();
			bullets = new BulletManager();
			groundTiles = new FlxGroup();
			platforms = new FlxGroup();
		}
		public static function moveAllObjects(x:int):void
		{
			for (var tile in groundTiles.members)
			{
				Registry.groundTiles.members[tile].x += x;
			}
			for (var platform in platforms.members)
			{
				platforms.members[platform].x += x;
			}
			for (var enemy in enemies.members)
			{
				enemies.members[enemy].x += x;
			}
			for (var backgrounds in background.members) 
			{
				Registry.background.members[backgrounds].x += x;
			}
		}
	}

}