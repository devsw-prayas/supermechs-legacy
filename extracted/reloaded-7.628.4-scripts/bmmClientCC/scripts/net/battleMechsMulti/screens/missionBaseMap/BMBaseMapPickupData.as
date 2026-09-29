package net.battleMechsMulti.screens.missionBaseMap
{
   import flash.display.Sprite;
   
   public class BMBaseMapPickupData
   {
      
      public static const STATE_WAIT:String = "wait";
      
      public static const STATE_GO_UP:String = "goUp";
      
      public static const STATE_GROW:String = "grow";
      
      public static const STATE_SHRINK:String = "shrink";
      
      public var framesCounter:uint = 0;
      
      public var waitFrames:uint = 0;
      
      public var type:String = "";
      
      public var name:String = "";
      
      public var state:String = "";
      
      public var grp:Sprite = null;
      
      public function BMBaseMapPickupData()
      {
         super();
      }
   }
}

