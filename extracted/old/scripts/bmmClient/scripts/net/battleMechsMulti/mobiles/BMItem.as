package net.battleMechsMulti.mobiles
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class BMItem extends Sprite
   {
      
      private var _width:Number;
      
      private var _height:Number;
      
      private var _ID:Number;
      
      private var _centerGrp:Boolean;
      
      private var _runAsMobile:Boolean;
      
      public var itemGrp:MovieClip;
      
      public var overItemGrp1:MovieClip;
      
      public var overItemGrp2:MovieClip;
      
      public var backgroundMC:MovieClip;
      
      private var imageHolder:MovieClip;
      
      public var assetsBitmap:Bitmap;
      
      private var assetsBitmapData:BitmapData;
      
      private var itemGlobalBitmap:Bitmap;
      
      private var itemGlobalBitmapData:BitmapData;
      
      public function BMItem()
      {
         super();
      }
      
      public function initialize(param1:Number, param2:Number, param3:Number, param4:MovieClip, param5:Number, param6:Number, param7:Boolean, param8:MovieClip, param9:Boolean) : void
      {
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         this._ID = param1;
         this._width = param2;
         this._height = param3;
         this._centerGrp = param7;
         this._runAsMobile = param9;
         this.itemGrp = param4;
         this.imageHolder = new MovieClip();
         if(param8 != null)
         {
            this.backgroundMC = param8;
            this.imageHolder.bottomLayer = new Sprite();
            this.imageHolder.topLayer = new Sprite();
            this.imageHolder.addChild(this.imageHolder.bottomLayer);
            this.imageHolder.addChild(this.imageHolder.topLayer);
            _loc10_ = this.itemGrp.width;
            if(_loc10_ < this.itemGrp.height)
            {
               _loc10_ = this.itemGrp.height;
            }
            this.backgroundMC.width = _loc10_;
            this.backgroundMC.height = _loc10_;
            if(_loc10_ > this.itemGrp.width)
            {
               this.itemGrp.x += (_loc10_ - this.itemGrp.width) / 2;
            }
            else
            {
               this.itemGrp.y += (_loc10_ - this.itemGrp.height) / 2;
            }
            this.imageHolder.bottomLayer.addChild(this.backgroundMC);
            this.imageHolder.topLayer.addChild(this.itemGrp);
         }
         else
         {
            this.imageHolder.addChild(this.itemGrp);
         }
         if(this._width > 0)
         {
            _loc11_ = this.imageHolder.width / this._width;
            _loc12_ = this.imageHolder.height / this._height;
            _loc13_ = 1;
            if(_loc11_ < _loc12_)
            {
               _loc13_ = _loc12_;
            }
            else
            {
               _loc13_ = _loc11_;
            }
            this.imageHolder.width /= _loc13_;
            this.imageHolder.height /= _loc13_;
         }
         if(this._centerGrp)
         {
            this.imageHolder.x = -this.imageHolder.width / 2;
            this.imageHolder.y = -this.imageHolder.height / 2;
         }
         else
         {
            this.imageHolder.x = (this._width - this.imageHolder.width) / 2;
            this.imageHolder.y = (this._height - this.imageHolder.height) / 2;
         }
         if(param5)
         {
            _loc14_ = param5 * 2;
            if(this.imageHolder.width > this.imageHolder.height)
            {
               _loc15_ = this.imageHolder.width;
               this.imageHolder.width -= _loc14_;
               _loc16_ = this.imageHolder.width / _loc15_;
               this.imageHolder.height *= _loc16_;
               this.imageHolder.x += param5;
               this.imageHolder.y = param5 + (param3 - _loc14_ - this.imageHolder.height) / 2;
            }
            else
            {
               _loc17_ = this.imageHolder.height;
               this.imageHolder.height -= _loc14_;
               _loc18_ = this.imageHolder.height / _loc17_;
               this.imageHolder.width *= _loc18_;
               this.imageHolder.y += param5;
               this.imageHolder.x = param5 + (param2 - _loc14_ - this.imageHolder.width) / 2;
            }
         }
         if(param6 > 0)
         {
            _loc19_ = this.itemGrp.width / this.itemGrp.height;
            if(this.itemGrp.width > this.itemGrp.height)
            {
               this.itemGrp.width -= param6 * 2;
               this.itemGrp.height -= param6 * 2 / _loc19_;
               this.itemGrp.x += param6;
               this.itemGrp.y += param6 / _loc19_;
            }
            else
            {
               this.itemGrp.width -= param6 * 2 * _loc19_;
               this.itemGrp.height -= param6 * 2;
               this.itemGrp.x += param6 * _loc19_;
               this.itemGrp.y += param6;
            }
         }
         addChild(this.imageHolder);
      }
      
      public function addOverItemGrp1(param1:MovieClip) : void
      {
         this.overItemGrp1 = param1;
         this.overItemGrp1.width = this._width;
         this.overItemGrp1.height = this._height;
         if(this._centerGrp)
         {
            this.overItemGrp1.x = -this.overItemGrp1.width / 2;
            this.overItemGrp1.y = -this.overItemGrp1.height / 2;
         }
         addChild(this.overItemGrp1);
      }
      
      public function addOverItemGrp2(param1:MovieClip) : void
      {
         this.overItemGrp2 = param1;
         this.overItemGrp2.width = this._width;
         this.overItemGrp2.height = this._height;
         if(this._centerGrp)
         {
            this.overItemGrp2.x = -this.overItemGrp2.width / 2;
            this.overItemGrp2.y = -this.overItemGrp2.height / 2;
         }
         addChild(this.overItemGrp2);
      }
      
      public function createAssetsBitmap(param1:Array, param2:Array, param3:Sprite, param4:Boolean = false) : void
      {
         var _loc6_:uint = 0;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc5_:Number = 1;
         if(param4)
         {
            _loc5_ = 1.4;
            _loc6_ = 0;
            while(_loc6_ < param1.length)
            {
               param1[_loc6_].x *= _loc5_;
               param1[_loc6_].y *= _loc5_;
               param1[_loc6_].scaleX = _loc5_;
               param1[_loc6_].scaleY = _loc5_;
               _loc6_++;
            }
            _loc6_ = 0;
            while(_loc6_ < param2.length)
            {
               param2[_loc6_].x *= _loc5_;
               param2[_loc6_].y *= _loc5_;
               param2[_loc6_].width *= _loc5_;
               param2[_loc6_].height *= _loc5_;
               _loc6_++;
            }
         }
         if(param1 == null)
         {
            param1 = new Array();
         }
         if(param2 == null)
         {
            param2 = new Array();
         }
         if(param1.length > 0)
         {
            _loc7_ = param1[0].x + param1[0].width;
            _loc8_ = param1[0].y + param1[0].height;
         }
         else
         {
            _loc7_ = param2[0].x + param2[0].width;
            _loc8_ = param2[0].y + param2[0].height;
         }
         var _loc9_:MovieClip = new MovieClip();
         _loc6_ = 0;
         while(_loc6_ < param1.length)
         {
            if(_loc7_ < param1[_loc6_].x + param1[_loc6_].width)
            {
               _loc7_ = param1[_loc6_].x + param1[_loc6_].width;
            }
            if(_loc8_ < param1[_loc6_].y + param1[_loc6_].height)
            {
               _loc8_ = param1[_loc6_].y + param1[_loc6_].height;
            }
            _loc9_.addChild(param1[_loc6_]);
            _loc6_++;
         }
         _loc6_ = 0;
         while(_loc6_ < param2.length)
         {
            if(_loc7_ < param2[_loc6_].x + param2[_loc6_].width)
            {
               _loc7_ = param2[_loc6_].x + param2[_loc6_].width;
            }
            if(_loc8_ < param2[_loc6_].y + param2[_loc6_].height)
            {
               _loc8_ = param2[_loc6_].y + param2[_loc6_].height;
            }
            _loc9_.addChild(param2[_loc6_]);
            _loc6_++;
         }
         this.assetsBitmapData = new BitmapData(_loc7_,_loc8_,true,0);
         this.assetsBitmap = new Bitmap(this.assetsBitmapData);
         this.assetsBitmapData.draw(_loc9_);
         _loc6_ = 0;
         while(_loc6_ < param1.length)
         {
            _loc9_.removeChild(param1[_loc6_]);
            if(param1[_loc6_].parent != null)
            {
               param1[_loc6_].parent.removeChild(param1[_loc6_]);
            }
            _loc6_++;
         }
         _loc6_ = 0;
         while(_loc6_ < param2.length)
         {
            _loc9_.removeChild(param2[_loc6_]);
            if(param2[_loc6_].parent != null)
            {
               param2[_loc6_].parent.removeChild(param2[_loc6_]);
            }
            _loc6_++;
         }
         if(param4)
         {
            this.assetsBitmap.width /= _loc5_;
            this.assetsBitmap.height /= _loc5_;
         }
         param3.addChild(this.assetsBitmap);
      }
      
      public function convertMeIntoBitmap(param1:Boolean = false) : void
      {
         if(this._centerGrp)
         {
            this.itemGrp.x += this.itemGrp.width / 2;
            this.itemGrp.y += this.itemGrp.height / 2;
         }
         var _loc2_:Number = 1;
         if(param1)
         {
            _loc2_ = 1.5;
            this.itemGrp.width *= _loc2_;
            this.itemGrp.height *= _loc2_;
         }
         this.itemGlobalBitmapData = new BitmapData(Math.ceil(this._width * _loc2_),Math.ceil(this._height * _loc2_),true,0);
         this.itemGlobalBitmapData.draw(this);
         this.itemGlobalBitmap = new Bitmap(this.itemGlobalBitmapData);
         if(_loc2_)
         {
            this.itemGlobalBitmap.width /= _loc2_;
            this.itemGlobalBitmap.height /= _loc2_;
            if(this._centerGrp)
            {
               this.itemGlobalBitmap.x -= this.imageHolder.width / 2 / _loc2_;
               this.itemGlobalBitmap.y -= this.imageHolder.height / 2 / _loc2_;
            }
         }
         else if(this._centerGrp)
         {
            this.itemGlobalBitmap.x -= this.imageHolder.width / 2;
            this.itemGlobalBitmap.y -= this.imageHolder.height / 2;
         }
         addChild(this.itemGlobalBitmap);
         this.itemGrp.parent.removeChild(this.itemGrp);
         this.itemGrp = null;
      }
      
      public function get ID() : Number
      {
         return this._ID;
      }
      
      public function removeMe() : void
      {
         if(this.backgroundMC != null)
         {
            this.imageHolder.bottomLayer.removeChild(this.backgroundMC);
            if(this.itemGrp != null)
            {
               this.imageHolder.topLayer.removeChild(this.itemGrp);
            }
            this.backgroundMC = null;
         }
         else if(this.itemGrp != null)
         {
            if(this._runAsMobile)
            {
               if(this.itemGrp.gpuImage != null)
               {
                  try
                  {
                     this.itemGrp.gpuImage.dispose();
                     this.itemGrp.removeChild(this.itemGrp.gpuImage);
                     this.itemGrp.gpuImage = null;
                  }
                  catch(err:Error)
                  {
                     itemGrp.gpuImage = null;
                  }
               }
            }
            this.imageHolder.removeChild(this.itemGrp);
         }
         if(this.assetsBitmapData != null)
         {
            this.assetsBitmapData.dispose();
            this.assetsBitmapData = null;
         }
         if(this.assetsBitmap != null)
         {
            this.assetsBitmap.parent.removeChild(this.assetsBitmap);
         }
         this.assetsBitmap = null;
         if(this.itemGlobalBitmapData != null)
         {
            this.itemGlobalBitmapData.dispose();
            this.itemGlobalBitmapData = null;
         }
         if(this.itemGlobalBitmap != null)
         {
            this.itemGlobalBitmap.parent.removeChild(this.itemGlobalBitmap);
         }
         this.itemGlobalBitmap = null;
         if(this.overItemGrp1 != null)
         {
            if(this.itemGrp != null)
            {
               if(this._runAsMobile)
               {
                  if(this.itemGrp.gpuImage != null)
                  {
                     try
                     {
                        this.itemGrp.gpuImage.dispose();
                        this.itemGrp.removeChild(this.itemGrp.gpuImage);
                        this.itemGrp.gpuImage = null;
                     }
                     catch(err:Error)
                     {
                        itemGrp.gpuImage = null;
                     }
                  }
               }
            }
            removeChild(this.overItemGrp1);
         }
         if(this.overItemGrp2 != null)
         {
            if(this.itemGrp != null)
            {
               if(this._runAsMobile)
               {
                  if(this.itemGrp.gpuImage != null)
                  {
                     try
                     {
                        this.itemGrp.gpuImage.dispose();
                        this.itemGrp.removeChild(this.itemGrp.gpuImage);
                        this.itemGrp.gpuImage = null;
                     }
                     catch(err:Error)
                     {
                        itemGrp.gpuImage = null;
                     }
                  }
               }
            }
            removeChild(this.overItemGrp2);
         }
         this.itemGrp = null;
         this.overItemGrp1 = null;
         this.overItemGrp2 = null;
         removeChild(this.imageHolder);
         this.imageHolder = null;
         if(parent != null)
         {
            parent.removeChild(this);
         }
      }
   }
}

