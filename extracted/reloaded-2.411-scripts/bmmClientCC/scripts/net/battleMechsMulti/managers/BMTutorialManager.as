package net.battleMechsMulti.managers
{
   import com.greensock.TweenMax;
   import flash.display.MovieClip;
   import net.battleMechsMulti.helpers.BMCampaignMechsHelper;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   import net.battleMechsMulti.mobiles.BMPlayerItemData;
   import net.battleMechsMulti.mobiles.BMTileListItem;
   import net.battleMechsMulti.session.LoginServices;
   
   public class BMTutorialManager extends BMBaseClass
   {
      
      private static var _instance:BMTutorialManager;
      
      private static var _allowInstantiation:Boolean;
      
      public static const TUTORIAL_LEVEL_NOT_SET:uint = 0;
      
      public static const TUTORIAL_LEVEL_MECH1:uint = 1;
      
      public static const TUTORIAL_LEVEL_LONE_BATTLE1:uint = 2;
      
      public static const TUTORIAL_LEVEL_MECH2:uint = 3;
      
      public static const TUTORIAL_LEVEL_LONE_BATTLE2:uint = 4;
      
      public static const TUTORIAL_LEVEL_MECH3:uint = 5;
      
      public static const TUTORIAL_LEVEL_MISSION1:uint = 6;
      
      public static const TUTORIAL_LEVEL_SHOP1:uint = 7;
      
      public static const TUTORIAL_LEVEL_MECH4:uint = 8;
      
      public static const TUTORIAL_LEVEL_MISSION2:uint = 9;
      
      public static const TUTORIAL_LEVEL_MECH5:uint = 10;
      
      public static const TUTORIAL_LEVEL_FUSION:uint = 11;
      
      public static const TUTORIAL_LEVEL_SHOP2:uint = 12;
      
      public static const TUTORIAL_LEVEL_MISSION3:uint = 13;
      
      public static const TUTORIAL_LEVEL_COMPLETED:uint = 14;
      
      public static const TUTORIAL_DESTINATION_NONE:uint = 0;
      
      public static const TUTORIAL_DESTINATION_MECH:uint = 1;
      
      public static const TUTORIAL_DESTINATION_FUSION:uint = 2;
      
      public static const TUTORIAL_DESTINATION_SHOP:uint = 3;
      
      public static const TUTORIAL_DESTINATION_LONE_BATTLE:uint = 4;
      
      public static const TUTORIAL_DESTINATION_MISSION:uint = 5;
      
      private var _guestGenerateUserActive:Boolean = false;
      
      private var _completingLocalTutorialForRegisteredUser:Boolean = false;
      
      private var _guestRegistrationActive:Boolean = false;
      
      private var _workshop_equipItemID:Number;
      
      private var _workshop_equipItemEquipmentID:Number;
      
      private var _upgrade_forceTargetItemID:Number;
      
      private var _upgrade_forceSourceItemIDs:Array;
      
      private var _draggingFingerOriginXPos:Number;
      
      private var _draggingFingerOriginYPos:Number;
      
      private var _draggingFingerTargetXPos:Number;
      
      private var _draggingFingerTargetYPos:Number;
      
      private var _draggingFingerCounter:uint;
      
      private var _draggingFingerEndlessLoop:Boolean;
      
      private const ARROWS_AND_MARKERS_DELAY_FRAMES:uint = 80;
      
      public function BMTutorialManager()
      {
         super();
         if(!_allowInstantiation)
         {
            throw new Error("Error: Instantiation failed: Use BMTutorialManager.getInstance() instead of new.");
         }
      }
      
      public static function gi() : BMTutorialManager
      {
         if(_instance == null)
         {
            _allowInstantiation = true;
            _instance = new BMTutorialManager();
            _allowInstantiation = false;
         }
         return _instance;
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("tutorialManager");
      }
      
      public function completeLocalTutorialCheck() : void
      {
         if(this.canCompleteLocalTutorialForRegisteredUser())
         {
            this.completeLocalTutorialForRegisteredUser();
         }
         else if(this.canCreateServerGeneratedUser())
         {
            this.createServerGeneratedUser();
         }
      }
      
      public function isTutorialActive() : Boolean
      {
         var _loc1_:Boolean = false;
         if(this.getTutorialDestination() != BMTutorialManager.TUTORIAL_DESTINATION_NONE)
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      public function setTutorialLevel(param1:Number, param2:String = "") : void
      {
         if(dataM.myProfile.tutorialLevel < param1)
         {
            if(param1 == BMTutorialManager.TUTORIAL_LEVEL_COMPLETED)
            {
               param1 += 100;
            }
            dataM.myProfile.tutorialLevel = param1;
            if(this.isTutorialActive() == false)
            {
               BMSpecialOffersManager.gi().refreshSpecialOffersBoostIDs();
            }
            dataM.saveGuestData("setTutorialLevel");
         }
      }
      
      public function getTutorialDestination() : uint
      {
         var _loc1_:uint = TUTORIAL_DESTINATION_NONE;
         if((dataM.gameType == BMDataManager.GAME_TYPE_TUTORIAL || dataM.gameType == BMDataManager.GAME_TYPE_TUTORIAL_PVE) && dataM.myProfile != null)
         {
            if(dataM.myProfile.tutorialLevel < 100)
            {
               switch(dataM.myProfile.tutorialLevel)
               {
                  case TUTORIAL_LEVEL_NOT_SET:
                  case TUTORIAL_LEVEL_MECH1:
                     _loc1_ = BMTutorialManager.TUTORIAL_DESTINATION_MECH;
                     break;
                  case TUTORIAL_LEVEL_LONE_BATTLE1:
                     _loc1_ = BMTutorialManager.TUTORIAL_DESTINATION_LONE_BATTLE;
                     break;
                  case TUTORIAL_LEVEL_MECH2:
                     _loc1_ = BMTutorialManager.TUTORIAL_DESTINATION_MECH;
                     break;
                  case TUTORIAL_LEVEL_LONE_BATTLE2:
                     _loc1_ = BMTutorialManager.TUTORIAL_DESTINATION_LONE_BATTLE;
                     break;
                  case TUTORIAL_LEVEL_MECH3:
                     _loc1_ = BMTutorialManager.TUTORIAL_DESTINATION_MECH;
                     break;
                  case TUTORIAL_LEVEL_MISSION1:
                     _loc1_ = BMTutorialManager.TUTORIAL_DESTINATION_MISSION;
                     break;
                  case TUTORIAL_LEVEL_SHOP1:
                     _loc1_ = BMTutorialManager.TUTORIAL_DESTINATION_SHOP;
                     break;
                  case TUTORIAL_LEVEL_MECH4:
                     _loc1_ = BMTutorialManager.TUTORIAL_DESTINATION_MECH;
                     break;
                  case TUTORIAL_LEVEL_MISSION2:
                     _loc1_ = BMTutorialManager.TUTORIAL_DESTINATION_MISSION;
                     break;
                  case TUTORIAL_LEVEL_MECH5:
                     _loc1_ = BMTutorialManager.TUTORIAL_DESTINATION_MECH;
                     break;
                  case TUTORIAL_LEVEL_FUSION:
                     _loc1_ = BMTutorialManager.TUTORIAL_DESTINATION_FUSION;
                     break;
                  case TUTORIAL_LEVEL_SHOP2:
                     _loc1_ = BMTutorialManager.TUTORIAL_DESTINATION_SHOP;
                     break;
                  case TUTORIAL_LEVEL_MISSION3:
                     _loc1_ = BMTutorialManager.TUTORIAL_DESTINATION_MISSION;
               }
            }
         }
         return _loc1_;
      }
      
      public function traceTutorialDestination() : void
      {
         if(dataM.myProfile == null)
         {
            return;
         }
         switch(dataM.myProfile.tutorialLevel)
         {
            case TUTORIAL_LEVEL_NOT_SET:
               trace("TUTORIAL_LEVEL_NOT_SET");
               break;
            case TUTORIAL_LEVEL_MECH1:
               trace("TUTORIAL_LEVEL_MECH1");
               break;
            case TUTORIAL_LEVEL_LONE_BATTLE1:
               trace("TUTORIAL_LEVEL_LONE_BATTLE1");
               break;
            case TUTORIAL_LEVEL_MECH2:
               trace("TUTORIAL_LEVEL_MECH2");
               break;
            case TUTORIAL_LEVEL_LONE_BATTLE2:
               trace("TUTORIAL_LEVEL_LONE_BATTLE2");
               break;
            case TUTORIAL_LEVEL_MECH3:
               trace("TUTORIAL_LEVEL_MECH3");
               break;
            case TUTORIAL_LEVEL_MISSION1:
               trace("TUTORIAL_LEVEL_MISSION1");
               break;
            case TUTORIAL_LEVEL_SHOP1:
               trace("TUTORIAL_LEVEL_SHOP1");
               break;
            case TUTORIAL_LEVEL_MECH4:
               trace("TUTORIAL_LEVEL_MECH4");
               break;
            case TUTORIAL_LEVEL_MISSION2:
               trace("TUTORIAL_LEVEL_MISSION2");
               break;
            case TUTORIAL_LEVEL_MECH5:
               trace("TUTORIAL_LEVEL_MECH5");
               break;
            case TUTORIAL_LEVEL_FUSION:
               trace("TUTORIAL_LEVEL_FUSION");
               break;
            case TUTORIAL_LEVEL_SHOP2:
               trace("TUTORIAL_LEVEL_SHOP2");
               break;
            case TUTORIAL_LEVEL_MISSION3:
               trace("TUTORIAL_LEVEL_MISSION3");
               break;
            default:
               trace("TUTORIAL_LEVEL_COMPLETED");
         }
      }
      
      public function refreshWorkshopTutorial() : void
      {
         this._workshop_equipItemID = -1;
         this._workshop_equipItemEquipmentID = -1;
         screensM.screenWorkshop.mcDraggingFinger.visible = false;
         if(this.isTutorialActive())
         {
            this.workshop1Tutorial();
            this.workshop2Tutorial();
            this.workshop3Tutorial();
            this.workshop4Tutorial();
            this.workshop5Tutorial();
         }
      }
      
      private function workshop1Tutorial() : void
      {
         var _loc2_:BMPlayerItemData = null;
         var _loc3_:BMPlayerItemData = null;
         var _loc4_:BMPlayerItemData = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:uint = 0;
         var _loc9_:BMPlayerItemData = null;
         var _loc10_:uint = 0;
         var _loc11_:Boolean = false;
         if(dataM.myProfile.tutorialLevel > BMTutorialManager.TUTORIAL_LEVEL_LONE_BATTLE1)
         {
            return;
         }
         var _loc1_:Boolean = false;
         if(dataM.myProfile.tutorialLevel == BMTutorialManager.TUTORIAL_LEVEL_LONE_BATTLE1)
         {
            _loc1_ = true;
            this._workshop_equipItemID = 9999;
         }
         else
         {
            this.deactivateDraggingFinger();
            this.setTutorialLevel(BMTutorialManager.TUTORIAL_LEVEL_MECH1);
            _loc5_ = -1;
            _loc6_ = -1;
            _loc7_ = -1;
            _loc8_ = 0;
            while(_loc8_ < dataM.myPlayerData.items.length)
            {
               _loc9_ = dataM.myPlayerData.items[_loc8_];
               switch(_loc9_.itemID)
               {
                  case BMCampaignMechsHelper.getTutorial_hanger1_torso():
                     _loc2_ = dataM.myPlayerData.items[_loc8_];
                     _loc5_ = screensM.screenWorkshop.inventoryTileList.findTileIDByTileListItemID(_loc2_.playerItemID);
                     break;
                  case BMCampaignMechsHelper.getTutorial_hanger1_leg():
                     _loc3_ = dataM.myPlayerData.items[_loc8_];
                     _loc6_ = screensM.screenWorkshop.inventoryTileList.findTileIDByTileListItemID(_loc3_.playerItemID);
                     break;
                  case BMCampaignMechsHelper.getTutorial_hanger1_sideWeapon():
                     _loc4_ = dataM.myPlayerData.items[_loc8_];
                     _loc7_ = screensM.screenWorkshop.inventoryTileList.findTileIDByTileListItemID(_loc4_.playerItemID);
               }
               _loc8_++;
            }
            if(_loc2_ != null && _loc3_ != null && _loc4_ != null)
            {
               if(_loc2_.equipped == 0)
               {
                  this.displayTutorialMarker_inventory(_loc5_,true);
                  this._workshop_equipItemID = _loc2_.itemID;
                  _loc10_ = _loc2_.playerItemID;
               }
               else if(_loc3_.equipped == 0)
               {
                  this.displayTutorialMarker_inventory(_loc6_,true);
                  this._workshop_equipItemID = _loc3_.itemID;
                  _loc10_ = _loc3_.playerItemID;
               }
               else if(_loc4_.equipped == 0)
               {
                  this.displayTutorialMarker_inventory(_loc7_,true);
                  this._workshop_equipItemID = _loc4_.itemID;
                  this._workshop_equipItemEquipmentID = 1;
                  _loc10_ = _loc4_.playerItemID;
               }
               else
               {
                  _loc1_ = true;
                  this._workshop_equipItemID = 9999;
               }
               if(this._workshop_equipItemID > 0 && this._workshop_equipItemID < 9999)
               {
                  _loc11_ = false;
                  if(_loc2_.equipped == 0)
                  {
                     _loc11_ = true;
                  }
                  this.activateDraggingFinger(this._workshop_equipItemID,_loc10_,_loc11_);
               }
            }
         }
         if(_loc1_)
         {
            this.setTutorialLevel(BMTutorialManager.TUTORIAL_LEVEL_LONE_BATTLE1);
            screensM.screenWorkshop.inventoryTileList.deactivateGuideArrow();
            screensM.screenWorkshop.inventoryTileList.deactivateAllAnimatedMarkers();
            screensM.screenWorkshop.tutorialTasksCompletedTaunt(this.workshop_goToBattle);
         }
      }
      
      private function workshop2Tutorial() : void
      {
         var _loc2_:BMPlayerItemData = null;
         var _loc3_:BMPlayerItemData = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:uint = 0;
         var _loc7_:BMPlayerItemData = null;
         if(dataM.myProfile.tutorialLevel < BMTutorialManager.TUTORIAL_LEVEL_MECH2)
         {
            return;
         }
         if(dataM.myProfile.tutorialLevel > BMTutorialManager.TUTORIAL_LEVEL_LONE_BATTLE2)
         {
            return;
         }
         var _loc1_:Boolean = false;
         if(dataM.myProfile.tutorialLevel == BMTutorialManager.TUTORIAL_LEVEL_LONE_BATTLE2)
         {
            _loc1_ = true;
            this._workshop_equipItemID = 9999;
         }
         else
         {
            this.setTutorialLevel(BMTutorialManager.TUTORIAL_LEVEL_MECH2,"screenHangerMenu refreshTutorial hanger2");
            _loc4_ = -1;
            _loc5_ = -1;
            _loc6_ = 0;
            while(_loc6_ < dataM.myPlayerData.items.length)
            {
               _loc7_ = dataM.myPlayerData.items[_loc6_];
               switch(_loc7_.itemID)
               {
                  case BMCampaignMechsHelper.getTutorial_hanger2_torso():
                     _loc2_ = dataM.myPlayerData.items[_loc6_];
                     _loc4_ = screensM.screenWorkshop.inventoryTileList.findTileIDByTileListItemID(_loc2_.playerItemID);
                     break;
                  case BMCampaignMechsHelper.getTutorial_hanger2_sideWeapon():
                     _loc3_ = dataM.myPlayerData.items[_loc6_];
                     _loc5_ = screensM.screenWorkshop.inventoryTileList.findTileIDByTileListItemID(_loc3_.playerItemID);
               }
               _loc6_++;
            }
            if(_loc2_.equipped == 0)
            {
               this.displayTutorialMarker_inventory(_loc4_,true);
               this._workshop_equipItemID = _loc2_.itemID;
            }
            else if(_loc3_.equipped == 0)
            {
               this.displayTutorialMarker_inventory(_loc5_,true);
               this._workshop_equipItemID = _loc3_.itemID;
               this._workshop_equipItemEquipmentID = 2;
            }
            else
            {
               _loc1_ = true;
               this._workshop_equipItemID = 9999;
            }
         }
         if(_loc1_)
         {
            this.setTutorialLevel(BMTutorialManager.TUTORIAL_LEVEL_LONE_BATTLE2);
            screensM.screenWorkshop.inventoryTileList.deactivateGuideArrow();
            screensM.screenWorkshop.inventoryTileList.deactivateAllAnimatedMarkers();
            screensM.screenWorkshop.tutorialTasksCompletedTaunt(this.workshop_goToBattle);
         }
      }
      
      private function workshop3Tutorial() : void
      {
         var _loc2_:BMPlayerItemData = null;
         var _loc3_:BMPlayerItemData = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:uint = 0;
         var _loc7_:BMPlayerItemData = null;
         if(dataM.myProfile.tutorialLevel < BMTutorialManager.TUTORIAL_LEVEL_MECH3)
         {
            return;
         }
         if(dataM.myProfile.tutorialLevel > BMTutorialManager.TUTORIAL_LEVEL_MISSION1)
         {
            return;
         }
         var _loc1_:Boolean = false;
         if(dataM.myProfile.tutorialLevel == BMTutorialManager.TUTORIAL_LEVEL_MISSION1)
         {
            _loc1_ = true;
            this._workshop_equipItemID = 9999;
         }
         else
         {
            this.setTutorialLevel(BMTutorialManager.TUTORIAL_LEVEL_MECH3,"screenHangerMenu refreshTutorial hanger3");
            _loc4_ = -1;
            _loc5_ = -1;
            _loc6_ = 0;
            while(_loc6_ < dataM.myPlayerData.items.length)
            {
               _loc7_ = dataM.myPlayerData.items[_loc6_];
               switch(_loc7_.itemID)
               {
                  case BMCampaignMechsHelper.getTutorial_hanger3_torso():
                     _loc2_ = dataM.myPlayerData.items[_loc6_];
                     _loc4_ = screensM.screenWorkshop.inventoryTileList.findTileIDByTileListItemID(_loc2_.playerItemID);
                     break;
                  case BMCampaignMechsHelper.getTutorial_hanger3_sideWeapon():
                     _loc3_ = dataM.myPlayerData.items[_loc6_];
                     _loc5_ = screensM.screenWorkshop.inventoryTileList.findTileIDByTileListItemID(_loc3_.playerItemID);
               }
               _loc6_++;
            }
            if(_loc2_.equipped == 0)
            {
               this.displayTutorialMarker_inventory(_loc4_,true);
               this._workshop_equipItemID = _loc2_.itemID;
            }
            else if(_loc3_.equipped == 0)
            {
               this.displayTutorialMarker_inventory(_loc5_,true);
               this._workshop_equipItemID = _loc3_.itemID;
               this._workshop_equipItemEquipmentID = 1;
            }
            else
            {
               _loc1_ = true;
               this._workshop_equipItemID = 9999;
            }
         }
         if(_loc1_)
         {
            this.setTutorialLevel(BMTutorialManager.TUTORIAL_LEVEL_MISSION1);
            screensM.screenWorkshop.inventoryTileList.deactivateGuideArrow();
            screensM.screenWorkshop.inventoryTileList.deactivateAllAnimatedMarkers();
            screensM.screenWorkshop.tutorialTasksCompletedTaunt(this.workshop_goToMainMenu);
         }
      }
      
      private function workshop4Tutorial() : void
      {
         var _loc2_:BMPlayerItemData = null;
         var _loc3_:BMPlayerItemData = null;
         var _loc4_:BMPlayerItemData = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:uint = 0;
         var _loc9_:BMPlayerItemData = null;
         if(dataM.myProfile.tutorialLevel < BMTutorialManager.TUTORIAL_LEVEL_MECH4)
         {
            return;
         }
         if(dataM.myProfile.tutorialLevel > BMTutorialManager.TUTORIAL_LEVEL_MISSION2)
         {
            return;
         }
         var _loc1_:Boolean = false;
         if(dataM.myProfile.tutorialLevel == BMTutorialManager.TUTORIAL_LEVEL_MISSION2)
         {
            _loc1_ = true;
            this._workshop_equipItemID = 9999;
         }
         else
         {
            this.setTutorialLevel(BMTutorialManager.TUTORIAL_LEVEL_MECH4,"screenHangerMenu refreshTutorial hanger4");
            _loc5_ = -1;
            _loc6_ = -1;
            _loc7_ = -1;
            _loc8_ = 0;
            while(_loc8_ < dataM.myPlayerData.items.length)
            {
               _loc9_ = dataM.myPlayerData.items[_loc8_];
               switch(_loc9_.itemID)
               {
                  case BMCampaignMechsHelper.getTutorial_hanger4_sideWeapon():
                     _loc2_ = dataM.myPlayerData.items[_loc8_];
                     _loc5_ = screensM.screenWorkshop.inventoryTileList.findTileIDByTileListItemID(_loc2_.playerItemID);
                     break;
                  case BMCampaignMechsHelper.getTutorial_hanger4_topWeapon():
                     _loc3_ = dataM.myPlayerData.items[_loc8_];
                     _loc6_ = screensM.screenWorkshop.inventoryTileList.findTileIDByTileListItemID(_loc3_.playerItemID);
                     break;
                  case BMCampaignMechsHelper.getTutorial_hanger4_module():
                     _loc4_ = dataM.myPlayerData.items[_loc8_];
                     _loc7_ = screensM.screenWorkshop.inventoryTileList.findTileIDByTileListItemID(_loc4_.playerItemID);
               }
               _loc8_++;
            }
            if(_loc2_.equipped == 0)
            {
               this.displayTutorialMarker_inventory(_loc5_,true);
               this._workshop_equipItemID = _loc2_.itemID;
               this._workshop_equipItemEquipmentID = 2;
            }
            else if(_loc3_.equipped == 0)
            {
               this.displayTutorialMarker_inventory(_loc6_,true);
               this._workshop_equipItemID = _loc3_.itemID;
               this._workshop_equipItemEquipmentID = 1;
            }
            else if(_loc4_.equipped == 0)
            {
               this.displayTutorialMarker_inventory(_loc7_,true);
               this._workshop_equipItemID = _loc4_.itemID;
               this._workshop_equipItemEquipmentID = 1;
            }
            else
            {
               _loc1_ = true;
               this._workshop_equipItemID = 9999;
            }
         }
         if(_loc1_)
         {
            this.setTutorialLevel(BMTutorialManager.TUTORIAL_LEVEL_MISSION2);
            screensM.screenWorkshop.inventoryTileList.deactivateGuideArrow();
            screensM.screenWorkshop.inventoryTileList.deactivateAllAnimatedMarkers();
            screensM.screenWorkshop.tutorialTasksCompletedTaunt(this.workshop_goToMainMenu);
         }
      }
      
      private function workshop5Tutorial() : void
      {
         var _loc2_:BMPlayerItemData = null;
         var _loc3_:BMPlayerItemData = null;
         var _loc4_:BMPlayerItemData = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:uint = 0;
         var _loc9_:BMPlayerItemData = null;
         if(dataM.myProfile.tutorialLevel < BMTutorialManager.TUTORIAL_LEVEL_MECH5)
         {
            return;
         }
         if(dataM.myProfile.tutorialLevel > BMTutorialManager.TUTORIAL_LEVEL_FUSION)
         {
            return;
         }
         var _loc1_:Boolean = false;
         if(dataM.myProfile.tutorialLevel == BMTutorialManager.TUTORIAL_LEVEL_FUSION)
         {
            _loc1_ = true;
            this._workshop_equipItemID = 9999;
         }
         else
         {
            this.setTutorialLevel(BMTutorialManager.TUTORIAL_LEVEL_MECH4,"screenHangerMenu refreshTutorial hanger4");
            _loc5_ = -1;
            _loc6_ = -1;
            _loc7_ = -1;
            _loc8_ = 0;
            while(_loc8_ < dataM.myPlayerData.items.length)
            {
               _loc9_ = dataM.myPlayerData.items[_loc8_];
               switch(_loc9_.itemID)
               {
                  case BMCampaignMechsHelper.getTutorial_hanger5_leg():
                     _loc2_ = dataM.myPlayerData.items[_loc8_];
                     _loc5_ = screensM.screenWorkshop.inventoryTileList.findTileIDByTileListItemID(_loc2_.playerItemID);
                     break;
                  case BMCampaignMechsHelper.getTutorial_hanger5_module():
                     _loc3_ = dataM.myPlayerData.items[_loc8_];
                     _loc6_ = screensM.screenWorkshop.inventoryTileList.findTileIDByTileListItemID(_loc3_.playerItemID);
                     break;
                  case BMCampaignMechsHelper.getTutorial_hanger5_drone():
                     _loc4_ = dataM.myPlayerData.items[_loc8_];
                     _loc7_ = screensM.screenWorkshop.inventoryTileList.findTileIDByTileListItemID(_loc4_.playerItemID);
               }
               _loc8_++;
            }
            if(_loc2_.equipped == 0)
            {
               this.displayTutorialMarker_inventory(_loc5_,true);
               this._workshop_equipItemID = _loc2_.itemID;
            }
            else if(_loc3_.equipped == 0)
            {
               this.displayTutorialMarker_inventory(_loc6_,true);
               this._workshop_equipItemID = _loc3_.itemID;
               this._workshop_equipItemEquipmentID = 2;
            }
            else if(_loc4_.equipped == 0)
            {
               this.displayTutorialMarker_inventory(_loc7_,true);
               this._workshop_equipItemID = _loc4_.itemID;
            }
            else
            {
               _loc1_ = true;
               this._workshop_equipItemID = 9999;
            }
         }
         if(_loc1_)
         {
            this.setTutorialLevel(BMTutorialManager.TUTORIAL_LEVEL_FUSION);
            screensM.screenWorkshop.activateBackTutorialArrow();
            screensM.screenWorkshop.disableInventory();
            screensM.screenWorkshop.disableMech();
            screensM.screenWorkshop.disableCategories();
            screensM.screenWorkshop.inventoryTileList.deactivateGuideArrow();
            screensM.screenWorkshop.inventoryTileList.deactivateAllAnimatedMarkers();
            screensM.screenWorkshop.tutorialTasksCompletedTaunt();
            screensM.screenWorkshop.btnBack.visible = true;
         }
      }
      
      private function workshop_goToBattle() : void
      {
         dataM.saveGuestData("tutorialManager_workshop_goToBattle");
         screensM.removeScreen("screenWorkshop");
         dataM.startBattleVSComputer("regular","");
         screensM.addBattleScreens();
      }
      
      private function workshop_goToMainMenu() : void
      {
         dataM.saveGuestData("tutorialManager_workshop_goToBattle");
         screensM.screenWorkshop.backClicked();
      }
      
      public function workshop_upgradeButtonVisible() : Boolean
      {
         if(this.isTutorialActive())
         {
            if(dataM.myProfile.tutorialLevel != TUTORIAL_LEVEL_FUSION)
            {
               return false;
            }
         }
         return true;
      }
      
      private function displayTutorialMarker_inventory(param1:Number, param2:Boolean) : void
      {
         if(param2)
         {
            screensM.screenWorkshop.inventoryTileList.addGuideArrow(new mcGuideArrow_delay80());
            screensM.screenWorkshop.inventoryTileList.activateGuideArrow(param1,"tileID",this.ARROWS_AND_MARKERS_DELAY_FRAMES);
            screensM.screenWorkshop.inventoryTileList.activateAnimatedMarker(param1,"tileID",0);
         }
         else
         {
            screensM.screenWorkshop.inventoryTileList.addGuideArrow(new mcGuideArrow());
            screensM.screenWorkshop.inventoryTileList.activateGuideArrow(param1,"tileID",0);
            screensM.screenWorkshop.inventoryTileList.activateAnimatedMarker(param1,"tileID",0);
         }
      }
      
      private function activateDraggingFinger(param1:uint, param2:uint, param3:Boolean = false) : void
      {
         var _loc5_:BMTileListItem = null;
         var _loc6_:String = null;
         var _loc4_:MovieClip = this.getCurrentDraggingFinger();
         if(this.getTutorialDestination() == BMTutorialManager.TUTORIAL_DESTINATION_MECH)
         {
            _loc5_ = screensM.screenWorkshop.inventoryTileList.findTileListItemByTileListItemID(param2);
            this._draggingFingerOriginXPos = screensM.screenWorkshop.inventoryPlaceHolder.x + _loc5_.x;
            this._draggingFingerOriginYPos = screensM.screenWorkshop.inventoryPlaceHolder.y + _loc5_.y;
            this._draggingFingerTargetXPos = screensM.screenWorkshop.mechViewHolder.x;
            this._draggingFingerTargetYPos = screensM.screenWorkshop.mechViewHolder.y - 100;
            switch(this._workshop_equipItemID)
            {
               case BMCampaignMechsHelper.getTutorial_hanger1_torso():
                  _loc6_ = "torso1";
                  break;
               case BMCampaignMechsHelper.getTutorial_hanger1_sideWeapon():
                  _loc6_ = "weapon1";
                  break;
               case BMCampaignMechsHelper.getTutorial_hanger1_leg():
                  _loc6_ = "leg1";
            }
            _loc4_.gotoAndStop(_loc6_);
            this._draggingFingerCounter = 0;
            this._draggingFingerEndlessLoop = param3;
            this.activateDraggingFingerSub();
         }
      }
      
      private function activateDraggingFingerSub() : void
      {
         var _loc1_:MovieClip = this.getCurrentDraggingFinger();
         TweenMax.fromTo(_loc1_,0.8,{
            "x":this._draggingFingerOriginXPos,
            "y":this._draggingFingerOriginYPos,
            "alpha":1,
            "visible":true
         },{
            "x":this._draggingFingerTargetXPos,
            "y":this._draggingFingerTargetYPos,
            "onComplete":this.draggingFingerMoveAnimationEnded
         });
      }
      
      private function draggingFingerMoveAnimationEnded() : void
      {
         var _loc1_:MovieClip = this.getCurrentDraggingFinger();
         TweenMax.to(_loc1_,0.3,{
            "delay":0.4,
            "alpha":0,
            "onComplete":this.draggingFingerAlphaOutAnimationEnded
         });
      }
      
      private function draggingFingerAlphaOutAnimationEnded() : void
      {
         if(this._draggingFingerEndlessLoop == false)
         {
            ++this._draggingFingerCounter;
         }
         if(this._draggingFingerCounter < 4)
         {
            this.activateDraggingFingerSub();
         }
         else
         {
            this.deactivateDraggingFinger();
         }
      }
      
      private function deactivateDraggingFinger() : void
      {
         var _loc1_:MovieClip = null;
         _loc1_ = this.getCurrentDraggingFinger();
         _loc1_.visible = false;
         TweenMax.killTweensOf(_loc1_);
      }
      
      private function getCurrentDraggingFinger() : MovieClip
      {
         var _loc1_:MovieClip = null;
         if(this.getTutorialDestination() == BMTutorialManager.TUTORIAL_DESTINATION_MECH)
         {
            _loc1_ = screensM.screenWorkshop.mcDraggingFinger;
            screensM.screenWorkshop.mcDraggingFinger.mouseEnabled = false;
            screensM.screenWorkshop.mcDraggingFinger.mouseChildren = false;
         }
         return _loc1_;
      }
      
      public function refreshUpgradeTutorial() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         if(this.isTutorialActive())
         {
            if(dataM.myProfile.tutorialLevel > TUTORIAL_LEVEL_FUSION)
            {
               this._upgrade_forceTargetItemID = 9999;
               screensM.screenHangerUpgrade.activateBackTutorialArrow_back();
               screensM.screenHangerUpgrade.deactivateTutorialArrow_boost();
               screensM.screenHangerUpgrade.btnBack.visible = true;
            }
            else
            {
               this._upgrade_forceTargetItemID = BMCampaignMechsHelper.getTutorial_hanger3_torso();
               this._upgrade_forceSourceItemIDs = new Array();
               this._upgrade_forceSourceItemIDs.push(BMCampaignMechsHelper.getTutorial_hanger1_torso());
               this._upgrade_forceSourceItemIDs.push(BMCampaignMechsHelper.getTutorial_hanger1_leg());
               this._upgrade_forceSourceItemIDs.push(BMCampaignMechsHelper.getTutorial_hanger1_sideWeapon());
               _loc1_ = false;
               _loc2_ = -1;
               if(screensM.screenHangerUpgrade.currentUpgradePanel == null)
               {
                  _loc1_ = true;
               }
               else
               {
                  _loc2_ = int(screensM.screenHangerUpgrade.currentUpgradePanel.getSourcePlayerItemIDs().length);
                  if(_loc2_ < 3)
                  {
                     _loc1_ = true;
                  }
               }
               screensM.screenHangerUpgrade.btnBack.visible = false;
               screensM.screenHangerUpgrade.inventoryTileList.deactivateGuideArrow();
               screensM.screenHangerUpgrade.inventoryTileList.deactivateAllAnimatedMarkers();
               if(_loc1_)
               {
                  _loc3_ = this._upgrade_forceTargetItemID;
                  if(_loc2_ != -1)
                  {
                     _loc3_ = Number(this._upgrade_forceSourceItemIDs[_loc2_]);
                  }
                  _loc4_ = this.findPlayerItemByItemID(_loc3_);
                  _loc5_ = screensM.screenHangerUpgrade.inventoryTileList.findTileIDByTileListItemID(_loc4_);
                  screensM.screenHangerUpgrade.inventoryTileList.addGuideArrow(new mcGuideArrow());
                  screensM.screenHangerUpgrade.inventoryTileList.activateGuideArrow(_loc5_,"tileID",0);
                  screensM.screenHangerUpgrade.inventoryTileList.activateAnimatedMarker(_loc5_,"tileID",0);
                  screensM.screenHangerUpgrade.btnUpgrade.disableMe();
               }
               else
               {
                  screensM.screenHangerUpgrade.activateBackTutorialArrow_boost();
                  screensM.screenHangerUpgrade.btnUpgrade.enableMe();
               }
            }
         }
      }
      
      private function findPlayerItemByItemID(param1:Number) : Number
      {
         var _loc2_:int = 0;
         while(_loc2_ < dataM.myPlayerData.items.length)
         {
            if(BMPlayerItemData(dataM.myPlayerData.items[_loc2_]).itemID == param1)
            {
               return dataM.myPlayerData.items[_loc2_].playerItemID;
            }
            _loc2_++;
         }
         return -1;
      }
      
      public function upgrade_canSelectTargetItem(param1:Number) : Boolean
      {
         if(this.isTutorialActive())
         {
            if(this.upgrade_forceTargetItemID > 0)
            {
               if(param1 != this.upgrade_forceTargetItemID)
               {
                  return false;
               }
            }
         }
         return true;
      }
      
      public function upgrade_canSelectSourceItem(param1:Number, param2:int) : Boolean
      {
         if(this.isTutorialActive())
         {
            if(this.upgrade_forceSourceItemIDs.length > 0)
            {
               return this.upgrade_forceSourceItemIDs[param2] == param1;
            }
         }
         return true;
      }
      
      public function upgrade_isInventoryEnabled() : Boolean
      {
         if(this.isTutorialActive())
         {
            if(this.getTutorialDestination() != BMTutorialManager.TUTORIAL_DESTINATION_FUSION)
            {
               return false;
            }
         }
         return true;
      }
      
      public function hangerUpgradeClicked() : void
      {
         if(this.isTutorialActive())
         {
            this.setTutorialLevel(BMTutorialManager.TUTORIAL_LEVEL_SHOP2);
            this._upgrade_forceTargetItemID = 0;
            this._upgrade_forceSourceItemIDs = new Array();
         }
      }
      
      private function createServerGeneratedUser() : void
      {
         this._guestGenerateUserActive = true;
         BMLoginManager.gi().loginType = BMLoginManager.LOGIN_TYPE_REGISTER_GENERATED;
         BMLoginManager.gi().doExternalLogin(LoginServices.GENERATED_USER,"",dataM.installationData.deviceId);
         screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
      }
      
      private function canCreateServerGeneratedUser() : Boolean
      {
         var _loc1_:Boolean = false;
         if(dataM.myProfile.tutorialLevel >= BMTutorialManager.TUTORIAL_LEVEL_MISSION3 && loginM.isConnected == false)
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      public function get guestGenerateUserActive() : Boolean
      {
         return this._guestGenerateUserActive;
      }
      
      public function completeGeneratingGuestUser() : void
      {
         this._guestGenerateUserActive = false;
         dataM.resetGuestSharedObject("tutorialManager_completeGeneratingGuestUser");
      }
      
      private function completeLocalTutorialForRegisteredUser() : void
      {
         remoteM.socketM.getInitialData(true,true);
         dataM.rerunLoginManager_gotPlayerData = true;
         dataM.allowNameChangeAfterRegister = true;
         this._completingLocalTutorialForRegisteredUser = true;
      }
      
      private function canCompleteLocalTutorialForRegisteredUser() : Boolean
      {
         var _loc1_:Boolean = false;
         if(dataM.gameType == BMDataManager.GAME_TYPE_TUTORIAL && dataM.myProfile.tutorialLevel >= BMTutorialManager.TUTORIAL_LEVEL_MISSION3 && loginM.isConnected)
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      public function get completingLocalTutorialForRegisteredUser() : Boolean
      {
         return this._completingLocalTutorialForRegisteredUser;
      }
      
      public function localTutorialForRegisteredUserCompleted() : void
      {
         dataM.resetGuestSharedObject("tutorialManager_localTutorialForRegisteredUserCompleted");
         this._completingLocalTutorialForRegisteredUser = false;
      }
      
      public function get guestRegistrationActive() : Boolean
      {
         return this._guestRegistrationActive;
      }
      
      public function set guestRegistrationActive(param1:Boolean) : void
      {
         this._guestRegistrationActive = param1;
      }
      
      public function get workshop_equipItemID() : Number
      {
         return this._workshop_equipItemID;
      }
      
      public function get workshop_equipItemEquipmentID() : Number
      {
         return this._workshop_equipItemEquipmentID;
      }
      
      public function get upgrade_forceTargetItemID() : Number
      {
         return this._upgrade_forceTargetItemID;
      }
      
      public function get upgrade_forceSourceItemIDs() : Array
      {
         return this._upgrade_forceSourceItemIDs;
      }
   }
}

