package net.battleMechsMulti.mobiles
{
   import flash.display.MovieClip;
   import flash.utils.getDefinitionByName;
   
   public class BMRoundBar extends MovieClip
   {
      
      private var roundBar:MovieClip;
      
      private var _fillAngle:Number;
      
      private var _pasteAngle:Number;
      
      private var fillArray:Array = new Array();
      
      public function BMRoundBar()
      {
         super();
      }
      
      public function initialize() : void
      {
         this.roundBar = new mcRoundBar();
         addChild(this.roundBar);
      }
      
      public function fillBar(param1:Number) : void
      {
         var _loc2_:Number = 360 * param1;
         this.removeFill();
         if(_loc2_ < 0)
         {
            _loc2_ = 0;
         }
         else if(_loc2_ > 360)
         {
            _loc2_ = 360;
         }
         this._fillAngle = Math.ceil(_loc2_);
         this._pasteAngle = 0;
         var _loc3_:Number = this._fillAngle;
         while(_loc3_ > 0)
         {
            if(_loc3_ == 360)
            {
               this.addFillPart("360");
               _loc3_ -= 360;
            }
            else if(_loc3_ >= 180)
            {
               this.addFillPart("180");
               _loc3_ -= 180;
               this._pasteAngle += 180;
            }
            else if(_loc3_ >= 90)
            {
               this.addFillPart("90");
               _loc3_ -= 90;
               this._pasteAngle += 90;
            }
            else if(_loc3_ >= 45)
            {
               this.addFillPart("45");
               _loc3_ -= 45;
               this._pasteAngle += 45;
            }
            else if(_loc3_ >= 22.5)
            {
               this.addFillPart("22_5");
               _loc3_ -= 22.5;
               this._pasteAngle += 22.5;
            }
            else if(_loc3_ >= 11.25)
            {
               this.addFillPart("11_25");
               _loc3_ -= 11.25;
               this._pasteAngle += 11.25;
            }
            else
            {
               this.addFillPart("5_625");
               _loc3_ -= 6;
               this._pasteAngle += 6;
            }
         }
      }
      
      private function addFillPart(param1:String) : void
      {
         var _loc2_:Class = Class(getDefinitionByName("mcRoundBarFill_" + param1));
         var _loc3_:MovieClip = new _loc2_();
         _loc3_.rotation = this._pasteAngle;
         this.roundBar.mcFillHolder.addChild(_loc3_);
         this.fillArray.push(_loc3_);
      }
      
      private function removeFill() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < this.fillArray.length)
         {
            this.fillArray[_loc1_].parent.removeChild(this.fillArray[_loc1_]);
            this.fillArray[_loc1_] = null;
            _loc1_++;
         }
         this.fillArray = new Array();
      }
      
      public function showEmptyCover() : void
      {
         this.roundBar.mcEmptyCover.visible = true;
      }
      
      public function hideEmptyCover() : void
      {
         this.roundBar.mcEmptyCover.visible = false;
      }
      
      public function removeMe() : void
      {
         this.removeFill();
         this.roundBar.parent.removeChild(this.roundBar);
         this.roundBar = null;
      }
   }
}

