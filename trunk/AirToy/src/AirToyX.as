import collision.CollisionGroup;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Shape;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Matrix;
import flash.media.Camera;
import flash.media.Video;

import mx.core.UIComponent;


[SWF(width="640", height="480", frameRate="30", backgroundColor="#FFFFFF")]

private var colG:CollisionGroup;
private var vid:Video;
private var cam:Camera;
private var bmd:BitmapData;
private var arrayMat:Array;
private var matr:Matrix;
private var currentCap:BitmapData;
private var prevCap:BitmapData;
private var auxCap:BitmapData;
private var lon:Number;
private var paint:BitmapData;
private var mc:UIComponent;
private var bm:Bitmap;
private var bm2:Bitmap;
//private var but:Button=new Button();
private var collisions:Array;
private var color:uint;
private var outline:Shape;
//static var boton:Object=new Object();
private var nombre:String;
private var colisiones:int;
	
public function AirToyX():void
{
	setupCamera();
	
	
	//outline=new Shape();
	//this.rawChildren.addChild(outline);
	addEventListener(Event.ENTER_FRAME, goImages);
	//addEventListener(Event.ENTER_FRAME, getOrange);
//	this.addEventListener(MouseEvent.CLICK, click);
	
}
		
private function setupCamera():void
{
	vid = new Video(640, 480);
	cam = Camera.getCamera();
	cam.setMode(640, 480, 30);
	vid.attachCamera(cam);
	///////
	matr = new Matrix();
	matr.scale((vid.scaleX/100), (vid.scaleY/100));
	currentCap=new BitmapData(vid.width, vid.height);
	prevCap=new BitmapData(vid.width, vid.height);
	arrayMat=new Array();
	//mc.x=vid.width;
	//mc.y=vid.y;
	mc=new UIComponent();
	mc.width=vid.width;
	mc.height=vid.height;
	//mc.addChild(vid);
	paint = new BitmapData(vid.width, vid.height);
	bm=new Bitmap();
	bm.bitmapData=currentCap;
	mc.addChild(vid);
	mc.addChild(bm);
	//mc.rotationY=180;
	//mc.x=640;
	//mc.swapChildren(bm,vid);
	hd.addChild(mc);
	
	colG = new CollisionGroup();
	colG.addItem(bm);
	colG.addItem(but);
	colG.addItem(but2);
	colG.addItem(but3);
	colG.addItem(clicable);
	colG.alphaThreshold=.1;
}	
		
/*public function snap():void
{
	currentCap.draw(vid);
}
*/
/*private function click(e:Event):void
{
	currentCap.draw(vid);
	color=currentCap.getPixel(this.mouseX, this.mouseY);
	//trace(color);
	//trace(color.toString(16));
	
	
}*/


			
private function goImages(e:Event):void
{
	currentCap.draw(vid);
	auxCap = currentCap.clone();
	auxCap.draw(prevCap, null, null, "difference");
	auxCap.threshold(auxCap, auxCap.rect, auxCap.rect.topLeft, ">", 0xFF555555, 0xFFFF0000, 0x00FFFFFF, false);
	arrayMat.push(auxCap);
	if(arrayMat.length >8)
	{
		arrayMat.shift().dispose();
	}
	lon=arrayMat.length;
	var cada:Number=255/lon;
	var g:Number;
	prevCap=currentCap.clone();
	
	paint.fillRect(paint.rect, 0x00FF0000);
	

			
	for(var i:Number=0; i<lon; i++)
	{
		g=cada*i;
		paint.threshold(arrayMat[i], paint.rect, paint.rect.topLeft, "==",  0xFFFF0000, (255<<24 | 0<<16 |g<<16 | 0), 0x00FFFFFF, false);
	}
	bm.bitmapData=paint;
	cols()
	
}

private  function cols():void
{
		///////////COLISIONES
	collisions = colG.checkCollisions();
	//trace(collisions.length);
	
	var botonaux:String;
	for(var i:uint = 0; i < collisions.length; i++){
		collisions[0].object1.selected=true;
		botonaux=collisions[0].object1.name;
		if(collisions[0].object1.name=="clicable"){
			collisions[0].object1.over=true;
			 
			//alert();
			
			
			
			//(Button(collisions[0].object1)).label
			
		}
		
		if(collisions[0].object1.name!="clicable" && botonaux==nombre){
			//trace(nombre);
			//trace(colisiones);
			 if(colisiones>15){
					
			myBottomClickhandler(new MouseEvent(MouseEvent.CLICK));
			colisiones=0;
			}
			if(colisiones<=15){
			colisiones++;
			}
		
		}


	}
	if(!collisions.length)
	{
		but.selected=false;
		but2.selected=false;
		but3.selected=false;
		//obj.colision=0;
	}
if(botonaux!=nombre){
		nombre=botonaux;
		colisiones=0;
}
}
private function alert():void{
	import mx.controls.*;
	Alert.show("Hello, world!");
}	

private function myBottomClickhandler(evento:MouseEvent):void{
	trace("Boton pulsado!!");
		import mx.controls.*;
	Alert.show("Hello, world!");
}