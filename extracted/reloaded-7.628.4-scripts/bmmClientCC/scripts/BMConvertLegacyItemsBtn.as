package
{
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol86")]
   public dynamic class BMConvertLegacyItemsBtn extends BMBasicButton
   {
      
      public function BMConvertLegacyItemsBtn()
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

