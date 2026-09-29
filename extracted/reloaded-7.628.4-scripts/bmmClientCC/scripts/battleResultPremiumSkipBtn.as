package
{
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3625")]
   public dynamic class battleResultPremiumSkipBtn extends BMBasicButton
   {
      
      public function battleResultPremiumSkipBtn()
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

