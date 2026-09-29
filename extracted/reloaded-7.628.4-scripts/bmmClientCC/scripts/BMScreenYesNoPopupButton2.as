package
{
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1830")]
   public dynamic class BMScreenYesNoPopupButton2 extends BMBasicButton
   {
      
      public function BMScreenYesNoPopupButton2()
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

