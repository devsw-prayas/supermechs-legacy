package net.battleMechsMulti.mobiles
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   import flash.display.MovieClip;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   
   public class BMMapMech extends BMBaseClass
   {
      
      public static const STATUS_STAND:String = "stand";
      
      public static const STATUS_WALK:String = "walk";
      
      public static const STATUS_STOMP:String = "stomp";
      
      public static const DIRECTION_UP:String = "up";
      
      public static const DIRECTION_DOWN:String = "down";
      
      public static const DIRECTION_LEFT:String = "left";
      
      public static const DIRECTION_RIGHT:String = "right";
      
      private var mcMech:MovieClip;
      
      private var _status:String;
      
      private var _direction:String;
      
      private var _assetNames:Array;
      
      private var _walkingFrameCounter:uint;
      
      private var _stompFrameCounter:uint;
      
      private var _originLocations:Object;
      
      private var _fireCountdown:uint;
      
      private var _endAnimationFunction:Function;
      
      public function BMMapMech()
      {
         super();
      }
      
      public function initialize() : void
      {
         var _loc2_:uint = 0;
         generateSingletonClassesPointers("");
         this.mcMech = externalAssetsM.getAsset("general","mo_playerMech");
         this._originLocations = new Object();
         this._originLocations["walk_up_torso"] = {
            "xPos":this.mcMech.mcWalk_up.mcTorso.x,
            "yPos":this.mcMech.mcWalk_up.mcTorso.y
         };
         this._originLocations["walk_up_right"] = {
            "xPos":this.mcMech.mcWalk_up.mcRight.x,
            "yPos":this.mcMech.mcWalk_up.mcRight.y
         };
         this._originLocations["walk_up_left"] = {
            "xPos":this.mcMech.mcWalk_up.mcLeft.x,
            "yPos":this.mcMech.mcWalk_up.mcLeft.y
         };
         this._originLocations["walk_down_torso"] = {
            "xPos":this.mcMech.mcWalk_down.mcTorso.x,
            "yPos":this.mcMech.mcWalk_down.mcTorso.y
         };
         this._originLocations["walk_down_right"] = {
            "xPos":this.mcMech.mcWalk_down.mcRight.x,
            "yPos":this.mcMech.mcWalk_down.mcRight.y
         };
         this._originLocations["walk_down_left"] = {
            "xPos":this.mcMech.mcWalk_down.mcLeft.x,
            "yPos":this.mcMech.mcWalk_down.mcLeft.y
         };
         this._originLocations["walk_left_torso"] = {
            "xPos":this.mcMech.mcWalk_left.mcTorso.x,
            "yPos":this.mcMech.mcWalk_left.mcTorso.y
         };
         this._originLocations["walk_left_right"] = {
            "xPos":this.mcMech.mcWalk_left.mcRight.x,
            "yPos":this.mcMech.mcWalk_left.mcRight.y
         };
         this._originLocations["walk_left_left"] = {
            "xPos":this.mcMech.mcWalk_left.mcLeft.x,
            "yPos":this.mcMech.mcWalk_left.mcLeft.y
         };
         this._originLocations["walk_right_torso"] = {
            "xPos":this.mcMech.mcWalk_right.mcTorso.x,
            "yPos":this.mcMech.mcWalk_right.mcTorso.y
         };
         this._originLocations["walk_right_right"] = {
            "xPos":this.mcMech.mcWalk_right.mcRight.x,
            "yPos":this.mcMech.mcWalk_right.mcRight.y
         };
         this._originLocations["walk_right_left"] = {
            "xPos":this.mcMech.mcWalk_right.mcLeft.x,
            "yPos":this.mcMech.mcWalk_right.mcLeft.y
         };
         this._originLocations["stand_up_torso"] = {
            "xPos":this.mcMech.mcStand_up.mcTorso.x,
            "yPos":this.mcMech.mcStand_up.mcTorso.y
         };
         this._originLocations["stand_up_right"] = {
            "xPos":this.mcMech.mcStand_up.mcRight.x,
            "yPos":this.mcMech.mcStand_up.mcRight.y
         };
         this._originLocations["stand_up_left"] = {
            "xPos":this.mcMech.mcStand_up.mcLeft.x,
            "yPos":this.mcMech.mcStand_up.mcLeft.y
         };
         this._originLocations["stand_down_torso"] = {
            "xPos":this.mcMech.mcStand_down.mcTorso.x,
            "yPos":this.mcMech.mcStand_down.mcTorso.y
         };
         this._originLocations["stand_down_right"] = {
            "xPos":this.mcMech.mcStand_down.mcRight.x,
            "yPos":this.mcMech.mcStand_down.mcRight.y
         };
         this._originLocations["stand_down_left"] = {
            "xPos":this.mcMech.mcStand_down.mcLeft.x,
            "yPos":this.mcMech.mcStand_down.mcLeft.y
         };
         this._originLocations["stand_left_torso"] = {
            "xPos":this.mcMech.mcStand_left.mcTorso.x,
            "yPos":this.mcMech.mcStand_left.mcTorso.y
         };
         this._originLocations["stand_left_right"] = {
            "xPos":this.mcMech.mcStand_left.mcRight.x,
            "yPos":this.mcMech.mcStand_left.mcRight.y
         };
         this._originLocations["stand_left_left"] = {
            "xPos":this.mcMech.mcStand_left.mcLeft.x,
            "yPos":this.mcMech.mcStand_left.mcLeft.y
         };
         this._originLocations["stand_right_torso"] = {
            "xPos":this.mcMech.mcStand_right.mcTorso.x,
            "yPos":this.mcMech.mcStand_right.mcTorso.y
         };
         this._originLocations["stand_right_right"] = {
            "xPos":this.mcMech.mcStand_right.mcRight.x,
            "yPos":this.mcMech.mcStand_right.mcRight.y
         };
         this._originLocations["stand_right_left"] = {
            "xPos":this.mcMech.mcStand_right.mcLeft.x,
            "yPos":this.mcMech.mcStand_right.mcLeft.y
         };
         this.mcMech.mcStand_up.mcTorso.parent.removeChild(this.mcMech.mcStand_up.mcTorso);
         this.mcMech.mcStand_up.mcTorso = null;
         this.mcMech.mcStand_up.mcRight.parent.removeChild(this.mcMech.mcStand_up.mcRight);
         this.mcMech.mcStand_up.mcRight = null;
         this.mcMech.mcStand_up.mcLeft.parent.removeChild(this.mcMech.mcStand_up.mcLeft);
         this.mcMech.mcStand_up.mcLeft = null;
         this.mcMech.mcStand_up.parent.removeChild(this.mcMech.mcStand_up);
         this.mcMech.mcStand_up = null;
         this.mcMech.mcStand_down.mcTorso.parent.removeChild(this.mcMech.mcStand_down.mcTorso);
         this.mcMech.mcStand_down.mcTorso = null;
         this.mcMech.mcStand_down.mcRight.parent.removeChild(this.mcMech.mcStand_down.mcRight);
         this.mcMech.mcStand_down.mcRight = null;
         this.mcMech.mcStand_down.mcLeft.parent.removeChild(this.mcMech.mcStand_down.mcLeft);
         this.mcMech.mcStand_down.mcLeft = null;
         this.mcMech.mcStand_down.parent.removeChild(this.mcMech.mcStand_down);
         this.mcMech.mcStand_down = null;
         this.mcMech.mcStand_left.mcTorso.parent.removeChild(this.mcMech.mcStand_left.mcTorso);
         this.mcMech.mcStand_left.mcTorso = null;
         this.mcMech.mcStand_left.mcRight.parent.removeChild(this.mcMech.mcStand_left.mcRight);
         this.mcMech.mcStand_left.mcRight = null;
         this.mcMech.mcStand_left.mcLeft.parent.removeChild(this.mcMech.mcStand_left.mcLeft);
         this.mcMech.mcStand_left.mcLeft = null;
         this.mcMech.mcStand_left.parent.removeChild(this.mcMech.mcStand_left);
         this.mcMech.mcStand_left = null;
         this.mcMech.mcStand_right.mcTorso.parent.removeChild(this.mcMech.mcStand_right.mcTorso);
         this.mcMech.mcStand_right.mcTorso = null;
         this.mcMech.mcStand_right.mcRight.parent.removeChild(this.mcMech.mcStand_right.mcRight);
         this.mcMech.mcStand_right.mcRight = null;
         this.mcMech.mcStand_right.mcLeft.parent.removeChild(this.mcMech.mcStand_right.mcLeft);
         this.mcMech.mcStand_right.mcLeft = null;
         this.mcMech.mcStand_right.parent.removeChild(this.mcMech.mcStand_right);
         this.mcMech.mcStand_right = null;
         var _loc1_:uint = 1;
         while(_loc1_ <= 2)
         {
            _loc2_ = 1;
            while(_loc2_ <= 4)
            {
               this.mcMech.mcWalk_up["mcFire" + _loc1_]["mcFire" + _loc2_].visible = false;
               this.mcMech.mcWalk_down["mcFire" + _loc1_]["mcFire" + _loc2_].visible = false;
               this.mcMech.mcWalk_left["mcFire" + _loc1_]["mcFire" + _loc2_].visible = false;
               this.mcMech.mcWalk_right["mcFire" + _loc1_]["mcFire" + _loc2_].visible = false;
               _loc2_++;
            }
            _loc1_++;
         }
         addChild(this.mcMech);
         this._assetNames = ["mcWalk_up","mcWalk_down","mcWalk_left","mcWalk_right"];
         this.setStatusAndDirection("stand","up");
      }
      
      public function colorMech(param1:uint, param2:uint) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc7_:ColorTransform = null;
         var _loc8_:BitmapData = null;
         var _loc9_:ColorTransform = null;
         var _loc10_:Array = null;
         var _loc11_:uint = 0;
         var _loc12_:BitmapData = null;
         var _loc6_:Number = 2;
         if(param1 > 0)
         {
            _loc7_ = new ColorTransform();
            _loc7_.color = dataM.colorsDB[param1];
            _loc3_ = 0;
            while(_loc3_ < this._assetNames.length)
            {
               this.mcMech[this._assetNames[_loc3_]].mcTorso.mcColor.transform.colorTransform = _loc7_;
               this.mcMech[this._assetNames[_loc3_]].mcTorso.mcColor.blendMode = BlendMode.OVERLAY;
               if(dataM.runAsMobile)
               {
                  this.mcMech[this._assetNames[_loc3_]].mcTorso.itemGfx.width *= _loc6_;
                  this.mcMech[this._assetNames[_loc3_]].mcTorso.itemGfx.height *= _loc6_;
                  this.mcMech[this._assetNames[_loc3_]].mcTorso.mcColor.width *= _loc6_;
                  this.mcMech[this._assetNames[_loc3_]].mcTorso.mcColor.height *= _loc6_;
                  _loc4_ = -this.mcMech[this._assetNames[_loc3_]].mcTorso.itemGfx.x;
                  _loc5_ = -this.mcMech[this._assetNames[_loc3_]].mcTorso.itemGfx.y;
                  this.mcMech[this._assetNames[_loc3_]].mcTorso.itemGfx.x += _loc4_;
                  this.mcMech[this._assetNames[_loc3_]].mcTorso.itemGfx.y += _loc5_;
                  this.mcMech[this._assetNames[_loc3_]].mcTorso.mcColor.x += _loc4_;
                  this.mcMech[this._assetNames[_loc3_]].mcTorso.mcColor.y += _loc5_;
                  _loc8_ = new BitmapData(this.mcMech[this._assetNames[_loc3_]].mcTorso.width,this.mcMech[this._assetNames[_loc3_]].mcTorso.height,true,0);
                  _loc8_.draw(this.mcMech[this._assetNames[_loc3_]].mcTorso);
                  this.mcMech[this._assetNames[_loc3_]].mcTorso.gpuImage = new Bitmap(_loc8_,"auto",true);
                  this.mcMech[this._assetNames[_loc3_]].mcTorso.gpuImage.width /= _loc6_;
                  this.mcMech[this._assetNames[_loc3_]].mcTorso.gpuImage.height /= _loc6_;
                  this.mcMech[this._assetNames[_loc3_]].mcTorso.gpuImage.x = -_loc4_;
                  this.mcMech[this._assetNames[_loc3_]].mcTorso.gpuImage.y = -_loc5_;
                  this.mcMech[this._assetNames[_loc3_]].mcTorso.addChild(this.mcMech[this._assetNames[_loc3_]].mcTorso.gpuImage);
                  this.mcMech[this._assetNames[_loc3_]].mcTorso["cacheAsBitmapMatrix"] = new Matrix();
                  this.mcMech[this._assetNames[_loc3_]].mcTorso.cacheAsBitmap = true;
                  this.mcMech[this._assetNames[_loc3_]].mcTorso.itemGfx.parent.removeChild(this.mcMech[this._assetNames[_loc3_]].mcTorso.itemGfx);
                  this.mcMech[this._assetNames[_loc3_]].mcTorso.itemGfx = null;
                  this.mcMech[this._assetNames[_loc3_]].mcTorso.mcColor.parent.removeChild(this.mcMech[this._assetNames[_loc3_]].mcTorso.mcColor);
                  this.mcMech[this._assetNames[_loc3_]].mcTorso.mcColor = null;
               }
               _loc3_++;
            }
         }
         if(param2 > 0)
         {
            _loc9_ = new ColorTransform();
            _loc9_.color = dataM.colorsDB[param2];
            _loc3_ = 0;
            while(_loc3_ < this._assetNames.length)
            {
               _loc10_ = ["mcLeft","mcRight"];
               _loc11_ = 0;
               while(_loc11_ <= 1)
               {
                  this.mcMech[this._assetNames[_loc3_]][_loc10_[_loc11_]].mcColor.transform.colorTransform = _loc9_;
                  this.mcMech[this._assetNames[_loc3_]][_loc10_[_loc11_]].mcColor.blendMode = BlendMode.OVERLAY;
                  if(dataM.runAsMobile)
                  {
                     this.mcMech[this._assetNames[_loc3_]][_loc10_[_loc11_]].itemGfx.width *= _loc6_;
                     this.mcMech[this._assetNames[_loc3_]][_loc10_[_loc11_]].itemGfx.height *= _loc6_;
                     this.mcMech[this._assetNames[_loc3_]][_loc10_[_loc11_]].mcColor.width *= _loc6_;
                     this.mcMech[this._assetNames[_loc3_]][_loc10_[_loc11_]].mcColor.height *= _loc6_;
                     _loc4_ = -this.mcMech[this._assetNames[_loc3_]][_loc10_[_loc11_]].itemGfx.x;
                     _loc5_ = -this.mcMech[this._assetNames[_loc3_]][_loc10_[_loc11_]].itemGfx.y;
                     this.mcMech[this._assetNames[_loc3_]][_loc10_[_loc11_]].itemGfx.x += _loc4_;
                     this.mcMech[this._assetNames[_loc3_]][_loc10_[_loc11_]].itemGfx.y += _loc5_;
                     this.mcMech[this._assetNames[_loc3_]][_loc10_[_loc11_]].mcColor.x += _loc4_;
                     this.mcMech[this._assetNames[_loc3_]][_loc10_[_loc11_]].mcColor.y += _loc5_;
                     _loc12_ = new BitmapData(this.mcMech[this._assetNames[_loc3_]][_loc10_[_loc11_]].width,this.mcMech[this._assetNames[_loc3_]][_loc10_[_loc11_]].height,true,0);
                     _loc12_.draw(this.mcMech[this._assetNames[_loc3_]][_loc10_[_loc11_]]);
                     this.mcMech[this._assetNames[_loc3_]][_loc10_[_loc11_]].gpuImage = new Bitmap(_loc12_,"auto",true);
                     this.mcMech[this._assetNames[_loc3_]][_loc10_[_loc11_]].gpuImage.width /= _loc6_;
                     this.mcMech[this._assetNames[_loc3_]][_loc10_[_loc11_]].gpuImage.height /= _loc6_;
                     this.mcMech[this._assetNames[_loc3_]][_loc10_[_loc11_]].gpuImage.x = -_loc4_;
                     this.mcMech[this._assetNames[_loc3_]][_loc10_[_loc11_]].gpuImage.y = -_loc5_;
                     this.mcMech[this._assetNames[_loc3_]][_loc10_[_loc11_]].addChild(this.mcMech[this._assetNames[_loc3_]][_loc10_[_loc11_]].gpuImage);
                     this.mcMech[this._assetNames[_loc3_]][_loc10_[_loc11_]]["cacheAsBitmapMatrix"] = new Matrix();
                     this.mcMech[this._assetNames[_loc3_]][_loc10_[_loc11_]].cacheAsBitmap = true;
                     this.mcMech[this._assetNames[_loc3_]][_loc10_[_loc11_]].itemGfx.parent.removeChild(this.mcMech[this._assetNames[_loc3_]][_loc10_[_loc11_]].itemGfx);
                     this.mcMech[this._assetNames[_loc3_]][_loc10_[_loc11_]].itemGfx = null;
                     this.mcMech[this._assetNames[_loc3_]][_loc10_[_loc11_]].mcColor.parent.removeChild(this.mcMech[this._assetNames[_loc3_]][_loc10_[_loc11_]].mcColor);
                     this.mcMech[this._assetNames[_loc3_]][_loc10_[_loc11_]].mcColor = null;
                  }
                  _loc11_++;
               }
               _loc3_++;
            }
         }
      }
      
      public function setStatusAndDirection(param1:String, param2:String, param3:Function = null) : void
      {
         var _loc4_:String = null;
         var _loc5_:uint = 0;
         this._endAnimationFunction = param3;
         if(this._status != param1 || this._direction != param2)
         {
            this._status = param1;
            this._direction = param2;
            _loc4_ = "mcWalk_" + this._direction;
            switch(this._status)
            {
               case STATUS_STOMP:
                  this._stompFrameCounter = 0;
                  this.mcMech["mcWalk_" + this._direction].mcTorso.x = this._originLocations["stand_" + this._direction + "_torso"].xPos;
                  this.mcMech["mcWalk_" + this._direction].mcTorso.y = this._originLocations["stand_" + this._direction + "_torso"].yPos;
                  this.mcMech["mcWalk_" + this._direction].mcLeft.x = this._originLocations["stand_" + this._direction + "_left"].xPos;
                  this.mcMech["mcWalk_" + this._direction].mcLeft.y = this._originLocations["stand_" + this._direction + "_left"].yPos;
                  this.mcMech["mcWalk_" + this._direction].mcRight.x = this._originLocations["stand_" + this._direction + "_right"].xPos;
                  this.mcMech["mcWalk_" + this._direction].mcRight.y = this._originLocations["stand_" + this._direction + "_right"].yPos;
                  break;
               case STATUS_WALK:
                  this._walkingFrameCounter = 0;
                  break;
               case STATUS_STAND:
                  this.mcMech["mcWalk_" + this._direction].mcTorso.x = this._originLocations["stand_" + this._direction + "_torso"].xPos;
                  this.mcMech["mcWalk_" + this._direction].mcTorso.y = this._originLocations["stand_" + this._direction + "_torso"].yPos;
                  this.mcMech["mcWalk_" + this._direction].mcLeft.x = this._originLocations["stand_" + this._direction + "_left"].xPos;
                  this.mcMech["mcWalk_" + this._direction].mcLeft.y = this._originLocations["stand_" + this._direction + "_left"].yPos;
                  this.mcMech["mcWalk_" + this._direction].mcRight.x = this._originLocations["stand_" + this._direction + "_right"].xPos;
                  this.mcMech["mcWalk_" + this._direction].mcRight.y = this._originLocations["stand_" + this._direction + "_right"].yPos;
            }
            _loc5_ = 0;
            while(_loc5_ < this._assetNames.length)
            {
               if(_loc4_ == this._assetNames[_loc5_])
               {
                  if(this.mcMech[this._assetNames[_loc5_]].parent == null)
                  {
                     this.mcMech.addChild(this.mcMech[this._assetNames[_loc5_]]);
                  }
               }
               else if(this.mcMech[this._assetNames[_loc5_]].parent != null)
               {
                  this.mcMech[this._assetNames[_loc5_]].parent.removeChild(this.mcMech[this._assetNames[_loc5_]]);
               }
               _loc5_++;
            }
         }
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(this._fireCountdown > 0)
         {
            --this._fireCountdown;
            if(this._fireCountdown == 0)
            {
               this.mcMech["mcWalk_" + this._direction].mcFire1.mcFire1.visible = false;
               this.mcMech["mcWalk_" + this._direction].mcFire1.mcFire2.visible = false;
               this.mcMech["mcWalk_" + this._direction].mcFire1.mcFire3.visible = false;
               this.mcMech["mcWalk_" + this._direction].mcFire1.mcFire4.visible = false;
               this.mcMech["mcWalk_" + this._direction].mcFire2.mcFire1.visible = false;
               this.mcMech["mcWalk_" + this._direction].mcFire2.mcFire2.visible = false;
               this.mcMech["mcWalk_" + this._direction].mcFire2.mcFire3.visible = false;
               this.mcMech["mcWalk_" + this._direction].mcFire2.mcFire4.visible = false;
            }
            else if(this._fireCountdown % 2 == 0)
            {
               this.mcMech["mcWalk_" + this._direction].mcFire1.mcFire1.visible = true;
               this.mcMech["mcWalk_" + this._direction].mcFire1.mcFire2.visible = true;
               this.mcMech["mcWalk_" + this._direction].mcFire1.mcFire1.visible = false;
               this.mcMech["mcWalk_" + this._direction].mcFire1.mcFire2.visible = false;
               this.mcMech["mcWalk_" + this._direction].mcFire2.mcFire1.visible = true;
               this.mcMech["mcWalk_" + this._direction].mcFire2.mcFire2.visible = true;
               this.mcMech["mcWalk_" + this._direction].mcFire2.mcFire1.visible = false;
               this.mcMech["mcWalk_" + this._direction].mcFire2.mcFire2.visible = false;
            }
            else
            {
               this.mcMech["mcWalk_" + this._direction].mcFire1.mcFire1.visible = false;
               this.mcMech["mcWalk_" + this._direction].mcFire1.mcFire2.visible = false;
               this.mcMech["mcWalk_" + this._direction].mcFire1.mcFire1.visible = true;
               this.mcMech["mcWalk_" + this._direction].mcFire1.mcFire2.visible = true;
               this.mcMech["mcWalk_" + this._direction].mcFire2.mcFire1.visible = false;
               this.mcMech["mcWalk_" + this._direction].mcFire2.mcFire2.visible = false;
               this.mcMech["mcWalk_" + this._direction].mcFire2.mcFire1.visible = true;
               this.mcMech["mcWalk_" + this._direction].mcFire2.mcFire2.visible = true;
            }
         }
         if(this._status == STATUS_WALK)
         {
            if(this._walkingFrameCounter == 0)
            {
               this.mcMech["mcWalk_" + this._direction].mcTorso.x = this._originLocations["walk_" + this._direction + "_torso"].xPos;
               this.mcMech["mcWalk_" + this._direction].mcTorso.y = this._originLocations["walk_" + this._direction + "_torso"].yPos;
               this.mcMech["mcWalk_" + this._direction].mcLeft.x = this._originLocations["walk_" + this._direction + "_left"].xPos;
               this.mcMech["mcWalk_" + this._direction].mcLeft.y = this._originLocations["walk_" + this._direction + "_left"].yPos;
               this.mcMech["mcWalk_" + this._direction].mcRight.x = this._originLocations["walk_" + this._direction + "_right"].xPos;
               this.mcMech["mcWalk_" + this._direction].mcRight.y = this._originLocations["walk_" + this._direction + "_right"].yPos;
            }
            ++this._walkingFrameCounter;
            if(this._walkingFrameCounter <= 4)
            {
               this.mcMech["mcWalk_" + this._direction].mcTorso.y -= 0.5;
            }
            else if(this._walkingFrameCounter <= 8)
            {
               this.mcMech["mcWalk_" + this._direction].mcTorso.y += 1;
            }
            else if(this._walkingFrameCounter <= 16)
            {
               this.mcMech["mcWalk_" + this._direction].mcTorso.y -= 0.5;
            }
            else if(this._walkingFrameCounter <= 20)
            {
               this.mcMech["mcWalk_" + this._direction].mcTorso.y += 1;
            }
            else
            {
               this.mcMech["mcWalk_" + this._direction].mcTorso.y -= 0.5;
            }
            switch(this._direction)
            {
               case DIRECTION_UP:
                  if(this._walkingFrameCounter <= 6)
                  {
                     this.mcMech["mcWalk_" + this._direction].mcLeft.scaleY -= 0.04;
                     this.mcMech["mcWalk_" + this._direction].mcLeft.y -= 1.5;
                  }
                  else if(this._walkingFrameCounter <= 12)
                  {
                     this.mcMech["mcWalk_" + this._direction].mcLeft.scaleY += 0.04;
                  }
                  else
                  {
                     this.mcMech["mcWalk_" + this._direction].mcLeft.y += 0.75;
                  }
                  if(this._walkingFrameCounter <= 12)
                  {
                     this.mcMech["mcWalk_" + this._direction].mcRight.y += 0.75;
                  }
                  else if(this._walkingFrameCounter <= 18)
                  {
                     this.mcMech["mcWalk_" + this._direction].mcRight.scaleY -= 0.04;
                     this.mcMech["mcWalk_" + this._direction].mcRight.y -= 1.5;
                  }
                  else
                  {
                     this.mcMech["mcWalk_" + this._direction].mcRight.scaleY += 0.04;
                  }
                  break;
               case DIRECTION_DOWN:
                  if(this._walkingFrameCounter <= 6)
                  {
                     this.mcMech["mcWalk_" + this._direction].mcLeft.scaleY -= 0.04;
                     this.mcMech["mcWalk_" + this._direction].mcLeft.y += 0.75;
                  }
                  else if(this._walkingFrameCounter <= 12)
                  {
                     this.mcMech["mcWalk_" + this._direction].mcLeft.scaleY += 0.04;
                     this.mcMech["mcWalk_" + this._direction].mcLeft.y += 0.75;
                  }
                  else
                  {
                     this.mcMech["mcWalk_" + this._direction].mcLeft.y -= 0.75;
                  }
                  if(this._walkingFrameCounter <= 12)
                  {
                     this.mcMech["mcWalk_" + this._direction].mcRight.y -= 0.75;
                  }
                  else if(this._walkingFrameCounter <= 18)
                  {
                     this.mcMech["mcWalk_" + this._direction].mcRight.scaleY -= 0.04;
                     this.mcMech["mcWalk_" + this._direction].mcRight.y += 0.75;
                  }
                  else
                  {
                     this.mcMech["mcWalk_" + this._direction].mcRight.scaleY += 0.04;
                     this.mcMech["mcWalk_" + this._direction].mcRight.y += 0.75;
                  }
                  break;
               case DIRECTION_LEFT:
               case DIRECTION_RIGHT:
                  if(this._walkingFrameCounter <= 12)
                  {
                     this.mcMech["mcWalk_" + this._direction].mcLeft.x -= 1.25;
                  }
                  else if(this._walkingFrameCounter <= 18)
                  {
                     this.mcMech["mcWalk_" + this._direction].mcLeft.x += 1.25;
                     this.mcMech["mcWalk_" + this._direction].mcLeft.y -= 0.5;
                  }
                  else
                  {
                     this.mcMech["mcWalk_" + this._direction].mcLeft.x += 1.25;
                     this.mcMech["mcWalk_" + this._direction].mcLeft.y += 0.5;
                  }
                  if(this._walkingFrameCounter <= 6)
                  {
                     this.mcMech["mcWalk_" + this._direction].mcRight.x += 1.25;
                     this.mcMech["mcWalk_" + this._direction].mcRight.y -= 0.5;
                  }
                  else if(this._walkingFrameCounter <= 12)
                  {
                     this.mcMech["mcWalk_" + this._direction].mcRight.x += 1.25;
                     this.mcMech["mcWalk_" + this._direction].mcRight.y += 0.5;
                  }
                  else
                  {
                     this.mcMech["mcWalk_" + this._direction].mcRight.x -= 1.25;
                  }
            }
            if(this._walkingFrameCounter == 24)
            {
               this._walkingFrameCounter = 0;
            }
         }
         else if(this._status == STATUS_STOMP)
         {
            ++this._stompFrameCounter;
            if(this._stompFrameCounter < 20)
            {
               this.mcMech["mcWalk_" + this._direction].mcLeft.y -= 0.5;
               this.mcMech["mcWalk_" + this._direction].mcTorso.y -= 0.25;
            }
            else if(this._stompFrameCounter < 25)
            {
               this.mcMech["mcWalk_" + this._direction].mcLeft.y += 2;
               this.mcMech["mcWalk_" + this._direction].mcTorso.y += 1;
            }
            else
            {
               if(this._endAnimationFunction != null)
               {
                  this._endAnimationFunction();
               }
               this.setStatusAndDirection(STATUS_STAND,this._direction);
            }
         }
      }
      
      public function deactivateFireAnimation() : void
      {
         this._fireCountdown = 0;
         this.mcMech["mcWalk_" + this._direction].mcFire1.mcFire1.visible = false;
         this.mcMech["mcWalk_" + this._direction].mcFire1.mcFire2.visible = false;
         this.mcMech["mcWalk_" + this._direction].mcFire1.mcFire3.visible = false;
         this.mcMech["mcWalk_" + this._direction].mcFire1.mcFire4.visible = false;
         this.mcMech["mcWalk_" + this._direction].mcFire2.mcFire1.visible = false;
         this.mcMech["mcWalk_" + this._direction].mcFire2.mcFire2.visible = false;
         this.mcMech["mcWalk_" + this._direction].mcFire2.mcFire3.visible = false;
         this.mcMech["mcWalk_" + this._direction].mcFire2.mcFire4.visible = false;
      }
      
      public function activateFireAnimation() : void
      {
         this._fireCountdown = 45;
         soundM.createSound("fireMachineGun2",0.3);
      }
      
      public function removeMe() : void
      {
      }
   }
}

