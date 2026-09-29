package
{
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol827")]
   public dynamic class missionDifficultyBattleLockedBtn extends BMBasicButton
   {
      
      public function missionDifficultyBattleLockedBtn()
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

