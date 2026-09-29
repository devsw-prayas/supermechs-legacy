package
{
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2335")]
   public dynamic class BMMultiplayerLadderBattleBtn2 extends BMBasicButton
   {
      
      public function BMMultiplayerLadderBattleBtn2()
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

