package
{
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2744")]
   public dynamic class InventoryExpandUpgradeBtn extends BMBasicButton
   {
      
      public function InventoryExpandUpgradeBtn()
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

