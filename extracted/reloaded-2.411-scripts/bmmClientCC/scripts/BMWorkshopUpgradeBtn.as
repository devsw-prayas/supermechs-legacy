package
{
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol48")]
   public dynamic class BMWorkshopUpgradeBtn extends BMBasicButton
   {
      
      public function BMWorkshopUpgradeBtn()
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

