package utils
{
	import collision.CollisionGroup;
	

	import comps.feed;
	import comps.feedback;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.media.Camera;
	import flash.media.Video;
	
	import mx.containers.Canvas;
	import mx.core.UIComponent;

	public class SetupCamera
	{
		private var colG:CollisionGroup;
		private var vid:Video;
		private var cam:Camera;
		private var matr:Matrix;
		private var currentCap:BitmapData;
		private var prevCap:BitmapData;
		private var paint:BitmapData;
		private var mc:UIComponent;
		private var bm:Bitmap;
		private var detectionMap:BitmapData;
		private var drawMatrix:Matrix;
		private var scaleFactor:int = 4;
		private var w:int = 640;
		private var h:int = 480;
		private var faceRectContainer :Sprite;
		private var faceDetect:FaceDetector;
		private var arrayMat:Array;
		
		//public function SetupCamera(canvasPrincipal:Canvas,but:Button,but2:Button,but3:Button)
		public function SetupCamera(canvasPrincipal:Canvas,arrayfd:Array)
		{
			vid = new Video(640, 480);
			cam = Camera.getCamera();
			cam.setMode(640, 480, 30);
			vid.attachCamera(cam);
		//vid.addEventListener( Event.RENDER, cameraReadyHandler );
			
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
			canvasPrincipal.addChild(mc);
			
			faceDetect=new FaceDetector(detectionMap,drawMatrix,faceRectContainer,vid);
			colG = new CollisionGroup();
			colG.addItem(bm);
			for(var i:uint=0;i<2;i++)
			{
			 colG.addItem(arrayfd[i].but);
			}
			//colG.addItem(but3);
			colG.alphaThreshold=.1;
	

		}
		public function getColG():CollisionGroup
		{
			return this.colG;
		}
		
		public function setColG(_colG:CollisionGroup):void
		{
			 this.colG=_colG;
		}
		
		public function getVid():Video
		{
			return this.vid;
		}
		
		public function setVid(_vid:Video):void
		{
			 this.vid=_vid;
		}
		
		public function getCurrentCap():BitmapData
		{
			return this.currentCap;
		}
		
		public function setCurrentCap(_currentCap:BitmapData):void
		{
			 this.currentCap=_currentCap;
		}
		
		public function getPrevCap():BitmapData
		{
			return this.prevCap;
		}
		
		public function setPrevCap(_prevCap:BitmapData):void
		{
			 this.prevCap=_prevCap;
		}
		
		public function getPaint():BitmapData
		{
			return this.paint;
		}
		
		public function setPaint(_paint:BitmapData):void
		{
			this.paint=_paint;
		}
		
		public function getBm():Bitmap
		{
			return this.bm;
		}
		
		public function setBm(_bm:Bitmap):void
		{
			this.bm=_bm;
		}
		
		public function getFaceDetect():FaceDetector
		{
			return this.faceDetect;
		}
		
		public function setFaceDetect(_faceDetect:FaceDetector):void
		{
			this.faceDetect=_faceDetect;
		}
		
		public function getArrayMat():Array
		{
			return this.arrayMat;
		}
		
		public function setArrayMat(_arrayMap:Array):void
		{
			this.arrayMat=_arrayMap;
		}
	
	}
}