package
{
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2795")]
   public dynamic class BMConvertLegacyItemsRarityBtn extends BMBasicButton
   {
      
      public function BMConvertLegacyItemsRarityBtn()
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

