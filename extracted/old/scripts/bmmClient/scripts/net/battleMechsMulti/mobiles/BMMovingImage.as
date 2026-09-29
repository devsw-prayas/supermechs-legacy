package net.battleMechsMulti.mobiles
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   import net.tacticsoft.utils.DetectedSettings;
   
   public class BMMovingImage extends MovieClip
   {
      
      private var movingImageBM:Bitmap;
      
      private var movingImageBMD:BitmapData;
      
      private var movingImageMC:Sprite;
      
      public var holderMC:MovieClip;
      
      private var sizeIncreaseCounter:Number;
      
      private var sizeDecreaseCounter:Number;
      
      private var delayBeforeMotionCounter:Number;
      
      private var motionCounter:Number;
      
      private var setForDeletionFunction:Function;
      
      private var returnFunction:Function;
      
      private var originWidth:Number;
      
      private var originHeight:Number;
      
      private var originXPos:Number;
      
      private var originYPos:Number;
      
      private var targetXPos:Number;
      
      private var targetYPos:Number;
      
      private var popupOnly:Boolean = false;
      
      public var movingImageID:Number;
      
      public var motionAllowed:Boolean = false;
      
      private var sizeIncreaseFrames:Number;
      
      private var sizeDecreaseFrames:Number;
      
      private var delayBeforeMotionFrames:Number;
      
      private var motionFrames:Number;
      
      private const SIZE_INCREASE_FRAMES:Number = 12;
      
      private const SIZE_DECREASE_FRAMES:Number = 3;
      
      private const DELAY_BEFORE_MOTION_FRAMES:Number = 10;
      
      private const MOTION_FRAMES:Number = 10;
      
      private const SIZE_INCREASE_MAX:Number = 1.2;
      
      public function BMMovingImage()
      {
         super();
      }
      
      public function initialize(param1:Number, param2:DisplayObject, param3:Number, param4:Number, param5:MovieClip, param6:Function, param7:Function, param8:Number, param9:Number, param10:Number, param11:Number, param12:Boolean) : void
      {
         var _loc13_:GlowFilter = null;
         var _loc14_:GlowFilter = null;
         this.movingImageID = param1;
         this.setForDeletionFunction = param6;
         this.returnFunction = param7;
         this.holderMC = param5;
         this.movingImageBMD = new BitmapData(param2.width / param2.scaleX,param2.height / param2.scaleY,false,0);
         this.movingImageBM = new Bitmap(this.movingImageBMD,"auto",true);
         this.movingImageBMD.draw(param2);
         this.movingImageBM.smoothing = true;
         this.originWidth = param2.width;
         this.originHeight = param2.height;
         this.targetXPos = param2.x + this.originWidth / 2;
         this.targetYPos = param2.y + this.originHeight / 2;
         this.movingImageBM.x = -this.originWidth / 2 / param2.scaleX;
         this.movingImageBM.y = -this.originHeight / 2 / param2.scaleY;
         this.movingImageMC = new Sprite();
         this.movingImageMC.addChild(this.movingImageBM);
         this.originXPos = param3;
         this.originYPos = param4;
         if(Math.ceil(this.originXPos) == Math.ceil(param2.x + param2.width / 2) && Math.ceil(this.originYPos) == Math.ceil(param2.y + param2.height / 2))
         {
            this.popupOnly = true;
         }
         this.sizeIncreaseFrames = this.SIZE_INCREASE_FRAMES;
         this.sizeDecreaseFrames = this.SIZE_DECREASE_FRAMES;
         this.delayBeforeMotionFrames = this.DELAY_BEFORE_MOTION_FRAMES;
         this.motionFrames = this.MOTION_FRAMES;
         if(param8 > 0)
         {
            this.sizeIncreaseFrames = param8;
         }
         if(param9 > 0)
         {
            this.sizeDecreaseFrames = param9;
         }
         if(param10 > 0)
         {
            this.delayBeforeMotionFrames = param10;
         }
         if(param11 > 0)
         {
            this.motionFrames = param11;
         }
         this.movingImageMC.x = this.originXPos;
         this.movingImageMC.y = this.originYPos;
         if(param12 && !DetectedSettings.isMobile)
         {
            _loc13_ = new GlowFilter(16763904,1,10,10,2.5,1,false,false);
            _loc14_ = new GlowFilter(16750848,1,10,10,2,1,false,false);
            this.movingImageMC.filters = [_loc13_,_loc14_];
         }
         this.movingImageMC.width = 0;
         this.movingImageMC.height = 0;
         if(false)
         {
            this.movingImageMC["cacheAsBitmapMatrix"] = new Matrix();
            this.movingImageMC.cacheAsBitmap = true;
         }
         addChild(this.movingImageMC);
         this.holderMC.addChild(this);
         this.sizeIncreaseCounter = 0;
         this.sizeDecreaseCounter = 0;
         this.delayBeforeMotionCounter = 0;
         this.motionCounter = 0;
      }
      
      public function runFrame(param1:uint) : void
      {
         var _loc2_:Number = NaN;
         if(this.sizeIncreaseCounter < this.sizeIncreaseFrames)
         {
            _loc2_ = this.SIZE_INCREASE_MAX * this.sizeIncreaseCounter / this.sizeIncreaseFrames;
            this.movingImageMC.width = this.originWidth * _loc2_;
            this.movingImageMC.height = this.originHeight * _loc2_;
            ++this.sizeIncreaseCounter;
         }
         else if(this.sizeDecreaseCounter < this.sizeDecreaseFrames)
         {
            _loc2_ = 1 + (this.sizeDecreaseFrames - this.sizeDecreaseCounter) / this.sizeDecreaseFrames * (this.SIZE_INCREASE_MAX - 1);
            this.movingImageMC.width = this.originWidth * _loc2_;
            this.movingImageMC.height = this.originHeight * _loc2_;
            ++this.sizeDecreaseCounter;
         }
         else if(this.popupOnly)
         {
            this.animationEnded(param1);
         }
         else if(this.delayBeforeMotionCounter < this.delayBeforeMotionFrames)
         {
            if(this.delayBeforeMotionCounter == 0)
            {
               this.movingImageMC.width = this.originWidth;
               this.movingImageMC.height = this.originHeight;
            }
            ++this.delayBeforeMotionCounter;
         }
         else if(this.motionAllowed)
         {
            if(this.motionCounter <= this.motionFrames)
            {
               this.movingImageMC.x = this.originXPos + (this.targetXPos - this.originXPos) * (this.motionCounter / this.motionFrames);
               this.movingImageMC.y = this.originYPos + (this.targetYPos - this.originYPos) * (this.motionCounter / this.motionFrames);
               ++this.motionCounter;
            }
            else
            {
               this.animationEnded(param1);
            }
         }
      }
      
      private function animationEnded(param1:uint) : void
      {
         this.movingImageMC.x = this.targetXPos;
         this.movingImageMC.y = this.targetYPos;
         if(this.returnFunction != null)
         {
            this.returnFunction();
         }
         this.setForDeletionFunction(param1);
      }
      
      public function removeMe() : void
      {
         this.movingImageBMD.dispose();
         this.movingImageMC.removeChild(this.movingImageBM);
         this.movingImageBM = null;
         this.movingImageBMD = null;
         this.movingImageMC = null;
      }
   }
}

