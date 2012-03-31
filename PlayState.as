package  
{
	import flash.sampler.NewObjectSample;
	import org.flixel.*;
	public class PlayState extends FlxState 
	{
		[Embed(source = 'assets/crosshair.png')]private var crosshairSprite:Class;
		[Embed(source = 'assets/splat.png')]private var splat:Class;
		override public function create():void 
		{
			var scoreNumber:String = "KM: ";
			scoreNumber = scoreNumber + FlxG.score;
			super.create();
			FlxG.mouse.load(crosshairSprite, 1, 0, 0);
			Registry.init();
			add(Registry.player);
			add(Registry.enemies);
			add(Registry.player.gun);
			add(Registry.bullets);
			add(new FlxText(FlxG.width/2-100, FlxG.height/2-100, 1000, scoreNumber));
		}
		public function playAgain():void
		{
			
			
		}
		private function createEmitter(graphic:Class,numberOfParticles:int):FlxEmitter
		{
			var emitter:FlxEmitter = new FlxEmitter();
			emitter.makeParticles(graphic,numberOfParticles, 16, false, 0);
			add(emitter);
			emitter.start(true, 5);
			emitter.at(Registry.player);
			emitter.bounce;
			return emitter;
		}
		override public function update():void 
		{
			super.update();
			var scoreNumber:Number = FlxG.score;
			FlxG.score++;
			trace(FlxG.score);
			if (FlxG.overlap(Registry.enemies, Registry.player))
			{
				FlxG.shake(0.05, 0.5,null, true, 0);
				var emitter:FlxEmitter = createEmitter(splat,100);
				emitter.at(Registry.player);
				Registry.player.exists = false;
				Registry.player.gun.exists = false;
			}
			FlxG.overlap(Registry.bullets, Registry.enemies, enemyBulletCollision);
		}
		
		public function enemyBulletCollision(bulletHit:FlxObject,enemyHit:FlxObject):void
		{
			var enemy:Enemy =  Enemy(enemyHit);
			var bullet:Bullet = Bullet(bulletHit);
			bullet.exists = false;
			enemy.hurt(bullet.damage);
		}
		

		
		
		
	}

}