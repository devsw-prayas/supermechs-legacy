package net.battleMechsMulti.mobiles.buttons
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import net.battleMechsMulti.mobiles.BMItem;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2840")]
   public class BMButton extends MovieClip
   {
      
      public var buttonCore:BMButtonCore;
      
      private var buttonPicture:MovieClip;
      
      private var buttonItem:BMItem;
      
      private var _clickedFunction:Function;
      
      private var _runAsMobile:Boolean;
      
      private var _languageID:Number = 0;
      
      private var _buttonNameOriginYPos:Number = 0;
      
      public var mouseHitArea:Sprite;
      
      public var selectedEffect:Sprite;
      
      public var mouseOverEffect:Sprite;
      
      public var disabledEffect:Sprite;
      
      public var mcBackground:MovieClip;
      
      public var pictureHolder:MovieClip;
      
      public var pictureSizer:MovieClip;
      
      public var txtButtonName:TextField;
      
      private var pictureBitmap:Bitmap;
      
      private var pictureBitmapData:BitmapData;
      
      private var textBitmap:Bitmap;
      
      private var textBitmapData:BitmapData;
      
      public function BMButton()
      {
         super();
         if(this.txtButtonName != null)
         {
            this._buttonNameOriginYPos = this.txtButtonName.y;
         }
      }
      
      public function setRunAsMobile(param1:Boolean) : void
      {
         this._runAsMobile = param1;
      }
      
      public function initialize(param1:String, param2:String, param3:MovieClip, param4:Array, param5:Function, param6:Boolean) : void
      {
         var _loc7_:MovieClip = null;
         var _loc8_:BitmapData = null;
         var _loc9_:Bitmap = null;
         this._clickedFunction = param5;
         this._runAsMobile = param6;
         this.buttonCore = new BMButtonCore();
         this.buttonCore.initialize(this.mouseHitArea,this._clickedFunction,param4,null,null,null,null,this._runAsMobile);
         if(this._runAsMobile == false)
         {
            this.buttonCore.setMouseOverEffect(this.mouseOverEffect);
            this.mouseHitArea.buttonMode = true;
            this.mouseHitArea.useHandCursor = true;
         }
         else
         {
            this.mouseOverEffect.visible = false;
         }
         this.buttonCore.setSelectedEffect(this.selectedEffect);
         this.buttonCore.setDisabledEffect(this.disabledEffect);
         this.setButtonName(param1);
         if(param2 != "")
         {
            if(this.mcBackground != null)
            {
               this.mcBackground.gotoAndStop(param2);
            }
         }
         if(param3 != null)
         {
            if(this.pictureHolder != null)
            {
               this.buttonPicture = param3;
               this.buttonPicture.x = this.pictureSizer.x;
               this.buttonPicture.y = this.pictureSizer.y;
               this.buttonPicture.width = this.pictureSizer.width;
               this.buttonPicture.height = this.pictureSizer.height;
               this.pictureHolder.addChild(this.buttonPicture);
               this.addPictureBlackBorder(false);
               this.createPictureBitmap();
            }
            else
            {
               TsLogger.log("BMButton error : cannot add a picture");
            }
         }
         if(this._runAsMobile)
         {
            if(this.mcBackground != null)
            {
               _loc7_ = new MovieClip();
               addChild(_loc7_);
               swapChildren(this.mcBackground,_loc7_);
               this.mcBackground.parent.removeChild(this.mcBackground);
               _loc7_.addChild(this.mcBackground);
               _loc8_ = new BitmapData(_loc7_.width,_loc7_.height,true,0);
               _loc8_.draw(_loc7_);
               _loc9_ = new Bitmap(_loc8_);
               addChild(_loc9_);
               swapChildren(_loc7_,_loc9_);
               _loc7_.parent.removeChild(_loc7_);
               _loc7_ = null;
            }
         }
      }
      
      private function createPictureBitmap() : void
      {
         if(this._runAsMobile)
         {
            if(this.pictureBitmapData != null)
            {
               this.pictureBitmapData.dispose();
            }
            if(this.pictureBitmap != null)
            {
               this.pictureBitmap.parent.removeChild(this.pictureBitmap);
            }
            if(this.pictureHolder.filters.length > 0)
            {
               this.addPictureBlackBorder(true);
            }
            this.pictureBitmapData = new BitmapData((this.mcBackground.width - this.pictureSizer.x) * 2,(this.mcBackground.height - this.pictureSizer.y) * 2,true,0);
            this.buttonPicture.width *= 2;
            this.buttonPicture.height *= 2;
            this.pictureBitmapData.draw(this.pictureHolder);
            this.pictureBitmap = new Bitmap(this.pictureBitmapData);
            this.pictureBitmap.smoothing = true;
            this.pictureBitmap.width /= 2;
            this.pictureBitmap.height /= 2;
            this.pictureBitmap.x = this.pictureSizer.x / 2;
            this.pictureBitmap.y = this.pictureSizer.y / 2;
            this.pictureHolder.removeChild(this.buttonPicture);
            this.pictureHolder.filters = new Array();
            this.pictureHolder.addChild(this.pictureBitmap);
         }
      }
      
      public function setLanguageID(param1:Number) : void
      {
         this._languageID = param1;
      }
      
      public function replacePicture(param1:MovieClip) : void
      {
         if(this.buttonPicture != null)
         {
            if(this.buttonPicture.parent != null)
            {
               this.buttonPicture.parent.removeChild(this.buttonPicture);
            }
         }
         this.buttonPicture = param1;
         this.buttonPicture.x = this.pictureSizer.x;
         this.buttonPicture.y = this.pictureSizer.y;
         this.buttonPicture.width = this.pictureSizer.width;
         this.buttonPicture.height = this.pictureSizer.height;
         this.pictureHolder.addChild(this.buttonPicture);
         this.createPictureBitmap();
      }
      
      public function replaceItem(param1:BMItem) : void
      {
         if(this.buttonItem != null)
         {
            this.buttonItem.removeMe();
         }
         this.buttonItem = param1;
         this.buttonItem.x = this.pictureSizer.x + this.pictureSizer.width / 2;
         this.buttonItem.y = this.pictureSizer.y + this.pictureSizer.height / 2;
         this.buttonItem.width = this.pictureSizer.width;
         this.buttonItem.height = this.pictureSizer.height;
         this.pictureHolder.addChild(this.buttonItem);
      }
      
      public function addPictureBlackBorder(param1:Boolean) : void
      {
         if(param1)
         {
            this.pictureHolder.filters = [new GlowFilter(0,1,6,6,8,1)];
         }
         else
         {
            this.pictureHolder.filters = [new GlowFilter(0,1,4,4,5,1)];
         }
      }
      
      public function changeFontSize(param1:Number) : void
      {
         var _loc2_:TextFormat = this.txtButtonName.getTextFormat();
         _loc2_.size = param1;
         this.txtButtonName.setTextFormat(_loc2_);
         if(this._runAsMobile)
         {
            if(param1 < 33)
            {
               this.txtButtonName.y = this._buttonNameOriginYPos + Math.ceil((33 - param1) * 0.25);
            }
            else if(param1 > 33)
            {
               this.txtButtonName.y = this._buttonNameOriginYPos - Math.ceil((param1 - 33) * 0.25);
            }
         }
         else if(param1 < 33)
         {
            this.txtButtonName.y = this._buttonNameOriginYPos + Math.ceil((33 - param1) * 0.5);
         }
         else if(param1 > 33)
         {
            this.txtButtonName.y = this._buttonNameOriginYPos - Math.ceil((param1 - 33) * 0.5);
         }
      }
      
      public function changeFontColor(param1:uint) : void
      {
         var _loc2_:TextFormat = null;
         if(this.txtButtonName != null)
         {
            _loc2_ = this.txtButtonName.getTextFormat();
            _loc2_.color = param1;
            this.txtButtonName.setTextFormat(_loc2_);
         }
      }
      
      public function setButtonName(param1:String) : void
      {
         var _loc2_:TextFormat = null;
         var _loc3_:MovieClip = null;
         if(this.txtButtonName != null)
         {
            _loc2_ = this.txtButtonName.getTextFormat();
            if(this._languageID > 0)
            {
            }
            this.txtButtonName.text = param1;
            this.txtButtonName.setTextFormat(_loc2_);
            if(this._runAsMobile)
            {
               if(this.textBitmap != null)
               {
                  this.textBitmapData.dispose();
                  this.textBitmap.parent.removeChild(this.textBitmap);
                  this.textBitmap = null;
               }
               _loc3_ = new MovieClip();
               this.txtButtonName.scaleX = 2;
               this.txtButtonName.scaleY = 2;
               _loc3_.x = this.txtButtonName.x;
               _loc3_.y = this.txtButtonName.y;
               _loc3_.addChild(this.txtButtonName);
               this.textBitmapData = new BitmapData(_loc3_.width,_loc3_.height,true,0);
               this.textBitmapData.draw(_loc3_);
               this.textBitmap = new Bitmap(this.textBitmapData);
               this.textBitmap.width /= 2;
               this.textBitmap.height /= 2;
               this.textBitmap.smoothing = true;
               this.textBitmap.x = this.txtButtonName.x;
               this.textBitmap.y = this.txtButtonName.y - 3;
               addChild(this.textBitmap);
            }
         }
      }
      
      public function activateSoundFunctions(param1:Function, param2:Function) : void
      {
         this.buttonCore.activateSoundFunctions(param1,param2);
      }
      
      public function disableMe() : void
      {
         this.buttonCore.disableMe(true);
         if(this._runAsMobile == false)
         {
            this.mouseHitArea.buttonMode = false;
            this.mouseHitArea.useHandCursor = false;
         }
      }
      
      public function disableMe_noDisabledEffect() : void
      {
         this.buttonCore.disableMe(false);
         if(this._runAsMobile == false)
         {
            this.mouseHitArea.buttonMode = false;
            this.mouseHitArea.useHandCursor = false;
         }
      }
      
      public function enableMe() : void
      {
         this.buttonCore.enableMe();
         if(this._runAsMobile == false)
         {
            this.mouseHitArea.buttonMode = true;
            this.mouseHitArea.useHandCursor = true;
         }
      }
   }
}

