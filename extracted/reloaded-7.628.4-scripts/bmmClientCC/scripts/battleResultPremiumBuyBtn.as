package
{
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3644")]
   public dynamic class battleResultPremiumBuyBtn extends BMBasicButton
   {
      
      public function battleResultPremiumBuyBtn()
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

