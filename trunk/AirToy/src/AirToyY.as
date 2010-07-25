import Events.ColisionsEvent;

import collision.CollisionGroup;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Matrix;
import flash.media.Camera;
import flash.media.Video;

import mx.core.UIComponent;

import utils.FaceDetector;
	

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

private var detectionMap:BitmapData;
		private var drawMatrix:Matrix;
		private var scaleFactor:int = 4;
		private var w:int = 640;
		private var h:int = 480;
		private var faceRectContainer :Sprite;
		private var detectionCountCheck:Boolean;
		private var Face:FaceDetector;
		
public function AirToyX():void
{
	setupCamera();
	addEventListener(Event.ENTER_FRAME, goImages);
	Face=new FaceDetector(detectionMap,drawMatrix,faceRectContainer,vid);
	
	
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
		
	detectionCountCheck=Face.cameraReadyHandler(e);
	

	//}
	
}

private  function cols():void
{
		///////////COLISIONES
	collisions = colG.checkCollisions();

	
	var botonaux:String;
	for(var i:uint = 0; i < collisions.length; i++){
		if(detectionCountCheck){
		collisions[0].object1.selected=true;
		}
		botonaux=collisions[0].object1.name;
		if(collisions[0].object1.name=="clicable"){
			collisions[0].object1.over=true;
			
		}
		//He modificado las colisiones a 7 ya que con 15 y el face recognition va muy lento
		if(collisions[0].object1.name!="clicable" && botonaux==nombre && collisions[0].object1.selected){
			 if(colisiones>9){
							
				myBottomClickhandler(new MouseEvent(MouseEvent.CLICK));
				colisiones=0;
				
			}
			
			if(colisiones<=9){
				colisiones++;
				//dispatchEvent(new ColisionsEvent(ColisionsEvent.COLISION));
				
				feedback.control(new ColisionsEvent(ColisionsEvent.COLISION));
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