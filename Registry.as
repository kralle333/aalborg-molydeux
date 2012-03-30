package  
{
	public class Registry 
	{
		public static var player:Player;
		public static var enemies:EnemyManager;
		
		public static function init() 
		{
			player = new Player("Dudebro");
			enemies = new EnemyManager();
		}
		
	}

}