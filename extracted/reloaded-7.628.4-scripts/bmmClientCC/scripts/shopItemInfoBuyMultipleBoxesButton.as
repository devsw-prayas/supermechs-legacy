package
{
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1193")]
   public dynamic class shopItemInfoBuyMultipleBoxesButton extends BMBasicButton
   {
      
      public function shopItemInfoBuyMultipleBoxesButton()
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

