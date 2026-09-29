package
{
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2292")]
   public dynamic class BMMultiplayerLadderBackBtn extends BMBasicButton
   {
      
      public function BMMultiplayerLadderBackBtn()
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

