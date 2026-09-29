package
{
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2324")]
   public dynamic class BMMultiplayerLadderChatBtn extends BMBasicButton
   {
      
      public function BMMultiplayerLadderChatBtn()
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

