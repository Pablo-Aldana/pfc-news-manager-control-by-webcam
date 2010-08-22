package comps
{
	import mx.controls.Button;
	import mx.controls.ProgressBar;
	import Events.ColisionsEvent;
	import utils.SetupCamera;
	
	public class feed
	{
		private var but:Button;
		private var pbar:ProgressBar
		[Bindable]private var porcentaje:Number;
		[Bindable]private var escalar:int;
		private static var colisiones:int;
		private var nombre:String;
		private var discount:int=60;
		
		public function feed(name:String)
		{
			but=new Button();
			pbar= new ProgressBar();
			but.label=name;
			but.id=name;
			but.x=0;
			but.y=0;
			but.width=154;
			but.height=87;
			but.alpha=0.76;
			pbar.id=name;
			pbar.x=0;
			pbar.y=0;
			pbar.width=154;
			pbar.height=87;
			pbar.mode="manual";
			pbar.labelPlacement="center";
	
		}
					
		public function control():void
		{
			escalar=(colisiones*100)/30;
			pbar.setProgress(escalar, 100);
			//trace(escalar);
		}
					
		public  function cols(_colisiones:int,detectionCountCheck:Boolean,collisions:Array):void
		{
		///////////COLISIONES
			//trace(colisiones);
			//colisiones=_colisiones;
			var botonaux:String;
			for(var i:uint = 0; i < collisions.length; i++)
			{
				/*if(detectionCountCheck){
				collisions[0].object1.but.selected=true;
				}*/
				botonaux=collisions[0].object1.name;
				
				/*if(collisions[0].object1.name=="clicable"){
					collisions[0].object1.over=true;
					
				}*/
				//He modificado las colisiones a 7 ya que con 15 y el face recognition va muy lento
				if(botonaux==nombre && detectionCountCheck)
				{
					if(colisiones>30)
					{
									
						//myBottomClickhandler(new MouseEvent(MouseEvent.CLICK));
						colisiones=0;
					
					}
					
					if(colisiones<=30)
					{
						colisiones++;
						//dispatchEvent(new ColisionsEvent(ColisionsEvent.COLISION));
						trace(botonaux+" "+colisiones);
						
						control();
					}
				
				}
			}
			
			/*if(colisiones>0)
			{
					colisiones--;
					control();
			}*/
			if(!collisions.length)
			{
				but.selected=false;
				
			}
			if(botonaux!=nombre){
					nombre=botonaux;
					colisiones=0;
					
			}
			/*if(botonaux==nombre && colisiones>0)
			{
				colisiones--;
				control();
			}*/
			_colisiones++;
		}
	


	}
}