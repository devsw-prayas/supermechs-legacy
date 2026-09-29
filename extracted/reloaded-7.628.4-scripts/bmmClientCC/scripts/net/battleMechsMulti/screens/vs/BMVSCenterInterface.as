package net.battleMechsMulti.screens.vs
{
   import com.greensock.TweenMax;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMLanguageManager;
   import net.battleMechsMulti.mobiles.BMMovieClip;
   import net.battleMechsMulti.screens.battle.BMBattleTimerDisplay;
   
   public class BMVSCenterInterface extends BMMovieClip
   {
      
      public var mcVSImage:Sprite;
      
      public var txtPickMechs:TextField;
      
      public var txtMechsSelected:TextField;
      
      public var mcClock:BMBattleTimerDisplay;
      
      private var _clockInitialYPos:Number;
      
      private var _maxMechs:uint;
      
      public function BMVSCenterInterface()
      {
         super();
         this._clockInitialYPos = this.mcClock.y;
         this.mcClock.y -= 60;
      }
      
      public function showPickMechInterface(param1:uint) : void
      {
         TweenMax.to(this.mcVSImage,0.4,{
            "scaleX":0.01,
            "scaleY":0.01,
            "visible":false
         });
         TweenMax.to(this.mcClock,0.4,{"y":this._clockInitialYPos});
         updateTextAndFormat(this.txtPickMechs,BMLanguageManager.getInstance().getText("vs_pickMechs"));
         this._maxMechs = param1;
         this.updateMechsSelectedText();
      }
      
      public function updateMechsSelected(param1:uint) : void
      {
         this.updateMechsSelectedText(param1);
      }
      
      private function updateMechsSelectedText(param1:uint = 0) : void
      {
         updateTextAndFormat(this.txtMechsSelected,param1 + " / " + this._maxMechs);
      }
      
      public function updateClock(param1:uint) : void
      {
         this.mcClock.updateTimerDisplay(param1);
      }
      
      public function pickMechsTimeEnded() : void
      {
         this.mcClock.showTimeEnded();
      }
   }
}

