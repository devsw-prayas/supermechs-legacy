package
{
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1335")]
   public dynamic class BMScreenYesNoPopupButton5 extends BMBasicButton
   {
      
      public function BMScreenYesNoPopupButton5()
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

