package
{
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1995")]
   public dynamic class BMScreenYesNoPopupButton4 extends BMBasicButton
   {
      
      public function BMScreenYesNoPopupButton4()
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

