package net.battleMechsMulti.mobiles
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class BMActionRange extends BMBaseClass
   {
      
      private var _stepsTotal:Number;
      
      private var _stepWidth:Number;
      
      private var _stepStart:Number;
      
      private var _stepAddon:Number;
      
      private var _showLeftBorder:Boolean;
      
      private var _showRightBorder:Boolean;
      
      private var _color:String;
      
      private var _skipSteps:Array;
      
      private var lines:Array;
      
      private var borders:Array;
      
      private var linesHolder:Sprite;
      
      private var bordersHolder:Sprite;
      
      private var moveToStepArrowsForMobile:Array;
      
      private const ALPHA_CHANGE_PER_FRAME:Number = 0.25;
      
      private const LINES_IN_STEP:Number = 5;
      
      private const MAP_MAX_STEPS:uint = 10;
      
      public const FLOOR_STEP_SIZE:Number = 200;
      
      public function BMActionRange()
      {
         super();
      }
      
      public function initialize(param1:Number, param2:Number) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:MovieClip = null;
         var _loc6_:uint = 0;
         var _loc7_:Sprite = null;
         generateSingletonClassesPointers("");
         this._stepsTotal = param1;
         this._stepWidth = param2;
         this._skipSteps = new Array();
         this._color = "red";
         this.linesHolder = new Sprite();
         this.lines = new Array();
         _loc3_ = 0;
         while(_loc3_ <= this._stepsTotal * this.LINES_IN_STEP)
         {
            _loc4_ = new mcActionRangeLine();
            _loc4_.x = _loc3_ * this._stepWidth / this.LINES_IN_STEP;
            if(_loc3_ % this.LINES_IN_STEP != 0)
            {
               _loc4_.height -= 50;
            }
            else
            {
               _loc4_.height += 50;
               _loc4_.width += 30;
            }
            this.lines.push(_loc4_);
            _loc3_++;
         }
         this.bordersHolder = new Sprite();
         this.borders = new Array();
         _loc3_ = 0;
         while(_loc3_ <= this._stepsTotal * this.LINES_IN_STEP)
         {
            _loc5_ = new mcActionRangeBorder();
            _loc5_.x = _loc3_ * this._stepWidth / this.LINES_IN_STEP;
            this.borders.push(_loc5_);
            _loc3_++;
         }
         addChild(this.linesHolder);
         addChild(this.bordersHolder);
         if(dataM.runAsMobile)
         {
            this.moveToStepArrowsForMobile = new Array();
            _loc6_ = 1;
            while(_loc6_ <= this.MAP_MAX_STEPS)
            {
               _loc7_ = new mcGuideArrowHollow();
               _loc7_.x = (_loc6_ - 0.5) * this.FLOOR_STEP_SIZE;
               _loc7_.y = -50;
               this.moveToStepArrowsForMobile.push(_loc7_);
               _loc6_++;
            }
         }
      }
      
      public function displayRange(param1:Number, param2:Number, param3:Array, param4:Boolean, param5:Boolean, param6:String) : void
      {
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:Boolean = false;
         if(dataM.runAsMobile && param6 == "green")
         {
            if(param1 < 0)
            {
               param1 = 0;
            }
            _loc8_ = param1 + param2;
            if(_loc8_ > this.MAP_MAX_STEPS)
            {
               _loc8_ = this.MAP_MAX_STEPS;
            }
            _loc9_ = param1;
            while(_loc9_ < _loc8_)
            {
               _loc10_ = true;
               _loc7_ = 0;
               while(_loc7_ < param3.length)
               {
                  if(_loc9_ == param3[_loc7_])
                  {
                     _loc10_ = false;
                     _loc7_ = param3.length;
                  }
                  _loc7_++;
               }
               if(_loc10_)
               {
                  if(this.moveToStepArrowsForMobile[_loc9_].parent == null)
                  {
                     screensM.screenBattle.holder_effects.addChild(this.moveToStepArrowsForMobile[_loc9_]);
                  }
               }
               else if(this.moveToStepArrowsForMobile[_loc9_].parent != null)
               {
                  this.moveToStepArrowsForMobile[_loc9_].parent.removeChild(this.moveToStepArrowsForMobile[_loc9_]);
               }
               _loc9_++;
            }
         }
         else
         {
            this._color = param6;
            _loc7_ = 0;
            while(_loc7_ < this.lines.length)
            {
               this.lines[_loc7_].gotoAndStop(this._color);
               _loc7_++;
            }
            _loc7_ = 0;
            while(_loc7_ < this.borders.length)
            {
               this.borders[_loc7_].gotoAndStop(this._color);
               _loc7_++;
            }
            this._stepStart = param1;
            this._stepAddon = param2;
            this._skipSteps = new Array();
            if(param3 != null)
            {
               this._skipSteps = param3;
            }
            this._showLeftBorder = param4;
            this._showRightBorder = param5;
            addEventListener(Event.ENTER_FRAME,this.linesOnEnterFrame);
         }
      }
      
      public function hideMe() : void
      {
         var _loc1_:uint = 0;
         if(dataM.runAsMobile)
         {
            _loc1_ = 0;
            while(_loc1_ < this.moveToStepArrowsForMobile.length)
            {
               if(this.moveToStepArrowsForMobile[_loc1_].parent != null)
               {
                  this.moveToStepArrowsForMobile[_loc1_].parent.removeChild(this.moveToStepArrowsForMobile[_loc1_]);
               }
               _loc1_++;
            }
         }
         this.displayRange(-1,-1,null,false,false,this._color);
      }
      
      private function linesOnEnterFrame(param1:Event) : void
      {
         var _loc4_:MovieClip = null;
         var _loc5_:Boolean = false;
         var _loc6_:MovieClip = null;
         var _loc7_:uint = 0;
         var _loc2_:Boolean = false;
         var _loc3_:uint = 0;
         while(_loc3_ <= this._stepsTotal * this.LINES_IN_STEP)
         {
            _loc4_ = this.lines[_loc3_];
            _loc5_ = false;
            if(this._skipSteps.length > 0)
            {
               _loc7_ = 0;
               while(_loc7_ < this._skipSteps.length)
               {
                  if(_loc3_ >= this._skipSteps[_loc7_] * this.LINES_IN_STEP && _loc3_ <= (this._skipSteps[_loc7_] + 1) * this.LINES_IN_STEP)
                  {
                     _loc5_ = true;
                  }
                  _loc7_++;
               }
            }
            if(_loc5_ == false && (_loc3_ >= this._stepStart * this.LINES_IN_STEP && _loc3_ <= (this._stepStart + this._stepAddon) * this.LINES_IN_STEP))
            {
               if(_loc4_.parent != null)
               {
                  if(_loc4_.alpha < 1)
                  {
                     _loc4_.alpha += this.ALPHA_CHANGE_PER_FRAME;
                     _loc2_ = true;
                  }
                  else
                  {
                     _loc4_.alpha = 1;
                  }
               }
               else
               {
                  _loc4_.alpha = 0;
                  this.linesHolder.addChild(_loc4_);
                  _loc2_ = true;
               }
            }
            else if(_loc4_.parent != null)
            {
               if(_loc4_.alpha > 0)
               {
                  _loc4_.alpha -= this.ALPHA_CHANGE_PER_FRAME;
               }
               else
               {
                  _loc4_.alpha = 0;
                  this.linesHolder.removeChild(_loc4_);
               }
               _loc2_ = true;
            }
            _loc6_ = this.borders[_loc3_];
            if(_loc3_ == this._stepStart * this.LINES_IN_STEP && this._showLeftBorder || _loc3_ == (this._stepStart + this._stepAddon) * this.LINES_IN_STEP && this._showRightBorder)
            {
               if(_loc6_.parent != null)
               {
                  if(_loc6_.alpha < 1)
                  {
                     _loc6_.alpha += this.ALPHA_CHANGE_PER_FRAME;
                     _loc2_ = true;
                  }
                  else
                  {
                     _loc6_.alpha = 1;
                  }
               }
               else
               {
                  _loc6_.alpha = 0;
                  this.bordersHolder.addChild(_loc6_);
                  _loc2_ = true;
               }
            }
            else if(_loc6_.parent != null)
            {
               if(_loc6_.alpha > 0)
               {
                  _loc6_.alpha -= this.ALPHA_CHANGE_PER_FRAME;
               }
               else
               {
                  _loc6_.alpha = 0;
                  this.bordersHolder.removeChild(_loc6_);
               }
               _loc2_ = true;
            }
            _loc3_++;
         }
         if(_loc2_ == false)
         {
            removeEventListener(Event.ENTER_FRAME,this.linesOnEnterFrame);
         }
      }
   }
}

