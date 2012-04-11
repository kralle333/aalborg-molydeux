package states
{
	import adobe.utils.CustomActions;
	import flash.sampler.NewObjectSample;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	import org.flixel.plugin.photonstorm.API.FlxKongregate;
	import gameclasses.*;
	import enemies.*;
	import weapons.MachineGun;
	import weapons.Pistol;
	import weapons.Shotgun;
	import weapons.SubMachineGun;
	
	public class PlayState extends FlxState
	{
		
		//For highscore
		private var scoreText:FlxText;
		private var killsText:FlxText;
		private var kills:int = 0;
		private var previousScore:int = 0;
		private var money:int
		
		private var moneyText:FlxText;
		private var musicOffButton:FlxButton;
		private var musicOnButton:FlxButton;
		//Textures
		[Embed(source='../../assets/gametextures/crosshair.png')]
		private var crosshairSprite:Class;
		[Embed(source='../../assets/gametextures/splat.png')]
		private var splat:Class;
		[Embed(source='../../assets/gametextures/startBar.png')]
		private var startBarTexture:Class;
		
		override public function create():void
		{
			FlxKongregate.init(apiHasLoaded);
			musicOffButton = new FlxButton(700, 10, "Music Off", musicOff);
			super.create();
			FlxG.mouse.load(crosshairSprite, 1, 0,0);
			Registry.init();
			backgroundPlace();
			add(Registry.player);
			add(Registry.enemiesGroup);
			Registry.player.currentWeapon = new Pistol();
			Registry.player.currentWeapon.origin = new FlxPoint(4, 4);
			add(Registry.player.currentWeapon);
			add(Registry.bullets);
			add(Registry.platforms);
			add(Registry.groundTiles);
			add(musicOffButton);
			initGround();
			scoreText = new FlxText(5, 50, 1000, "Distance: ");
			scoreText.size = 20;
			scoreText.color = 0xFF0000FF;
			add(scoreText);
			killsText = new FlxText(5, 75, 1000, "Kills: ");
			killsText.size = 20;
			killsText.color = 0xFF00FFFF;
			add(killsText);
			moneyText = new FlxText(5, 100, 1000, "Money: 0 g");
			moneyText.size = 20;
			moneyText.color = 0xFFFF00FF;
			add(moneyText);
			Registry.startBar = new FlxSprite(Registry.player.xBounds - 8, FlxG.height - 50, startBarTexture);
			add(Registry.startBar);
		}
		
		//KONGREGATE!!
		
		//End Kongregate
		public function playAgainClick():void
		{
			FlxG.score = 0;
			FlxG.resetState();
		}
		
		private function apiHasLoaded():void
		{
			FlxKongregate.connect();
		
		}
		
		public function mainMenuClick():void
		{
			FlxG.score = 0;
			FlxG.music.stop();
			FlxG.switchState(new MainMenuState());
		}
		
		private function createEmitter(graphic:Class, numberOfParticles:int):FlxEmitter
		{
			var emitter:FlxEmitter = new FlxEmitter();
			emitter.makeParticles(graphic, numberOfParticles, 16, false, 0);
			add(emitter);
			emitter.start(true, 5);
			emitter.at(Registry.player);
			emitter.bounce;
			return emitter;
		}
		
		override public function update():void
		{
			super.update();
			if (FlxG.keys.ENTER)
			{
				playAgainClick();
			}
			//Updating score
			scoreText.text = "Distance: " + (FlxG.score.toString());
			if (previousScore != FlxG.score)
			{
				money += (FlxG.score - previousScore) / Math.PI;
				previousScore = FlxG.score;
			}
			moneyText.text = "Money :" + money + " g";
			
			//Select Weapon begin
			if (FlxG.keys.ONE && Registry.player.currentWeapon.type != "Pistol" && Registry.player.ownsGun("Pistol"))
			{
				remove(Registry.player.currentWeapon);
				Registry.player.currentWeapon = new Pistol();
				Registry.player.currentWeapon.origin = new FlxPoint(4, 4);
				add(Registry.player.currentWeapon);
			}
			else if (FlxG.keys.TWO && Registry.player.currentWeapon.type != "SubMachineGun")
			{
				if (!Registry.player.ownsGun("SubMachineGun"))
				{
					if (money >= 5000)
					{
						Registry.player.giveGun("SubMachineGun");
						money -= 5000;
					}
				}
				if (Registry.player.ownsGun("SubMachineGun"))
				{
					remove(Registry.player.currentWeapon);
					Registry.player.currentWeapon = new SubMachineGun();
					Registry.player.currentWeapon.origin = new FlxPoint(4, 4);
					add(Registry.player.currentWeapon);
				}
			}
			else if (FlxG.keys.THREE && Registry.player.currentWeapon.type != "Shotgun")
			{
				if (!Registry.player.ownsGun("Shotgun"))
				{
					if (money >= 10000)
					{
						Registry.player.giveGun("Shotgun");
						money -= 10000;
					}
				}
				if (Registry.player.ownsGun("Shotgun"))
				{
					remove(Registry.player.currentWeapon);
					Registry.player.currentWeapon = new Shotgun();
					Registry.player.currentWeapon.origin = new FlxPoint(4, 4);
					add(Registry.player.currentWeapon);
				}
			}
			else if (FlxG.keys.FOUR && Registry.player.currentWeapon.type != "MachineGun")
			{
				if (!Registry.player.ownsGun("MachineGun"))
				{
					if (money >= 15000)
					{
						Registry.player.giveGun("MachineGun");
						money -= 15000;
					}
				}
				if (Registry.player.ownsGun("MachineGun"))
				{
					remove(Registry.player.currentWeapon);
					Registry.player.currentWeapon = new MachineGun();
					Registry.player.currentWeapon.origin = new FlxPoint(4, 4);
					add(Registry.player.currentWeapon);
				}
			}
			//Select Weapon end
			
			//COLLISSION START
			FlxG.overlap(Registry.enemiesGroup, Registry.player, enemyPlayerCollision);
			if (FlxG.overlap(Registry.groundTiles, Registry.player))
			{
				killPlayer();
			}
			
			FlxG.overlap(Registry.bullets, Registry.enemiesGroup, enemyBulletCollision);
			
			FlxG.overlap(Registry.platforms, Registry.player, corpseCollision)
			if (FlxG.overlap(Registry.startBar, Registry.player) || FlxG.overlap(Registry.platforms, Registry.player))
			{
				Registry.player.isLanded = true;
				Registry.player.jumping = false;
				Registry.player.falling = false;
			}
			else
			{
				Registry.player.falling = true;
			}
			
			//COLLISSION END
			updateBackground();
			updateGround();
			updatePlatforms();
		
		}
		private function killPlayer():void
		{
			FlxG.shake(0.05, 0.5, null, true, 0);
			var emitter:FlxEmitter = createEmitter(splat, 100);
			emitter.at(Registry.player);
			Registry.player.exists = false;
			Registry.player.currentWeapon.exists = false;
			saveHighscore(FlxG.score);
			add(new FlxButton(330, 250, "Play Again", playAgainClick));
			add(new FlxButton(330, 300, "Main Menu", mainMenuClick));
		}
		public function enemyPlayerCollision(enemy:FlxObject, player:FlxObject):void
		{
			if (!Enemy(enemy).isDead)
			{
				killPlayer();
			}
		}
		public function corpseCollision(platformHit:FlxObject, player:FlxObject):void
		{
			
			var platform:CorpsePlatform = CorpsePlatform(platformHit);
			if (platform.type == "corpseBounce")
			{
				Registry.player.isBouncing = true;
			}
		}
		
		public function enemyBulletCollision(bulletHit:FlxObject, enemyHit:FlxObject):void
		{
			var enemy:Enemy = Enemy(enemyHit);
			var bullet:Bullet = Bullet(bulletHit);
			bullet.exists = false;
			enemy.hurt(bullet.damage);
			if (enemy.isDead)
			{
				kills++;
				killsText.text = "Kills: " + kills;
				money += (enemy.type * enemy.strength) * 10;
			}
		}
		
		private function initGround():void
		{
			for (var i:int = 0; i < FlxG.width + 50; i += 48)
			{
				var tile:GroundTile = new GroundTile(i, FlxG.height - 48);
				Registry.groundTiles.add(tile);
				add(tile);
			}
		}
		
		private function backgroundPlace():void
		{
			
			for (var i:int = 0; i < FlxG.width + 400; i += 400)
			{
				var backgroundVar:Background = new Background(i, 0);
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
				for (var backgrounds:String in Registry.background.members)
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
				for (var tile:String in Registry.groundTiles.members)
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
				if (Registry.platforms.members[platform].added == false)
				{
					add(platform);
				}
			}
		}
		
		private function saveHighscore(highscore:int):void
		{
			if (highscore > 0)
			{
				HighScoreState.onSave(highscore);
				FlxKongregate.submitStats("Highscore", highscore);
			}
		}
		
		private function musicOff():void
		{
			if (FlxG.music.volume == 0)
			{
				musicOffButton.label.text = "Music Off";
				FlxG.music.volume = 1;
			}
			else
			{
				musicOffButton.label.text = "Music On";
				FlxG.music.volume = 0;
			}
		}
		
		private function connect():void
		{
			FlxKongregate.connect();
		}
		
		override public function destroy():void
		{
			FlxKongregate.disconnect();
			super.destroy();
		}
	
	}

}