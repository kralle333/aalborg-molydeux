package enemies
{
	import org.flixel.*;
	import gameclasses.*
	
	public class Enemy extends FlxSprite
	{
		public var isDead:Boolean = false;
		public var type:int = 0;
		public var strength:int = 0;
		private var inAir:Boolean = false;
		private var maxHeight:int = 100;
		private var currentMaxHeight:int = 0;
		private var jumpHeight:int = 0;
		private var bouncing:Boolean = false;
		
		public function Enemy(texture:Class)
		{
			super(200, 50, texture);
			exists = false;
			alive = false;
			origin.y = height;
		}
		
		public function spawn(maxStrength:int):void
		{
			inAir = false;
			x = FlxG.width;
			jumpHeight = 0;
			alpha = 1;
			angle = 0;
			alive = true;
			exists = true;
			health = 2;
			angularVelocity = 0;
			bouncing = false;
			strength = Math.round(Math.random() * (maxStrength));
			if (strength > 3)
			{
				strength = 3;
			}
			else if (strength < 2)
			{
				strength = 1;
			}
			switch (strength)
			{
				case 2: 
					color = 0xFF00FF00;
					health = 4;
					break;
				case 3: 
					color = 0xFFFF0000;
					health = 6;
					break;
				case 4: 
					color = 0xFF0000FF;
					health = 8;
					break;
			}
		}
		
		override public function hurt(damage:Number):void
		{
			super.hurt(damage);
			if (health > 0)
			{
				this.flicker(1);
			}
		}
		
		override public function kill():void
		{
			isDead = true;
		}
		
		override public function update():void
		{
			super.update();
			move();
			if (x + width < 0)
			{
				isDead = true;
			}
			if (isDead)
			{
				die();
			}
		
		}
		
		//Enemies override this
		public function move():void
		{
		
		}
		
		public function die():void
		{
		
		}
	}

}