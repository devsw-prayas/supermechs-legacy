package
{
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol78")]
   public dynamic class BMWorkshopRedeemMechBtn extends BMBasicButton
   {
      
      public function BMWorkshopRedeemMechBtn()
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

