package net.battleMechsMulti.screens.mainMenu
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Linear;
   import fl.motion.Color;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Point;
   import net.battleMechsMulti.mobiles.unlockedMechSlotsResolver.BMUnlockedMechSlotsResolver;
   import net.battleMechsMulti.utils.BMPubSub;
   
   public class CarouselAnimator extends MovieClip
   {
      
      public static const ON_MOVE_COMPLETE:String = "ON_MOVE_COMPLETE";
      
      private static var LOCKED_MECH_TINT:Number = 0.9;
      
      private var _items:Vector.<MovieClip> = new Vector.<MovieClip>();
      
      private var _radius:Point;
      
      private var _scale:Number = 0.45;
      
      private var _tint:Number = LOCKED_MECH_TINT;
      
      private var _angle:Number = -90;
      
      private var _moveToAngle:* = 0;
      
      private var _selectedIndex:int = 0;
      
      private var _maxAngleForMove:* = 180;
      
      private var _forceLockedVisualEffectByMechID:Array = new Array();
      
      public function CarouselAnimator()
      {
         super();
      }
      
      public function setItems(param1:Vector.<MovieClip>) : *
      {
         this._items = param1;
         this.angle = -90;
         this._moveToAngle = this.angle;
      }
      
      public function set angle(param1:Number) : void
      {
         this._angle = param1;
         this.setAllObjectsByAngle();
      }
      
      private function setAllObjectsByAngle() : void
      {
         var _loc1_:Number = 360 / this._items.length;
         var _loc2_:int = 0;
         while(_loc2_ < this._items.length)
         {
            this.setObjectAt(this._items[_loc2_],this._angle + _loc1_ * _loc2_);
            _loc2_++;
         }
      }
      
      public function get angle() : Number
      {
         return this._angle;
      }
      
      private function setObjectAt(param1:MovieClip, param2:Number) : *
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         _loc3_ = param2 * (Math.PI / 180);
         param1.x = this._radius.x * Math.cos(_loc3_);
         param1.y = this._radius.y * Math.sin(_loc3_);
         _loc4_ = 1 - (Math.sin(_loc3_) + 1) / 2;
         var _loc5_:Number = 1 - this._scale + this._scale * _loc4_;
         param1.scaleX = _loc5_;
         param1.scaleY = _loc5_;
         var _loc6_:Number = this._tint * (1 - _loc4_);
         if(BMUnlockedMechSlotsResolver.isMechSlotLocked(param1.mechID) || this.isMechForcedToLockedVisualEffect(param1.mechID))
         {
            _loc6_ = LOCKED_MECH_TINT;
         }
         var _loc7_:Color = new Color();
         _loc7_.setTint(0,_loc6_);
         param1.mcAssets.transform.colorTransform = _loc7_;
         addChildAt(param1,_loc4_ * numChildren);
      }
      
      public function set radius(param1:Point) : void
      {
         this._radius = param1;
      }
      
      public function set scale(param1:Number) : void
      {
         this._scale = param1;
      }
      
      public function set tint(param1:Number) : void
      {
         this._tint = param1;
      }
      
      public function get selectedIndex() : int
      {
         return this._selectedIndex;
      }
      
      public function get selectedMechID() : int
      {
         return this._items[this._selectedIndex].mechID;
      }
      
      public function set selectedIndex(param1:int) : void
      {
         TweenMax.killTweensOf(this);
         this._selectedIndex = this.modIndex(param1);
         this.angle = -1 * this._selectedIndex * 360 / this._items.length - 90;
         this._moveToAngle = this.angle;
      }
      
      public function getItemByIndex(param1:int) : MovieClip
      {
         param1 = this.modIndex(param1);
         return this._items[param1];
      }
      
      public function getSelectedItem() : MovieClip
      {
         return this._items[this._selectedIndex];
      }
      
      public function setSelectedItemLightOn() : void
      {
         this._items[this._selectedIndex].mcAssets.gotoAndStop("lightOn");
      }
      
      public function setSelectedItemLightOff() : void
      {
         this._items[this._selectedIndex].mcAssets.gotoAndStop("lightOff");
      }
      
      private function isMechForcedToLockedVisualEffect(param1:uint) : Boolean
      {
         if(this._forceLockedVisualEffectByMechID[param1] == null)
         {
            return false;
         }
         return this._forceLockedVisualEffectByMechID[param1];
      }
      
      public function forceLockedVisualEffectForMech(param1:uint) : void
      {
         this._forceLockedVisualEffectByMechID[param1] = true;
      }
      
      public function removeForceLockedVisualEffectForMechs() : void
      {
         this._forceLockedVisualEffectByMechID = new Array();
         this.setAllObjectsByAngle();
      }
      
      public function modIndex(param1:int) : int
      {
         if(param1 < 0)
         {
            param1 = this._items.length + param1;
         }
         return int(param1 % this._items.length);
      }
      
      public function moveBy(param1:int, param2:Number = 1) : void
      {
         var _loc3_:Number = this._moveToAngle - param1 * 360 / this._items.length;
         if(Math.abs(_loc3_ - this.angle) < this._maxAngleForMove)
         {
            this._selectedIndex = this.modIndex(this._selectedIndex + param1);
            this._moveToAngle = _loc3_;
            this.moveToAngle(this._moveToAngle,param2);
         }
      }
      
      public function moveToAngle(param1:Number, param2:Number = 1) : *
      {
         TweenMax.killTweensOf(this);
         TweenMax.to(this,param2,{
            "angle":param1,
            "onComplete":this.onMoveComplete
         });
      }
      
      private function onMoveComplete() : void
      {
         BMPubSub.pub(BMPubSub.MESSAGE_MAIN_MENU_CAROUSEL_ANIMATION_COMPLETED);
         dispatchEvent(new Event(ON_MOVE_COMPLETE));
      }
      
      public function doRotateAnimation(param1:Number) : *
      {
         TweenMax.killTweensOf(this);
         TweenMax.to(this,param1,{
            "angle":this.angle + 360,
            "repeat":-1,
            "ease":Linear.ease
         });
      }
   }
}

