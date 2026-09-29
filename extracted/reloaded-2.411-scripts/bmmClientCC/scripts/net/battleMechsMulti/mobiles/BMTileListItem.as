package net.battleMechsMulti.mobiles
{
   import fl.motion.Color;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import net.battleMechsMulti.mobiles.buttons.BMButtonCore;
   
   public class BMTileListItem extends MovieClip
   {
      
      private var _tileID:Number;
      
      private var _width:Number;
      
      private var _height:Number;
      
      private var _item:BMItem;
      
      private var _backgroundColor:uint;
      
      private var _frontColor:uint;
      
      private var _lineFrameColor:uint;
      
      private var _animatedMarkerAlpha:Number;
      
      private var _animatedMarkerAlphaDelay:Number;
      
      private var _animatedMarkerAlphaChange:Number;
      
      private var _animatedMarkerActive:Boolean;
      
      private var _animatedMarkerType:String;
      
      private var _enabled:Boolean;
      
      private var _mouseClickedFunction:Function;
      
      private var _mouseDownFunction:Function;
      
      private var _mouseUpFunction:Function;
      
      private var _mouseOverFunction:Function;
      
      private var _mouseOutFunction:Function;
      
      private var _removed:Boolean = false;
      
      private var _runAsMobile:Boolean;
      
      private var buttonCore:BMButtonCore;
      
      private var mcBackgroundColor:Sprite;
      
      private var mcFrontColor:Sprite;
      
      private var mcItemHolder:Sprite;
      
      private var mcDisabledEffect:Sprite;
      
      private var mcSelectedEffect:Sprite;
      
      private var mcMouseOverEffect:Sprite;
      
      public var mcMouseHitArea:Sprite;
      
      private var mcMarker:MovieClip;
      
      private var mcAnimatedMarker:Sprite;
      
      private var mcLineFrame:Sprite;
      
      private var ANIMATED_MARKER_ALPHA_MAX:Number = 0.3;
      
      private var ANIMATED_MARKER_ALPHA_CHANGE:Number = 0.01;
      
      public var contentLoaded:Boolean = true;
      
      public var contentData_playerItemID:Number;
      
      public var contentData_justBought:Boolean;
      
      public var contentData_itemID:Number;
      
      public var contentData_tileListType:String;
      
      public var contentData_removeHoldersMC:Boolean = false;
      
      public var contentData_removeColorMC:Boolean = false;
      
      public var contentData_clicked:Function;
      
      public var contentData_mouseDown:Function;
      
      public var contentData_mouseUp:Function;
      
      public var contentData_mouseOver:Function;
      
      public var contentData_mouseOut:Function;
      
      public var contentData_dataType:String;
      
      public var contentData_name:String;
      
      public var contentData_createFunction:Function;
      
      public var itemsThatNeedsAddingAndRemoving:Array = new Array();
      
      public function BMTileListItem()
      {
         super();
      }
      
      public function initialize(param1:Number, param2:Number, param3:BMItem, param4:String, param5:String, param6:String, param7:Number, param8:Function, param9:Function, param10:Function, param11:Function, param12:Function, param13:Boolean) : void
      {
         var _loc15_:Number = NaN;
         this._tileID = -1;
         this._item = param3;
         this._backgroundColor = 0;
         if(param4 != "")
         {
            this._backgroundColor = uint("0x" + param4);
         }
         this._frontColor = 0;
         if(param5 != "")
         {
            this._frontColor = uint("0x" + param5);
         }
         this._lineFrameColor = 0;
         if(param6 != "")
         {
            this._lineFrameColor = uint("0x" + param6);
         }
         if(this._backgroundColor != 0)
         {
            this.mcBackgroundColor = new Sprite();
            addChild(this.mcBackgroundColor);
         }
         this.mcItemHolder = new Sprite();
         addChild(this.mcItemHolder);
         this.mcItemHolder.addChild(this._item);
         this._enabled = true;
         this._mouseClickedFunction = param8;
         this._mouseDownFunction = param9;
         this._mouseUpFunction = param10;
         this._mouseOverFunction = param11;
         this._mouseOutFunction = param12;
         this._width = param1;
         this._height = param2;
         this._runAsMobile = param13;
         this.mcDisabledEffect = new Sprite();
         if(this._runAsMobile == false)
         {
            this.mcMouseOverEffect = new Sprite();
            this.mcSelectedEffect = new Sprite();
         }
         if(param7 > 0)
         {
            _loc15_ = param7;
            if(_loc15_ > this._width / 2)
            {
               _loc15_ = Math.floor(this._width / 2);
               if(_loc15_ > this._height / 2)
               {
                  _loc15_ = Math.floor(this._height / 2);
               }
            }
            this.mcDisabledEffect.graphics.beginFill(0,0.7);
            this.mcDisabledEffect.graphics.lineStyle(0,0,0);
            this.mcDisabledEffect.graphics.lineTo(_loc15_,0);
            this.mcDisabledEffect.graphics.lineTo(this._width - _loc15_,0);
            this.mcDisabledEffect.graphics.lineTo(this._width,_loc15_);
            this.mcDisabledEffect.graphics.lineTo(this._width,this._height - _loc15_);
            this.mcDisabledEffect.graphics.lineTo(this._width - _loc15_,this._height);
            this.mcDisabledEffect.graphics.lineTo(_loc15_,this._height);
            this.mcDisabledEffect.graphics.lineTo(0,this._height - _loc15_);
            this.mcDisabledEffect.graphics.lineTo(0,_loc15_);
            this.mcDisabledEffect.graphics.lineTo(_loc15_,0);
            this.mcDisabledEffect.graphics.endFill();
            if(this._runAsMobile == false)
            {
               this.mcMouseOverEffect.graphics.beginFill(16777215,0.2);
               this.mcMouseOverEffect.graphics.lineStyle(0,0,0);
               this.mcMouseOverEffect.graphics.lineTo(_loc15_,0);
               this.mcMouseOverEffect.graphics.lineTo(this._width - _loc15_,0);
               this.mcMouseOverEffect.graphics.lineTo(this._width,_loc15_);
               this.mcMouseOverEffect.graphics.lineTo(this._width,this._height - _loc15_);
               this.mcMouseOverEffect.graphics.lineTo(this._width - _loc15_,this._height);
               this.mcMouseOverEffect.graphics.lineTo(_loc15_,this._height);
               this.mcMouseOverEffect.graphics.lineTo(0,this._height - _loc15_);
               this.mcMouseOverEffect.graphics.lineTo(0,_loc15_);
               this.mcMouseOverEffect.graphics.lineTo(_loc15_,0);
               this.mcMouseOverEffect.graphics.endFill();
               this.mcSelectedEffect.graphics.beginFill(8251886,0.2);
               this.mcSelectedEffect.graphics.lineStyle(0,0,0);
               this.mcSelectedEffect.graphics.lineTo(_loc15_,0);
               this.mcSelectedEffect.graphics.lineTo(this._width - _loc15_,0);
               this.mcSelectedEffect.graphics.lineTo(this._width,_loc15_);
               this.mcSelectedEffect.graphics.lineTo(this._width,this._height - _loc15_);
               this.mcSelectedEffect.graphics.lineTo(this._width - _loc15_,this._height);
               this.mcSelectedEffect.graphics.lineTo(_loc15_,this._height);
               this.mcSelectedEffect.graphics.lineTo(0,this._height - _loc15_);
               this.mcSelectedEffect.graphics.lineTo(0,_loc15_);
               this.mcSelectedEffect.graphics.lineTo(_loc15_,0);
               this.mcSelectedEffect.graphics.endFill();
            }
         }
         else
         {
            this.mcDisabledEffect.graphics.beginFill(0,0.7);
            this.mcDisabledEffect.graphics.drawRect(0,0,this._width,this._height);
            this.mcDisabledEffect.graphics.endFill();
            if(this._runAsMobile == false)
            {
               this.mcMouseOverEffect.graphics.beginFill(16777215,0.2);
               this.mcMouseOverEffect.graphics.drawRect(0,0,this._width,this._height);
               this.mcMouseOverEffect.graphics.endFill();
               this.mcSelectedEffect.graphics.beginFill(8251886,0.2);
               this.mcSelectedEffect.graphics.drawRect(0,0,this._width,this._height);
               this.mcSelectedEffect.graphics.endFill();
            }
         }
         this.mcAnimatedMarker = new Sprite();
         this._animatedMarkerAlpha = 0;
         this._animatedMarkerAlphaDelay = 0;
         this._animatedMarkerAlphaChange = this.ANIMATED_MARKER_ALPHA_CHANGE;
         this._animatedMarkerActive = false;
         addChild(this.mcDisabledEffect);
         if(this._runAsMobile == false)
         {
            addChild(this.mcMouseOverEffect);
            addChild(this.mcSelectedEffect);
         }
         this.mcMouseHitArea = new Sprite();
         this.mcMouseHitArea.graphics.beginFill(0,0);
         this.mcMouseHitArea.graphics.drawRect(0,0,this._width,this._height);
         this.mcMouseHitArea.graphics.endFill();
         this.buttonCore = new BMButtonCore();
         var _loc14_:Function = null;
         if(this._mouseClickedFunction != null)
         {
            _loc14_ = this.hitAreaMouseClicked;
         }
         this.buttonCore.initialize(this.mcMouseHitArea,_loc14_,null,this.hitAreaMouseDown,this.hitAreaMouseUp,this.hitAreaMouseOver,this.hitAreaMouseOut,this._runAsMobile);
         if(this._runAsMobile == false)
         {
            this.buttonCore.setMouseOverEffect(this.mcMouseOverEffect);
            this.buttonCore.setSelectedEffect(this.mcSelectedEffect);
         }
         this.buttonCore.setDisabledEffect(this.mcDisabledEffect);
         this.mcLineFrame = new Sprite();
         this.mcLineFrame.mouseEnabled = false;
         this.mcLineFrame.mouseChildren = false;
         if(this._frontColor != 0)
         {
            this.mcFrontColor = new Sprite();
            addChild(this.mcFrontColor);
         }
         addChild(this.mcLineFrame);
         addChild(this.mcAnimatedMarker);
         this.addLineFrame(this._lineFrameColor,2,1,true);
         this.addBackgroundColor();
         this.addFrontColor();
         addChild(this.mcMouseHitArea);
      }
      
      public function addLineFrame(param1:uint, param2:Number, param3:Number, param4:Boolean) : void
      {
         var _loc5_:uint = 0;
         var _loc6_:Number = NaN;
         if(param1 != 0)
         {
            _loc5_ = param1;
            _loc6_ = 3;
            this.mcLineFrame.graphics.lineStyle(2,param1,param3);
            if(param4)
            {
               this.mcLineFrame.graphics.moveTo(param2,param2 + _loc6_);
               this.mcLineFrame.graphics.lineTo(param2 + _loc6_,param2);
               this.mcLineFrame.graphics.lineTo(this._width - param2 - _loc6_,param2);
               this.mcLineFrame.graphics.lineTo(this._width - param2,param2 + _loc6_);
               this.mcLineFrame.graphics.lineTo(this._width - param2,this._height - param2 - _loc6_);
               this.mcLineFrame.graphics.lineTo(this._width - param2 - _loc6_,this._height - param2);
               this.mcLineFrame.graphics.lineTo(param2 + _loc6_,this._height - param2);
               this.mcLineFrame.graphics.lineTo(param2,this._height - param2 - _loc6_);
               this.mcLineFrame.graphics.lineTo(param2,param2 + _loc6_);
            }
            else
            {
               this.mcLineFrame.graphics.moveTo(param2,param2);
               this.mcLineFrame.graphics.lineTo(this._width - param2,param2);
               this.mcLineFrame.graphics.lineTo(this._width - param2,this._height - param2);
               this.mcLineFrame.graphics.lineTo(param2,this._height - param2);
               this.mcLineFrame.graphics.lineTo(param2,param2);
            }
         }
         else
         {
            this.mcLineFrame.graphics.clear();
         }
      }
      
      private function addBackgroundColor() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         if(this._backgroundColor != 0)
         {
            _loc1_ = 3;
            _loc2_ = 2;
            this.mcBackgroundColor.graphics.beginFill(this._backgroundColor,1);
            this.mcBackgroundColor.graphics.lineStyle(2,0,0);
            this.mcBackgroundColor.graphics.moveTo(_loc2_,_loc2_ + _loc1_);
            this.mcBackgroundColor.graphics.lineTo(_loc2_ + _loc1_,_loc2_);
            this.mcBackgroundColor.graphics.lineTo(this._width - _loc2_ - _loc1_,_loc2_);
            this.mcBackgroundColor.graphics.lineTo(this._width - _loc2_,_loc2_ + _loc1_);
            this.mcBackgroundColor.graphics.lineTo(this._width - _loc2_,this._height - _loc2_ - _loc1_);
            this.mcBackgroundColor.graphics.lineTo(this._width - _loc2_ - _loc1_,this._height - _loc2_);
            this.mcBackgroundColor.graphics.lineTo(_loc2_ + _loc1_,this._height - _loc2_);
            this.mcBackgroundColor.graphics.lineTo(_loc2_,this._height - _loc2_ - _loc1_);
            this.mcBackgroundColor.graphics.lineTo(_loc2_,_loc2_ + _loc1_);
            this.mcBackgroundColor.graphics.endFill();
         }
      }
      
      private function addFrontColor() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         if(this._frontColor != 0)
         {
            _loc1_ = 3;
            _loc2_ = 2;
            this.mcFrontColor.graphics.beginFill(this._frontColor,0.3);
            this.mcFrontColor.graphics.lineStyle(2,0,0);
            this.mcFrontColor.graphics.moveTo(_loc2_,_loc2_ + _loc1_);
            this.mcFrontColor.graphics.lineTo(_loc2_ + _loc1_,_loc2_);
            this.mcFrontColor.graphics.lineTo(this._width - _loc2_ - _loc1_,_loc2_);
            this.mcFrontColor.graphics.lineTo(this._width - _loc2_,_loc2_ + _loc1_);
            this.mcFrontColor.graphics.lineTo(this._width - _loc2_,this._height - _loc2_ - _loc1_);
            this.mcFrontColor.graphics.lineTo(this._width - _loc2_ - _loc1_,this._height - _loc2_);
            this.mcFrontColor.graphics.lineTo(_loc2_ + _loc1_,this._height - _loc2_);
            this.mcFrontColor.graphics.lineTo(_loc2_,this._height - _loc2_ - _loc1_);
            this.mcFrontColor.graphics.lineTo(_loc2_,_loc2_ + _loc1_);
            this.mcFrontColor.graphics.endFill();
         }
      }
      
      private function hitAreaMouseClicked() : void
      {
         if(this._mouseClickedFunction != null)
         {
            this.returnParams(this._mouseClickedFunction);
         }
      }
      
      private function hitAreaMouseDown() : void
      {
         if(this._mouseDownFunction != null)
         {
            this.returnParams(this._mouseDownFunction);
         }
      }
      
      private function hitAreaMouseUp() : void
      {
         if(this._mouseUpFunction != null)
         {
            this.returnParams(this._mouseUpFunction);
         }
      }
      
      private function hitAreaMouseOver() : void
      {
         if(this._mouseOverFunction != null)
         {
            this.returnParams(this._mouseOverFunction);
         }
      }
      
      private function hitAreaMouseOut() : void
      {
         if(this._mouseOutFunction != null)
         {
            this.returnParams(this._mouseOutFunction);
         }
      }
      
      private function returnParams(param1:*) : void
      {
         param1(this._tileID,this._item.ID);
      }
      
      public function addMarker(param1:MovieClip) : void
      {
         this.mcMarker = param1;
         this.mcMarker.width = width;
         this.mcMarker.height = height;
         addChild(this.mcMarker);
      }
      
      public function removeMarker() : void
      {
         if(this.mcMarker != null)
         {
            if(this.mcMarker.parent != null)
            {
               this.mcMarker.parent.removeChild(this.mcMarker);
            }
            this.mcMarker = null;
         }
      }
      
      public function activateAnimatedMarker(param1:String, param2:Number) : void
      {
         if(this._animatedMarkerActive == false)
         {
            this._animatedMarkerType = param1;
            this._animatedMarkerAlphaDelay = param2;
            this._animatedMarkerActive = true;
            addEventListener(Event.ENTER_FRAME,this.animatedMarkerOnEnterFrame);
         }
      }
      
      public function deactivateAnimatedMarker(param1:String) : void
      {
         removeEventListener(Event.ENTER_FRAME,this.animatedMarkerOnEnterFrame);
         this._animatedMarkerAlpha = 0;
         this._animatedMarkerActive = false;
         this.drawAnimatedMarker();
      }
      
      private function animatedMarkerOnEnterFrame(param1:Event) : void
      {
         if(this._animatedMarkerAlphaDelay > 0)
         {
            --this._animatedMarkerAlphaDelay;
         }
         else
         {
            this._animatedMarkerAlpha += this._animatedMarkerAlphaChange;
            if(this._animatedMarkerAlpha >= this.ANIMATED_MARKER_ALPHA_MAX)
            {
               this._animatedMarkerAlpha = this.ANIMATED_MARKER_ALPHA_MAX;
               this._animatedMarkerAlphaChange *= -1;
            }
            else if(this._animatedMarkerAlpha <= 0)
            {
               this._animatedMarkerAlpha = 0;
               this._animatedMarkerAlphaChange *= -1;
            }
            this.drawAnimatedMarker();
         }
      }
      
      private function drawAnimatedMarker() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         switch(this._animatedMarkerType)
         {
            case "regular":
               this.mcAnimatedMarker.graphics.clear();
               this.mcAnimatedMarker.graphics.beginFill(65280,this._animatedMarkerAlpha);
               this.mcAnimatedMarker.graphics.drawRect(0,0,this._width,this._height);
               this.mcAnimatedMarker.graphics.endFill();
               this.mcAnimatedMarker.graphics.lineStyle(0,65280,this._animatedMarkerAlpha * 2);
               this.mcAnimatedMarker.graphics.moveTo(1,1);
               this.mcAnimatedMarker.graphics.lineTo(this._width - 1,1);
               this.mcAnimatedMarker.graphics.lineTo(this._width - 1,this._height - 1);
               this.mcAnimatedMarker.graphics.lineTo(1,this._height - 1);
               this.mcAnimatedMarker.graphics.lineTo(1,1);
               break;
            case "special":
               _loc1_ = 3;
               _loc2_ = 2;
               this.mcAnimatedMarker.graphics.clear();
               this.mcAnimatedMarker.graphics.beginFill(65280,this._animatedMarkerAlpha);
               this.mcAnimatedMarker.graphics.lineStyle(2,65280,this._animatedMarkerAlpha * 2);
               this.mcAnimatedMarker.graphics.moveTo(_loc2_,_loc2_ + _loc1_);
               this.mcAnimatedMarker.graphics.lineTo(_loc2_ + _loc1_,_loc2_);
               this.mcAnimatedMarker.graphics.lineTo(this._width - _loc2_ - _loc1_,_loc2_);
               this.mcAnimatedMarker.graphics.lineTo(this._width - _loc2_,_loc2_ + _loc1_);
               this.mcAnimatedMarker.graphics.lineTo(this._width - _loc2_,this._height - _loc2_ - _loc1_);
               this.mcAnimatedMarker.graphics.lineTo(this._width - _loc2_ - _loc1_,this._height - _loc2_);
               this.mcAnimatedMarker.graphics.lineTo(_loc2_ + _loc1_,this._height - _loc2_);
               this.mcAnimatedMarker.graphics.lineTo(_loc2_,this._height - _loc2_ - _loc1_);
               this.mcAnimatedMarker.graphics.lineTo(_loc2_,_loc2_ + _loc1_);
               this.mcAnimatedMarker.graphics.endFill();
         }
      }
      
      public function enableMe() : void
      {
         this._enabled = true;
         alpha = 1;
         this.buttonCore.enableMe();
      }
      
      public function disableMe(param1:Boolean) : void
      {
         this._enabled = false;
         this.buttonCore.disableMe(param1);
      }
      
      public function isEnabled() : Boolean
      {
         return this._enabled;
      }
      
      public function addDisabledEffect() : void
      {
         this.buttonCore.addDisabledEffect();
      }
      
      public function removeDisabledEffect() : void
      {
         this.buttonCore.removeDisabledEffect();
      }
      
      public function setItemTint(param1:Number) : void
      {
         var _loc2_:Color = new Color();
         _loc2_.setTint(0,param1);
         this._item.transform.colorTransform = _loc2_;
      }
      
      public function showMe() : void
      {
         visible = true;
      }
      
      public function hideMe() : void
      {
         visible = false;
      }
      
      public function changeItem(param1:BMItem) : void
      {
         this._item.removeMe();
         this._item = null;
         this._item = param1;
         this.mcItemHolder.addChild(this._item);
      }
      
      public function changeMouseOverEffect(param1:Sprite) : void
      {
         if(this._runAsMobile == false)
         {
            this.mcMouseOverEffect.graphics.clear();
            this.mcMouseOverEffect = param1;
            if(this.mcMouseOverEffect.parent != null)
            {
               this.mcMouseOverEffect.parent.removeChild(this.mcMouseOverEffect);
            }
            addChild(this.mcMouseOverEffect);
            this.buttonCore.setMouseOverEffect(this.mcMouseOverEffect);
            if(this.mcMouseHitArea != null)
            {
               if(this.mcMouseHitArea.parent != null)
               {
                  this.mcMouseHitArea.parent.removeChild(this.mcMouseHitArea);
               }
               addChild(this.mcMouseHitArea);
            }
         }
      }
      
      public function enableMouseUpWhileDisabled() : void
      {
         this.buttonCore.enableMouseUpWhileDisabled();
      }
      
      public function enableMouseOverAndOutWhileDisabled() : void
      {
         this.buttonCore.enableMouseOverAndOutWhileDisabled();
      }
      
      public function enableMouseOverEffect() : void
      {
         this.buttonCore.enableMouseOverEffect();
      }
      
      public function disableMouseOverEffect() : void
      {
         this.buttonCore.disableMouseOverEffect();
      }
      
      public function get item() : BMItem
      {
         return this._item;
      }
      
      public function set tileID(param1:Number) : void
      {
         this._tileID = param1;
      }
      
      public function get tileID() : Number
      {
         return this._tileID;
      }
      
      public function addAllListeners() : void
      {
         this.buttonCore.addAllListeners();
      }
      
      public function removeAllListeners() : void
      {
         this.buttonCore.removeAllListeners();
      }
      
      public function removeMe() : void
      {
         var _loc1_:uint = 0;
         if(this._removed == false)
         {
            this.deactivateAnimatedMarker("removeMe");
            if(this.itemsThatNeedsAddingAndRemoving.length > 0)
            {
               _loc1_ = 0;
               while(_loc1_ < this.itemsThatNeedsAddingAndRemoving.length)
               {
                  if(this.itemsThatNeedsAddingAndRemoving[_loc1_] != null)
                  {
                     this.itemsThatNeedsAddingAndRemoving[_loc1_].removeMe();
                  }
                  _loc1_++;
               }
            }
            this.itemsThatNeedsAddingAndRemoving = null;
            if(this.buttonCore != null)
            {
               this.buttonCore.removeMe();
               this.buttonCore = null;
            }
            if(this._item != null)
            {
               this._item.removeMe();
               this._item = null;
            }
            if(parent != null)
            {
               parent.removeChild(this);
            }
            this._removed = true;
         }
      }
   }
}

