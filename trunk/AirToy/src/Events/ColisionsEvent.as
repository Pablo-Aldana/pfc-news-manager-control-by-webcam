package Events
{
	import flash.events.Event; 
	
	public class ColisionsEvent extends Event 
	{
		public static const COLISION:String = "colision";
		
		public function ColisionsEvent(type:String)
		{
			super(type);
		}

	}
}


