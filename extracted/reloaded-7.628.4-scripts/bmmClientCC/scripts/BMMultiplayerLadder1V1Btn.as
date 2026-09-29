package
{
   import net.battleMechsMulti.mobiles.buttons.BMBasicSelectable;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2270")]
   public dynamic class BMMultiplayerLadder1V1Btn extends BMBasicSelectable
   {
      
      public function BMMultiplayerLadder1V1Btn()
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

