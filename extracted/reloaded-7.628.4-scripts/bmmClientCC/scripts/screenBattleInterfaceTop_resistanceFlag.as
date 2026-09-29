package
{
   import net.battleMechsMulti.screens.mainMenu.TextHolder;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3735")]
   public dynamic class screenBattleInterfaceTop_resistanceFlag extends TextHolder
   {
      
      public function screenBattleInterfaceTop_resistanceFlag()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      internal function frame1() : *
      {
         stop();
      }
   }
}

