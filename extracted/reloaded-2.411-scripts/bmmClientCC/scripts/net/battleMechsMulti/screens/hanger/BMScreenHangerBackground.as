package net.battleMechsMulti.screens.hanger
{
   import net.battleMechsMulti.screens.BMBaseScreen;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1514")]
   public class BMScreenHangerBackground extends BMBaseScreen
   {
      
      public function BMScreenHangerBackground()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
      }
      
      internal function frame1() : *
      {
         stop();
      }
   }
}

