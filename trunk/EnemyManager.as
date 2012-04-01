package  
{
	import org.flixel.*;
	public class EnemyManager extends FlxGroup
	{
		private var enemiesAllowed:int = 5;
		private var enemiesAlive:int = 0;
		private var typesAvaible:int = 1;
		public function EnemyManager()
		{
			for (var i:int = 0; i < enemiesAllowed; i++)
			{
				add(new Enemy);
				spawnEnemy();
			}
		}
		public function spawnEnemy():void
		{
			var enemy:Enemy = Enemy(getFirstDead());
			if (enemy)		
			{
				enemy.spawn(typesAvaible);
				alive = true;
				enemiesAlive++;
			}
		}
		override public function update():void 
		{
			super.update();
			if (FlxG.score !=0 &&FlxG.score%1000 == 0)
			{
				enemiesAllowed += 2;
				if (typesAvaible == 1)
				{
					typesAvaible++;
				}
			}
			if (FlxG.score !=0 && FlxG.score%1000 == 0)
			{
				if (typesAvaible == 2)
				{
					typesAvaible++;
				}
				typesAvaible++;
			}
			enemiesAlive = this.countLiving();
			if (enemiesAlive < enemiesAllowed)
			{
				spawnEnemy();
			}
			
		}
	}

}