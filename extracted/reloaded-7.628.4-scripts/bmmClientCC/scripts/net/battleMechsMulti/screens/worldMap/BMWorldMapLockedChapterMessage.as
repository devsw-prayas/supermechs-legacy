package net.battleMechsMulti.screens.worldMap
{
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.mobiles.BMMovieClip;
   import net.battleMechsMulti.mobiles.timer.BMTimer;
   
   public class BMWorldMapLockedChapterMessage extends BMMovieClip
   {
      
      public var txtTitle:TextField;
      
      public var mcTimer:BMTimer;
      
      private var _releaseDate:uint;
      
      public function BMWorldMapLockedChapterMessage()
      {
         super();
      }
      
      public function initialize(param1:String, param2:uint, param3:Function) : void
      {
         this._releaseDate = param2;
         this.mcTimer.initialize(this.getTimerLeft,param3,0,true);
         updateTextAndFormat(this.txtTitle,param1);
      }
      
      private function getTimerLeft() : int
      {
         return Math.max(0,this._releaseDate - BMDataManager.getInstance().currentTime);
      }
      
      public function removeMe() : void
      {
         if(parent != null)
         {
            parent.removeChild(this);
         }
         this.mcTimer.removeMe();
      }
   }
}

