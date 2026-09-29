package net.battleMechsMulti.mobiles.unlockedMechSlotsResolver
{
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.BMTutorialManager;
   import net.battleMechsMulti.mobiles.BMToolTip;
   import net.battleMechsMulti.mobiles.worldMap.BMWorldMapLocationData;
   import net.battleMechsMulti.screens.screensDirector.BMScreensDirectorTask;
   
   public class BMUnlockedMechSlotsResolver
   {
      
      public static var CANNOT_BE_UNLOCKED_BY_CHAPTER_COMPLETION:Number = -1;
      
      public function BMUnlockedMechSlotsResolver()
      {
         super();
      }
      
      public static function isMechSlotLocked(param1:uint) : Boolean
      {
         if(param1 > getNumberOfMechsUnlocked())
         {
            return true;
         }
         return false;
      }
      
      public static function wasNewMechSlotJustUnlockedThroughCampaign() : Boolean
      {
         if(getMechSlotJustUnlockedThroughCampaign() == 0)
         {
            return false;
         }
         return true;
      }
      
      public static function getMechSlotJustUnlockedThroughCampaign() : uint
      {
         if(areMechSlotsUnlockedByCampaign() == false)
         {
            return 0;
         }
         var _loc1_:BMDataManager = BMDataManager.getInstance();
         var _loc2_:uint = 1;
         var _loc3_:int = _loc1_.myProfile.currentMissionSlot;
         if(_loc3_ < 0)
         {
            return 0;
         }
         if(_loc1_.singlePlayerM.finishMissionForFirstTime == false)
         {
            return 0;
         }
         var _loc4_:BMWorldMapLocationData = _loc1_.singlePlayerM.getSpecificMissionDB(_loc2_,_loc3_);
         if(_loc4_.subType != BMWorldMapLocationData.SUB_TYPE_MISSION_BOSS)
         {
            return 0;
         }
         var _loc5_:uint = 1;
         var _loc6_:uint = 0;
         while(_loc6_ < unlockedMechsByMissionChapters.length)
         {
            if(unlockedMechsByMissionChapters[_loc6_] <= _loc4_.chapterID)
            {
               _loc5_++;
            }
            if(unlockedMechsByMissionChapters[_loc6_] == _loc4_.chapterID)
            {
               return _loc5_;
            }
            _loc6_++;
         }
         return 0;
      }
      
      public static function activateUnlockMechSlotSequence() : void
      {
         if(unlockedMechsByMissionChapters == null)
         {
            return;
         }
         var _loc1_:uint = getMechSlotJustUnlockedThroughCampaign();
         if(_loc1_ == 0)
         {
            return;
         }
         var _loc2_:BMScreensManager = BMScreensManager.getInstance();
         var _loc3_:Number = 1.5;
         _loc2_.screensDirector.addSequenceTask(BMScreensDirectorTask.SEQUENCE_WAIT,_loc3_);
         _loc2_.screensDirector.addLocationTask(BMScreensDirectorTask.LOCATION_MAIN_MENU);
         _loc2_.screensDirector.addSequenceTask(BMScreensDirectorTask.SEQUENCE_MAIN_MENU_SELECT_MECH,_loc3_,{
            "mechID":_loc1_,
            "forceLockedVisualEffect":true
         });
         _loc2_.screensDirector.addSequenceTask(BMScreensDirectorTask.SEQUENCE_MAIN_MENU_POINT_ON_MECH);
         _loc2_.screensDirector.addUserActionTask(BMScreensDirectorTask.USER_ACTION_MAIN_MENU_CLICK_ON_MECH);
         _loc2_.screensDirector.addSequenceTask(BMScreensDirectorTask.SEQUENCE_MAIN_MENU_REMOVE_SHADOW_FROM_MECH);
         _loc3_ = 0.5;
         _loc2_.screensDirector.addSequenceTask(BMScreensDirectorTask.SEQUENCE_WAIT,_loc3_);
         _loc3_ = 1.3;
         _loc2_.screensDirector.addSequenceTask(BMScreensDirectorTask.SEQUENCE_MAIN_MENU_MECH_DANCE,_loc3_);
         _loc3_ = 0.1;
         var _loc4_:String = "";
         var _loc5_:BMDataManager = BMDataManager.getInstance();
         switch(_loc1_)
         {
            case 2:
               _loc4_ = "<BR><FONT COLOR=\'#" + BMToolTip.TEXT_DAMAGE_ENERGY_COLOR + "\'>Energy</FONT> Mech unlocked!<BR><BR>Energy mechs can disable opponents\' weapons and deal extra damage";
               break;
            case 3:
               _loc4_ = "<BR><FONT COLOR=\'#" + BMToolTip.TEXT_DAMAGE_HEAT_COLOR + "\'>Heat</FONT> Mech unlocked!<BR><BR>Heat mechs can overheat opponents, causing them to lose actions";
         }
         _loc2_.screensDirector.addSequenceTask(BMScreensDirectorTask.SEQUENCE_GENERAL_MESSAGE,_loc3_,{"message":_loc4_});
         _loc2_.screensDirector.addUserActionTask(BMScreensDirectorTask.USER_ACTION_CLOSE_CONFIRMATION_SCREEN);
         _loc2_.screensDirector.addLocationTask(BMScreensDirectorTask.LOCATION_CAMPAIGN_WORLD);
      }
      
      public static function getChapterRequiredToCompleteForMechSlot(param1:uint) : Number
      {
         if(unlockedMechsByMissionChapters == null)
         {
            throw Error("getChapterRequiredToCompleteForMechSlot code should not have gotten here");
         }
         if(param1 == 1)
         {
            return 0;
         }
         if(unlockedMechsByMissionChapters[param1 - 2] != null)
         {
            return unlockedMechsByMissionChapters[param1 - 2];
         }
         return CANNOT_BE_UNLOCKED_BY_CHAPTER_COMPLETION;
      }
      
      public static function areMechSlotsUnlockedByCampaign() : Boolean
      {
         if(unlockedMechsByMissionChapters == null)
         {
            return false;
         }
         return true;
      }
      
      private static function get unlockedMechsByMissionChapters() : Array
      {
         var _loc1_:String = BMDataManager.getInstance().getGeneralSetting("unlockedMechsByMissionChapters",null);
         if(_loc1_ == null || _loc1_ == "")
         {
            return null;
         }
         return _loc1_.split(",");
      }
      
      public static function getNumberOfMechsUnlocked() : uint
      {
         var _loc6_:uint = 0;
         if(BMTutorialManager.gi().isTutorialActive())
         {
            return 1;
         }
         var _loc1_:BMDataManager = BMDataManager.getInstance();
         var _loc2_:uint = _loc1_.getNumberOfMechsUnlocked();
         var _loc3_:uint = 0;
         var _loc4_:uint = 1;
         if(unlockedMechsByMissionChapters != null)
         {
            _loc6_ = 1;
            if(_loc1_.singlePlayerM.didCompleteChapter(_loc6_,getChapterRequiredToCompleteForMechSlot(2),_loc3_))
            {
               _loc4_ = 2;
               if(_loc1_.singlePlayerM.didCompleteChapter(_loc6_,getChapterRequiredToCompleteForMechSlot(3),_loc3_))
               {
                  _loc4_ = 3;
               }
            }
         }
         var _loc5_:uint = _loc2_;
         if(_loc4_ > _loc2_)
         {
            _loc5_ = _loc4_;
         }
         if(_loc5_ > 3 && _loc1_.mechBuildsM.isEnabled)
         {
            _loc5_ = 3;
         }
         return _loc5_;
      }
   }
}

