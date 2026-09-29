package
{
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1260")]
   public dynamic class BMRaidLeaderboardButton2 extends BMBasicButton
   {
      
      public function BMRaidLeaderboardButton2()
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

