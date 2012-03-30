package  
{
	import flash.sampler.NewObjectSample;
	import org.flixel.*;
	public class PlayState extends FlxState 
	{
		[Embed(source = 'assets/crosshair.png')]private var crosshairSprite:Class;
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
		override public function update():void 
		{
			super.update();
			if (FlxG.overlap(Registry.enemies, Registry.player, null))
			{
				
				FlxG.shake(0.05, 0.5, null, true,0);
				
				
			}
		}
		

		
		
		
	}

}