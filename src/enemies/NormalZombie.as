package enemies

	public class NormalZombie extends Enemy
	{
		
		public function NormalZombie() 
		{
			
		}
		override function move()
		{
			if (type == 1)
			{
				if (!inAir && y == FlxG.height - height - 40)
				{
					inAir = true;
					currentMaxHeight = Math.random() * maxHeight + 100
				}
				else if (inAir)
				{
					if (currentMaxHeight > jumpHeight)
					{
						jumpHeight += 2;
						y -= 2;
					}
					else if(y < FlxG.height - height - 40)
					{
						y += 2;
					}
					else
					{
						y = FlxG.height - height - 40
						inAir = false;
						jumpHeight = 0;
					}
				}
			}
			}
	}

}