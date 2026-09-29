package
{
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2430")]
   public dynamic class missionDifficultyBattleBtn2 extends BMBasicButton
   {
      
      public function missionDifficultyBattleBtn2()
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

