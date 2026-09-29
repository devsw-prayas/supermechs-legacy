package
{
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1353")]
   public dynamic class BMCloseBtnGoldenDark extends BMBasicButton
   {
      
      public function BMCloseBtnGoldenDark()
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

