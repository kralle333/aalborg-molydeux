package  
{
	import adobe.utils.CustomActions;
	import flash.sampler.NewObjectSample;
	import org.flixel.*;
	public class PlayState extends FlxState 
	{
		var scoreText:FlxText;
		var kmText:String = "M: ";
		var maxPoint:Number = 0;	
		[Embed(source = 'assets/crosshair.png')]private var crosshairSprite:Class;
		[Embed(source = 'assets/splat.png')]private var splat:Class;
		private var groundTiles:FlxGroup = new FlxGroup();
		override public function create():void 
		{
			
			scoreText = new FlxText(FlxG.width/2-100, FlxG.height/2-100, 1000, kmText+maxPoint.toString());
			super.create();
			FlxG.mouse.load(crosshairSprite, 1, 0, 0);
			Registry.init();
			add(Registry.player);
			add(Registry.enemies);
			add(Registry.player.gun);
			add(Registry.bullets);
			initGround();
			add(scoreText);
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
			if ((Registry.player.x/1000) > maxPoint)
			{
				maxPoint = Registry.player.x / 1000;
				scoreText.text = kmText + (Registry.player.x/2).toString();
			}
			
			if (FlxG.overlap(Registry.enemies, Registry.player))
			{
				FlxG.shake(0.05, 0.5,null, true, 0);
				var emitter:FlxEmitter = createEmitter(splat,100);
				emitter.at(Registry.player);
				Registry.player.exists = false;
				Registry.player.gun.exists = false;
			}
			FlxG.overlap(Registry.bullets, Registry.enemies, enemyBulletCollision);
			updateGround();
		}
		
		public function enemyBulletCollision(bulletHit:FlxObject,enemyHit:FlxObject):void
		{
			var enemy:Enemy =  Enemy(enemyHit);
			var bullet:Bullet = Bullet(bulletHit);
			bullet.exists = false;
			enemy.hurt(bullet.damage);
		}
		private function initGround():void
		{
			for (var i:int = 0; i < FlxG.width; i += 48)
			{
				var tile:GroundTile = new GroundTile(i,FlxG.height-48);
				groundTiles.add(tile);
				add(tile);
			}
		}
		private function updateGround():void
		{
			var groundTile:Enemy = Enemy(groundTiles.getFirstAvailable());
			if (groundTile)
			{
				var farRightTile:GroundTile;
				var xPosition:int = 0;
				for (var tile in groundTiles.members)
				{
					if (groundTiles.members[tile].x > xPosition)
					{
						farRightTile = tile;
						xPosition = tile.x;
					}
				}
				groundTile.x = xPosition + 48;
				groundTile.exists = true;
			}
		}
		
	}

}