package
{
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1199")]
   public dynamic class screenMainMenuUpgradeBtn extends BMBasicButton
   {
      
      public function screenMainMenuUpgradeBtn()
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

