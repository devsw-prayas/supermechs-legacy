package
{
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3592")]
   public dynamic class battleResultPremiumVideoBtn extends BMBasicButton
   {
      
      public function battleResultPremiumVideoBtn()
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

