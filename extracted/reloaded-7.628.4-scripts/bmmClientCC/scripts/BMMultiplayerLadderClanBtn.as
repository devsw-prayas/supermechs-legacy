package
{
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2339")]
   public dynamic class BMMultiplayerLadderClanBtn extends BMBasicButton
   {
      
      public function BMMultiplayerLadderClanBtn()
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

