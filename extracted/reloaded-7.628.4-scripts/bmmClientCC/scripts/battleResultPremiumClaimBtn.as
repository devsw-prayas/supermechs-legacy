package
{
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3600")]
   public dynamic class battleResultPremiumClaimBtn extends BMBasicButton
   {
      
      public function battleResultPremiumClaimBtn()
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

