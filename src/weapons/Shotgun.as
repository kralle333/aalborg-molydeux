package weapons 
{
	public class Shotgun extends Weapon
	{
		[Embed(source='../../assets/weapons/shotgun.png')]
		private var texture:Class;
		public function Shotgun() 
		{
			super(texture);
		}
		
	}

}