package net.battleMechsMulti.screens.raid
{
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.screens.BMBaseScreen;
   
   public class BMScreenRaidRules extends BMBaseScreen
   {
      
      public var txtRules:TextField;
      
      public function BMScreenRaidRules()
      {
         super();
         generateSingletonClassesPointers();
         setLanguageManagerScreenName("raid");
      }
      
      public function initialize() : void
      {
         var _loc1_:String = getScreenText("rulesTitle") + "<BR><BR>- " + getScreenText("rulesRule1") + "<BR>";
         _loc1_ = _loc1_ + "- " + getScreenText("rulesRule2") + "<BR>";
         _loc1_ = _loc1_ + "- " + getScreenText("rulesRule3") + "<BR>";
         _loc1_ = _loc1_ + "- " + getScreenText("rulesRule4") + "<BR>";
         _loc1_ = _loc1_ + "- " + getScreenText("rulesRule5") + "<BR>";
         _loc1_ = _loc1_ + "- " + getScreenText("rulesRule6") + "<BR>";
         _loc1_ = _loc1_ + "- " + getScreenText("rulesRule7");
         updateTextAndFormat(this.txtRules,_loc1_);
      }
      
      public function removeMe() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_RAID_RULES);
      }
   }
}

