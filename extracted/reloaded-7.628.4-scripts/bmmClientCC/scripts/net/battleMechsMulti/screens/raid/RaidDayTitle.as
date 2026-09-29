package net.battleMechsMulti.screens.raid
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.battleMechsMulti.mobiles.BMMovieClip;
   
   public class RaidDayTitle extends BMMovieClip
   {
      
      public var txtDay:TextField;
      
      public var mcFrame:MovieClip;
      
      public var mcFill:MovieClip;
      
      public const FILL_CURRENT:String = "current";
      
      public const FILL_COMPLETED:String = "completed";
      
      public const FILL_LOCKED:String = "locked";
      
      public const FRAME_CURRENT:String = "current";
      
      public const FRAME_NOT_CURRENT:String = "notCurrent";
      
      public function RaidDayTitle()
      {
         super();
      }
      
      public function initialize(param1:uint, param2:String, param3:String) : void
      {
         var _loc4_:String = String(param1);
         if(param3 != this.FILL_CURRENT)
         {
            _loc4_ = "<FONT COLOR=\'#DDDDDD\'>" + _loc4_;
         }
         updateTextAndFormat(this.txtDay,_loc4_);
         this.mcFrame.gotoAndStop(param2);
         this.mcFill.gotoAndStop(param3);
      }
   }
}

