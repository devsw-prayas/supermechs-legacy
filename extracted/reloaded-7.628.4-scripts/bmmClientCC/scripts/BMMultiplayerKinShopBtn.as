package
{
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2377")]
   public dynamic class BMMultiplayerKinShopBtn extends BMBasicButton
   {
      
      public function BMMultiplayerKinShopBtn()
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

