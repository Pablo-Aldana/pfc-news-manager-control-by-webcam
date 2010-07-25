package utils
{
		import flash.display.BitmapData;
		import flash.display.Graphics;
		import flash.display.Sprite;
		import flash.events.Event;
		import flash.geom.Matrix;
		import flash.geom.Rectangle;
		import flash.media.Video;
		import flash.text.TextField;
		
		import jp.maaash.ObjectDetection.ObjectDetector;
		import jp.maaash.ObjectDetection.ObjectDetectorEvent;
		import jp.maaash.ObjectDetection.ObjectDetectorOptions;
		
		import mx.core.UIComponent;
	public class FaceDetector extends UIComponent
	{
			
	//Var for facial recognition
		private var detector:ObjectDetector;
		private var options:ObjectDetectorOptions;
		private var scaleFactor:int = 4;
		private var view :Sprite;
		
		private var tf :TextField;
		private var detectionMap:BitmapData;
		private var drawMatrix:Matrix;
		private var faceRectContainer :Sprite;
		private var vid:Video;
		private var pabloPoyas:Number=0;
		var detect:Boolean=false;
		
		
		private var lastTimer:int = 0;
		
		public function FaceDetector(_detectionMap:BitmapData,_drawMatrix:Matrix,_faceRectContainer:Sprite,_vid:Video)
		{
			faceRectContainer=_faceRectContainer;
			detectionMap=_detectionMap;
			drawMatrix=_drawMatrix;
			vid=_vid;
			
			initDetector();
		}
		
				//begin facial recognition
		public function cameraReadyHandler( event:Event ):Boolean
		{		
			if(pabloPoyas==0)
			{
				
				var detect1:Boolean;
				detectionMap.draw(vid,drawMatrix,null,"normal",null,true);
				detect=detector.detect( detectionMap );
				pabloPoyas=30;
			}else
				pabloPoyas--;
				
				
				
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
			
	}
}