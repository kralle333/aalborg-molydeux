package  
{
	import org.flixel.FlxGroup;
	public class EnemyManager extends FlxGroup
	{
		private var enemiesAllowed:int;
		public function EnemyManager()
		{
			for (var i:int = 0; i < enemiesAllowed; i++)
			{
				add(new Enemy);
			}
		}
	}

}