package
{
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2328")]
   public dynamic class BMMultiplayerLadderRankingListBtn extends BMBasicButton
   {
      
      public function BMMultiplayerLadderRankingListBtn()
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

