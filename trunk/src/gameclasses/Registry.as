package gameclasses
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import enemies.*;
	import states.*;
	public class Registry 
	{
		public static var player:Player;
		public static var enemiesGroup:EnemyManager;
		public static var bullets:BulletManager;
		public static var groundTiles:FlxGroup;
		public static var platforms:FlxGroup;
		public static var background:FlxGroup;
		public static var startBar:FlxSprite;
		
		public static function init():void
		{
			player = new Player("Dudebro");
			background = new FlxGroup();
			enemiesGroup = new EnemyManager();
			bullets = new BulletManager();
			groundTiles = new FlxGroup();
			platforms = new FlxGroup();
			startBar = new FlxSprite(0, 0);
		}
		public static function moveAllObjects(x:int):void
		{
			for (var tile:String in groundTiles.members)
			{
				Registry.groundTiles.members[tile].x += x;
			}
			for (var platform:String in platforms.members)
			{
				platforms.members[platform].x += x;
			}
			
			for (var backgrounds:String in background.members) 
			{
				Registry.background.members[backgrounds].x += x;
			}
			for (var enemy:String in enemiesGroup.members)
			{
				enemiesGroup.members[enemy].x += x;
			}
			startBar.x += x;
		}
	}

}