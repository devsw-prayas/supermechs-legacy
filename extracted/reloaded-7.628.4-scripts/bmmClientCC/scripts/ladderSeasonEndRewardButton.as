package
{
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2713")]
   public dynamic class ladderSeasonEndRewardButton extends BMBasicButton
   {
      
      public function ladderSeasonEndRewardButton()
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

