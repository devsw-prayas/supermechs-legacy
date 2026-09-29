package
{
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3885")]
   public dynamic class BMBaseBuildingFlowerButtonDisabled extends BMBasicButton
   {
      
      public function BMBaseBuildingFlowerButtonDisabled()
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

