import comps.feedback;
	
	
private var porcentaje:Number;
private var escalar:int;
public  var colisiones:int=0;
private var nombre:String;
public var count:Array=new Array();
private var prevcolisiones:Array= new Array();


		
public function control():void
{
	escalar=(colisiones*100)/20;
	pbar.setProgress(escalar,100);
		
}
			
public  function cols(detectionCountCheck:Boolean,collisions:Array,fd:Array):void
{
///////////COLISIONES

	var botonaux:String;
	var check:Boolean;
	for(var j:uint=0;j<2;j++)
	{
		check=(fd[j].but==this.but);
		if(fd[j].colisiones>0 && fd[j].colisiones==prevcolisiones[j] && !(check))
		{
			count[j]++;
			
		}else if(fd[j].colisiones!=prevcolisiones[j] && !(check))
		{
			count[j]=-1;
		}
		prevcolisiones[j]=fd[j].colisiones;
	}
	for(var i:uint = 0; i < collisions.length; i++)
	{
		
		botonaux=collisions[0].object1.name;
		
		if(collisions[0].object1==this.but)
		//He modificado las colisiones a 7 ya que con 15 y el face recognition va muy lento
		if(botonaux==nombre && detectionCountCheck)
		{
			if(colisiones>20)
			{
							
				//myBottomClickhandler(new MouseEvent(MouseEvent.CLICK));
				colisiones=0;
			
			}
			
			if(colisiones<=20)
			{
				colisiones++;
				control();
			
				
			}
		
		}
		
	}
	
	if(!collisions.length)
	{
		but.selected=false;
		
		
	}
	
	if(botonaux!=nombre){
			nombre=botonaux;
			
			
	}
	for(j = 0; j < 2; j++)
	{
		check=(fd[j].but==this.but);
		
		if(fd[j].colisiones>0 && count[j]>0 && !(check)){
			fd[j].colisiones--;
			fd[j].control();
		}
	}
	
}
	
