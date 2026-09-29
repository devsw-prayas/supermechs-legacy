package
{
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1542")]
   public dynamic class BMLoadReplayByCodeButton extends BMBasicButton
   {
      
      public function BMLoadReplayByCodeButton()
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

