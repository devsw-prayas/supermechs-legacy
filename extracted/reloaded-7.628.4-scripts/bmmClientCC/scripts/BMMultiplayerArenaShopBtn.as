package
{
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2301")]
   public dynamic class BMMultiplayerArenaShopBtn extends BMBasicButton
   {
      
      public function BMMultiplayerArenaShopBtn()
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

