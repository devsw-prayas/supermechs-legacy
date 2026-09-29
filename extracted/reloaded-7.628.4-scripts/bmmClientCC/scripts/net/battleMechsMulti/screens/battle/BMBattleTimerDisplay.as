package net.battleMechsMulti.screens.battle
{
   import flash.display.MovieClip;
   import net.battleMechsMulti.managers.BMSoundManager;
   
   public class BMBattleTimerDisplay extends MovieClip
   {
      
      public var mcAlert:MovieClip;
      
      public var clock_10s:MovieClip;
      
      public var clock_1s:MovieClip;
      
      private var _secondsMax:uint;
      
      public function BMBattleTimerDisplay()
      {
         super();
         this._secondsMax = 30;
      }
      
      public function setSecondsTotal(param1:uint) : void
      {
         this._secondsMax = param1;
      }
      
      public function updateTimerDisplay(param1:uint) : void
      {
         var _loc2_:String = "green";
         if(param1 <= this._secondsMax * 0.25)
         {
            _loc2_ = "red";
         }
         else if(param1 <= this._secondsMax * 0.5)
         {
            _loc2_ = "yellow";
         }
         switch(param1)
         {
            case 0:
            case 1:
            case 2:
            case 3:
               BMSoundManager.getInstance().createSound("clockTick",1);
         }
         var _loc3_:Number = param1 % 10;
         var _loc4_:Number = Math.floor(param1 / 10);
         this.clock_1s.gotoAndStop(_loc2_ + _loc3_);
         this.clock_10s.gotoAndStop(_loc2_ + _loc4_);
      }
      
      public function showDigits() : void
      {
         this.clock_1s.visible = true;
         this.clock_10s.visible = true;
      }
      
      public function showTimeEnded() : void
      {
         this.clock_1s.gotoAndStop("red0");
         this.clock_10s.gotoAndStop("red0");
         this.mcAlert.gotoAndPlay("animOn");
      }
      
      public function showDisabled() : void
      {
         this.clock_1s.gotoAndStop("gray8");
         this.clock_10s.gotoAndStop("gray8");
      }
   }
}

