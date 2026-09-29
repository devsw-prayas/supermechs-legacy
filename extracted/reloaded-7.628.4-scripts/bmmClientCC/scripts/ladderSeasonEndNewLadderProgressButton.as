package
{
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2705")]
   public dynamic class ladderSeasonEndNewLadderProgressButton extends BMBasicButton
   {
      
      public function ladderSeasonEndNewLadderProgressButton()
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

