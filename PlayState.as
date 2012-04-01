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
			scoreText = new FlxText(20, 20, 1000,"Distance: ");
			scoreText.size = 60;
			super.create();

			FlxG.mouse.load(crosshairSprite, 1, 0, 0);
			Registry.init();
			backgroundPlace();
			add(scoreText);
			add(Registry.player);
			add(Registry.enemies);
			add(Registry.player.gun);
			add(Registry.bullets);
			add(Registry.platforms);
			add(Registry.groundTiles);
			initGround();
			
			Registry.startBar = new FlxSprite(Registry.player.xBounds + 3, FlxG.height - 50, startBarTexture);
			add(Registry.startBar);
		}
		public function playAgainClick():void
		{
			FlxG.score = 0;
			FlxG.resetState();
		}
		public function mainMenuClick():void
		{
			FlxG.score = 0;
			FlxG.switchState(new MainMenuState());
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
			
			//For not debug
			if (FlxG.keys.ENTER) { playAgainClick(); }
			
			//Updating score
			scoreText.text = "Distance: " + (FlxG.score.toString());
			
			//COLLISSION START
			if (FlxG.overlap(Registry.enemies, Registry.player) || FlxG.overlap(Registry.groundTiles,Registry.player))
			{
				FlxG.shake(0.05, 0.5,null, true, 0);
				var emitter:FlxEmitter = createEmitter(splat,100);
				emitter.at(Registry.player);
				Registry.player.exists = false;
				Registry.player.gun.exists = false;
				if(saveHighscore(FlxG.score)){}
				add(new FlxButton(330, 250, "Play Again", playAgainClick));
				add(new FlxButton(330, 300, "Main Menu", mainMenuClick));
			}
			
			FlxG.overlap(Registry.bullets, Registry.enemies, enemyBulletCollision);
			
			
			if(FlxG.overlap(Registry.startBar, Registry.player) || FlxG.overlap(Registry.platforms, Registry.player))
			{
				Registry.player.landed(false);
			}
			else
			{
				Registry.player.landed(true);
			}
			FlxG.overlap(Registry.platforms, Registry.player,corpseCollision)
			//COLLISSION END
			updateBackground();
			updateGround();
			updatePlatforms();

		}
		public function corpseCollision(platformHit:FlxObject,player:FlxObject):void
		{
			
			var platform:CorpsePlatform = CorpsePlatform(platformHit);
			if (platform.type == "corpseBounce")
			{
				Registry.player.landed(true);
			}
			else
			{
				Registry.player.landed(false);
			}
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
		private function backgroundPlace():void
		{
				
				for (var i:int = 0; i <FlxG.width+400; i+=400) 
				{
					var backgroundVar:Background = new Background(i,0);
					add(backgroundVar);
					Registry.background.add(backgroundVar);
				}
			
		}
		private function updateBackground():void
		{
			var backgroundSprite:Background = Background(Registry.background.getFirstAvailable());
			if (backgroundSprite)
			{
				var farRightTile:Background;
				var xPosition:int = 0;
				for (var backgrounds in Registry.background.members)
				{
					if (Registry.background.members[backgrounds].x > xPosition)
					{
						farRightTile = Registry.background.members[backgrounds];
						xPosition = Registry.background.members[backgrounds].x;
					}
				}
				backgroundSprite.x = xPosition + 400;
				backgroundSprite.exists = true;
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
		private function saveHighscore(highscore:Number):Boolean
		{
			HighScore.levels = highscore;
			
			//Hvis highscore er større end 9 af de tidligere 10 highscores - så tilføj
			/////////////////////////////////////////////////////////////////////--- MAKE THIS!!!!
			if (highscore) { };
			
			return true;
		}
	}

}