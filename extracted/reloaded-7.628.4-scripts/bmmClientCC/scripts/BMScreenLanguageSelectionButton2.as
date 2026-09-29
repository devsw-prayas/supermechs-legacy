package
{
   import net.battleMechsMulti.mobiles.buttons.BMLanguageButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol235")]
   public dynamic class BMScreenLanguageSelectionButton2 extends BMLanguageButton
   {
      
      public function BMScreenLanguageSelectionButton2()
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

