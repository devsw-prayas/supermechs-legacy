package
{
   import net.battleMechsMulti.mobiles.buttons.BMBasicSelectable;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2403")]
   public dynamic class BMMultiplayerLadder2V2BBtn extends BMBasicSelectable
   {
      
      public function BMMultiplayerLadder2V2BBtn()
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

