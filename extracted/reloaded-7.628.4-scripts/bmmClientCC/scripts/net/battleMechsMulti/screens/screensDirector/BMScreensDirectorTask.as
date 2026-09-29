package net.battleMechsMulti.screens.screensDirector
{
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.shop.BMShopManager;
   import net.battleMechsMulti.managers.singlePlayer.BMSinglePlayerManager;
   import net.battleMechsMulti.utils.BMPubSub;
   
   public class BMScreensDirectorTask
   {
      
      public static const LOCATION_WORKSHOP:String = "loc_workshop";
      
      public static const LOCATION_CAMPAIGN_WORLD:String = "loc_campaignWorld";
      
      public static const LOCATION_CAMPAIGN_MISSION:String = "loc_campaignMission";
      
      public static const LOCATION_PVP_LOBBY:String = "loc_pvpLobby";
      
      public static const LOCATION_MAIN_MENU:String = "loc_mainMenu";
      
      public static const LOCATION_RAID_MENU:String = "loc_raidMenu";
      
      public static const LOCATION_UPGRADE:String = "loc_upgrade";
      
      public static const LOCATION_SHOP:String = "loc_shop";
      
      public static const LOCATION_QUESTS:String = "loc_quests";
      
      public static const LOCATION_CAMPAIGNS_MENU:String = "loc_campaignsMenu";
      
      public static const LOCATION_CLAN:String = "loc_clan";
      
      public static const SEQUENCE_WAIT:String = "seq_wait";
      
      public static const SEQUENCE_EQUIP_ITEM:String = "seq_equipItem";
      
      public static const SEQUENCE_WORKSHOP_MECH_DANCE:String = "seq_workshopMechDance";
      
      public static const SEQUENCE_MAIN_MENU_MECH_DANCE:String = "seq_mainMenuMechDance";
      
      public static const SEQUENCE_MAIN_MENU_SELECT_MECH:String = "seq_mainMenuSelectMech";
      
      public static const SEQUENCE_MAIN_MENU_POINT_ON_MECH:String = "seq_mainMenuPointOnMech";
      
      public static const SEQUENCE_MAIN_MENU_REMOVE_SHADOW_FROM_MECH:String = "seq_mainMenuRemoveShadowFromMech";
      
      public static const SEQUENCE_GENERAL_MESSAGE:String = "seq_generalMessage";
      
      public static const SEQUENCE_CLOSE_CONFIRMATION_SCREEN:String = "seq_closeConfirmationScreen";
      
      public static const SEQUENCE_WORLD_MAP_SELECT_MISSION:String = "seq_worldMapSelectMission";
      
      public static const SEQUENCE_WORLD_MAP_SELECT_CLAN_BOSS_MISSION:String = "seq_worldMapSelectClanBossMission";
      
      public static const SEQUENCE_BEFORE_BATTLE_WAVE:String = "seq_beforeBattleWave";
      
      public static const SEQUENCE_AFTER_BATTLE_SET_COMPLETE_SEQUENCE:String = "seq_afterBattleSetCompleteSequnce";
      
      public static const SEQUENCE_AFTER_BATTLE_UPGRADE:String = "seq_afterBattleUpgrade";
      
      public static const SEQUENCE_AFTER_BATTLE_COMPLETE:String = "seq_afterBattleComplete";
      
      public static const USER_ACTION_MAIN_MENU_CLICK_ON_MECH:String = "user_mainMenuClickOnMech";
      
      public static const USER_ACTION_CLOSE_CONFIRMATION_SCREEN:String = "user_closeConfirmationScreen";
      
      public static const USER_ACTION_WORKSHOP_SWITCH_TO_MECH_X:String = "user_workshopSwitchToMechX";
      
      public static const DATA_UPDATE_SAVE_MECH_CHANGES:String = "upd_saveMechChanges";
      
      public static const DATA_UPDATE_RELOAD_QUESTS_DATA:String = "upd_reloadQuestsData";
      
      public static const DATA_UPDATE_RELOAD_RAID_DATA:String = "upd_reloadRaidData";
      
      public static const TYPE_LOCATION:String = "type_location";
      
      public static const TYPE_SEQUENCE:String = "type_sequence";
      
      public static const TYPE_DATA_UPDATE:String = "type_dataUpdate";
      
      public static const TYPE_USER_ACTION:String = "type_userAction";
      
      private static const COMPLETION_REQ_LOCATION_REACHED:uint = 1;
      
      private static const COMPLETION_REQ_SEQUENCE_STARTED:uint = 2;
      
      private static const COMPLETION_REQ_BLACK_SCREEN_INACTIVE:uint = 3;
      
      private static const COMPLETION_REQ_DURATION_PASSED:uint = 4;
      
      private static const COMPLETION_REQ_DATA_UPDATED:uint = 5;
      
      private static const COMPLETION_REQ_MAIN_MENU_CAROUSEL_ANIM_COMPLETED:uint = 6;
      
      private static const COMPLETION_REQ_LEVEL_UP_CLOSED:uint = 7;
      
      private static const COMPLETION_REQ_MAIN_MENU_PLAYER_CLICK_ON_MECH:uint = 8;
      
      private static const COMPLETION_REQ_CONFIRMATION_SCREEN_CLOSED:uint = 9;
      
      private static const COMPLETION_REQ_WORKSHOP_SWITCH_TO_MECH_X:uint = 10;
      
      private static const LOCATIONS_THAT_DONT_NEED_TO_SUB_TO_SCREENS_STATUS_CHANGES:Array = [LOCATION_SHOP,LOCATION_QUESTS,LOCATION_CAMPAIGNS_MENU,LOCATION_CLAN];
      
      private static const ALL_COMPLETION_REQS:Array = [COMPLETION_REQ_LOCATION_REACHED,COMPLETION_REQ_SEQUENCE_STARTED,COMPLETION_REQ_BLACK_SCREEN_INACTIVE,COMPLETION_REQ_DURATION_PASSED,COMPLETION_REQ_DATA_UPDATED,COMPLETION_REQ_MAIN_MENU_CAROUSEL_ANIM_COMPLETED,COMPLETION_REQ_LEVEL_UP_CLOSED,COMPLETION_REQ_MAIN_MENU_PLAYER_CLICK_ON_MECH,COMPLETION_REQ_CONFIRMATION_SCREEN_CLOSED];
      
      private var _type:String;
      
      private var _taskID:String;
      
      private var _durationInSeconds:Number;
      
      private var _paramsObj:Object;
      
      private var _onCompleted:Function;
      
      private var _timer:Timer;
      
      private var _taskCompletionRequirements:Object = new Object();
      
      private var _pubSubTokens:Array = new Array();
      
      public function BMScreensDirectorTask(param1:String, param2:String, param3:Number, param4:Object, param5:Function)
      {
         super();
         this._type = param1;
         this._taskID = param2;
         this._durationInSeconds = param3;
         this._paramsObj = param4;
         this._onCompleted = param5;
      }
      
      public function excecute() : void
      {
         switch(this._type)
         {
            case TYPE_LOCATION:
               this._taskCompletionRequirements[COMPLETION_REQ_LOCATION_REACHED] = false;
               if(BMScreensManager.getInstance().isScreenOpened(BMScreensManager.SCR_LEVEL_UP_NEW))
               {
                  this._taskCompletionRequirements[COMPLETION_REQ_LEVEL_UP_CLOSED] = false;
               }
               break;
            case TYPE_SEQUENCE:
               this._taskCompletionRequirements[COMPLETION_REQ_SEQUENCE_STARTED] = false;
               break;
            case TYPE_DATA_UPDATE:
               this._taskCompletionRequirements[COMPLETION_REQ_DATA_UPDATED] = false;
               break;
            case TYPE_USER_ACTION:
         }
         switch(this._type)
         {
            case TYPE_DATA_UPDATE:
               break;
            case TYPE_USER_ACTION:
               switch(this._taskID)
               {
                  case USER_ACTION_MAIN_MENU_CLICK_ON_MECH:
                     this._taskCompletionRequirements[COMPLETION_REQ_MAIN_MENU_PLAYER_CLICK_ON_MECH] = false;
                     this.subToPub(BMPubSub.MESSAGE_MAIN_MENU_PLAYER_CLICKED_ON_MECH,this.mainMenuPlayerClickedOnMech);
                     break;
                  case USER_ACTION_CLOSE_CONFIRMATION_SCREEN:
                     this._taskCompletionRequirements[COMPLETION_REQ_CONFIRMATION_SCREEN_CLOSED] = false;
                     break;
                  case USER_ACTION_WORKSHOP_SWITCH_TO_MECH_X:
                     this._taskCompletionRequirements[COMPLETION_REQ_WORKSHOP_SWITCH_TO_MECH_X] = false;
                     this.subToPub(BMPubSub.MESSAGE_WORKSHOP_SWITCH_TO_MECH_X,this.workshopSwitchedToMechX);
                     BMScreensManager.getInstance().screenWorkshop.btnNextMech.ignoreScreensDirectorTasks();
                     BMScreensManager.getInstance().screenWorkshop.activateNextMechArrow();
               }
               break;
            default:
               if(this._durationInSeconds > 0)
               {
                  this._timer = new Timer(Math.ceil(this._durationInSeconds * 1000));
                  this._timer.addEventListener(TimerEvent.TIMER,this.onTimerTrigger);
                  this._timer.start();
                  this._taskCompletionRequirements[COMPLETION_REQ_DURATION_PASSED] = false;
               }
               if(this.subForBlackScreenInactiveMessage())
               {
                  this._taskCompletionRequirements[COMPLETION_REQ_BLACK_SCREEN_INACTIVE] = false;
                  this.subToPub(BMPubSub.MESSAGE_BLACK_SCREEN_INACTIVE,this.blackScreenInactive);
               }
               if(this.subForMainMenuCarouselAnimationComplete())
               {
                  this.subToPub(BMPubSub.MESSAGE_MAIN_MENU_CAROUSEL_ANIMATION_COMPLETED,this.mainMenuCarouselAnimationEnded);
                  this._taskCompletionRequirements[COMPLETION_REQ_MAIN_MENU_CAROUSEL_ANIM_COMPLETED] = false;
               }
         }
         if(this.subForScreensOpenCloseMessages())
         {
            this.subToPub(BMPubSub.MESSAGE_SCREEN_OPENED,this.screenOpened);
            this.subToPub(BMPubSub.MESSAGE_SCREEN_CLOSED,this.screenClosed);
         }
         this.handleTask();
      }
      
      private function subToPub(param1:String, param2:Function) : void
      {
         this._pubSubTokens.push(BMPubSub.sub(param1,param2));
      }
      
      private function subForScreensOpenCloseMessages() : Boolean
      {
         if(this._type != TYPE_LOCATION)
         {
            return true;
         }
         if(LOCATIONS_THAT_DONT_NEED_TO_SUB_TO_SCREENS_STATUS_CHANGES.indexOf(this._taskID) == -1)
         {
            return true;
         }
         return false;
      }
      
      private function subForBlackScreenInactiveMessage() : Boolean
      {
         if(this.subForMainMenuCarouselAnimationComplete())
         {
            return false;
         }
         if(this._durationInSeconds > 0)
         {
            return false;
         }
         if(this._type != TYPE_LOCATION)
         {
            return true;
         }
         if(LOCATIONS_THAT_DONT_NEED_TO_SUB_TO_SCREENS_STATUS_CHANGES.indexOf(this._taskID) == -1)
         {
            return true;
         }
         return false;
      }
      
      private function subForMainMenuCarouselAnimationComplete() : Boolean
      {
         if(this._taskID == SEQUENCE_MAIN_MENU_SELECT_MECH)
         {
            return true;
         }
         return false;
      }
      
      private function screenOpened(param1:String, param2:Object) : void
      {
         this.handleTask();
      }
      
      private function screenClosed(param1:String, param2:Object) : void
      {
         if(param2.screen == BMScreensManager.SCR_LEVEL_UP_NEW)
         {
            this._taskCompletionRequirements[COMPLETION_REQ_LEVEL_UP_CLOSED] = true;
         }
         else if(param2.screen == BMScreensManager.SCR_CONFIRMATION)
         {
            this._taskCompletionRequirements[COMPLETION_REQ_CONFIRMATION_SCREEN_CLOSED] = true;
         }
         this.handleTask();
      }
      
      private function isBlockedByLevelUp() : Boolean
      {
         if(this._taskCompletionRequirements[COMPLETION_REQ_LEVEL_UP_CLOSED] == null)
         {
            return false;
         }
         if(this._taskCompletionRequirements[COMPLETION_REQ_LEVEL_UP_CLOSED] == false)
         {
            return true;
         }
         return false;
      }
      
      private function handleTask() : void
      {
         switch(this._type)
         {
            case TYPE_LOCATION:
               if(this.isBlockedByLevelUp())
               {
                  return;
               }
               if(this._taskCompletionRequirements[COMPLETION_REQ_LOCATION_REACHED])
               {
                  return;
               }
               this.handleLocationTask();
               break;
            case TYPE_SEQUENCE:
               if(this._taskCompletionRequirements[COMPLETION_REQ_SEQUENCE_STARTED])
               {
                  return;
               }
               this.handleSequenceTask();
               break;
            case TYPE_DATA_UPDATE:
               if(this._taskCompletionRequirements[COMPLETION_REQ_DATA_UPDATED])
               {
                  return;
               }
               this.handleDataUpdateTask();
               break;
            case TYPE_USER_ACTION:
               this.handleUserActionTask();
         }
      }
      
      private function handleDataUpdateTask() : void
      {
         switch(this._taskID)
         {
            case DATA_UPDATE_SAVE_MECH_CHANGES:
               BMScreensManager.getInstance().screenWorkshop.updateMech();
               break;
            case DATA_UPDATE_RELOAD_QUESTS_DATA:
               BMDataManager.getInstance().questsManager.loadQuestData();
               break;
            case DATA_UPDATE_RELOAD_RAID_DATA:
               BMDataManager.getInstance().raidData.reloadRaidData();
         }
         this.dataUpdateSent();
      }
      
      private function handleSequenceTask() : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         if(this._taskID == SEQUENCE_WAIT)
         {
            this.sequenceStarted();
            return;
         }
         var _loc1_:Boolean = true;
         if(this.isScreenOpened(BMScreensManager.SCR_WORKSHOP))
         {
            switch(this._taskID)
            {
               case SEQUENCE_EQUIP_ITEM:
                  BMScreensManager.getInstance().screenWorkshop.equipItem(this._paramsObj.playerItemID,this._paramsObj.equipmentID);
                  break;
               case SEQUENCE_WORKSHOP_MECH_DANCE:
                  BMScreensManager.getInstance().screenWorkshop.tutorialTasksCompletedTaunt();
                  break;
               default:
                  _loc1_ = false;
            }
         }
         else if(this.isScreenOpened(BMScreensManager.SCR_MAIN_MENU))
         {
            switch(this._taskID)
            {
               case SEQUENCE_MAIN_MENU_MECH_DANCE:
                  BMScreensManager.getInstance().screenMainMenu.activateSelectedMechTaunt();
                  break;
               case SEQUENCE_MAIN_MENU_SELECT_MECH:
                  _loc1_ = BMScreensManager.getInstance().screenMainMenu.selectMech(this._paramsObj.mechID,this._paramsObj.forceLockedVisualEffect);
                  break;
               case SEQUENCE_MAIN_MENU_POINT_ON_MECH:
                  BMScreensManager.getInstance().screenMainMenu.pointOnMech();
                  break;
               case SEQUENCE_MAIN_MENU_REMOVE_SHADOW_FROM_MECH:
                  BMScreensManager.getInstance().screenMainMenu.removeShadowFromMech();
                  break;
               case SEQUENCE_GENERAL_MESSAGE:
                  BMScreensManager.getInstance().screenConfirmation.displayCustomMessage(this._paramsObj.message);
                  break;
               default:
                  _loc1_ = false;
            }
         }
         else if(this.isScreenOpened(BMScreensManager.SCR_BATTLE))
         {
            switch(this._taskID)
            {
               case SEQUENCE_BEFORE_BATTLE_WAVE:
                  BMScreensManager.getInstance().screenBattle.initWaveText(this._paramsObj.currentWave,this._paramsObj.wavesTotal);
                  break;
               case SEQUENCE_AFTER_BATTLE_UPGRADE:
                  BMScreensManager.getInstance().screenBattle.initUpgradeAnimation(this._paramsObj.upgradeType);
                  break;
               default:
                  _loc1_ = false;
            }
         }
         else if(this.isScreenOpened(BMScreensManager.SCR_MISSION_WORLD_MAP))
         {
            switch(this._taskID)
            {
               case SEQUENCE_WORLD_MAP_SELECT_MISSION:
                  _loc2_ = uint(this._paramsObj["missionSlot"]);
                  _loc3_ = uint(this._paramsObj["missionMode"]);
                  BMScreensManager.getInstance().screenMissionWorldMap.manuallySelectMission(_loc2_,_loc3_);
                  break;
               case SEQUENCE_WORLD_MAP_SELECT_CLAN_BOSS_MISSION:
                  BMScreensManager.getInstance().screenMissionWorldMap.manuallySelectBossMission();
            }
         }
         if(BMScreensManager.getInstance().isScreenOpened(BMScreensManager.SCR_CONFIRMATION))
         {
            if(this._taskID == SEQUENCE_CLOSE_CONFIRMATION_SCREEN)
            {
               BMScreensManager.getInstance().removeScreen(BMScreensManager.SCR_CONFIRMATION);
            }
         }
         if(_loc1_)
         {
            this.sequenceStarted();
         }
         else
         {
            this._onCompleted();
            trace("ScreensTaskDirector handleSequenceTask sequence " + this._taskID + " failed");
         }
      }
      
      private function handleLocationTask() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:String = null;
         BMScreensManager.getInstance().exitMissionBaseMapIfOpened();
         switch(this._taskID)
         {
            case LOCATION_MAIN_MENU:
               BMScreensManager.getInstance().goToMainMenu();
               break;
            case LOCATION_RAID_MENU:
               BMScreensManager.getInstance().screenTransitionsManager.raidMenuClicked();
               break;
            case LOCATION_UPGRADE:
               BMScreensManager.getInstance().screenTransitionsManager.upgrade();
               break;
            case LOCATION_CLAN:
               BMScreensManager.getInstance().screenTransitionsManager.communityClanClicked(false,this._paramsObj.tab);
               break;
            case LOCATION_QUESTS:
               _loc1_ = 1;
               if(this._paramsObj.selectedTab != null)
               {
                  _loc1_ = int(this._paramsObj.selectedTab);
               }
               _loc2_ = -1;
               if(this._paramsObj.selectedQuestID != null)
               {
                  _loc2_ = int(this._paramsObj.selectedQuestID);
               }
               BMScreensManager.getInstance().screenMainMenu.showQuestsScreen(_loc1_,_loc2_);
               break;
            case LOCATION_CAMPAIGNS_MENU:
               BMScreensManager.getInstance().screenMainMenu.onCampaignButtonHitSub();
               break;
            case LOCATION_WORKSHOP:
               BMScreensManager.getInstance().screenTransitionsManager.hangerMechClicked();
               break;
            case LOCATION_CAMPAIGN_WORLD:
               _loc3_ = uint(BMSinglePlayerManager.STORY_ID_CAMPAIGN_1V1);
               if(this._paramsObj != null && this._paramsObj["storyID"] != null)
               {
                  _loc3_ = uint(this._paramsObj["storyID"]);
               }
               BMScreensManager.getInstance().screenTransitionsManager.singlePlayerClicked(false,_loc3_);
               break;
            case LOCATION_PVP_LOBBY:
               BMScreensManager.getInstance().screenTransitionsManager.multiplayerLadderClicked();
               break;
            case LOCATION_SHOP:
               _loc4_ = null;
               BMShopManager.getInstance().showCategory(this._paramsObj.category,_loc4_);
               break;
            default:
               throw new Error("Error: screens director has no handling method for " + this._taskID);
         }
         this.locationSet();
      }
      
      private function isScreenOpened(param1:String) : Boolean
      {
         if(BMScreensManager.getInstance().getOpenedScreens().indexOf(param1) == -1)
         {
            return false;
         }
         return true;
      }
      
      private function handleUserActionTask() : void
      {
         switch(this._taskID)
         {
            case USER_ACTION_MAIN_MENU_CLICK_ON_MECH:
               break;
            case USER_ACTION_CLOSE_CONFIRMATION_SCREEN:
               if(BMScreensManager.getInstance().isScreenOpened(BMScreensManager.SCR_CONFIRMATION) == false)
               {
                  this.tryToRemoveTask();
               }
         }
      }
      
      private function mainMenuPlayerClickedOnMech(param1:String, param2:Object) : void
      {
         this._taskCompletionRequirements[COMPLETION_REQ_MAIN_MENU_PLAYER_CLICK_ON_MECH] = true;
         this.tryToRemoveTask();
      }
      
      private function workshopSwitchedToMechX(param1:String, param2:Object) : void
      {
         if(param2.mechID == null)
         {
            return;
         }
         if(int(param2.mechID) != int(this._paramsObj.mechID))
         {
            return;
         }
         this._taskCompletionRequirements[COMPLETION_REQ_WORKSHOP_SWITCH_TO_MECH_X] = true;
         BMScreensManager.getInstance().screenWorkshop.deactivateNextMechArrow();
         this.tryToRemoveTask();
      }
      
      private function dataUpdateSent() : void
      {
         this._taskCompletionRequirements[COMPLETION_REQ_DATA_UPDATED] = true;
         this.tryToRemoveTask();
      }
      
      private function locationSet() : void
      {
         this._taskCompletionRequirements[COMPLETION_REQ_LOCATION_REACHED] = true;
         this.tryToRemoveTask();
      }
      
      private function sequenceStarted() : void
      {
         this._taskCompletionRequirements[COMPLETION_REQ_SEQUENCE_STARTED] = true;
         this.tryToRemoveTask();
      }
      
      private function blackScreenInactive(param1:String, param2:Object) : void
      {
         this._taskCompletionRequirements[COMPLETION_REQ_BLACK_SCREEN_INACTIVE] = true;
         this.tryToRemoveTask();
      }
      
      private function mainMenuCarouselAnimationEnded(param1:String, param2:Object) : void
      {
         this._taskCompletionRequirements[COMPLETION_REQ_MAIN_MENU_CAROUSEL_ANIM_COMPLETED] = true;
         this.tryToRemoveTask();
      }
      
      private function tryToRemoveTask() : void
      {
         if(this.areCompletionRequirementsMet())
         {
            this._onCompleted();
         }
      }
      
      private function areCompletionRequirementsMet() : Boolean
      {
         var _loc1_:uint = 0;
         while(_loc1_ < ALL_COMPLETION_REQS.length)
         {
            if(this._taskCompletionRequirements[ALL_COMPLETION_REQS[_loc1_]] != null)
            {
               if(this._taskCompletionRequirements[ALL_COMPLETION_REQS[_loc1_]] == false)
               {
                  return false;
               }
            }
            _loc1_++;
         }
         return true;
      }
      
      private function onTimerTrigger(param1:TimerEvent) : void
      {
         this.removeTimer();
         this._taskCompletionRequirements[COMPLETION_REQ_DURATION_PASSED] = true;
         this.tryToRemoveTask();
      }
      
      private function removeTimer() : void
      {
         if(this._timer == null)
         {
            return;
         }
         this._timer.removeEventListener(TimerEvent.TIMER,this.onTimerTrigger);
         this._timer.stop();
         this._timer = null;
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function get taskID() : String
      {
         return this._taskID;
      }
      
      public function get paramsObj() : Object
      {
         return this._paramsObj;
      }
      
      public function removeMe() : void
      {
         while(this._pubSubTokens.length > 0)
         {
            BMPubSub.remove(this._pubSubTokens.pop());
         }
         this.removeTimer();
      }
   }
}

