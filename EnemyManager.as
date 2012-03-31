package  
{
	import org.flixel.*;
	public class EnemyManager extends FlxGroup
	{
		private var enemiesAllowed:int = 10;
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
				var rand:int = Math.random() * 5;
				var color:uint;
				switch(rand)
				{
					case 0: color = 0xFFFF00FF; break;
					case 1: color = 0xFF0FF0F3; break;
					case 2: color = 0xFFFF00FF; break;
					case 3: color = 0xFF0FF0F3; break;
					case 4: color = 0xFFF0FF93; break;
					case 5: color = 0xFF0014FF; break;
				}
				enemy.color = color;
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