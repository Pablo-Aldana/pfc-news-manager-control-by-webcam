import collision.CollisionGroup;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Graphics;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Matrix;
import flash.geom.Rectangle;
import flash.media.Camera;
import flash.media.Video;

import jp.maaash.ObjectDetection.ObjectDetector;
import jp.maaash.ObjectDetection.ObjectDetectorEvent;
import jp.maaash.ObjectDetection.ObjectDetectorOptions;

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
private var collisions:Array;
private var color:uint;
private var outline:Shape;
private var nombre:String;
private var colisiones:int;

//Var for facial recognition
		private var detector:ObjectDetector;
		private var options:ObjectDetectorOptions;
		
		private var view :Sprite;
		private var faceRectContainer :Sprite;
		private var tf :TextField;
		
		
		private var detectionMap:BitmapData;
		private var drawMatrix:Matrix;
		private var scaleFactor:int = 4;
		private var w:int = 640;
		private var h:int = 480;
		
		private var lastTimer:int = 0;
		private var detectionCountCheck:Boolean= false;
	
		
public function AirToyX():void
{
	setupCamera();
	addEventListener(Event.ENTER_FRAME, goImages);
	initDetector();
	
}
		
private function setupCamera():void
{
	vid = new Video(640, 480);
	cam = Camera.getCamera();
	cam.setMode(640, 480, 30);
	vid.attachCamera(cam);
	//vid.addEventListener( Event.RENDER, cameraReadyHandler );
	///////
	matr = new Matrix();
	matr.scale((vid.scaleX/100), (vid.scaleY/100));
	currentCap=new BitmapData(vid.width, vid.height);
	prevCap=new BitmapData(vid.width, vid.height);
	arrayMat=new Array();
	mc=new UIComponent();
	mc.width=vid.width;
	mc.height=vid.height;
	paint = new BitmapData(vid.width, vid.height);
	bm=new Bitmap();
	bm.visible=false;
	bm.bitmapData=currentCap;
	mc.addChild(vid);
	mc.addChild(bm);
	// begin facial recognition
	detectionMap = new BitmapData(w/scaleFactor, h/scaleFactor,false,0 );
	drawMatrix = new Matrix(1/scaleFactor, 0, 0, 1/scaleFactor );
	faceRectContainer = new Sprite;
	mc.addChild(faceRectContainer);
	//end
	hd.addChild(mc);
	
	colG = new CollisionGroup();
	colG.addItem(bm);
	colG.addItem(but);
	colG.addItem(but2);
	colG.addItem(but3);
	colG.addItem(clicable);
	colG.alphaThreshold=.1;
	
}	
//begin facial recognition
private function cameraReadyHandler( event:Event ):Boolean
{		
		var detect:Boolean;
		detectionMap.draw(vid,drawMatrix,null,"normal",null,true);
		detect=detector.detect( detectionMap );
		
	return(detect);
		
		
}	
private function initDetector():void
{
		detector = new ObjectDetector();
			
		var options:ObjectDetectorOptions = new ObjectDetectorOptions();
		options.min_size  = 30;
		detector.options = options;
		detector.addEventListener(ObjectDetectorEvent.DETECTION_COMPLETE, detectionHandler );
}
private function detectionHandler( e :ObjectDetectorEvent ):void
{			
			
			var g :Graphics = faceRectContainer.graphics;
			g.clear();
			if( e.rects ){
				g.lineStyle( 2 );	// black 2pix
				e.rects.forEach( function( r :Rectangle, idx :int, arr :Array ) :void {
					g.drawRect( r.x * scaleFactor, r.y * scaleFactor, r.width * scaleFactor, r.height * scaleFactor );
				});
			
			}
			

			
}
//end facial recognition		
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
	cols();

	//if(!detectionCountCheck){
		
	detectionCountCheck=cameraReadyHandler(e);
	
	
	//}
	
}

private  function cols():void
{
		///////////COLISIONES
	collisions = colG.checkCollisions();

	
	var botonaux:String;
	for(var i:uint = 0; i < collisions.length; i++){
		collisions[0].object1.selected=true;
		botonaux=collisions[0].object1.name;
		if(collisions[0].object1.name=="clicable"){
			collisions[0].object1.over=true;
		}
		//He modificado las colisiones a 7 ya que con 15 y el face recognition va muy lento
		if(collisions[0].object1.name!="clicable" && botonaux==nombre){
			 if(colisiones>9){
							
				myBottomClickhandler(new MouseEvent(MouseEvent.CLICK));
				colisiones=0;
			}
			
			if(colisiones<=9){
				colisiones++;
				trace(colisiones);
			}
		
		}


	}
	if(!collisions.length)
	{
		but.selected=false;
		but2.selected=false;
		but3.selected=false;
		
	}
	if(botonaux!=nombre){
			nombre=botonaux;
			colisiones=0;
	}
}


private function myBottomClickhandler(evento:MouseEvent):void{
	import mx.controls.*;
	
		Alert.show("Hello, world!");
}