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
			var Crosshair: Class;
			Crosshair = crosshairSprite;
			FlxG.mouse.load(Crosshair, 1, 0, 0);
			super.create();
			Registry.init();
			add(Registry.player);
			add(Registry.enemies);
			
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
			if (FlxG.overlap(Registry.enemies, Registry.player, null))
			{
				FlxG.shake(0.05, 0.5,null, true, 0);
				var emitter:FlxEmitter = createEmitter(splat,20);
				emitter.at(Registry.player);
				
				Registry.player.exists = false;
			}
		}
		

		
		
		
	}

}