package
{
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2001")]
   public dynamic class BMScreenYesNoPopupButton3 extends BMBasicButton
   {
      
      public function BMScreenYesNoPopupButton3()
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

