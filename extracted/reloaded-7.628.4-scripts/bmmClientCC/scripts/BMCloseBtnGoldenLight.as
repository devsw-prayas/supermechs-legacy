package
{
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1377")]
   public dynamic class BMCloseBtnGoldenLight extends BMBasicButton
   {
      
      public function BMCloseBtnGoldenLight()
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

