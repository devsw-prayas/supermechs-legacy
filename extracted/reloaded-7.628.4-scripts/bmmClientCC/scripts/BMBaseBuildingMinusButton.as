package
{
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3973")]
   public dynamic class BMBaseBuildingMinusButton extends BMBasicButton
   {
      
      public function BMBaseBuildingMinusButton()
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

