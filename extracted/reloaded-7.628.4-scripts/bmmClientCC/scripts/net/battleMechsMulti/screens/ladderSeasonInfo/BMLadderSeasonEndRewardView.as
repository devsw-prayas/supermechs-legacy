package net.battleMechsMulti.screens.ladderSeasonInfo
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Linear;
   import fl.motion.Color;
   import flash.display.BlendMode;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.shop.BMGachaMachineData;
   import net.battleMechsMulti.managers.shop.BMShopManager;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   import net.battleMechsMulti.mobiles.itemList.BMInterfaceItemView;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2734")]
   public class BMLadderSeasonEndRewardView extends BMBaseClass implements BMInterfaceItemView
   {
      
      public var mcSizer_fullSize:Sprite;
      
      public var mcSizer_rankIcon:Sprite;
      
      public var txtLadderRank:TextField;
      
      public var mcRewardHolder:Sprite;
      
      public var mcBackgroundImage:Sprite;
      
      public var mcRays:Sprite;
      
      public var mcGlow:Sprite;
      
      public var mcReflectionHolder:Sprite;
      
      public var mcReflectionFloor:Sprite;
      
      private var _disabled:Boolean = false;
      
      private var _ID:uint;
      
      public function BMLadderSeasonEndRewardView()
      {
         super();
         generateSingletonClassesPointers();
      }
      
      public function setData(param1:Object) : void
      {
         var _loc2_:BMLadderSeasonEndRewardData = null;
         var _loc5_:Sprite = null;
         var _loc6_:Number = NaN;
         var _loc7_:Array = null;
         var _loc10_:Number = NaN;
         var _loc11_:uint = 0;
         var _loc12_:BMGachaMachineData = null;
         var _loc13_:Array = null;
         var _loc14_:MovieClip = null;
         var _loc15_:MovieClip = null;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc18_:Color = null;
         var _loc19_:uint = 0;
         var _loc20_:Number = NaN;
         _loc2_ = param1 as BMLadderSeasonEndRewardData;
         this.txtLadderRank.text = String(_loc2_.ladderLevelRequired);
         var _loc3_:uint = dataM.getLadderRankIconNumber(_loc2_.ladderLevelRequired);
         var _loc4_:Number = this.mcSizer_rankIcon.width;
         _loc5_ = externalAssetsM.getAsset("general","Grp_rank" + _loc3_,_loc4_,_loc4_);
         _loc5_.x = this.mcSizer_rankIcon.x;
         _loc5_.y = this.mcSizer_rankIcon.y;
         addChild(_loc5_);
         this.mcRays.mouseEnabled = false;
         this.mcRays.mouseChildren = false;
         if(_loc2_.playerIsHere)
         {
            this.mcRays.visible = true;
            TweenMax.to(this.mcRays,16,{
               "rotation":360,
               "ease":Linear.ease,
               "repeat":-1
            });
         }
         else
         {
            this.mcRays.visible = false;
         }
         this._ID = param1.ID;
         _loc7_ = [0];
         if(_loc2_.rewardGachaMachineIDs.length > 1)
         {
            _loc7_.push(-32);
            if(_loc2_.rewardGachaMachineIDs.length > 2)
            {
               _loc6_ = 2;
               while(_loc6_ < _loc2_.rewardGachaMachineIDs.length)
               {
                  _loc10_ = Math.abs(_loc7_[_loc6_ - 1]) - Math.abs(_loc7_[_loc6_ - 2]);
                  _loc7_.push((_loc10_ + _loc10_ * 0.85) * -1);
                  _loc6_++;
               }
            }
         }
         _loc6_ = _loc2_.rewardGachaMachineIDs.length - 1;
         while(_loc6_ >= 0)
         {
            _loc11_ = uint(_loc2_.rewardGachaMachineIDs[_loc6_]);
            _loc12_ = dataM.gachaMachinesDB[_loc11_];
            _loc13_ = BMShopManager.gi().getBoxGrpForVisualID(_loc12_.imageID,-1);
            _loc14_ = _loc13_[0];
            _loc15_ = _loc13_[1];
            _loc16_ = this.mcSizer_fullSize.width * 0.9;
            _loc14_.mcInnerGlow.parent.removeChild(_loc14_.mcInnerGlow);
            _loc14_.mcOuterGlow.parent.removeChild(_loc14_.mcOuterGlow);
            _loc17_ = 2.4;
            _loc14_.scaleX /= _loc17_;
            _loc14_.scaleY /= _loc17_;
            _loc14_.y = _loc7_[_loc6_];
            if(_loc6_ > 0)
            {
               _loc18_ = new Color();
               _loc19_ = 0;
               _loc20_ = 0.15 * _loc6_;
               _loc18_.setTint(_loc19_,_loc20_);
               _loc14_.transform.colorTransform = _loc18_;
            }
            this.mcRewardHolder.addChild(_loc14_);
            _loc15_.scaleX /= _loc17_;
            _loc15_.scaleY /= _loc17_;
            this.mcReflectionHolder.addChild(_loc15_);
            if(_loc2_.playerIsHere == false)
            {
               if(_loc14_.mcOverlayEffect != null)
               {
                  _loc14_.mcOverlayEffect.visible = true;
                  _loc14_.mcOverlayEffect.blendMode = BlendMode.OVERLAY;
               }
            }
            _loc6_--;
         }
         var _loc8_:Number = (_loc2_.totalInList - 1 - this.ID) * 14;
         this.mcSizer_fullSize.height -= _loc8_;
         this.mcRewardHolder.y -= _loc8_;
         this.mcReflectionHolder.y -= _loc8_ + 3;
         this.mcReflectionFloor.y -= _loc8_;
         y += _loc8_;
         var _loc9_:Number = 1 + this._ID * 0.06;
         this.mcGlow.scaleX = _loc9_;
         this.mcGlow.scaleY = _loc9_;
         this.mcGlow.y = this.mcRewardHolder.y - this.mcGlow.height * 0.3;
         addEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStage);
         addEventListener(Event.ADDED_TO_STAGE,this.addedToStage);
      }
      
      public function isEnabled() : Boolean
      {
         return this._disabled == false;
      }
      
      public function set disabled(param1:Boolean) : void
      {
         this._disabled = param1;
      }
      
      public function get ID() : uint
      {
         return this._ID;
      }
      
      public function getItemWidth() : Number
      {
         return this.mcSizer_fullSize.width;
      }
      
      public function getItemHeight() : Number
      {
         return this.mcSizer_fullSize.height;
      }
      
      private function removedFromStage(param1:Event) : void
      {
         TweenMax.killTweensOf(this.mcRays);
      }
      
      private function addedToStage(param1:Event) : void
      {
         if(this.mcRays.visible)
         {
            TweenMax.to(this.mcRays,16,{
               "rotation":360,
               "ease":Linear.ease,
               "repeat":-1
            });
         }
      }
      
      public function removeMe() : void
      {
      }
   }
}

