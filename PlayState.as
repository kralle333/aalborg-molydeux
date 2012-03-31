package  
{
	import adobe.utils.CustomActions;
	import flash.sampler.NewObjectSample;
	import org.flixel.*;
	public class PlayState extends FlxState 
	{
		
		//For highscore
		private var kmText:String = "M: ";
		private var maxPoint:Number = 0;
		private var scoreText:FlxText;
		public var cameraView:FlxCamera;
		
		//Textures
		[Embed(source = 'assets/crosshair.png')]private var crosshairSprite:Class;
		[Embed(source = 'assets/splat.png')]private var splat:Class;
		[Embed(source = 'assets/startBar.png')] private var startBarTexture:Class;
		
		override public function create():void 
		{
			
			cameraView = (new FlxCamera(FlxG.width, FlxG.height, 10, 10, 0));
			scoreText = new FlxText(FlxG.width / 2 - 300, FlxG.height / 2 - 100, 1000, kmText + maxPoint.toString());
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
			initGround();
			add(scoreText);
			Registry.platforms.add(new FlxSprite(10, FlxG.height - 50, startBarTexture));
			FlxG.camera.setBounds(Registry.player.x, 0, FlxG.width*5, FlxG.height);
			FlxG.camera.follow(Registry.player);
		}
		public function playAgainClick():void
		{
			FlxG.switchState(new PlayState());
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
			emitter.start(true, 5);
			emitter.at(Registry.player);
			emitter.bounce;
			return emitter;
		}
		override public function update():void 
		{
			super.update();
			cameraView.follow(Registry.player);
			if ((Registry.player.x/1000) > maxPoint)
			{
				maxPoint = Registry.player.x / 1000;
				scoreText.text = kmText + (Registry.player.x/2).toString();
			}
			
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
			updateGround();
			updatePlatforms();
			if (!FlxG.overlap(Registry.platforms, Registry.player))
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
			for (var i:int = 0; i < FlxG.width; i += 48)
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
						farRightTile = tile;
						xPosition = tile.x;
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