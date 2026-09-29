package net.battleMechsMulti.screens.clan
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.battleMechsMulti.screens.BMBaseScreen;
   
   public class BMClanWarRewards extends BMBaseScreen
   {
      
      public var txtRewardTitle1:TextField;
      
      public var txtRewardTitle2:TextField;
      
      public var txtClanCoins1:TextField;
      
      public var txtClanCoins2:TextField;
      
      public var mcBoxes1:MovieClip;
      
      public var mcBoxes2:MovieClip;
      
      public function BMClanWarRewards()
      {
         super();
      }
      
      public function initialize(param1:uint, param2:uint, param3:uint, param4:uint) : void
      {
         generateSingletonClassesPointers();
         updateTextAndFormat(this.txtRewardTitle1,getSpecificText("clanWar_defaultReward"));
         updateTextAndFormat(this.txtRewardTitle2,getSpecificText("clanWar_winReward"));
         updateTextAndFormat(this.txtClanCoins1,param1.toString());
         updateTextAndFormat(this.txtClanCoins2,param2.toString());
         this.mcBoxes1.gotoAndStop("box" + param3);
         this.mcBoxes2.gotoAndStop("box" + param4);
      }
   }
}

