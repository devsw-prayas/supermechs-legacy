package
{
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2316")]
   public dynamic class BMMultiplayerLadderBattleBtn extends BMBasicButton
   {
      
      public function BMMultiplayerLadderBattleBtn()
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

