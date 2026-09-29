package
{
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1137")]
   public dynamic class screenMainMenuOptionsBtn extends BMBasicButton
   {
      
      public function screenMainMenuOptionsBtn()
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

