package
{
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2359")]
   public dynamic class BMKinClaimBtn extends BMBasicButton
   {
      
      public function BMKinClaimBtn()
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

