package
{
   import net.battleMechsMulti.screens.mainMenu.TextHolder;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2420")]
   public dynamic class listItemLevel extends TextHolder
   {
      
      public function listItemLevel()
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

