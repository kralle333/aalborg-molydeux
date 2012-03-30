package  
{
	import flash.sampler.NewObjectSample;
	import org.flixel.*;
	public class PlayState extends FlxState 
	{
		override public function create():void 
		{
			super.create();
			Registry.init();
			add(Registry.player);
			add(Registry.enemies);
		}
		override public function update():void 
		{
			super.update();
			if (FlxG.overlap(Registry.enemies, Registry.player))
			{
				
			}
		}		
	}

}