package net.battleMechsMulti.helpers
{
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMTutorialManager;
   import net.battleMechsMulti.managers.singlePlayer.BMSinglePlayerManager;
   
   public class BMMultiplayerCallToActionHelper
   {
      
      public function BMMultiplayerCallToActionHelper()
      {
         super();
         throw new Error("Do not instantiate this class");
      }
      
      public static function shouldDirectPlayerToMultiplayer() : Boolean
      {
         var _loc7_:uint = 0;
         var _loc8_:Boolean = false;
         var _loc9_:Boolean = false;
         var _loc10_:Boolean = false;
         if(BMTutorialManager.gi().isTutorialActive())
         {
            return false;
         }
         var _loc1_:int = BMSinglePlayerManager.STORY_ID_CAMPAIGN_1V1;
         var _loc2_:int = 0;
         var _loc3_:BMDataManager = BMDataManager.getInstance();
         var _loc4_:BMSinglePlayerManager = _loc3_.singlePlayerM;
         if(_loc3_.getGeneralSetting("allowMultiplayerCallToAction",0) == 0)
         {
            return false;
         }
         if(_loc4_.didCompleteChapter(BMSinglePlayerManager.STORY_ID_CAMPAIGN_1V1,3,0))
         {
            return false;
         }
         var _loc5_:int = _loc4_.getRecommendedMissionSlot(_loc1_,_loc2_);
         var _loc6_:* = _loc4_.didCompleteCampaign(_loc1_,_loc2_);
         for each(_loc7_ in _loc4_.missionsItemBoxSlots[_loc1_])
         {
            _loc8_ = Boolean(_loc6_) || _loc5_ > _loc7_;
            _loc9_ = _loc4_.didCompleteSlot(_loc1_,_loc7_,_loc2_);
            _loc10_ = _loc4_.getSpecificMissionDB(_loc1_,_loc7_).onlineWinsRequired <= _loc3_.myProfile.ladderWins;
            if(_loc8_ && !_loc9_ && !_loc10_)
            {
               return true;
            }
         }
         return false;
      }
   }
}

