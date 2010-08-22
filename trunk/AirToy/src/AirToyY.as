import comps.feedback;

import flash.display.BitmapData;
import flash.events.Event;
import flash.events.MouseEvent;

import utils.SetupCamera;
	

[SWF(width="640", height="480", frameRate="30", backgroundColor="#FFFFFF")]




private var auxCap:BitmapData;
private var lon:Number;
private var collisions:Array;
private var nombre:String;

private var camera:SetupCamera;
private var detectionCountCheck:Boolean;
private var arrayFeedback:Array=new Array(2);;

//private var fd:feed;	
public function AirToyX():void
{
/*	fd=new feed("but");
	fd.x=300;
	fd.y=10;
	this.addChild(fd);*/
	
		arrayFeedback[0]=feedback;
		arrayFeedback[1]=feedback2;
		
	
	
	camera= new SetupCamera(canvasPrincipal,arrayFeedback);
	addEventListener(Event.ENTER_FRAME, goImages);
	
	
	
}
	/*	
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
	
}	*/
	
private function goImages(e:Event):void
{
		
	camera.getCurrentCap().draw(camera.getVid());
	auxCap = camera.getCurrentCap().clone();
	auxCap.draw(camera.getPrevCap(), null, null, "difference");
	auxCap.threshold(auxCap, auxCap.rect, auxCap.rect.topLeft, ">", 0xFF555555, 0xFFFF0000, 0x00FFFFFF, false);
	camera.getArrayMat().push(auxCap);
	if(camera.getArrayMat().length >8)
	{
		camera.getArrayMat().shift().dispose();
	}
	lon=camera.getArrayMat().length;
	var cada:Number=255/lon;
	var g:Number;
	camera.setPrevCap(camera.getCurrentCap().clone());
	
	camera.getPaint().fillRect(camera.getPaint().rect, 0x00FF0000);
	

			
	for(var i:Number=0; i<lon; i++)
	{
		g=cada*i;
		camera.getPaint().threshold(camera.getArrayMat()[i], camera.getPaint().rect, camera.getPaint().rect.topLeft, "==",  0xFFFF0000, (255<<24 | 0<<16 |g<<16 | 0), 0x00FFFFFF, false);
	}
	
	
	camera.getBm().bitmapData=camera.getPaint();
	
	detectionCountCheck=camera.getFaceDetect().cameraReadyHandler(e);
	for(var j:uint=0;j<2;j++)
	{
		arrayFeedback[j].cols(detectionCountCheck,(camera.getColG().checkCollisions()),arrayFeedback);
	}

	
	
		
}





private function myBottomClickhandler(evento:MouseEvent):void{
	import mx.controls.*;
	
		Alert.show("Hello, world!");
}