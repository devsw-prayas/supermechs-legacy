package
{
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol823")]
   public dynamic class missionDifficultyPremiumBtn extends BMBasicButton
   {
      
      public function missionDifficultyPremiumBtn()
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

