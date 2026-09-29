package net.battleMechsMulti.mobiles
{
   import fl.motion.Color;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   
   public class BMMechDrone extends BMBaseClass
   {
      
      public var droneGrp:MovieClip;
      
      public var droneGrpSub:MovieClip;
      
      public var torsoItemGrp:MovieClip;
      
      public var specialParent:MovieClip;
      
      private var _mechBattleData:BMMechBattleData;
      
      private var _activeOriginalYPos:Number;
      
      private var _inactiveOriginalYPos:Number;
      
      private var _targetYPos:Number;
      
      private var _hoverTargetYPos:Number;
      
      private var _hoverYMotionType:String;
      
      private var _hoverMotionCooldown:Number;
      
      private var _lastXSpeed:Number;
      
      private var _lastYSpeed:Number;
      
      private var _activeXPos:Number;
      
      private var _activeYPos:Number;
      
      private var _inactiveXPos:Number;
      
      private var _inactiveYPos:Number;
      
      private var _lastDroneActive:Boolean;
      
      private var _sizeRatio:Number;
      
      private var _onHoldFrames:Number;
      
      private var _finishMoveActive:Boolean = false;
      
      private var _finishMoveDrone:Boolean = false;
      
      private var _finishFrameCounter:Number;
      
      private var _finishOriginXPos:Number;
      
      private var _finishOriginYPos:Number;
      
      private var _finishTargetXPos:Number;
      
      private var _finishTargetYPos:Number;
      
      public function BMMechDrone()
      {
         super();
      }
      
      public function initialize(param1:String, param2:BMMechBattleData, param3:MovieClip, param4:Number, param5:uint) : void
      {
         var _loc10_:Point = null;
         var _loc11_:ColorTransform = null;
         var _loc12_:uint = 0;
         var _loc13_:BitmapData = null;
         generateSingletonClassesPointers("");
         this.droneGrp = new MovieClip();
         var _loc6_:Boolean = true;
         if(dataM.runAsMobile)
         {
            _loc6_ = false;
         }
         this.droneGrpSub = externalAssetsM.getAsset("items1",param1,0,0,false,_loc6_);
         this._sizeRatio = param4;
         this.droneGrpSub.width *= this._sizeRatio;
         this.droneGrpSub.height *= this._sizeRatio;
         this._mechBattleData = param2;
         if(param5 > 0)
         {
            if(this.droneGrpSub.mcColor != null)
            {
               _loc11_ = new ColorTransform();
               _loc11_.color = dataM.colorsDB[param5];
               this.droneGrpSub.mcColor.transform.colorTransform = _loc11_;
               this.droneGrpSub.mcColor.blendMode = BlendMode.OVERLAY;
            }
         }
         if(dataM.runAsMobile)
         {
            if(this.droneGrpSub.itemGfx != null)
            {
               this.droneGrpSub.filters = [new GlowFilter(0,1,4,4,7)];
               _loc12_ = 4;
               this.droneGrpSub.itemGfx.x += _loc12_;
               this.droneGrpSub.itemGfx.y += _loc12_;
               if(this.droneGrpSub.mcColor != null)
               {
                  this.droneGrpSub.mcColor.x += _loc12_;
                  this.droneGrpSub.mcColor.y += _loc12_;
               }
               _loc13_ = new BitmapData(this.droneGrpSub.itemGfx.width + _loc12_ * 2,this.droneGrpSub.itemGfx.height + _loc12_ * 2,true,0);
               _loc13_.draw(this.droneGrpSub);
               this.droneGrpSub.gpuImage = new Bitmap(_loc13_,"auto",true);
               this.droneGrpSub.gpuImage.x -= _loc12_;
               this.droneGrpSub.gpuImage.y -= _loc12_;
               this.droneGrpSub.addChild(this.droneGrpSub.gpuImage);
               this.droneGrpSub["cacheAsBitmapMatrix"] = new Matrix();
               this.droneGrpSub.cacheAsBitmap = true;
               this.droneGrpSub.itemGfx.parent.removeChild(this.droneGrpSub.itemGfx);
               this.droneGrpSub.itemGfx = null;
               if(this.droneGrpSub.mcColor != null)
               {
                  this.droneGrpSub.mcColor.parent.removeChild(this.droneGrpSub.mcColor);
                  this.droneGrpSub.mcColor = null;
               }
            }
         }
         this.torsoItemGrp = param3;
         var _loc7_:Sprite = this.torsoItemGrp.mcCenter;
         var _loc8_:Point = new Point(_loc7_.x,_loc7_.y);
         var _loc9_:Point = this.torsoItemGrp.localToGlobal(_loc8_);
         _loc10_ = parent.globalToLocal(_loc9_);
         this.droneGrpSub.x = -this.droneGrpSub.mcCenter.x;
         this.droneGrpSub.y = -this.droneGrpSub.mcCenter.y;
         this.droneGrp.x = _loc10_.x;
         this.droneGrp.y = _loc10_.y;
         this._hoverMotionCooldown = 0;
         this._hoverYMotionType = "down";
         this._activeOriginalYPos = this.droneGrp.y;
         this._inactiveOriginalYPos = this.torsoItemGrp.mcCenter.y;
         _loc7_ = this.torsoItemGrp.mcDrone;
         _loc8_ = new Point(_loc7_.x,_loc7_.y);
         _loc9_ = this.torsoItemGrp.localToGlobal(_loc8_);
         _loc10_ = parent.globalToLocal(_loc9_);
         this._targetYPos = _loc10_.y;
         this._hoverTargetYPos = 0;
         this._lastXSpeed = 0;
         this._lastYSpeed = 0;
         this._lastDroneActive = false;
         this._onHoldFrames = 0;
         this.droneGrp.addChild(this.droneGrpSub);
         this.droneGrp.mcDrone = this.droneGrpSub;
         if(this.specialParent != null)
         {
            this.specialParent.addChild(this.droneGrp);
         }
         else
         {
            screensM.screenBattle.holder_drones.addChild(this.droneGrp);
         }
         if(dataM.battleType == "challenge")
         {
            if(dataM.battleSubType == "invisible")
            {
               if(param2.playerID == dataM.player2PlayerID)
               {
                  this.droneGrp.alpha = 0;
               }
            }
         }
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(this._finishMoveActive)
         {
            if(this._finishMoveDrone == false)
            {
               this.finishMoveHandler();
            }
         }
         else
         {
            this.droneHandler();
         }
      }
      
      private function droneHandler() : void
      {
         this.refreshDronePosition();
         this.reflectionHandler();
      }
      
      public function haltVerticalMotion(param1:Number) : void
      {
         this._hoverMotionCooldown += param1;
      }
      
      public function addOnHoldFrames(param1:Number) : void
      {
         this._onHoldFrames = param1;
      }
      
      private function refreshDronePosition() : void
      {
         var _loc1_:Sprite = null;
         var _loc2_:Point = null;
         var _loc3_:Point = null;
         var _loc4_:Point = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         if(this._onHoldFrames > 0)
         {
            --this._onHoldFrames;
         }
         else
         {
            if(this._mechBattleData.droneActive)
            {
               if(this._lastDroneActive == false)
               {
                  this.droneGrp.visible = true;
               }
               _loc1_ = this.torsoItemGrp.mcDrone;
               _loc2_ = new Point(_loc1_.x,_loc1_.y);
               _loc3_ = this.torsoItemGrp.localToGlobal(_loc2_);
               _loc4_ = parent.globalToLocal(_loc3_);
               _loc8_ = this._targetYPos;
               _loc7_ = _loc4_.x;
               _loc9_ = 0.4;
               _loc10_ = 0.4;
               if(dataM.slowCPUMode)
               {
                  _loc9_ = 0.8;
                  _loc10_ = 0.8;
               }
               if(this.droneGrp.x > _loc7_)
               {
                  if(this.droneGrp.x > _loc7_ + 1)
                  {
                     _loc5_ = (this.droneGrp.x - _loc7_) * _loc9_;
                     if(_loc5_ > this._lastXSpeed + _loc10_)
                     {
                        _loc5_ = this._lastXSpeed + _loc10_;
                     }
                     this.droneGrp.x -= _loc5_;
                     this._lastXSpeed = _loc5_;
                  }
                  else
                  {
                     this.droneGrp.x = _loc7_;
                     this._lastXSpeed = 0;
                  }
               }
               else if(this.droneGrp.x < _loc7_)
               {
                  if(this.droneGrp.x < _loc7_ - 1)
                  {
                     _loc5_ = (this.droneGrp.x - _loc7_) * _loc9_;
                     if(_loc5_ < this._lastXSpeed - _loc10_)
                     {
                        _loc5_ = this._lastXSpeed - _loc10_;
                     }
                     this.droneGrp.x -= _loc5_;
                     this._lastXSpeed = _loc5_;
                  }
                  else
                  {
                     this.droneGrp.x = _loc7_;
                     this._lastXSpeed = 0;
                  }
               }
               _loc11_ = 0.2;
               _loc12_ = 0.2;
               if(dataM.slowCPUMode)
               {
                  _loc11_ = 0.4;
                  _loc12_ = 0.4;
               }
               if(this.droneGrp.y > _loc8_)
               {
                  if(this.droneGrp.y > _loc8_ + 1)
                  {
                     _loc6_ = (this.droneGrp.y - _loc8_) * _loc11_;
                     if(_loc6_ > this._lastYSpeed + _loc12_)
                     {
                        _loc6_ = this._lastYSpeed + _loc12_;
                     }
                     this.droneGrp.y -= _loc6_;
                     this._lastYSpeed = _loc6_;
                  }
                  else
                  {
                     this.droneGrp.y = _loc8_;
                     this._lastYSpeed = 0;
                  }
               }
               else if(this.droneGrp.y < _loc8_)
               {
                  if(this.droneGrp.y < _loc8_ - 1)
                  {
                     _loc6_ = (this.droneGrp.y - _loc8_) * _loc11_;
                     if(_loc6_ < this._lastYSpeed - _loc12_)
                     {
                        _loc6_ = this._lastYSpeed - _loc12_;
                     }
                     this.droneGrp.y -= _loc6_;
                     this._lastYSpeed = _loc6_;
                  }
                  else
                  {
                     this.droneGrp.y = _loc8_;
                     this._lastYSpeed = 0;
                  }
               }
               if(this._hoverMotionCooldown > 0)
               {
                  --this._hoverMotionCooldown;
               }
               else
               {
                  if(this._hoverTargetYPos == 0)
                  {
                     this._hoverTargetYPos = Math.random() * 4 + 2;
                  }
                  switch(this._hoverYMotionType)
                  {
                     case "down":
                        if(this.droneGrp.mcDrone.y > this._hoverTargetYPos - 0.5)
                        {
                           this.droneGrp.mcDrone.y = this._hoverTargetYPos;
                           this._hoverYMotionType = "up";
                           this._hoverTargetYPos = -(Math.random() * 4 + 2);
                           this._hoverMotionCooldown = 80 + Math.ceil(Math.random() * 100);
                        }
                        else
                        {
                           this.droneGrp.mcDrone.y += this._hoverTargetYPos / 10;
                        }
                        break;
                     case "up":
                        if(this.droneGrp.mcDrone.y < this._hoverTargetYPos + 0.5)
                        {
                           this.droneGrp.mcDrone.y = this._hoverTargetYPos;
                           this._hoverYMotionType = "down";
                           this._hoverTargetYPos = Math.random() * 4 + 2;
                           this._hoverMotionCooldown = 80 + Math.ceil(Math.random() * 100);
                        }
                        else
                        {
                           this.droneGrp.mcDrone.y += this._hoverTargetYPos / 10;
                        }
                  }
               }
            }
            else
            {
               _loc1_ = this.torsoItemGrp.mcCenter;
               _loc2_ = new Point(_loc1_.x,_loc1_.y);
               _loc3_ = this.torsoItemGrp.localToGlobal(_loc2_);
               _loc4_ = parent.globalToLocal(_loc3_);
               _loc8_ = _loc4_.y;
               _loc7_ = _loc4_.x;
               if(this.droneGrp.x > _loc7_)
               {
                  if(this.droneGrp.x > _loc7_ + 0.5)
                  {
                     this.droneGrp.x -= (this.droneGrp.x - _loc7_) * 0.3;
                  }
                  else
                  {
                     this.droneGrp.x = _loc7_;
                  }
               }
               else if(this.droneGrp.x < _loc7_)
               {
                  if(this.droneGrp.x < _loc7_ - 0.5)
                  {
                     this.droneGrp.x += (_loc7_ - this.droneGrp.x) * 0.3;
                  }
                  else
                  {
                     this.droneGrp.x = _loc7_;
                  }
               }
               this._lastXSpeed = 0;
               if(this.droneGrp.y > _loc8_)
               {
                  if(this.droneGrp.y > _loc8_ + 0.5)
                  {
                     this.droneGrp.y -= (this.droneGrp.y - _loc8_) * 0.3;
                  }
                  else
                  {
                     this.droneGrp.y = _loc8_;
                  }
               }
               else if(this.droneGrp.y < _loc8_)
               {
                  if(this.droneGrp.y < _loc8_)
                  {
                     if(this.droneGrp.y < _loc8_ - 0.5)
                     {
                        this.droneGrp.y += (_loc8_ - this.droneGrp.y) * 0.3;
                     }
                     else
                     {
                        this.droneGrp.y = _loc8_;
                     }
                  }
               }
               else
               {
                  this.droneGrp.visible = false;
               }
            }
            this._lastDroneActive = this._mechBattleData.droneActive;
         }
      }
      
      public function activateDroneReflection() : void
      {
         this.droneGrp.alpha = 1;
      }
      
      private function reflectionHandler() : void
      {
         if(dataM.battleType == "challenge")
         {
            if(dataM.battleSubType == "invisible")
            {
               if(this._mechBattleData.playerID == dataM.player2PlayerID)
               {
                  if(this.droneGrp.alpha > 0)
                  {
                     this.droneGrp.alpha -= 0.1;
                     if(this.droneGrp.alpha < 0)
                     {
                        this.droneGrp.alpha = 0;
                     }
                  }
               }
            }
         }
      }
      
      public function activateFinishMove(param1:Number, param2:Number) : void
      {
         this._finishFrameCounter = 0;
         this._finishOriginXPos = this.droneGrp.x;
         this._finishOriginYPos = this.droneGrp.y;
         this._finishTargetXPos = this._finishOriginXPos + param1;
         this._finishTargetYPos = this._finishOriginYPos + param2;
         this._finishMoveActive = true;
      }
      
      private function finishMoveHandler() : void
      {
         var _loc4_:Number = NaN;
         ++this._finishFrameCounter;
         var _loc1_:Number = this._finishFrameCounter;
         var _loc2_:Number = 40;
         if(_loc1_ > _loc2_)
         {
            _loc1_ = _loc2_;
         }
         var _loc3_:Number = Math.abs(this.droneGrp.x - this._finishTargetXPos);
         if(_loc3_ <= _loc2_ + 3)
         {
            this.droneGrp.visible = false;
            screensM.screenBattle.finish8AnimationEnded();
            this._finishMoveDrone = true;
         }
         else
         {
            if(this._finishOriginXPos > this._finishTargetXPos)
            {
               this.droneGrp.x -= _loc1_;
            }
            else
            {
               this.droneGrp.x += _loc1_;
            }
            _loc4_ = Math.abs((this.droneGrp.x - this._finishOriginXPos) / (this._finishTargetXPos - this._finishOriginXPos));
            this.droneGrp.y = this._finishOriginYPos + (this._finishTargetYPos - this._finishOriginYPos) * _loc4_;
         }
      }
      
      public function addStaticGlow(param1:String) : void
      {
         var _loc2_:Color = null;
         var _loc3_:uint = 0;
         var _loc4_:Number = NaN;
         if(this.droneGrp != null)
         {
            _loc2_ = new Color();
            _loc4_ = 0.4;
            switch(param1)
            {
               case "lightGreen":
                  _loc3_ = 13434828;
                  break;
               case "strongGreen":
                  _loc3_ = 65280;
                  _loc4_ = 0.35;
                  break;
               case "black":
                  _loc3_ = 0;
                  _loc4_ = 0.65;
            }
            _loc2_.setTint(_loc3_,_loc4_);
            this.droneGrp.transform.colorTransform = _loc2_;
         }
      }
      
      public function removeStaticGlow() : void
      {
         if(this.droneGrp != null)
         {
            this.droneGrp.transform.colorTransform = new ColorTransform();
         }
      }
      
      public function removeMe() : void
      {
         if(this.droneGrp != null)
         {
            if(this.droneGrp.parent != null)
            {
               this.droneGrp.parent.removeChild(this.droneGrp);
            }
            this.droneGrp = null;
         }
      }
   }
}

