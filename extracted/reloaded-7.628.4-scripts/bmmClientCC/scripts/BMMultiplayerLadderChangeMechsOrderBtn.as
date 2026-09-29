package
{
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2287")]
   public dynamic class BMMultiplayerLadderChangeMechsOrderBtn extends BMBasicButton
   {
      
      public function BMMultiplayerLadderChangeMechsOrderBtn()
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

