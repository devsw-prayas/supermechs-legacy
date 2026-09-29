package
{
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2574")]
   public dynamic class screenMainMenuUpgradeSmallBtn extends BMBasicButton
   {
      
      public function screenMainMenuUpgradeSmallBtn()
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

