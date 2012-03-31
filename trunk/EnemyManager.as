package  
{
	import org.flixel.*;
	public class EnemyManager extends FlxGroup
	{
		private var enemiesAllowed:int = 5;
		private var enemiesAlive:int = 0;
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
				enemy.spawn();
				alive = true;
				enemiesAlive++;
			}
		}
		override public function update():void 
		{
			super.update();
			enemiesAlive = this.countLiving();
			if (enemiesAlive < enemiesAllowed)
			{
				spawnEnemy();
			}
			
		}
	}

}