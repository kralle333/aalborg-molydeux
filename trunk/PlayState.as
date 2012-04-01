package  
{
	import adobe.utils.CustomActions;
	import flash.sampler.NewObjectSample;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	public class PlayState extends FlxState 
	{
		
		//For highscore
		private var scoreText:FlxText;
		
		//Textures
		[Embed(source = 'assets/crosshair.png')]private var crosshairSprite:Class;
		[Embed(source = 'assets/splat.png')]private var splat:Class;
		[Embed(source = 'assets/startBar.png')] private var startBarTexture:Class;
		
		override public function create():void 
		{
			
			scoreText = new FlxText(FlxG.width / 2 - 300, FlxG.height / 2 - 100, 1000,"M: ");
			scoreText.size = 100;
			super.create();
			FlxG.mouse.load(crosshairSprite, 1, 0, 0);
			Registry.init();
			add(Registry.player);
			add(Registry.enemies);
			add(Registry.player.gun);
			add(Registry.bullets);
			add(Registry.platforms);
			add(Registry.groundTiles);
			add(scoreText);
			initGround();
			
			Registry.platforms.add(new FlxSprite(50, FlxG.height - 50, startBarTexture));
		}
		public function playAgainClick():void
		{
			FlxG.score = 0;
			FlxG.resetState();
		}
		public function mainMenuClick():void
		{
			FlxG.switchState(new MainMenuState());
		}
		private function createEmitter(graphic:Class,numberOfParticles:int):FlxEmitter
		{
			var emitter:FlxEmitter = new FlxEmitter();
			emitter.makeParticles(graphic,numberOfParticles, 16, false, 0);
			add(emitter);
			emitter.gravity = 50;	
			emitter.maxParticleSpeed = new FlxPoint(200, 200);
			emitter.start(true, 5);
			emitter.at(Registry.player);
			emitter.bounce;
			return emitter;
		}
		override public function update():void 
		{
			super.update();
			
			//For debug
			if (FlxG.keys.ENTER) { FlxG.switchState(new PlayState()); }
			
			//Updating score
			scoreText.text = "M: " + (FlxG.score.toString());
			
			//COLLISSION START
			if (FlxG.overlap(Registry.enemies, Registry.player) || FlxG.overlap(Registry.groundTiles,Registry.player))
			{
				FlxG.shake(0.05, 0.5,null, true, 0);
				var emitter:FlxEmitter = createEmitter(splat,100);
				emitter.at(Registry.player);
				Registry.player.exists = false;
				Registry.player.gun.exists = false;
				
				add(new FlxButton(330, 250, "Play Again", playAgainClick));
				add(new FlxButton(330, 300, "Main Menu", mainMenuClick));
			}
			
			FlxG.overlap(Registry.bullets, Registry.enemies, enemyBulletCollision);
			
			if (!FlxG.overlap(Registry.platforms, Registry.player))
			{
				Registry.player.landed(true);
			}
			else
			{
				
				Registry.player.landed(false);
			}
			//COLLISSION END
			
			updateGround();
			updatePlatforms();

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
			for (var i:int = 0; i < FlxG.width+50; i += 48)
			{
				var tile:GroundTile = new GroundTile(i,FlxG.height-48);
				Registry.groundTiles.add(tile);
				add(tile);
			}
		}
		private function updateGround():void
		{
			var groundTile:GroundTile = GroundTile(Registry.groundTiles.getFirstAvailable());
			if (groundTile)
			{
				var farRightTile:GroundTile;
				var xPosition:int = 0;
				for (var tile in Registry.groundTiles.members)
				{
					if (Registry.groundTiles.members[tile].x > xPosition)
					{
						farRightTile = Registry.groundTiles.members[tile];
						xPosition = Registry.groundTiles.members[tile].x;
					}
				}
				groundTile.x = xPosition + 48;
				groundTile.exists = true;
			}
		}
		private function updatePlatforms():void
		{
			for (var platform in Registry.platforms)
			{
				if (Registry.platforms.members[platform].added == false )
				{
					add(platform);
				}
			}
		}
	}

}