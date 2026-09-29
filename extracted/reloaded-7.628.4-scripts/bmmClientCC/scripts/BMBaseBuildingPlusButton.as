package
{
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3975")]
   public dynamic class BMBaseBuildingPlusButton extends BMBasicButton
   {
      
      public function BMBaseBuildingPlusButton()
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

