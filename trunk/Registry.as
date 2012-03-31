package  
{
	public class Registry 
	{
		public static var player:Player;
		public static var enemies:EnemyManager;
		public static var bullets:BulletManager;
		
		public static function init():void
		{
			player = new Player("Dudebro");
			enemies = new EnemyManager();
			bullets = new BulletManager();
		}
		
	}

}