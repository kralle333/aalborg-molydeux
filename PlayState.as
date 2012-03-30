package  
{
	import flash.sampler.NewObjectSample;
	import org.flixel.*;
	public class PlayState extends FlxState 
	{
		
		
		override public function create():void 
		{
			
			super.create();
		}
		
		
		override public function update():void 
		{
			
			super.update();
			while(x)
			{
				var y = FlxG.mouse.screenX;
				var x = FlxG.mouse.screenY;
				add(new FlxButton(x, y, "Something", null));
				
				
			}
			
			
		}
		
	}

}