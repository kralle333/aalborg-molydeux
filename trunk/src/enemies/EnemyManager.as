package enemies
{
	import org.flixel.*;
	public class EnemyManager extends FlxGroup
	{
		private var enemiesAllowed:int = 5;
		private var enemiesAlive:int = 0;
		public var typesAvailable:int = 1;
		public var enemyStrength:int = 1;
		public function EnemyManager()
		{
			for (var i:int = 0; i < enemiesAllowed; i++)
			{
				add(new NormalZombie());
				spawnEnemy();
			}
		}
		public function spawnEnemy():void
		{
			var enemy:Enemy = Enemy(getFirstDead());
			if (enemy)		
			{
				remove(enemy);
				var type:int = Math.round(Math.random() * (typesAvailable - 1));
				if (type > 2)
				{
					type = 2;
				}
				var newEnemy:Enemy;
				switch(type)
				{
					case 0:newEnemy = new NormalZombie(); break;
					case 1:newEnemy = new BouncyZombie(); break;
					case 2:newEnemy = new FlyingZombie(); break;
				}
				newEnemy.spawn(enemyStrength);
				add(newEnemy);				
				enemiesAlive++;
			}
		}
		override public function update():void 
		{
			super.update();
			if (FlxG.score !=0 &&FlxG.score%3000 == 0 && FlxG.score %6000 != 0)
			{
				enemiesAllowed += 5;
				enemyStrength++;		
			}
			if (FlxG.score !=0 &&FlxG.score%6000 == 0)
			{
				enemiesAllowed += 5;
				typesAvailable++;
			}
			enemiesAlive = this.countLiving();
			if (enemiesAlive < enemiesAllowed)
			{
				spawnEnemy();
			}
			
		}
	}

}