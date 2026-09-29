package
{
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1211")]
   public dynamic class screenMainMenuWorkshopBtn extends BMBasicButton
   {
      
      public function screenMainMenuWorkshopBtn()
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

