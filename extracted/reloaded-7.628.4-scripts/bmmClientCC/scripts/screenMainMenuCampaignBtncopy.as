package
{
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2518")]
   public dynamic class screenMainMenuCampaignBtncopy extends BMBasicButton
   {
      
      public function screenMainMenuCampaignBtncopy()
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

