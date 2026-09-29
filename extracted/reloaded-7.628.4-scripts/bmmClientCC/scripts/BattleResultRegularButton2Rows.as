package
{
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3680")]
   public dynamic class BattleResultRegularButton2Rows extends BMBasicButton
   {
      
      public function BattleResultRegularButton2Rows()
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

