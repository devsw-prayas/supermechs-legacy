package net.battleMechsMulti.mobiles
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol361")]
   public class BMBar extends MovieClip
   {
      
      private var _fillRatio:Number = 0;
      
      private var _fillDirection:String;
      
      public var mcFill:MovieClip;
      
      public var mcFillSizer:MovieClip;
      
      public var mcSeparatorLines:MovieClip;
      
      public var mcBackground:MovieClip;
      
      private const FILL_ANIMATION_MODIFIER:Number = 3;
      
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
      
      public function setFill(param1:Number, param2:Boolean = false) : void
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
         var _loc2_:Number = this.mcFill.width / this.mcFillSizer.width;
         if(this._fillRatio > _loc2_)
         {
            this.mcFill.width += (this.mcFillSizer.width * this._fillRatio - this.mcFill.width) / this.FILL_ANIMATION_MODIFIER;
         }
         else
         {
            this.mcFill.width -= (this.mcFill.width - this.mcFillSizer.width * this._fillRatio) / this.FILL_ANIMATION_MODIFIER;
         }
         _loc2_ = this.mcFill.width / this.mcFillSizer.width;
         if(Math.abs(this._fillRatio - _loc2_) < 0.001)
         {
            removeEventListener(Event.ENTER_FRAME,this.changeFillOnEnterFrame);
            this.mcFill.width = this.mcFillSizer.width * this._fillRatio;
         }
         this.refreshFillXPosition();
      }
      
      public function getFillRatio() : Number
      {
         return this._fillRatio;
      }
   }
}

