package
{
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1615")]
   public dynamic class BMRaidLeaderboardButton1 extends BMBasicButton
   {
      
      public function BMRaidLeaderboardButton1()
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

