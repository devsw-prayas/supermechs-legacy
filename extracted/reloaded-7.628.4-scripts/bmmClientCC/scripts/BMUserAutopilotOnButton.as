package
{
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol930")]
   public dynamic class BMUserAutopilotOnButton extends BMBasicButton
   {
      
      public function BMUserAutopilotOnButton()
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

