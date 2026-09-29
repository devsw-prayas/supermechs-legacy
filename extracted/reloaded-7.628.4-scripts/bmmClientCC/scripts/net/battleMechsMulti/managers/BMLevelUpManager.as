package net.battleMechsMulti.managers
{
   import net.battleMechsMulti.data.BMLevelUpData;
   import net.battleMechsMulti.helpers.BMGameShortcutsHelper;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.utils.BMPubSub;
   
   public class BMLevelUpManager extends BMBaseClass
   {
      
      private static var _instance:BMLevelUpManager;
      
      private var _callDisplayLevelUpPopUpWhenAllDirectorTasksAreFinished:Boolean = false;
      
      public function BMLevelUpManager()
      {
         super();
         generateSingletonClassesPointers("");
         BMPubSub.sub(BMPubSub.MESSAGE_SCREENS_DIRECTOR_FINISHED_ALL_TASKS,this.handleAllScreensDirectorTasksFinished);
      }
      
      public static function gi() : BMLevelUpManager
      {
         if(_instance == null)
         {
            _instance = new BMLevelUpManager();
         }
         return _instance;
      }
      
      public function applyLevelUpData(param1:BMLevelUpData) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc2_:BMDataManager = BMDataManager.getInstance();
         var _loc3_:BMPlayerProfile = _loc2_.myProfile;
         _loc2_.battleCreditsMax = param1.battleCreditsMax;
         if(_loc2_.getGeneralSetting("giveHalfBattleCreditsOnLevelUp",false))
         {
            _loc4_ = _loc2_.myProfile.battleCredits;
            _loc2_.battleCreditsManager.setBattleCredits(_loc4_ + _loc2_.battleCreditsMax / 2);
         }
         else
         {
            _loc2_.battleCreditsManager.setBattleCreditsToMax();
         }
         _loc3_.lastLevel = _loc3_.level = param1.newLevel;
         _loc3_.inventorySizeState.maxSize = param1.inventorySlots;
         if(param1.hasItems)
         {
            _loc5_ = 0;
            while(_loc5_ < param1.reward.items.length)
            {
               _loc2_.myProfile.newItemsPurchased.push(param1.reward.items[_loc5_].playerItemID);
               _loc2_.addPlayerItemDataToInventory(_loc3_.playerID,param1.reward.items[_loc5_].itemID,param1.reward.items[_loc5_].playerItemID,0,0,0);
               _loc5_++;
            }
         }
         if(param1.hasBoxes)
         {
            _loc2_.myProfile.addFreePackages(param1.reward.boxes);
            screensM.addScreen(BMScreensManager.SCR_GET_ITEMS_NO_SPACE);
         }
         if(param1.getGoldAmount() > 0)
         {
            _loc3_.gold += param1.getGoldAmount();
         }
         if(param1.getTokensAmount() > 0)
         {
            _loc3_.tokens += param1.getTokensAmount();
            _loc3_.tokens_bonus += param1.getTokensAmount();
         }
         param1.reset();
         _loc3_.levelUpData = null;
      }
      
      public function displayLevelUpPopUp() : void
      {
         if(BMGameShortcutsHelper.levelUpShortcut())
         {
            return;
         }
         if(screensM.screensDirector.hasTasks())
         {
            this._callDisplayLevelUpPopUpWhenAllDirectorTasksAreFinished = true;
            return;
         }
         if(!screensM.isScreenOpened(BMScreensManager.SCR_LEVEL_UP_NEW) && dataM.myProfile.hasPandingLevelUp)
         {
            soundM.createSound("levelUp",1);
            screensM.addScreen(BMScreensManager.SCR_LEVEL_UP_NEW);
            screensM.screenLevelUpNew.show(dataM.myProfile.levelUpData);
         }
      }
      
      private function handleAllScreensDirectorTasksFinished(param1:String, param2:Object) : void
      {
         if(this._callDisplayLevelUpPopUpWhenAllDirectorTasksAreFinished)
         {
            this.displayLevelUpPopUp();
            this._callDisplayLevelUpPopUpWhenAllDirectorTasksAreFinished = false;
         }
      }
   }
}

