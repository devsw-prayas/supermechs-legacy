package net.battleMechsMulti.mobiles
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import net.battleMechsMulti.managers.BMDataManager;
   
   public class BMMapMech extends BMBaseClass
   {
      
      public static const STATUS_STAND:String = "stand";
      
      public static const STATUS_WALK:String = "walk";
      
      public static const STATUS_STOMP:String = "stomp";
      
      public static const DIRECTION_UP:String = "up";
      
      public static const DIRECTION_DOWN:String = "down";
      
      public static const DIRECTION_LEFT:String = "left";
      
      public static const DIRECTION_RIGHT:String = "right";
      
      public static const TYPE_MECH:String = "mech";
      
      public static const TYPE_TANK:String = "tank";
      
      public static const TYPE_JEEP:String = "jeep";
      
      private var mcMech:MovieClip;
      
      private var _status:String;
      
      private var _direction:String;
      
      private var _assetNames:Array;
      
      private var _walkingFrameCounter:uint;
      
      private var _stompFrameCounter:uint;
      
      private var _originPositions:Object;
      
      private var _fireCountdown:uint;
      
      private var _fastAnimationSpeed:Boolean = false;
      
      private var _endAnimationFunction:Function;
      
      private var _type:String;
      
      private var hatUp:MovieClip;
      
      private var hatDown:MovieClip;
      
      private var hatLeft:MovieClip;
      
      private var hatRight:MovieClip;
      
      private var mcBarHolder:MovieClip;
      
      public function BMMapMech()
      {
         super();
      }
      
      public function initialize(param1:String = "mech", param2:uint = 1, param3:String = "") : void
      {
         var _loc6_:String = null;
         var _loc7_:Boolean = false;
         var _loc8_:uint = 0;
         generateSingletonClassesPointers("");
         this._type = param1;
         var _loc4_:String = "mo_playerMech";
         if(this._type == TYPE_TANK)
         {
            _loc4_ = "mo_animatedTank";
         }
         else if(this._type == TYPE_JEEP)
         {
            _loc4_ = "mo_animatedJeep";
         }
         this.mcMech = externalAssetsM.getAsset("general",_loc4_);
         if(param2 > 1)
         {
            if(this.mcMech.mcWalk_up.mcTorso.itemGfx.mcCockpit != null)
            {
               this.mcMech.mcWalk_up.mcTorso.itemGfx.mcCockpit.gotoAndStop(param2);
            }
            if(this.mcMech.mcWalk_down.mcTorso.itemGfx.mcCockpit != null)
            {
               this.mcMech.mcWalk_down.mcTorso.itemGfx.mcCockpit.gotoAndStop(param2);
            }
            if(this.mcMech.mcWalk_left.mcTorso.itemGfx.mcCockpit != null)
            {
               this.mcMech.mcWalk_left.mcTorso.itemGfx.mcCockpit.gotoAndStop(param2);
            }
            if(this.mcMech.mcWalk_right.mcTorso.itemGfx.mcCockpit != null)
            {
               this.mcMech.mcWalk_right.mcTorso.itemGfx.mcCockpit.gotoAndStop(param2);
            }
            if(this.mcMech.mcStand_up.mcTorso.itemGfx.mcCockpit != null)
            {
               this.mcMech.mcStand_up.mcTorso.itemGfx.mcCockpit.gotoAndStop(param2);
            }
            if(this.mcMech.mcStand_down.mcTorso.itemGfx.mcCockpit != null)
            {
               this.mcMech.mcStand_down.mcTorso.itemGfx.mcCockpit.gotoAndStop(param2);
            }
            if(this.mcMech.mcStand_left.mcTorso.itemGfx.mcCockpit != null)
            {
               this.mcMech.mcStand_left.mcTorso.itemGfx.mcCockpit.gotoAndStop(param2);
            }
            if(this.mcMech.mcStand_right.mcTorso.itemGfx.mcCockpit != null)
            {
               this.mcMech.mcStand_right.mcTorso.itemGfx.mcCockpit.gotoAndStop(param2);
            }
         }
         if(this.mcMech.mcWalk_up.mcTorso.mcHat != null && param3 != "")
         {
            _loc6_ = param3;
            _loc7_ = false;
            if(param3 == "hatPerk3")
            {
               _loc6_ += "_straight";
               _loc7_ = true;
            }
            this.hatUp = externalAssetsM.getAsset("items1",_loc6_);
            this.hatUp.scaleX = 0.3;
            this.hatUp.scaleY = 0.3;
            this.hatUp.x = this.mcMech.mcWalk_up.mcTorso.mcHat.x;
            this.hatUp.y = this.mcMech.mcWalk_up.mcTorso.mcHat.y;
            this.mcMech.mcWalk_up.mcTorso.addChild(this.hatUp);
            this.hatDown = externalAssetsM.getAsset("items1",_loc6_);
            this.hatDown.scaleX = 0.3;
            this.hatDown.scaleY = 0.3;
            if(_loc7_)
            {
               this.hatDown.scaleY = 0.15;
            }
            this.hatDown.x = this.mcMech.mcWalk_down.mcTorso.mcHat.x;
            this.hatDown.y = this.mcMech.mcWalk_down.mcTorso.mcHat.y;
            this.mcMech.mcWalk_down.mcTorso.addChild(this.hatDown);
            this.hatLeft = externalAssetsM.getAsset("items1",param3);
            this.hatLeft.scaleX = 0.3;
            this.hatLeft.scaleY = 0.3;
            this.hatLeft.x = this.mcMech.mcWalk_left.mcTorso.mcHat.x;
            this.hatLeft.y = this.mcMech.mcWalk_left.mcTorso.mcHat.y;
            this.mcMech.mcWalk_left.mcTorso.addChild(this.hatLeft);
            this.hatRight = externalAssetsM.getAsset("items1",param3);
            this.hatRight.scaleX = 0.3;
            this.hatRight.scaleY = 0.3;
            this.hatRight.x = this.mcMech.mcWalk_right.mcTorso.mcHat.x;
            this.hatRight.y = this.mcMech.mcWalk_right.mcTorso.mcHat.y;
            this.mcMech.mcWalk_right.mcTorso.addChild(this.hatRight);
         }
         this._originPositions = new Object();
         this._originPositions["walk_up_torso"] = {
            "xPos":this.mcMech.mcWalk_up.mcTorso.x,
            "yPos":this.mcMech.mcWalk_up.mcTorso.y
         };
         this._originPositions["walk_up_right"] = {
            "xPos":this.mcMech.mcWalk_up.mcRight.x,
            "yPos":this.mcMech.mcWalk_up.mcRight.y
         };
         this._originPositions["walk_up_left"] = {
            "xPos":this.mcMech.mcWalk_up.mcLeft.x,
            "yPos":this.mcMech.mcWalk_up.mcLeft.y
         };
         this._originPositions["walk_down_torso"] = {
            "xPos":this.mcMech.mcWalk_down.mcTorso.x,
            "yPos":this.mcMech.mcWalk_down.mcTorso.y
         };
         this._originPositions["walk_down_right"] = {
            "xPos":this.mcMech.mcWalk_down.mcRight.x,
            "yPos":this.mcMech.mcWalk_down.mcRight.y
         };
         this._originPositions["walk_down_left"] = {
            "xPos":this.mcMech.mcWalk_down.mcLeft.x,
            "yPos":this.mcMech.mcWalk_down.mcLeft.y
         };
         this._originPositions["walk_left_torso"] = {
            "xPos":this.mcMech.mcWalk_left.mcTorso.x,
            "yPos":this.mcMech.mcWalk_left.mcTorso.y
         };
         this._originPositions["walk_left_right"] = {
            "xPos":this.mcMech.mcWalk_left.mcRight.x,
            "yPos":this.mcMech.mcWalk_left.mcRight.y
         };
         this._originPositions["walk_left_left"] = {
            "xPos":this.mcMech.mcWalk_left.mcLeft.x,
            "yPos":this.mcMech.mcWalk_left.mcLeft.y
         };
         this._originPositions["walk_right_torso"] = {
            "xPos":this.mcMech.mcWalk_right.mcTorso.x,
            "yPos":this.mcMech.mcWalk_right.mcTorso.y
         };
         this._originPositions["walk_right_right"] = {
            "xPos":this.mcMech.mcWalk_right.mcRight.x,
            "yPos":this.mcMech.mcWalk_right.mcRight.y
         };
         this._originPositions["walk_right_left"] = {
            "xPos":this.mcMech.mcWalk_right.mcLeft.x,
            "yPos":this.mcMech.mcWalk_right.mcLeft.y
         };
         this._originPositions["stand_up_torso"] = {
            "xPos":this.mcMech.mcStand_up.mcTorso.x,
            "yPos":this.mcMech.mcStand_up.mcTorso.y
         };
         this._originPositions["stand_up_right"] = {
            "xPos":this.mcMech.mcStand_up.mcRight.x,
            "yPos":this.mcMech.mcStand_up.mcRight.y
         };
         this._originPositions["stand_up_left"] = {
            "xPos":this.mcMech.mcStand_up.mcLeft.x,
            "yPos":this.mcMech.mcStand_up.mcLeft.y
         };
         this._originPositions["stand_down_torso"] = {
            "xPos":this.mcMech.mcStand_down.mcTorso.x,
            "yPos":this.mcMech.mcStand_down.mcTorso.y
         };
         this._originPositions["stand_down_right"] = {
            "xPos":this.mcMech.mcStand_down.mcRight.x,
            "yPos":this.mcMech.mcStand_down.mcRight.y
         };
         this._originPositions["stand_down_left"] = {
            "xPos":this.mcMech.mcStand_down.mcLeft.x,
            "yPos":this.mcMech.mcStand_down.mcLeft.y
         };
         this._originPositions["stand_left_torso"] = {
            "xPos":this.mcMech.mcStand_left.mcTorso.x,
            "yPos":this.mcMech.mcStand_left.mcTorso.y
         };
         this._originPositions["stand_left_right"] = {
            "xPos":this.mcMech.mcStand_left.mcRight.x,
            "yPos":this.mcMech.mcStand_left.mcRight.y
         };
         this._originPositions["stand_left_left"] = {
            "xPos":this.mcMech.mcStand_left.mcLeft.x,
            "yPos":this.mcMech.mcStand_left.mcLeft.y
         };
         this._originPositions["stand_right_torso"] = {
            "xPos":this.mcMech.mcStand_right.mcTorso.x,
            "yPos":this.mcMech.mcStand_right.mcTorso.y
         };
         this._originPositions["stand_right_right"] = {
            "xPos":this.mcMech.mcStand_right.mcRight.x,
            "yPos":this.mcMech.mcStand_right.mcRight.y
         };
         this._originPositions["stand_right_left"] = {
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
         var _loc5_:uint = 1;
         while(_loc5_ <= 2)
         {
            _loc8_ = 1;
            while(_loc8_ <= 4)
            {
               this.mcMech.mcWalk_up["mcFire" + _loc5_]["mcFire" + _loc8_].visible = false;
               this.mcMech.mcWalk_down["mcFire" + _loc5_]["mcFire" + _loc8_].visible = false;
               this.mcMech.mcWalk_left["mcFire" + _loc5_]["mcFire" + _loc8_].visible = false;
               this.mcMech.mcWalk_right["mcFire" + _loc5_]["mcFire" + _loc8_].visible = false;
               _loc8_++;
            }
            _loc5_++;
         }
         addChild(this.mcMech);
         this._assetNames = ["mcWalk_up","mcWalk_down","mcWalk_left","mcWalk_right"];
         this.setStatusAndDirection("stand","up");
      }
      
      public function showHPBar(param1:Number) : void
      {
         var _loc2_:Boolean = false;
         if(this.mcBarHolder == null)
         {
            this.mcBarHolder = new mcBaseMapEnemyHPBar();
            _loc2_ = true;
            this.mcBarHolder.y = 22;
            addChild(this.mcBarHolder);
         }
         var _loc3_:BMBar = this.mcBarHolder.mcBar;
         if(_loc2_)
         {
            _loc3_.initialize(BMBar.COLOR_YELLOW);
         }
         _loc3_.setFill(param1,true);
      }
      
      public function setFastAnimationSpeed() : void
      {
         this._fastAnimationSpeed = true;
      }
      
      public function setRegularAnimationSpeed() : void
      {
         this._fastAnimationSpeed = false;
      }
      
      private function get sizeIncrease() : Number
      {
         return 2;
      }
      
      private function get useLegsAnimation() : Boolean
      {
         return this._type == TYPE_MECH;
      }
      
      private function colorItem(param1:MovieClip, param2:Sprite, param3:uint) : void
      {
         var _loc4_:Sprite = null;
         var _loc5_:Number = NaN;
         var _loc6_:BitmapData = null;
         var _loc7_:Sprite = null;
         var _loc8_:ColorTransform = null;
         if(param3 >= BMDataManager.PATTERN_COLORS_FIRST_ID)
         {
            _loc4_ = externalAssetsM.getAsset("general","ColorPattern" + param3);
            _loc5_ = 1;
            if(dataM.runAsMobile)
            {
               _loc5_ = this.sizeIncrease;
            }
            _loc6_ = new BitmapData(_loc4_.width * _loc5_,_loc4_.height * _loc5_,true);
            _loc6_.draw(_loc4_);
            _loc7_ = new Sprite();
            _loc7_.graphics.beginBitmapFill(_loc6_);
            _loc7_.graphics.drawRect(0,0,param1.width * _loc5_,param1.height * _loc5_);
            param1.camoHolder = new MovieClip();
            param2.parent.removeChild(param2);
            param1.camoHolder.addChild(param2);
            param1.camoHolder.addChild(_loc7_);
            _loc7_.mask = param2;
            param1.camoHolder.blendMode = BlendMode.OVERLAY;
            param1.addChild(param1.camoHolder);
         }
         else
         {
            _loc8_ = new ColorTransform();
            _loc8_.color = dataM.colorsDB[param3];
            param1.mcColor.transform.colorTransform = _loc8_;
            param1.mcColor.blendMode = BlendMode.OVERLAY;
         }
      }
      
      public function colorMech(param1:uint, param2:uint) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:MovieClip = null;
         var _loc7_:Sprite = null;
         var _loc8_:BitmapData = null;
         var _loc9_:Array = null;
         var _loc10_:uint = 0;
         var _loc11_:BitmapData = null;
         if(param1 > 0)
         {
            _loc3_ = 0;
            while(_loc3_ < this._assetNames.length)
            {
               _loc6_ = this.mcMech[this._assetNames[_loc3_]].mcTorso;
               _loc7_ = _loc6_.mcColor;
               if(_loc7_ != null)
               {
                  this.colorItem(_loc6_,_loc7_,param1);
                  if(dataM.runAsMobile)
                  {
                     _loc6_.itemGfx.width *= this.sizeIncrease;
                     _loc6_.itemGfx.height *= this.sizeIncrease;
                     _loc6_.mcColor.width *= this.sizeIncrease;
                     _loc6_.mcColor.height *= this.sizeIncrease;
                     _loc4_ = -_loc6_.itemGfx.x;
                     _loc5_ = -_loc6_.itemGfx.y;
                     _loc6_.itemGfx.x += _loc4_;
                     _loc6_.itemGfx.y += _loc5_;
                     _loc6_.mcColor.x += _loc4_;
                     _loc6_.mcColor.y += _loc5_;
                     if(_loc6_.camoHolder != null)
                     {
                        _loc6_.camoHolder.x += _loc4_;
                        _loc6_.camoHolder.y += _loc5_;
                     }
                     _loc8_ = new BitmapData(_loc6_.width,_loc6_.height,true,0);
                     _loc8_.draw(_loc6_);
                     _loc6_.gpuImage = new Bitmap(_loc8_,"auto",true);
                     _loc6_.gpuImage.width /= this.sizeIncrease;
                     _loc6_.gpuImage.height /= this.sizeIncrease;
                     _loc6_.gpuImage.x = -_loc4_;
                     _loc6_.gpuImage.y = -_loc5_;
                     _loc6_.addChild(_loc6_.gpuImage);
                     _loc6_["cacheAsBitmapMatrix"] = new Matrix();
                     _loc6_.cacheAsBitmap = true;
                     _loc6_.itemGfx.parent.removeChild(_loc6_.itemGfx);
                     _loc6_.itemGfx = null;
                     _loc6_.mcColor.parent.removeChild(_loc6_.mcColor);
                     _loc6_.mcColor = null;
                     if(_loc6_.camoHolder != null)
                     {
                        if(_loc6_.camoHolder.parent != null)
                        {
                           _loc6_.camoHolder.parent.removeChild(_loc6_.camoHolder);
                        }
                     }
                  }
               }
               _loc3_++;
            }
         }
         if(param2 > 0)
         {
            _loc3_ = 0;
            while(_loc3_ < this._assetNames.length)
            {
               _loc9_ = ["mcLeft","mcRight"];
               _loc10_ = 0;
               while(_loc10_ <= 1)
               {
                  _loc6_ = this.mcMech[this._assetNames[_loc3_]][_loc9_[_loc10_]];
                  _loc7_ = _loc6_.mcColor;
                  if(_loc7_ != null)
                  {
                     this.colorItem(_loc6_,_loc7_,param2);
                     if(dataM.runAsMobile)
                     {
                        _loc6_.itemGfx.width *= this.sizeIncrease;
                        _loc6_.itemGfx.height *= this.sizeIncrease;
                        _loc6_.mcColor.width *= this.sizeIncrease;
                        _loc6_.mcColor.height *= this.sizeIncrease;
                        _loc4_ = -_loc6_.itemGfx.x;
                        _loc5_ = -_loc6_.itemGfx.y;
                        _loc6_.itemGfx.x += _loc4_;
                        _loc6_.itemGfx.y += _loc5_;
                        _loc6_.mcColor.x += _loc4_;
                        _loc6_.mcColor.y += _loc5_;
                        if(_loc6_.camoHolder != null)
                        {
                           _loc6_.camoHolder.x += _loc4_;
                           _loc6_.camoHolder.y += _loc5_;
                        }
                        _loc11_ = new BitmapData(_loc6_.width,_loc6_.height,true,0);
                        _loc11_.draw(_loc6_);
                        _loc6_.gpuImage = new Bitmap(_loc11_,"auto",true);
                        _loc6_.gpuImage.width /= this.sizeIncrease;
                        _loc6_.gpuImage.height /= this.sizeIncrease;
                        _loc6_.gpuImage.x = -_loc4_;
                        _loc6_.gpuImage.y = -_loc5_;
                        _loc6_.addChild(_loc6_.gpuImage);
                        _loc6_["cacheAsBitmapMatrix"] = new Matrix();
                        _loc6_.cacheAsBitmap = true;
                        _loc6_.itemGfx.parent.removeChild(_loc6_.itemGfx);
                        _loc6_.itemGfx = null;
                        _loc6_.mcColor.parent.removeChild(_loc6_.mcColor);
                        _loc6_.mcColor = null;
                        if(_loc6_.camoHolder != null)
                        {
                           if(_loc6_.camoHolder.parent != null)
                           {
                              _loc6_.camoHolder.parent.removeChild(_loc6_.camoHolder);
                           }
                        }
                     }
                  }
                  _loc10_++;
               }
               _loc3_++;
            }
         }
         if(this.hatUp != null)
         {
            this.hatUp.parent.removeChild(this.hatUp);
            this.mcMech.mcWalk_up.mcTorso.addChild(this.hatUp);
            this.hatDown.parent.removeChild(this.hatDown);
            this.mcMech.mcWalk_down.mcTorso.addChild(this.hatDown);
            this.hatLeft.parent.removeChild(this.hatLeft);
            this.mcMech.mcWalk_left.mcTorso.addChild(this.hatLeft);
            this.hatRight.parent.removeChild(this.hatRight);
            this.mcMech.mcWalk_right.mcTorso.addChild(this.hatRight);
         }
      }
      
      public function setStatusAndDirection(param1:String, param2:String, param3:Function = null) : void
      {
         this._endAnimationFunction = param3;
         if(this._status == param1 && this._direction == param2)
         {
            return;
         }
         this._status = param1;
         this._direction = param2;
         this.resetFireEffectsInDirection(this._direction);
         var _loc4_:String = "mcWalk_" + this._direction;
         switch(this._status)
         {
            case STATUS_STOMP:
               this._stompFrameCounter = 0;
               this.mcMech["mcWalk_" + this._direction].mcTorso.x = this._originPositions["stand_" + this._direction + "_torso"].xPos;
               this.mcMech["mcWalk_" + this._direction].mcTorso.y = this._originPositions["stand_" + this._direction + "_torso"].yPos;
               this.mcMech["mcWalk_" + this._direction].mcLeft.x = this._originPositions["stand_" + this._direction + "_left"].xPos;
               this.mcMech["mcWalk_" + this._direction].mcLeft.y = this._originPositions["stand_" + this._direction + "_left"].yPos;
               this.mcMech["mcWalk_" + this._direction].mcRight.x = this._originPositions["stand_" + this._direction + "_right"].xPos;
               this.mcMech["mcWalk_" + this._direction].mcRight.y = this._originPositions["stand_" + this._direction + "_right"].yPos;
               break;
            case STATUS_WALK:
               this._walkingFrameCounter = 0;
               break;
            case STATUS_STAND:
               this.mcMech["mcWalk_" + this._direction].mcTorso.x = this._originPositions["stand_" + this._direction + "_torso"].xPos;
               this.mcMech["mcWalk_" + this._direction].mcTorso.y = this._originPositions["stand_" + this._direction + "_torso"].yPos;
               this.mcMech["mcWalk_" + this._direction].mcLeft.x = this._originPositions["stand_" + this._direction + "_left"].xPos;
               this.mcMech["mcWalk_" + this._direction].mcLeft.y = this._originPositions["stand_" + this._direction + "_left"].yPos;
               this.mcMech["mcWalk_" + this._direction].mcRight.x = this._originPositions["stand_" + this._direction + "_right"].xPos;
               this.mcMech["mcWalk_" + this._direction].mcRight.y = this._originPositions["stand_" + this._direction + "_right"].yPos;
         }
         var _loc5_:uint = 0;
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
      
      public function getDirection() : String
      {
         return this._direction;
      }
      
      private function resetFireEffectsInDirection(param1:String) : void
      {
         this.mcMech["mcWalk_" + param1].mcFire1.mcFire1.visible = false;
         this.mcMech["mcWalk_" + param1].mcFire1.mcFire2.visible = false;
         this.mcMech["mcWalk_" + param1].mcFire1.mcFire3.visible = false;
         this.mcMech["mcWalk_" + param1].mcFire1.mcFire4.visible = false;
         this.mcMech["mcWalk_" + param1].mcFire2.mcFire1.visible = false;
         this.mcMech["mcWalk_" + param1].mcFire2.mcFire2.visible = false;
         this.mcMech["mcWalk_" + param1].mcFire2.mcFire3.visible = false;
         this.mcMech["mcWalk_" + param1].mcFire2.mcFire4.visible = false;
      }
      
      public function onEnterFrameTrigger() : void
      {
         this.firingHandler();
         this.walkingHandler();
         this.stompingHandler();
      }
      
      private function stompingHandler() : void
      {
         if(this._status != STATUS_STOMP)
         {
            return;
         }
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
      
      private function walkingHandler() : void
      {
         if(this._status != STATUS_WALK)
         {
            return;
         }
         if(this._walkingFrameCounter == 0)
         {
            this.mcMech["mcWalk_" + this._direction].mcTorso.x = this._originPositions["walk_" + this._direction + "_torso"].xPos;
            this.mcMech["mcWalk_" + this._direction].mcTorso.y = this._originPositions["walk_" + this._direction + "_torso"].yPos;
            this.mcMech["mcWalk_" + this._direction].mcLeft.x = this._originPositions["walk_" + this._direction + "_left"].xPos;
            this.mcMech["mcWalk_" + this._direction].mcLeft.y = this._originPositions["walk_" + this._direction + "_left"].yPos;
            this.mcMech["mcWalk_" + this._direction].mcRight.x = this._originPositions["walk_" + this._direction + "_right"].xPos;
            this.mcMech["mcWalk_" + this._direction].mcRight.y = this._originPositions["walk_" + this._direction + "_right"].yPos;
            this.mcMech["mcWalk_" + this._direction].mcLeft.scaleX = 1;
            this.mcMech["mcWalk_" + this._direction].mcLeft.scaleY = 1;
            this.mcMech["mcWalk_" + this._direction].mcRight.scaleX = 1;
            this.mcMech["mcWalk_" + this._direction].mcRight.scaleY = 1;
         }
         ++this._walkingFrameCounter;
         var _loc1_:uint = 1;
         if(this._fastAnimationSpeed)
         {
            _loc1_ = 2;
         }
         if(this._walkingFrameCounter <= 4 / _loc1_)
         {
            this.mcMech["mcWalk_" + this._direction].mcTorso.y -= 0.5 * _loc1_;
         }
         else if(this._walkingFrameCounter <= 8 / _loc1_)
         {
            this.mcMech["mcWalk_" + this._direction].mcTorso.y += 1 * _loc1_;
         }
         else if(this._walkingFrameCounter <= 16 / _loc1_)
         {
            this.mcMech["mcWalk_" + this._direction].mcTorso.y -= 0.5 * _loc1_;
         }
         else if(this._walkingFrameCounter <= 20 / _loc1_)
         {
            this.mcMech["mcWalk_" + this._direction].mcTorso.y += 1 * _loc1_;
         }
         else
         {
            this.mcMech["mcWalk_" + this._direction].mcTorso.y -= 0.5 * _loc1_;
         }
         if(this.useLegsAnimation)
         {
            switch(this._direction)
            {
               case DIRECTION_UP:
                  if(this._walkingFrameCounter <= 6 / _loc1_)
                  {
                     this.mcMech["mcWalk_" + this._direction].mcLeft.scaleY -= 0.04 * _loc1_;
                     this.mcMech["mcWalk_" + this._direction].mcLeft.y -= 1.5 * _loc1_;
                  }
                  else if(this._walkingFrameCounter <= 12 / _loc1_)
                  {
                     this.mcMech["mcWalk_" + this._direction].mcLeft.scaleY += 0.04 * _loc1_;
                  }
                  else
                  {
                     this.mcMech["mcWalk_" + this._direction].mcLeft.y += 0.75 * _loc1_;
                  }
                  if(this._walkingFrameCounter <= 12 / _loc1_)
                  {
                     this.mcMech["mcWalk_" + this._direction].mcRight.y += 0.75 * _loc1_;
                  }
                  else if(this._walkingFrameCounter <= 18 / _loc1_)
                  {
                     this.mcMech["mcWalk_" + this._direction].mcRight.scaleY -= 0.04 * _loc1_;
                     this.mcMech["mcWalk_" + this._direction].mcRight.y -= 1.5 * _loc1_;
                  }
                  else
                  {
                     this.mcMech["mcWalk_" + this._direction].mcRight.scaleY += 0.04 * _loc1_;
                  }
                  break;
               case DIRECTION_DOWN:
                  if(this._walkingFrameCounter <= 6 / _loc1_)
                  {
                     this.mcMech["mcWalk_" + this._direction].mcLeft.scaleY -= 0.04 * _loc1_;
                     this.mcMech["mcWalk_" + this._direction].mcLeft.y += 0.75 * _loc1_;
                  }
                  else if(this._walkingFrameCounter <= 12 / _loc1_)
                  {
                     this.mcMech["mcWalk_" + this._direction].mcLeft.scaleY += 0.04 * _loc1_;
                     this.mcMech["mcWalk_" + this._direction].mcLeft.y += 0.75 * _loc1_;
                  }
                  else
                  {
                     this.mcMech["mcWalk_" + this._direction].mcLeft.y -= 0.75 * _loc1_;
                  }
                  if(this._walkingFrameCounter <= 12 / _loc1_)
                  {
                     this.mcMech["mcWalk_" + this._direction].mcRight.y -= 0.75 * _loc1_;
                  }
                  else if(this._walkingFrameCounter <= 18 / _loc1_)
                  {
                     this.mcMech["mcWalk_" + this._direction].mcRight.scaleY -= 0.04 * _loc1_;
                     this.mcMech["mcWalk_" + this._direction].mcRight.y += 0.75 * _loc1_;
                  }
                  else
                  {
                     this.mcMech["mcWalk_" + this._direction].mcRight.scaleY += 0.04 * _loc1_;
                     this.mcMech["mcWalk_" + this._direction].mcRight.y += 0.75 * _loc1_;
                  }
                  break;
               case DIRECTION_LEFT:
               case DIRECTION_RIGHT:
                  if(this._walkingFrameCounter <= 12 / _loc1_)
                  {
                     this.mcMech["mcWalk_" + this._direction].mcLeft.x -= 1.25 * _loc1_;
                  }
                  else if(this._walkingFrameCounter <= 18 / _loc1_)
                  {
                     this.mcMech["mcWalk_" + this._direction].mcLeft.x += 1.25 * _loc1_;
                     this.mcMech["mcWalk_" + this._direction].mcLeft.y -= 0.5 * _loc1_;
                  }
                  else
                  {
                     this.mcMech["mcWalk_" + this._direction].mcLeft.x += 1.25 * _loc1_;
                     this.mcMech["mcWalk_" + this._direction].mcLeft.y += 0.5 * _loc1_;
                  }
                  if(this._walkingFrameCounter <= 6 / _loc1_)
                  {
                     this.mcMech["mcWalk_" + this._direction].mcRight.x += 1.25 * _loc1_;
                     this.mcMech["mcWalk_" + this._direction].mcRight.y -= 0.5 * _loc1_;
                  }
                  else if(this._walkingFrameCounter <= 12 / _loc1_)
                  {
                     this.mcMech["mcWalk_" + this._direction].mcRight.x += 1.25 * _loc1_;
                     this.mcMech["mcWalk_" + this._direction].mcRight.y += 0.5 * _loc1_;
                  }
                  else
                  {
                     this.mcMech["mcWalk_" + this._direction].mcRight.x -= 1.25 * _loc1_;
                  }
            }
         }
         if(this._walkingFrameCounter == 24 / _loc1_)
         {
            this._walkingFrameCounter = 0;
         }
      }
      
      private function firingHandler() : void
      {
         if(this._fireCountdown == 0)
         {
            return;
         }
         --this._fireCountdown;
         this.resetFireEffectsInDirection(this._direction);
         if(this._fireCountdown > 0)
         {
            if(this._fireCountdown % 2 == 0)
            {
               this.mcMech["mcWalk_" + this._direction].mcFire1.mcFire1.visible = true;
               this.mcMech["mcWalk_" + this._direction].mcFire2.mcFire1.visible = true;
            }
            else
            {
               this.mcMech["mcWalk_" + this._direction].mcFire1.mcFire2.visible = true;
               this.mcMech["mcWalk_" + this._direction].mcFire2.mcFire2.visible = true;
            }
         }
         else
         {
            this.mcMech["mcWalk_" + this._direction].mcFire1.mcFire1.visible = false;
            this.mcMech["mcWalk_" + this._direction].mcFire2.mcFire1.visible = false;
            this.mcMech["mcWalk_" + this._direction].mcFire1.mcFire2.visible = false;
            this.mcMech["mcWalk_" + this._direction].mcFire2.mcFire2.visible = false;
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
      
      public function exportMechState() : Object
      {
         var _loc1_:Object = new Object();
         _loc1_.walkingFrameCounter = this._walkingFrameCounter;
         _loc1_.stompFrameCounter = this._stompFrameCounter;
         _loc1_.fireCountdown = this._fireCountdown;
         _loc1_.fastAnimationSpeed = this._fastAnimationSpeed;
         _loc1_.direction = this._direction;
         _loc1_.status = this._status;
         _loc1_["mcWalk_" + this._direction] = new Object();
         _loc1_["mcWalk_" + this._direction]["mcTorso"] = new Object();
         _loc1_["mcWalk_" + this._direction]["mcTorso"].x = this.mcMech["mcWalk_" + this._direction].mcTorso.x;
         _loc1_["mcWalk_" + this._direction]["mcTorso"].y = this.mcMech["mcWalk_" + this._direction].mcTorso.y;
         _loc1_["mcWalk_" + this._direction]["mcLeft"] = new Object();
         _loc1_["mcWalk_" + this._direction]["mcLeft"].x = this.mcMech["mcWalk_" + this._direction].mcLeft.x;
         _loc1_["mcWalk_" + this._direction]["mcLeft"].y = this.mcMech["mcWalk_" + this._direction].mcLeft.y;
         _loc1_["mcWalk_" + this._direction]["mcLeft"].scaleX = this.mcMech["mcWalk_" + this._direction].mcLeft.scaleX;
         _loc1_["mcWalk_" + this._direction]["mcLeft"].scaleY = this.mcMech["mcWalk_" + this._direction].mcLeft.scaleY;
         _loc1_["mcWalk_" + this._direction]["mcRight"] = new Object();
         _loc1_["mcWalk_" + this._direction]["mcRight"].x = this.mcMech["mcWalk_" + this._direction].mcRight.x;
         _loc1_["mcWalk_" + this._direction]["mcRight"].y = this.mcMech["mcWalk_" + this._direction].mcRight.y;
         _loc1_["mcWalk_" + this._direction]["mcRight"].scaleX = this.mcMech["mcWalk_" + this._direction].mcRight.scaleX;
         _loc1_["mcWalk_" + this._direction]["mcRight"].scaleY = this.mcMech["mcWalk_" + this._direction].mcRight.scaleY;
         return _loc1_;
      }
      
      public function importMechState(param1:Object) : void
      {
         this.setStatusAndDirection(param1.status,param1.direction);
         this.mcMech["mcWalk_" + this._direction].mcTorso.x = param1["mcWalk_" + this._direction]["mcTorso"].x;
         this.mcMech["mcWalk_" + this._direction].mcTorso.y = param1["mcWalk_" + this._direction]["mcTorso"].y;
         this.mcMech["mcWalk_" + this._direction].mcLeft.x = param1["mcWalk_" + this._direction]["mcLeft"].x;
         this.mcMech["mcWalk_" + this._direction].mcLeft.y = param1["mcWalk_" + this._direction]["mcLeft"].y;
         this.mcMech["mcWalk_" + this._direction].mcLeft.scaleX = param1["mcWalk_" + this._direction]["mcLeft"].scaleX;
         this.mcMech["mcWalk_" + this._direction].mcLeft.scaleY = param1["mcWalk_" + this._direction]["mcLeft"].scaleY;
         this.mcMech["mcWalk_" + this._direction].mcRight.x = param1["mcWalk_" + this._direction]["mcRight"].x;
         this.mcMech["mcWalk_" + this._direction].mcRight.y = param1["mcWalk_" + this._direction]["mcRight"].y;
         this.mcMech["mcWalk_" + this._direction].mcRight.scaleX = param1["mcWalk_" + this._direction]["mcRight"].scaleX;
         this.mcMech["mcWalk_" + this._direction].mcRight.scaleY = param1["mcWalk_" + this._direction]["mcRight"].scaleY;
         this._walkingFrameCounter = param1.walkingFrameCounter;
         this._stompFrameCounter = param1.stompFrameCounter;
         this._fireCountdown = param1.fireCountdown;
         this._fastAnimationSpeed = param1.fastAnimationSpeed;
      }
      
      public function removeMe() : void
      {
         if(this.mcMech.parent != null)
         {
            this.mcMech.parent.removeChild(this.mcMech);
            this.mcMech = null;
         }
         if(this.parent == null)
         {
            return;
         }
         this.parent.removeChild(this);
      }
   }
}

