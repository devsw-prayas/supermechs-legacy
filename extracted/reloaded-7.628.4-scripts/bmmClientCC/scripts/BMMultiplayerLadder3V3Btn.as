package
{
   import net.battleMechsMulti.mobiles.buttons.BMBasicSelectable;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2285")]
   public dynamic class BMMultiplayerLadder3V3Btn extends BMBasicSelectable
   {
      
      public function BMMultiplayerLadder3V3Btn()
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

