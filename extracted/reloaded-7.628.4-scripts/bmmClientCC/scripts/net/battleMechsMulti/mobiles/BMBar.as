package net.battleMechsMulti.mobiles
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol389")]
   public class BMBar extends MovieClip
   {
      
      public static const FILL_SPEED_NORMAL:uint = 1;
      
      public static const FILL_SPEED_SLOW:uint = 2;
      
      public static const FILL_TYPE_LINEAR:uint = 1;
      
      public static const FILL_TYPE_CUBIC:uint = 2;
      
      public static const COLOR_RED:String = "red";
      
      public static const COLOR_ORANGE:String = "orange";
      
      public static const COLOR_ORANGE2:String = "orange2";
      
      public static const COLOR_GREEN:String = "green";
      
      public static const COLOR_BLUE:String = "blue";
      
      public static const COLOR_YELLOW:String = "yellow";
      
      private var _fillRatio:Number = 0;
      
      private var _fillDirection:String;
      
      private var _animationDelayFrames:uint;
      
      private var _fillSpeed:uint = 1;
      
      private var _fillType:uint = 2;
      
      private var _fillChangedCallback:Function;
      
      public var mcFill:MovieClip;
      
      public var mcFillSizer:MovieClip;
      
      public var mcSeparatorLines:MovieClip;
      
      public var mcBackground:MovieClip;
      
      private const CUBIC_ANIMATION_MODIFIER_IN_NORAML_SPEED:Number = 3;
      
      private const CUBIC_ANIMATION_MODIFIER_IN_SLOW_SPEED:Number = 12;
      
      private const LINEAR_ANIMATION_MODIFIER_IN_NORAML_SPEED:Number = 50;
      
      private const LINEAR_ANIMATION_MODIFIER_IN_SLOW_SPEED:Number = 100;
      
      public function BMBar()
      {
         super();
      }
      
      public function initialize(param1:String = "", param2:String = "right") : void
      {
         if(param1 != "")
         {
            this.mcFill.gotoAndStop(param1);
         }
         this._fillDirection = param2;
      }
      
      public function setFillSpeed(param1:uint) : void
      {
         this._fillSpeed = param1;
      }
      
      public function setFillType(param1:uint) : void
      {
         this._fillType = param1;
      }
      
      public function setFillChangedCallback(param1:Function) : void
      {
         this._fillChangedCallback = param1;
      }
      
      public function addSeparateorLines(param1:Number) : void
      {
         if(this.mcSeparatorLines != null)
         {
            removeChild(this.mcSeparatorLines);
            this.mcSeparatorLines.graphics.clear();
         }
         this.mcSeparatorLines = new MovieClip();
         this.mcSeparatorLines.graphics.lineStyle(0,0,0.25);
         var _loc2_:Number = param1 / scaleX;
         while(_loc2_ < width / scaleX)
         {
            this.mcSeparatorLines.graphics.moveTo(_loc2_,0);
            this.mcSeparatorLines.graphics.lineTo(_loc2_,height / scaleY);
            _loc2_ += param1 / scaleX;
         }
         addChild(this.mcSeparatorLines);
      }
      
      public function setFill(param1:Number, param2:Boolean = false, param3:uint = 0) : void
      {
         this._fillRatio = param1;
         if(this._fillRatio < 0)
         {
            this._fillRatio = 0;
         }
         else if(this._fillRatio > 1)
         {
            this._fillRatio = 1;
         }
         this._animationDelayFrames = param3;
         if(this.mcFill.width / this.mcFillSizer.width != this._fillRatio)
         {
            if(param2)
            {
               addEventListener(Event.ENTER_FRAME,this.changeFillOnEnterFrame);
            }
            else
            {
               this.mcFill.width = this.mcFillSizer.width * this._fillRatio;
               this.refreshFillXPosition();
            }
         }
      }
      
      private function refreshFillXPosition() : void
      {
         switch(this._fillDirection)
         {
            case "right":
               this.mcFill.x = this.mcFillSizer.x;
               break;
            case "left":
               this.mcFill.x = this.mcFillSizer.x + this.mcFillSizer.width - this.mcFill.width;
         }
      }
      
      private function changeFillOnEnterFrame(param1:Event) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         if(this._animationDelayFrames > 0)
         {
            --this._animationDelayFrames;
            return;
         }
         var _loc2_:Number = this.mcFill.width / this.mcFillSizer.width;
         if(this._fillType == FILL_TYPE_CUBIC)
         {
            _loc3_ = this.CUBIC_ANIMATION_MODIFIER_IN_NORAML_SPEED;
            if(this._fillSpeed == FILL_SPEED_SLOW)
            {
               _loc3_ = this.CUBIC_ANIMATION_MODIFIER_IN_SLOW_SPEED;
            }
         }
         else
         {
            _loc3_ = this.LINEAR_ANIMATION_MODIFIER_IN_NORAML_SPEED;
            if(this._fillSpeed == FILL_SPEED_SLOW)
            {
               _loc3_ = this.LINEAR_ANIMATION_MODIFIER_IN_SLOW_SPEED;
            }
         }
         if(this._fillType == FILL_TYPE_CUBIC)
         {
            if(this._fillRatio > _loc2_)
            {
               this.mcFill.width += (this.mcFillSizer.width * this._fillRatio - this.mcFill.width) / _loc3_;
            }
            else
            {
               this.mcFill.width -= (this.mcFill.width - this.mcFillSizer.width * this._fillRatio) / _loc3_;
            }
         }
         else
         {
            _loc4_ = this.mcFillSizer.width / _loc3_;
            _loc5_ = this.mcFillSizer.width * this._fillRatio;
            if(this._fillRatio > _loc2_)
            {
               if(this.mcFill.width + _loc4_ > _loc5_)
               {
                  this.mcFill.width = _loc5_;
               }
               else
               {
                  this.mcFill.width += _loc4_;
               }
            }
            else if(this.mcFill.width - _loc4_ < _loc5_)
            {
               this.mcFill.width = _loc5_;
            }
            else
            {
               this.mcFill.width -= _loc4_;
            }
         }
         _loc2_ = this.mcFill.width / this.mcFillSizer.width;
         if(Math.abs(this._fillRatio - _loc2_) < 0.001)
         {
            removeEventListener(Event.ENTER_FRAME,this.changeFillOnEnterFrame);
            this.mcFill.width = this.mcFillSizer.width * this._fillRatio;
         }
         if(this._fillChangedCallback != null)
         {
            this._fillChangedCallback(_loc2_);
         }
         this.refreshFillXPosition();
      }
      
      public function getFillRatio() : Number
      {
         return this._fillRatio;
      }
   }
}

