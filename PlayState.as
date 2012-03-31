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
			super.create();
			FlxG.mouse.load(crosshairSprite, 1, 0, 0);
			Registry.init();
			add(Registry.player);
			add(Registry.enemies);
			add(Registry.player.gun);
			add(Registry.bullets);
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
			if (FlxG.overlap(Registry.enemies, Registry.player))
			{
				FlxG.shake(0.05, 0.5,null, true, 0);
				var emitter:FlxEmitter = createEmitter(splat,100);
				emitter.at(Registry.player);
				FlxG.
				Registry.player.exists = false;
				Registry.player.gun.exists = false;
			}
			FlxG.overlap(Registry.bullets, Registry.enemies, enemyBulletCollision);
		}
		
		public function enemyBulletCollision(bulletHit:FlxObject,enemyHit:FlxObject):void
		{
			var enemy:Enemy =  Enemy(enemyHit);
			var bullet:Bullet = Bullet(bulletHit);
			enemy.hurt(bullet.damage);
		}
		

		
		
		
	}

}