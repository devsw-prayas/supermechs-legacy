package net.battleMechsMulti.screens.raid
{
   import fl.motion.Color;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMExternalAssetsManager;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.mobiles.BMMechView;
   import net.battleMechsMulti.mobiles.mechView.BMMechViewManualColors;
   
   public class RaidEnemyThumb extends MovieClip
   {
      
      public var mcMechHolder:Sprite;
      
      public var mcMechReflectionHolder:Sprite;
      
      public var mcAmountBackground:Sprite;
      
      public var txtAmount:TextField;
      
      public var mcSizer:Sprite;
      
      public var mcMissionBackground:MovieClip;
      
      private var mechViews:Vector.<BMMechView> = new Vector.<BMMechView>();
      
      private var mechViewReflections:Vector.<BMMechView> = new Vector.<BMMechView>();
      
      private var _totalMechs:uint;
      
      public function RaidEnemyThumb()
      {
         super();
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
      }
      
      public function initialize_avatarThumb(param1:String, param2:uint, param3:uint) : void
      {
         var _loc4_:Vector.<BMMechStructure> = null;
         var _loc5_:BMMechViewManualColors = null;
         var _loc6_:uint = 1;
         var _loc7_:Boolean = false;
         var _loc8_:Boolean = true;
         param1 += "_thumb";
         this.initialize(_loc4_,_loc5_,param1,param2,_loc6_,param3,_loc7_,_loc8_);
      }
      
      public function initialize_mechView(param1:Vector.<BMMechStructure>, param2:BMMechViewManualColors, param3:uint, param4:uint, param5:Boolean, param6:Boolean = false) : void
      {
         var _loc7_:String = "";
         var _loc8_:uint = 0;
         this.initialize(param1,param2,_loc7_,_loc8_,param3,param4,param5,param6);
      }
      
      private function initialize(param1:Vector.<BMMechStructure>, param2:BMMechViewManualColors, param3:String, param4:uint, param5:uint, param6:uint, param7:Boolean, param8:Boolean = false) : void
      {
         var _loc11_:MovieClip = null;
         var _loc12_:Array = null;
         var _loc13_:* = 0;
         this.removeMechViews();
         var _loc9_:Boolean = false;
         var _loc10_:Boolean = param7 == true;
         if(param3 != "")
         {
            _loc11_ = BMExternalAssetsManager.getInstance().getAsset("items1",param3);
            _loc12_ = [param4];
            if(_loc11_.loading)
            {
               BMExternalAssetsManager.getInstance().modifyExternalAssetDuplicationContainer(_loc11_,true,0,this.avatarLoadingComplete,_loc12_);
            }
            else
            {
               this.avatarLoadingComplete(_loc11_,_loc12_);
            }
         }
         else
         {
            this._totalMechs = param1.length;
            _loc13_ = 0;
            while(_loc13_ < param1.length)
            {
               this.mechViews[_loc13_] = new BMMechView();
               this.mechViewReflections[_loc13_] = new BMMechView();
               _loc13_++;
            }
            _loc13_ = int(param1.length - 1);
            while(_loc13_ >= 0)
            {
               if(param1[_loc13_].torso != 0)
               {
                  _loc9_ = false;
                  this.createMech(_loc13_,param1[_loc13_],param2,this.mechViews[_loc13_],_loc9_,_loc10_);
                  this.mechViews[_loc13_].activateBreathing();
                  _loc9_ = true;
                  this.createMech(_loc13_,param1[_loc13_],param2,this.mechViewReflections[_loc13_],_loc9_,_loc10_);
               }
               _loc13_--;
            }
         }
         param6 = Math.max(1,param6);
         param6 = Math.min(9,param6);
         this.mcMissionBackground.gotoAndStop("theme" + param6);
         this.displayAmount(param5,param8);
      }
      
      private function displayAmount(param1:uint, param2:Boolean) : void
      {
         if(param2)
         {
            this.txtAmount.text = "";
            this.mcAmountBackground.visible = false;
         }
         else
         {
            this.txtAmount.text = "x" + param1;
         }
      }
      
      private function avatarLoadingComplete(param1:MovieClip, param2:Array) : void
      {
         var _loc3_:uint = 0;
         _loc3_ = uint(param2[0]);
         param1.width = this.mcSizer.width;
         param1.height = this.mcSizer.height;
         this.mcMechHolder.x = this.mcSizer.x + this.mcSizer.width;
         this.mcMechHolder.y = this.mcSizer.y;
         BMDataManager.getInstance().colorItemGrp(param1,_loc3_);
         this.mcMechHolder.addChild(param1);
         this.mcMechHolder.scaleX *= -1;
      }
      
      private function createMech(param1:uint, param2:BMMechStructure, param3:BMMechViewManualColors, param4:BMMechView, param5:Boolean, param6:Boolean) : void
      {
         var _loc7_:uint = BMDataManager.getInstance().player2PlayerID;
         var _loc8_:uint = 100;
         param4.initialize(_loc7_,"hanger",BMMechStructure.ITEM_TYPE_ITEM_ID);
         param4.setManualColors(param3);
         var _loc9_:Array = [param1,param5,param6];
         param4.buildMech(param2,this.onBuildMechComplete,_loc9_);
      }
      
      private function onBuildMechComplete(param1:Array) : void
      {
         var _loc5_:BMMechView = null;
         var _loc13_:Number = NaN;
         var _loc2_:uint = uint(param1[0]);
         var _loc3_:Boolean = Boolean(param1[1]);
         var _loc4_:Boolean = Boolean(param1[2]);
         if(_loc3_)
         {
            _loc5_ = this.mechViewReflections[_loc2_];
         }
         else
         {
            _loc5_ = this.mechViews[_loc2_];
         }
         var _loc6_:Number = 0.46;
         if(_loc4_)
         {
            _loc6_ += 0.05;
         }
         _loc5_.scaleX = _loc6_;
         _loc5_.scaleY = _loc6_;
         var _loc7_:Number = this.mcMechHolder.y * 0.95;
         if(_loc5_.height > _loc7_)
         {
            _loc13_ = Math.abs(1 - (_loc5_.height - _loc7_) / _loc5_.height);
            _loc5_.width *= _loc13_;
            _loc5_.height *= _loc13_;
            _loc6_ *= _loc13_;
         }
         _loc5_.scaleX *= -1;
         var _loc8_:Number = 1;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:Color = new Color();
         var _loc12_:Number = 0;
         switch(_loc2_)
         {
            case 0:
               if(this._totalMechs == 2)
               {
                  _loc9_ = -15;
               }
               else if(this._totalMechs == 3)
               {
                  _loc9_ = -15;
               }
               break;
            case 1:
               _loc8_ = 0.9;
               if(this._totalMechs == 2)
               {
                  _loc9_ = 15;
                  _loc10_ = 2;
               }
               else
               {
                  _loc9_ = 5;
                  _loc10_ = 3;
               }
               _loc12_ = 0.3;
               break;
            case 2:
               _loc8_ = 0.8;
               _loc9_ = 15;
               _loc10_ = 4;
               _loc12_ = 0.6;
         }
         if(_loc12_ > 0)
         {
            _loc11_.setTint(0,_loc12_);
            _loc5_.transform.colorTransform = _loc11_;
            _loc5_.transform.colorTransform = _loc11_;
         }
         _loc5_.scaleX *= _loc8_;
         _loc5_.scaleY *= _loc8_;
         _loc9_ /= Math.abs(_loc5_.scaleX);
         _loc10_ /= Math.abs(_loc5_.scaleX);
         _loc5_.x += _loc9_;
         if(_loc3_)
         {
            _loc5_.scaleY *= -1;
            _loc5_.y = (_loc5_.mechSizer.height + _loc5_.mechSizer.y) * _loc6_ - 10;
         }
         else
         {
            _loc5_.resetYPos();
         }
         if(_loc3_)
         {
            _loc5_.y -= _loc10_ * 2;
         }
         else
         {
            _loc5_.y -= _loc10_;
         }
         if(_loc3_)
         {
            this.mcMechReflectionHolder.addChild(_loc5_);
         }
         else
         {
            this.mcMechHolder.addChild(_loc5_);
         }
      }
      
      public function triggerMech() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < this.mechViews.length)
         {
            if(this.mechViews[_loc1_].mechStructure != null)
            {
               this.mechViews[_loc1_].onEnterFrameTrigger();
            }
            _loc1_++;
         }
      }
      
      private function removeMechViews() : void
      {
         var _loc1_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < this.mechViews.length)
         {
            if(this.mechViews[_loc1_].mechStructure != null)
            {
               this.mechViews[_loc1_].removeMe();
               this.mechViews[_loc1_] = null;
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.mechViewReflections.length)
         {
            if(this.mechViewReflections[_loc1_].mechStructure != null)
            {
               this.mechViewReflections[_loc1_].removeMe();
               this.mechViewReflections[_loc1_] = null;
            }
            _loc1_++;
         }
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
         this.removeMechViews();
      }
   }
}

