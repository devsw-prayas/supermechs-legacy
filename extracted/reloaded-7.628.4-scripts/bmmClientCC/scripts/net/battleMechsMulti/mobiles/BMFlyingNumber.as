package net.battleMechsMulti.mobiles
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.geom.Matrix;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol5221")]
   public class BMFlyingNumber extends BMBaseClass
   {
      
      public var txtNumber:TextField;
      
      public var holderMC:MovieClip;
      
      private var _ySpeed:Number;
      
      private var _frameCounter:Number;
      
      private var _numberText:String;
      
      private var _delayFrames:Number;
      
      private var _viewScale:Number;
      
      private var _direction:String;
      
      private var _textBitmap:Bitmap;
      
      private var _textBitmapData:BitmapData;
      
      private const INITIAL_Y_SPEED:Number = -8;
      
      private const Y_SPEED_REDUCE_RATIO:Number = 0.9;
      
      private const Y_SPEED_MINIMUM:Number = 0.5;
      
      private const DELAY_FRAMES_BEFORE_ALPHA_OUT:Number = 18;
      
      public function BMFlyingNumber()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      public function initialize(param1:MovieClip, param2:String, param3:String, param4:Number, param5:Number, param6:String) : void
      {
         generateSingletonClassesPointers("");
         this.holderMC = param1;
         this._numberText = param2;
         this._delayFrames = param4;
         this._viewScale = param5;
         this._direction = param6;
         if(this._delayFrames > 0)
         {
            alpha = 0;
         }
         this._ySpeed = this.INITIAL_Y_SPEED;
         this._frameCounter = 0;
         gotoAndStop(param3);
         this["cacheAsBitmapMatrix"] = new Matrix();
         this.cacheAsBitmap = true;
      }
      
      public function runFrame(param1:uint) : void
      {
         if(this._numberText != "")
         {
            if(this.txtNumber != null)
            {
               this.txtNumber.text = this._numberText;
               if(dataM.runAsMobile)
               {
                  this._textBitmapData = new BitmapData(this.txtNumber.width,this.txtNumber.height,true,0);
                  this._textBitmap = new Bitmap(this._textBitmapData);
                  this._textBitmapData.draw(this.txtNumber);
                  this._textBitmap.x = this.txtNumber.x;
                  this._textBitmap.y = this.txtNumber.y;
                  addChild(this._textBitmap);
                  this.txtNumber.parent.removeChild(this.txtNumber);
               }
               this._numberText = "";
            }
         }
         if(this._delayFrames > 0)
         {
            --this._delayFrames;
            if(this._delayFrames == 0)
            {
               alpha = 1;
            }
         }
         else if(this._ySpeed == 0)
         {
            ++this._frameCounter;
            if(this._frameCounter > this.DELAY_FRAMES_BEFORE_ALPHA_OUT)
            {
               width *= 0.7;
               height *= 0.7;
               if(width < 5)
               {
                  effectsM.setFlyingNumberForDeletion(param1);
               }
            }
         }
         else
         {
            switch(this._direction)
            {
               case "up":
                  y += this._ySpeed / this._viewScale;
                  break;
               case "down":
                  y -= this._ySpeed / this._viewScale;
            }
            this._ySpeed *= this.Y_SPEED_REDUCE_RATIO;
            if(this._ySpeed > -this.Y_SPEED_MINIMUM)
            {
               this._ySpeed = 0;
            }
         }
      }
      
      public function removeMe() : void
      {
         if(dataM.runAsMobile)
         {
            if(this._textBitmapData != null)
            {
               this._textBitmapData.dispose();
               this._textBitmapData = null;
            }
            if(this._textBitmap != null)
            {
               if(this._textBitmap.parent != null)
               {
                  this._textBitmap.parent.removeChild(this._textBitmap);
               }
               this._textBitmap = null;
            }
            this.txtNumber = null;
         }
         if(this.txtNumber != null)
         {
            if(this.txtNumber.parent != null)
            {
               this.txtNumber.parent.removeChild(this.txtNumber);
               this.txtNumber = null;
            }
         }
         if(parent != null)
         {
            parent.removeChild(this);
         }
      }
      
      internal function frame1() : *
      {
         stop();
      }
   }
}

