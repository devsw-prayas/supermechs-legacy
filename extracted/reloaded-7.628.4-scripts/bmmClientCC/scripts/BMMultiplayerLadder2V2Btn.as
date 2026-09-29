package
{
   import net.battleMechsMulti.mobiles.buttons.BMBasicSelectable;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2279")]
   public dynamic class BMMultiplayerLadder2V2Btn extends BMBasicSelectable
   {
      
      public function BMMultiplayerLadder2V2Btn()
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

