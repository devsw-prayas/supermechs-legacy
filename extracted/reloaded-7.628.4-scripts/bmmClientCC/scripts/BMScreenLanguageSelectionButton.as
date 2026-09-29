package
{
   import net.battleMechsMulti.mobiles.buttons.BMLanguageButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol341")]
   public dynamic class BMScreenLanguageSelectionButton extends BMLanguageButton
   {
      
      public function BMScreenLanguageSelectionButton()
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

