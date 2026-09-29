package
{
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol815")]
   public dynamic class missionDifficultyNukeEmptyBtn extends BMBasicButton
   {
      
      public function missionDifficultyNukeEmptyBtn()
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

