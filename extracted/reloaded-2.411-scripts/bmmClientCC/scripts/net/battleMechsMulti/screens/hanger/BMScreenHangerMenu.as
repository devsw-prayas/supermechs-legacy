package net.battleMechsMulti.screens.hanger
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.battleMechsMulti.helpers.BMCampaignMechsHelper;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMShopManager;
   import net.battleMechsMulti.managers.BMTutorialManager;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.mobiles.BMPlayerData;
   import net.battleMechsMulti.mobiles.BMPlayerItemData;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.BMTileListItem;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureI;
   import net.battleMechsMulti.mobiles.pointersAndMarkers.BMTutorialArrowController;
   import net.battleMechsMulti.screens.BMBaseScreen;
   import net.battleMechsMulti.utils.FeatureFlags;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1337")]
   public class BMScreenHangerMenu extends BMBaseScreen
   {
      
      public var mcSizer_btnMech:Sprite;
      
      public var mcSizer_btnFusion:Sprite;
      
      public var mcSizer_btnBack:Sprite;
      
      public var mcSizer_btnChangeMechsOrder:Sprite;
      
      public var btnMech:BMButton_pictureE;
      
      public var btnFusion:BMButton_pictureE;
      
      public var btnBack:BMButton_pictureI;
      
      public var btnChangeMechsOrder:BMButton_pictureE;
      
      public var mcTutorialArrow:Sprite;
      
      public var mcButtonsHolder:Sprite;
      
      public var mcIconsHolder:Sprite;
      
      public var mcButtonMarker:Sprite;
      
      public var txtMech:TextField;
      
      public var txtFusion:TextField;
      
      public var txtChangeMechsOrder:TextField;
      
      private var _currentPlayerData:BMPlayerData;
      
      public var tutorialPhase:String = "none";
      
      private var _lastTutorialPhase:String;
      
      public var screenStatus:String;
      
      public var hangerEnabled:Boolean;
      
      private var _updateMech_selectedMechID:uint;
      
      private var _updateMech_lastTorsoPlayerItemIDs:Array;
      
      private var _updateMech_lastItems:Array;
      
      private var _changeStatusOnNextFrame:String = "";
      
      private var _stppedTutorialForLevelUpBonus:Boolean;
      
      private var _tutorialArrowController:BMTutorialArrowController;
      
      private var _makingSureMechIsEquipped_lastTutorialLevel:Number = -1;
      
      public var btnLogout:BMButton_pictureE;
      
      public var mcMechComplete:MovieClip;
      
      public var returnToMenuMultiPlayer:Boolean = false;
      
      public var returnToMissionBaseMap:Boolean = false;
      
      private const ARROWS_AND_MARKERS_DELAY_FRAMES:uint = 80;
      
      private var _firstRefresh:Boolean = true;
      
      private var _postUpdateMechDestinationIsFusion:* = false;
      
      public function BMScreenHangerMenu()
      {
         super();
      }
      
      public function initialize() : void
      {
         TsLogger.log("BMScreenHangerMenu initialized");
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("hanger");
         if(dataM.runAsMobile == false)
         {
            screensM.stagePointer.addEventListener(MouseEvent.MOUSE_UP,this.stageMouseUp);
         }
         this.mcMechComplete.visible = false;
         this.hangerEnabled = true;
      }
      
      public function refreshScreen(param1:String, param2:Boolean = false) : void
      {
         var _loc4_:Function = null;
         var _loc5_:Function = null;
         var _loc6_:Function = null;
         if(this._firstRefresh)
         {
            screensM.createButtonFromSizer("screenHangerMenu","btnMech","pictureE");
            screensM.createButtonFromSizer("screenHangerMenu","btnFusion","pictureE");
            screensM.createButtonFromSizer("screenHangerMenu","btnBack","pictureI");
            screensM.createButtonFromSizer("screenHangerMenu","btnChangeMechsOrder","pictureE");
            _loc4_ = this.mechClicked;
            _loc5_ = this.fusionClicked;
            _loc6_ = this.backClicked;
            if(dataM.runAsMobile)
            {
               _loc4_ = null;
               _loc5_ = null;
               _loc6_ = null;
            }
            this.btnMech.initialize("","",externalAssetsM.getAsset("general","interface_mech"),null,_loc4_,dataM.runAsMobile);
            this.btnFusion.initialize("","",externalAssetsM.getAsset("general","interface_fusion"),null,_loc5_,dataM.runAsMobile);
            this.btnBack.initialize("","",externalAssetsM.getAsset("general","interface_back2"),null,_loc6_,dataM.runAsMobile);
            this.btnChangeMechsOrder.initialize("","",externalAssetsM.getAsset("general","interface_changeMechsOrder"),null,this.changeMechsOrderClicked,dataM.runAsMobile);
            this.btnMech.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnFusion.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnChangeMechsOrder.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnBack.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this._tutorialArrowController = new BMTutorialArrowController(this.mcTutorialArrow);
            this._firstRefresh = false;
         }
         this._stppedTutorialForLevelUpBonus = false;
         this._currentPlayerData = dataM.playersData[dataM.player1PlayerID];
         var _loc3_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         this.tutorialPhase = "none";
         this._lastTutorialPhase = "none";
         this.screenStatus = "";
         dataM.tutorialEnabled = true;
         if(tutorialM.isTutorialActive() == false)
         {
            dataM.tutorialEnabled = false;
         }
         dataM.updateMechStructure(dataM.player1PlayerID,1);
         if(dataM.hanger_newItemsForDisplay.length > 0)
         {
            screensM.addScreen("screenItemCards");
            screensM.screenItemCards.refreshScreen(dataM.hanger_newItemsForDisplay,25);
            dataM.hanger_newItemsForDisplay = new Array();
         }
         if(param2 == false)
         {
            this.createUpdateMechLastData();
         }
         this.mcButtonMarker.visible = false;
         switch(param1)
         {
            case "mech":
               this.mechClicked();
               break;
            case "shopCombined":
               this.shopCombinedClicked();
               break;
            case "shopRegular":
               this.shopRegularClicked();
               break;
            case "shopMythical":
               this.shopMythicalClicked();
               break;
            case "fusion":
               this.fusionClicked();
               break;
            case "gifts":
               this.giftsClicked();
         }
         if(dataM.tutorialEnabled == false)
         {
            screensM.screenTopBar.enableButtons("hangerMenu refreshScreen");
         }
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(parent != null)
         {
            this._tutorialArrowController.runFrame();
            if(this._changeStatusOnNextFrame != "")
            {
               screensM.removeScreen("screenConfirmation");
               switch(this._changeStatusOnNextFrame)
               {
                  case "mech":
                     this.mechClickedSub();
                     break;
                  case "shopCombined":
                     this.shopCombinedClickedSub();
                     break;
                  case "shopRegular":
                     this.shopRegularClickedSub();
                     break;
                  case "shopMythical":
                     this.shopMythicalClickedSub();
                     break;
                  case "fusion":
                     this.fusionClickedSub();
                     break;
                  case "gifts":
                     this.giftsClickedSub();
               }
               this._changeStatusOnNextFrame = "";
            }
         }
      }
      
      private function stageMouseUp(param1:MouseEvent) : void
      {
         this.stageMouseUpSub();
      }
      
      public function stageMouseUpSub() : void
      {
         if(screensM.isScreenOpened("screenHangerInventory"))
         {
            screensM.screenHangerInventory.stopDraggingItem("stageMouseUp");
            screensM.screenHangerInventory.cancelFingerWheeling();
         }
         if(screensM.isScreenOpened("screenHangerShop"))
         {
            screensM.screenHangerShop.cancelFingerWheeling();
         }
      }
      
      private function showButtonMarker(param1:BMButton_pictureE) : void
      {
         this.mcButtonMarker.x = param1.x;
         this.mcButtonMarker.y = param1.y;
         if(param1.visible)
         {
            this.mcButtonMarker.visible = true;
         }
         else
         {
            this.mcButtonMarker.visible = false;
         }
      }
      
      public function shopCombinedClicked() : void
      {
         if(this.screenStatus != "shopCombined")
         {
            if(dataM.runAsMobile)
            {
               screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait",-1,-1);
               this._changeStatusOnNextFrame = "shopCombined";
            }
            else
            {
               this.shopCombinedClickedSub();
            }
         }
      }
      
      private function shopCombinedClickedSub() : void
      {
         this.screenStatus = "shopCombined";
         if(dataM.runAsMobile)
         {
            screensM.screenHangerBackground.gotoAndStop("shopCombined_mobile");
         }
         else
         {
            screensM.screenHangerBackground.gotoAndStop("shopCombined");
         }
         if(screensM.isScreenOpened("screenHangerInventory"))
         {
            screensM.screenHangerInventory.removeMe();
         }
         if(screensM.isScreenOpened("screenHangerMech"))
         {
            screensM.screenHangerMech.removeMe();
         }
         if(screensM.isScreenOpened("screenHangerFusion"))
         {
            screensM.screenHangerFusion.removeMe();
         }
         if(screensM.isScreenOpened("screenHangerGiftKeys"))
         {
            screensM.screenHangerGiftKeys.removeMe();
         }
         if(screensM.isScreenOpened("screenHangerInsertGiftKey"))
         {
            screensM.screenHangerInsertGiftKey.removeMe();
         }
         if(screensM.isScreenOpened("screenHangerShop"))
         {
            screensM.screenHangerShop.removeMe();
         }
         if(!BMShopManager.gi().isScreenOpened())
         {
            BMShopManager.gi().showCategoriesScreen("Workshop");
         }
         this.refreshTutorial();
         tooltip.hideToolTip();
      }
      
      public function shopRegularClicked() : void
      {
         if(this.screenStatus != "shopRegular")
         {
            if(dataM.runAsMobile)
            {
               screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait",-1,-1);
               this._changeStatusOnNextFrame = "shopRegular";
            }
            else
            {
               this.shopRegularClickedSub();
            }
         }
      }
      
      private function shopRegularClickedSub() : void
      {
         this.screenStatus = "shopRegular";
         if(dataM.runAsMobile)
         {
            screensM.screenHangerBackground.gotoAndStop("shopRegular_mobile");
         }
         else
         {
            screensM.screenHangerBackground.gotoAndStop("shopRegular");
         }
         if(screensM.isScreenOpened("screenHangerInventory"))
         {
            screensM.screenHangerInventory.removeMe();
         }
         if(screensM.isScreenOpened("screenHangerMech"))
         {
            screensM.screenHangerMech.removeMe();
         }
         if(screensM.isScreenOpened("screenHangerFusion"))
         {
            screensM.screenHangerFusion.removeMe();
         }
         if(screensM.isScreenOpened("screenHangerGiftKeys"))
         {
            screensM.screenHangerGiftKeys.removeMe();
         }
         if(screensM.isScreenOpened("screenHangerInsertGiftKey"))
         {
            screensM.screenHangerInsertGiftKey.removeMe();
         }
         if(screensM.isScreenOpened("screenGlobalShop"))
         {
            screensM.screenGlobalShop.removeMe();
         }
         if(screensM.isScreenOpened("screenHangerShop") == false)
         {
            screensM.addScreen("screenHangerShop");
         }
         screensM.screenHangerShop.refreshScreen("regular");
         this.refreshTutorial();
         tooltip.hideToolTip();
      }
      
      public function shopMythicalClicked() : void
      {
         if(this.screenStatus != "shopMythical")
         {
            if(dataM.runAsMobile)
            {
               screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait",-1,-1);
               this._changeStatusOnNextFrame = "shopMythical";
            }
            else
            {
               this.shopMythicalClickedSub();
            }
         }
      }
      
      private function shopMythicalClickedSub() : void
      {
         this.screenStatus = "shopMythical";
         this.btnMech.visible = false;
         this.btnFusion.visible = false;
         this.btnChangeMechsOrder.visible = false;
         this.txtMech.visible = false;
         this.txtFusion.visible = false;
         this.txtChangeMechsOrder.visible = false;
         if(dataM.runAsMobile)
         {
            screensM.screenHangerBackground.gotoAndStop("shopMythical_mobile");
         }
         else
         {
            screensM.screenHangerBackground.gotoAndStop("shopMythical");
         }
         if(screensM.isScreenOpened("screenHangerInventory"))
         {
            screensM.screenHangerInventory.removeMe();
         }
         if(screensM.isScreenOpened("screenHangerMech"))
         {
            screensM.screenHangerMech.removeMe();
         }
         if(screensM.isScreenOpened("screenHangerFusion"))
         {
            screensM.screenHangerFusion.removeMe();
         }
         if(screensM.isScreenOpened("screenHangerGiftKeys"))
         {
            screensM.screenHangerGiftKeys.removeMe();
         }
         if(screensM.isScreenOpened("screenHangerInsertGiftKey"))
         {
            screensM.screenHangerInsertGiftKey.removeMe();
         }
         if(screensM.isScreenOpened("screenGlobalShop"))
         {
            screensM.screenGlobalShop.removeMe();
         }
         if(screensM.isScreenOpened("screenHangerShop") == false)
         {
            screensM.addScreen("screenHangerShop");
         }
         screensM.screenHangerShop.refreshScreen("mythical");
         tooltip.hideToolTip();
      }
      
      public function fusionClicked() : void
      {
         if(!tutorialM.isTutorialActive())
         {
            this._postUpdateMechDestinationIsFusion = true;
            this.updateMech();
            return;
         }
         if(this.screenStatus != "fusion")
         {
            if(dataM.runAsMobile)
            {
               screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait",-1,-1);
               this._changeStatusOnNextFrame = "fusion";
            }
            else
            {
               this.fusionClickedSub();
            }
         }
      }
      
      private function fusionClickedSub() : void
      {
         this.screenStatus = "fusion";
         if(dataM.runAsMobile)
         {
            screensM.screenHangerBackground.gotoAndStop("fusion_mobile");
         }
         else
         {
            screensM.screenHangerBackground.gotoAndStop("fusion");
         }
         if(screensM.isScreenOpened("screenHangerMech"))
         {
            screensM.screenHangerMech.removeMe();
         }
         if(screensM.isScreenOpened("screenHangerShop"))
         {
            screensM.screenHangerShop.removeMe();
         }
         if(screensM.isScreenOpened("screenGlobalShop"))
         {
            screensM.screenGlobalShop.removeMe();
         }
         if(screensM.isScreenOpened("screenHangerGiftKeys"))
         {
            screensM.screenHangerGiftKeys.removeMe();
         }
         if(screensM.isScreenOpened("screenHangerInsertGiftKey"))
         {
            screensM.screenHangerInsertGiftKey.removeMe();
         }
         if(screensM.isScreenOpened("screenHangerFusion") == false)
         {
            screensM.addScreen("screenHangerFusion");
         }
         screensM.screenHangerFusion.refreshScreen();
         if(screensM.isScreenOpened("screenHangerInventory") == false)
         {
            screensM.addScreen("screenHangerInventory");
         }
         screensM.screenHangerInventory.refreshScreen();
         if(dataM.tutorialEnabled)
         {
            screensM.readdScreen("screenHangerInventory");
         }
         this.showButtonMarker(this.btnFusion);
         this.refreshTutorial();
      }
      
      private function fusionButtonMouseOver() : void
      {
         tooltip.showToolTip("regularText",getScreenText("fusion"),-1,-1);
      }
      
      public function giftsClicked() : void
      {
         if(this.screenStatus != "gifts")
         {
            if(dataM.runAsMobile)
            {
               screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait",-1,-1);
               this._changeStatusOnNextFrame = "gifts";
            }
            else
            {
               this.giftsClickedSub();
            }
         }
      }
      
      public function giftsClickedSub() : void
      {
         var _loc3_:Object = null;
         var _loc4_:Boolean = false;
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc2_:Number = 0;
         this.btnMech.visible = false;
         this.btnFusion.visible = false;
         this.btnChangeMechsOrder.visible = false;
         this.txtMech.visible = false;
         this.txtFusion.visible = false;
         this.txtChangeMechsOrder.visible = false;
         for each(_loc3_ in _loc1_.gifts)
         {
            _loc2_++;
         }
         if(_loc2_ > 0)
         {
            this.screenStatus = "gifts";
            screensM.screenHangerBackground.gotoAndStop("gifts");
            if(screensM.isScreenOpened("screenHangerInventory"))
            {
               screensM.screenHangerInventory.removeMe();
            }
            if(screensM.isScreenOpened("screenHangerMech"))
            {
               screensM.screenHangerMech.removeMe();
            }
            if(screensM.isScreenOpened("screenHangerFusion"))
            {
               screensM.screenHangerFusion.removeMe();
            }
            if(screensM.isScreenOpened("screenHangerShop"))
            {
               screensM.screenHangerShop.removeMe();
            }
            if(screensM.isScreenOpened("screenGlobalShop"))
            {
               screensM.screenGlobalShop.removeMe();
            }
            _loc4_ = false;
            if(_loc1_.alreadyUsedAGift == false && _loc1_.level <= dataM.giftKeysUseMaxLevel)
            {
               _loc4_ = true;
            }
            if(_loc4_)
            {
               screensM.addScreen("screenHangerInsertGiftKey");
               screensM.screenHangerInsertGiftKey.refreshScreen();
            }
            else
            {
               screensM.addScreen("screenHangerGiftKeys");
               screensM.screenHangerGiftKeys.refreshScreen(true);
            }
         }
         else
         {
            screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait",-1,-1);
            remoteM.socketM.lobby_loadGifts();
         }
         tooltip.hideToolTip();
      }
      
      private function giftsButtonMouseOver() : void
      {
         tooltip.showToolTip("regularText",getSpecificText("menu_gifts"),-1,-1);
      }
      
      public function giftHasJustBeenUsed() : void
      {
         screensM.screenHangerInsertGiftKey.removeMe();
         screensM.addScreen("screenHangerGiftKeys");
         screensM.screenHangerGiftKeys.refreshScreen(true);
      }
      
      public function changeMechsOrderClicked() : void
      {
         screensM.addScreen("screenChangeMechsOrder");
         screensM.screenChangeMechsOrder.refreshScreen();
         screensM.screenHangerInventory.changeMechsOrderScreenOpened();
      }
      
      public function mechClicked() : void
      {
         if(this.screenStatus != "mech")
         {
            if(dataM.runAsMobile)
            {
               screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait",-1,-1);
               this._changeStatusOnNextFrame = "mech";
            }
            else
            {
               this.mechClickedSub();
            }
         }
      }
      
      private function mechClickedSub() : void
      {
         this.screenStatus = "mech";
         dataM.hanger_sawInventory = true;
         if(dataM.runAsMobile)
         {
            screensM.screenHangerBackground.gotoAndStop("mech_mobile");
         }
         else
         {
            screensM.screenHangerBackground.gotoAndStop("mech");
         }
         if(screensM.isScreenOpened("screenHangerShop"))
         {
            screensM.screenHangerShop.removeMe();
         }
         if(screensM.isScreenOpened("screenGlobalShop"))
         {
            screensM.screenGlobalShop.removeMe();
         }
         if(screensM.isScreenOpened("screenHangerFusion"))
         {
            screensM.screenHangerFusion.removeMe();
         }
         if(screensM.isScreenOpened("screenHangerGiftKeys"))
         {
            screensM.screenHangerGiftKeys.removeMe();
         }
         if(screensM.isScreenOpened("screenHangerInsertGiftKey"))
         {
            screensM.screenHangerInsertGiftKey.removeMe();
         }
         if(screensM.isScreenOpened("screenHangerMech") == false)
         {
            screensM.addScreen("screenHangerMech");
         }
         if(screensM.isScreenOpened("screenHangerInventory") == false)
         {
            screensM.addScreen("screenHangerInventory");
         }
         screensM.screenHangerInventory.refreshScreen();
         screensM.screenHangerMech.refreshScreen(true);
         this.refreshTutorial();
         this.showButtonMarker(this.btnMech);
         tooltip.hideToolTip();
      }
      
      private function mechButtonMouseOver() : void
      {
         tooltip.showToolTip("regularText",getScreenText("myMech"),-1,-1);
      }
      
      public function refreshTutorial() : void
      {
      }
      
      private function tutorial_makeSureMechIsEquipped() : void
      {
         var _loc1_:Object = null;
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = false;
         var _loc4_:uint = 0;
         var _loc5_:BMPlayerItemData = null;
         var _loc6_:BMMechStructure = null;
         if(this._makingSureMechIsEquipped_lastTutorialLevel != dataM.myProfile.tutorialLevel)
         {
            this._makingSureMechIsEquipped_lastTutorialLevel = dataM.myProfile.tutorialLevel;
            _loc1_ = new Object();
            _loc2_ = true;
            if(dataM.myProfile.tutorialLevel <= BMTutorialManager.TUTORIAL_LEVEL_LONE_BATTLE2)
            {
               _loc1_[BMCampaignMechsHelper.getTutorial_hanger1_torso()] = true;
               _loc1_[BMCampaignMechsHelper.getTutorial_hanger1_sideWeapon()] = true;
               _loc1_[BMCampaignMechsHelper.getTutorial_hanger1_leg()] = true;
            }
            else if(dataM.myProfile.tutorialLevel <= BMTutorialManager.TUTORIAL_LEVEL_MECH3)
            {
               _loc1_[BMCampaignMechsHelper.getTutorial_hanger1_leg()] = true;
               _loc1_[BMCampaignMechsHelper.getTutorial_hanger2_torso()] = true;
               _loc1_[BMCampaignMechsHelper.getTutorial_hanger1_sideWeapon()] = true;
               _loc1_[BMCampaignMechsHelper.getTutorial_hanger2_sideWeapon()] = true;
            }
            else if(dataM.myProfile.tutorialLevel <= BMTutorialManager.TUTORIAL_LEVEL_MECH4)
            {
               _loc1_[BMCampaignMechsHelper.getTutorial_hanger1_leg()] = true;
               _loc1_[BMCampaignMechsHelper.getTutorial_hanger3_torso()] = true;
               _loc1_[BMCampaignMechsHelper.getTutorial_hanger2_sideWeapon()] = true;
               _loc1_[BMCampaignMechsHelper.getTutorial_hanger3_sideWeapon()] = true;
            }
            else if(dataM.myProfile.tutorialLevel <= BMTutorialManager.TUTORIAL_LEVEL_MECH5)
            {
               _loc1_[BMCampaignMechsHelper.getTutorial_hanger1_leg()] = true;
               _loc1_[BMCampaignMechsHelper.getTutorial_hanger3_torso()] = true;
               _loc1_[BMCampaignMechsHelper.getTutorial_hanger3_sideWeapon()] = true;
               if(FeatureFlags.NEW_ECONOMY)
               {
                  _loc1_[BMCampaignMechsHelper.getTutorial_hanger2_sideWeapon()] = true;
               }
               else
               {
                  _loc1_[BMCampaignMechsHelper.getTutorial_hanger4_sideWeapon()] = true;
               }
               _loc1_[BMCampaignMechsHelper.getTutorial_hanger4_topWeapon()] = true;
               _loc1_[BMCampaignMechsHelper.getTutorial_hanger4_module()] = true;
            }
            else if(dataM.myProfile.tutorialLevel <= BMTutorialManager.TUTORIAL_LEVEL_FUSION && screensM.isScreenOpened("screenHangerMech"))
            {
               _loc1_[BMCampaignMechsHelper.getTutorial_hanger5_leg()] = true;
               _loc1_[BMCampaignMechsHelper.getTutorial_hanger3_torso()] = true;
               _loc1_[BMCampaignMechsHelper.getTutorial_hanger3_sideWeapon()] = true;
               if(FeatureFlags.NEW_ECONOMY)
               {
                  _loc1_[BMCampaignMechsHelper.getTutorial_hanger2_sideWeapon()] = true;
               }
               else
               {
                  _loc1_[BMCampaignMechsHelper.getTutorial_hanger4_sideWeapon()] = true;
               }
               _loc1_[BMCampaignMechsHelper.getTutorial_hanger4_topWeapon()] = true;
               _loc1_[BMCampaignMechsHelper.getTutorial_hanger4_module()] = true;
               _loc1_[BMCampaignMechsHelper.getTutorial_hanger5_module()] = true;
               _loc1_[BMCampaignMechsHelper.getTutorial_hanger5_drone()] = true;
            }
            else
            {
               _loc2_ = false;
            }
            if(_loc2_)
            {
               _loc3_ = false;
               _loc4_ = 0;
               for(; _loc4_ < dataM.myPlayerData.items.length; _loc4_++)
               {
                  _loc5_ = dataM.myPlayerData.items[_loc4_];
                  _loc6_ = dataM.myPlayerData.mechStructures[1];
                  if(_loc5_.equipped == 1)
                  {
                     if(_loc1_[_loc5_.itemID] == null)
                     {
                        trace("REMOVING :" + _loc5_.equipmentType + " " + _loc5_.itemID);
                        _loc5_.equipped = 0;
                        _loc5_.equipmentType = "";
                        _loc5_.equipmentID = 0;
                        _loc3_ = true;
                     }
                     continue;
                  }
                  switch(_loc5_.itemID)
                  {
                     case BMCampaignMechsHelper.getTutorial_hanger1_torso():
                     case BMCampaignMechsHelper.getTutorial_hanger2_torso():
                     case BMCampaignMechsHelper.getTutorial_hanger3_torso():
                        if(_loc1_[_loc5_.itemID])
                        {
                           _loc5_.equipped = 1;
                           _loc5_.equipmentType = "torso";
                           _loc6_.torso = _loc5_.playerItemID;
                           _loc3_ = true;
                        }
                        break;
                     case BMCampaignMechsHelper.getTutorial_hanger1_leg():
                     case BMCampaignMechsHelper.getTutorial_hanger5_leg():
                        if(_loc1_[_loc5_.itemID])
                        {
                           _loc5_.equipped = 1;
                           _loc5_.equipmentType = "leg";
                           _loc6_.leg = _loc5_.playerItemID;
                           _loc3_ = true;
                        }
                        break;
                     case BMCampaignMechsHelper.getTutorial_hanger1_sideWeapon():
                     case BMCampaignMechsHelper.getTutorial_hanger3_sideWeapon():
                        if(_loc1_[_loc5_.itemID])
                        {
                           _loc5_.equipped = 1;
                           _loc5_.equipmentType = "sideWeapon";
                           _loc5_.equipmentID = 1;
                           _loc6_.sideWeapon1 = _loc5_.playerItemID;
                           _loc3_ = true;
                        }
                        break;
                     case BMCampaignMechsHelper.getTutorial_hanger2_sideWeapon():
                     case BMCampaignMechsHelper.getTutorial_hanger4_sideWeapon():
                        if(_loc1_[_loc5_.itemID])
                        {
                           _loc5_.equipped = 1;
                           _loc5_.equipmentType = "sideWeapon";
                           _loc5_.equipmentID = 2;
                           _loc6_.sideWeapon2 = _loc5_.playerItemID;
                           _loc3_ = true;
                        }
                        break;
                     case BMCampaignMechsHelper.getTutorial_hanger4_topWeapon():
                        if(_loc1_[_loc5_.itemID])
                        {
                           _loc5_.equipped = 1;
                           _loc5_.equipmentType = "topWeapon";
                           _loc5_.equipmentID = 1;
                           _loc6_.topWeapon1 = _loc5_.playerItemID;
                           _loc3_ = true;
                        }
                        break;
                     case BMCampaignMechsHelper.getTutorial_hanger4_module():
                        if(_loc1_[_loc5_.itemID])
                        {
                           _loc5_.equipped = 1;
                           _loc5_.equipmentType = "module";
                           _loc5_.equipmentID = 1;
                           _loc6_.module1 = _loc5_.playerItemID;
                           _loc3_ = true;
                        }
                        break;
                     case BMCampaignMechsHelper.getTutorial_hanger5_module():
                        if(_loc1_[_loc5_.itemID])
                        {
                           _loc5_.equipped = 1;
                           _loc5_.equipmentType = "module";
                           _loc5_.equipmentID = 2;
                           _loc6_.module1 = _loc5_.playerItemID;
                           _loc3_ = true;
                        }
                        break;
                     case BMCampaignMechsHelper.getTutorial_hanger5_drone():
                        if(_loc1_[_loc5_.itemID])
                        {
                           _loc5_.equipped = 1;
                           _loc5_.equipmentType = "drone";
                           _loc6_.drone = _loc5_.playerItemID;
                           _loc3_ = true;
                        }
                  }
               }
               if(_loc3_)
               {
                  screensM.screenHangerInventory.refreshScreen();
                  screensM.screenHangerMech.refreshScreen(true);
               }
            }
         }
      }
      
      public function refreshButtons(param1:String = "") : void
      {
         if(tutorialM.isTutorialActive())
         {
            this.btnBack.visible = false;
            this.btnFusion.visible = false;
            this.btnMech.visible = false;
            this.btnChangeMechsOrder.visible = false;
            this.txtMech.visible = false;
            this.txtFusion.visible = false;
            this.txtChangeMechsOrder.visible = false;
            if(dataM.myProfile.tutorialLevel >= BMTutorialManager.TUTORIAL_LEVEL_MECH5)
            {
               this.btnBack.visible = true;
               this.btnFusion.visible = true;
               this.btnMech.visible = true;
               this.txtFusion.visible = true;
               this.txtMech.visible = true;
               this.btnBack.disableMe();
               this.btnMech.disableMe();
               this.btnFusion.disableMe();
               switch(param1)
               {
                  case "goToFusion":
                     if(screensM.isScreenOpened("screenHangerFusion") == false)
                     {
                        this.btnFusion.enableMe();
                        this._tutorialArrowController.activateTutorialArrow(this,this.btnFusion.x + this.btnFusion.width,this.btnFusion.y + this.btnFusion.height / 2);
                     }
               }
               switch(dataM.myProfile.tutorialLevel)
               {
                  case BMTutorialManager.TUTORIAL_LEVEL_SHOP2:
                     this.btnBack.enableMe();
               }
            }
         }
         else
         {
            this.btnBack.visible = true;
            this.btnFusion.visible = true;
            this.btnMech.visible = true;
            this.btnChangeMechsOrder.visible = true;
            this.btnBack.enableMe();
            this.btnFusion.enableMe();
            this.btnMech.enableMe();
            if(dataM.myProfile.level < dataM.SECOND_MECH_UNLOCK_LEVEL)
            {
               this.btnChangeMechsOrder.disableMe();
            }
            else
            {
               this.btnChangeMechsOrder.enableMe();
            }
            this.txtChangeMechsOrder.visible = true;
            this.txtMech.visible = true;
            this.txtFusion.visible = true;
         }
      }
      
      private function tutorialLaunchBattleVSComputer() : void
      {
         dataM.startBattleVSComputer("regular","");
         screensM.screenBlack.activateBlackScreen(this.findBattleSuccess,true,true,null,0);
      }
      
      private function tutorialLaunchWorldMap() : void
      {
         screensM.screenBlack.activateBlackScreen(this.goToWorldMap,true,true,null,0);
      }
      
      private function displayTutorialMarker_inventory(param1:Number, param2:Boolean) : void
      {
         if(param2)
         {
            screensM.screenHangerInventory.inventoryTileList.addGuideArrow(new mcGuideArrow_delay80());
            screensM.screenHangerInventory.inventoryTileList.activateGuideArrow(param1,"tileID",this.ARROWS_AND_MARKERS_DELAY_FRAMES);
            screensM.screenHangerInventory.inventoryTileList.activateAnimatedMarker(param1,"tileID",0);
         }
         else
         {
            screensM.screenHangerInventory.inventoryTileList.addGuideArrow(new mcGuideArrow());
            screensM.screenHangerInventory.inventoryTileList.activateGuideArrow(param1,"tileID",0);
            screensM.screenHangerInventory.inventoryTileList.activateAnimatedMarker(param1,"tileID",0);
         }
      }
      
      private function displayTutorialMarker_shop(param1:Number, param2:Boolean) : void
      {
         if(param2)
         {
            screensM.screenHangerShop.itemsTileList.addGuideArrow(new mcGuideArrow_delay80());
            screensM.screenHangerShop.itemsTileList.activateGuideArrow(param1,"tileID",this.ARROWS_AND_MARKERS_DELAY_FRAMES);
            screensM.screenHangerShop.itemsTileList.activateAnimatedMarker(param1,"tileID",0);
         }
         else
         {
            screensM.screenHangerShop.itemsTileList.addGuideArrow(new mcGuideArrow());
            screensM.screenHangerShop.itemsTileList.activateGuideArrow(param1,"tileID",0);
            screensM.screenHangerShop.itemsTileList.activateAnimatedMarker(param1,"tileID",0);
         }
      }
      
      private function displayTutorialMarker_subType(param1:Number, param2:Boolean) : void
      {
         if(param2)
         {
            screensM.screenHangerShop.subTypeTileList.addGuideArrow(new mcGuideArrow_delay80());
            screensM.screenHangerShop.subTypeTileList.activateGuideArrow(param1,"tileListItemID",this.ARROWS_AND_MARKERS_DELAY_FRAMES);
            screensM.screenHangerShop.subTypeTileList.activateAnimatedMarker(param1,"tileListItemID",0);
         }
         else
         {
            screensM.screenHangerShop.subTypeTileList.addGuideArrow(new mcGuideArrow());
            screensM.screenHangerShop.subTypeTileList.activateGuideArrow(param1,"tileListItemID",0);
            screensM.screenHangerShop.subTypeTileList.activateAnimatedMarker(param1,"tileListItemID",0);
         }
      }
      
      public function findBattleSuccess() : void
      {
         this.resetNewItemsPurchased();
         screensM.addBattleScreens();
         screensM.screenNewMenu.removeCurrentScreen();
         screensM.screenNewMenu.removeMe();
         screensM.removeScreen("screenConfirmation");
      }
      
      private function goToWorldMap() : void
      {
         this.resetNewItemsPurchased();
         screensM.screenNewMenu.singlePlayerClicked();
         screensM.removeScreen("screenConfirmation");
      }
      
      public function activateGoToMapTutorial() : void
      {
         this.disableAllButtons();
      }
      
      private function tutorialLaunchMissionBaseMap() : void
      {
         var _loc2_:uint = 0;
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(_loc1_.missionID > 0)
         {
            this.goToMissionBaseMap();
         }
         else
         {
            _loc2_ = 0;
            if(_loc1_.mapProgress[0] == "v")
            {
               _loc2_ = 1;
            }
            dataM.createMissionLocally(_loc2_,1,1);
            this.goToMissionBaseMap();
         }
      }
      
      public function gotTutorialMissionData() : void
      {
         screensM.removeScreen("screenConfirmation");
         screensM.screenBlack.activateBlackScreen(this.goToMissionBaseMap,true,true,null,0);
      }
      
      public function getMissionDataFailed() : void
      {
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.ONLINE_PLAYER_ID + "Profile"];
         _loc1_.missionID = 0;
         this.tutorialLaunchMissionBaseMap();
      }
      
      public function newMissionCreated() : void
      {
         screensM.removeScreen("screenConfirmation");
         screensM.screenBlack.activateBlackScreen(this.goToMissionBaseMap,true,true,null,0);
      }
      
      private function goToMissionBaseMap() : void
      {
         this.resetNewItemsPurchased();
         screensM.screenNewMenu.removeCurrentScreen();
         screensM.screenNewMenu.removeMe();
         screensM.removeScreen("screenConfirmation");
         screensM.addScreen("screenMissionBaseMap");
         screensM.addScreen("screenTopBar");
         screensM.screenMissionBaseMap.refreshScreen(false);
         screensM.screenTopBar.refreshScreen(false);
      }
      
      private function createUpdateMechLastData() : void
      {
         var _loc2_:uint = 0;
         var _loc4_:BMMechStructure = null;
         var _loc5_:uint = 0;
         var _loc6_:BMPlayerItemData = null;
         var _loc7_:String = null;
         var _loc1_:BMPlayerData = dataM.playersData[dataM.player1PlayerID];
         var _loc3_:Boolean = false;
         this._updateMech_selectedMechID = _loc1_.selectedMechID;
         this._updateMech_lastTorsoPlayerItemIDs = new Array();
         this._updateMech_lastItems = new Array();
         _loc2_ = 1;
         while(_loc2_ <= dataM.inventoryMaxMechs)
         {
            _loc4_ = _loc1_.mechStructures[_loc2_];
            if(_loc4_.hasAtLeastOneItem())
            {
               _loc3_ = true;
            }
            _loc2_++;
         }
         if(_loc3_)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc1_.items.length)
            {
               _loc6_ = _loc1_.items[_loc5_];
               _loc2_ = _loc6_.equipped;
               if(_loc2_ >= 1)
               {
                  _loc7_ = _loc6_.equipmentType;
                  if(_loc6_.equipmentID > 0)
                  {
                     _loc7_ += _loc6_.equipmentID;
                  }
                  this._updateMech_lastItems.push({
                     "playerItemID":_loc6_.playerItemID,
                     "slotName":_loc7_,
                     "mechID":_loc2_
                  });
               }
               _loc5_++;
            }
         }
      }
      
      public function updateMech() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:BMPlayerProfile = null;
         var _loc6_:BMPlayerData = null;
         var _loc7_:Boolean = false;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:Boolean = false;
         var _loc11_:Boolean = false;
         var _loc12_:BMMechStructure = null;
         var _loc13_:uint = 0;
         var _loc14_:BMPlayerItemData = null;
         var _loc15_:String = null;
         var _loc16_:Object = null;
         if(dataM.mechIsOverWeight([1]))
         {
            screensM.screenConfirmation.displayQuestionOrNotification("weightBlock",-1,-1);
         }
         else
         {
            _loc1_ = this.canExitHanger_notEnoughAmmo();
            if(_loc1_)
            {
               _loc2_ = false;
               _loc3_ = new Array();
               _loc4_ = new Array();
               _loc5_ = dataM["player" + dataM.player1PlayerID + "Profile"];
               _loc6_ = dataM.playersData[dataM.player1PlayerID];
               _loc7_ = false;
               _loc8_ = 1;
               while(_loc8_ <= dataM.battleMaxMechs)
               {
                  _loc12_ = _loc6_.mechStructures[_loc8_];
                  if(_loc12_.hasAtLeastOneItem())
                  {
                     _loc7_ = true;
                  }
                  _loc8_++;
               }
               _loc9_ = 0;
               if(_loc7_)
               {
                  _loc13_ = 0;
                  while(_loc13_ < _loc6_.items.length)
                  {
                     _loc14_ = _loc6_.items[_loc13_];
                     _loc8_ = _loc14_.equipped;
                     if(_loc8_ >= 1)
                     {
                        _loc15_ = _loc14_.equipmentType;
                        if(_loc14_.equipmentID > 0)
                        {
                           _loc15_ += _loc14_.equipmentID;
                        }
                        _loc4_.push({
                           "slotName":_loc15_,
                           "equipped":_loc8_,
                           "playerItemID":_loc14_.playerItemID
                        });
                        if(_loc2_ == false)
                        {
                           if(this._updateMech_lastItems[_loc9_] != null)
                           {
                              _loc16_ = this._updateMech_lastItems[_loc9_];
                              if(_loc16_.slotName != _loc15_ || _loc16_.mechID != _loc8_ || _loc16_.playerItemID != _loc14_.playerItemID)
                              {
                                 _loc2_ = true;
                              }
                           }
                           else
                           {
                              _loc2_ = true;
                           }
                        }
                        _loc9_++;
                     }
                     _loc13_++;
                  }
               }
               if(_loc4_.length != this._updateMech_lastItems.length)
               {
                  _loc2_ = true;
               }
               _loc10_ = false;
               if(this._updateMech_selectedMechID != _loc6_.selectedMechID)
               {
                  _loc10_ = true;
               }
               _loc11_ = false;
               if(_loc2_ || tutorialM.isTutorialActive())
               {
                  _loc11_ = true;
               }
               if(_loc11_ || _loc10_)
               {
                  remoteM.inventory_updateMechs(_loc11_,_loc3_,_loc4_,_loc10_,_loc6_.selectedMechID);
                  if(dataM.gameType != BMDataManager.GAME_TYPE_TUTORIAL)
                  {
                     screensM.screenConfirmation.displayQuestionOrNotification("savingMech",-1,-1);
                  }
               }
               else
               {
                  this.finishExitScreenAfterUpdateMech(false);
               }
            }
         }
      }
      
      public function updateMechsSuccess() : void
      {
         this.updateMechsSuccessSub();
      }
      
      public function updateMechsLocally() : void
      {
         this.updateMechsSuccessSub();
      }
      
      private function updateMechsSuccessSub() : void
      {
         if(tutorialM.isTutorialActive())
         {
            if(tutorialM.getTutorialDestination() == BMTutorialManager.TUTORIAL_DESTINATION_FUSION)
            {
               screensM.removeScreen("screenConfirmation");
            }
            else if(dataM.myProfile.tutorialLevel == BMTutorialManager.TUTORIAL_LEVEL_MECH5)
            {
               screensM.removeScreen("screenConfirmation");
               tutorialM.setTutorialLevel(dataM.myProfile.tutorialLevel + 1,"screenHanger");
               this.refreshTutorial();
            }
            else
            {
               this.updateMechBeforeGoingToBattleInTutorialIsDone();
            }
         }
         else
         {
            this.finishExitScreenAfterUpdateMech();
         }
      }
      
      private function finishExitScreenAfterUpdateMech(param1:Boolean = true) : *
      {
         if(param1)
         {
            screensM.removeScreen("screenConfirmation");
         }
         if(this._postUpdateMechDestinationIsFusion)
         {
            screensM.screenNewMenu.removeCurrentScreen();
            this._postUpdateMechDestinationIsFusion = false;
            screensM.addScreen("screenHangerUpgrade");
         }
         else
         {
            this.backClickedSub(true,false);
         }
      }
      
      private function updateMechBeforeGoingToBattleInTutorialIsDone() : void
      {
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(tutorialM.getTutorialDestination() == BMTutorialManager.TUTORIAL_DESTINATION_LONE_BATTLE)
         {
            this.tutorialLaunchBattleVSComputer();
         }
         else if(tutorialM.getTutorialDestination() == BMTutorialManager.TUTORIAL_DESTINATION_MISSION)
         {
            screensM.removeScreen("screenConfirmation");
            this.backClickedSub(true,false);
         }
      }
      
      public function backClicked() : void
      {
         if(tutorialM.isTutorialActive())
         {
            this.backClickedSub(true,false);
         }
         else
         {
            this.updateMech();
         }
      }
      
      public function backClickedSub(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:Boolean = true;
         if(param1 && param2)
         {
            _loc3_ = this.canExitHanger_notEnoughAmmo();
         }
         if(_loc3_)
         {
            screensM.screenNewMenu.mainMenu();
         }
      }
      
      private function canExitHanger_notEnoughAmmo() : Boolean
      {
         return true;
      }
      
      public function exitCancelledNoAmmo(param1:String, param2:Number) : void
      {
         var _loc7_:BMPlayerItemData = null;
         var _loc8_:BMItemData = null;
         var _loc9_:uint = 0;
         var _loc11_:Array = null;
         var _loc12_:Number = NaN;
         var _loc13_:uint = 0;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:BMItemData = null;
         var _loc17_:String = null;
         var _loc18_:Number = NaN;
         var _loc19_:BMTileListItem = null;
         var _loc20_:MovieClip = null;
         var _loc3_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc4_:BMPlayerData = dataM.playersData[dataM.player1PlayerID];
         var _loc5_:Number = 0;
         var _loc6_:Number = 0;
         _loc9_ = 0;
         while(_loc9_ < _loc4_.items.length)
         {
            _loc7_ = _loc4_.items[_loc9_];
            if(_loc7_.equipped == 0)
            {
               _loc6_++;
               if(_loc5_ == 0)
               {
                  _loc8_ = dataM.itemsDB[_loc7_.itemID];
                  if(_loc8_.type == "module" && _loc8_.level <= _loc3_.level)
                  {
                     if(_loc8_[param1] > 0)
                     {
                        _loc5_ = _loc7_.playerItemID;
                     }
                  }
               }
            }
            _loc9_++;
         }
         var _loc10_:String = screensM.screenHangerInventory.getCurrentEquipmentType();
         if(_loc5_ > 0)
         {
            if(this.screenStatus != "mech")
            {
               this.mechClickedSub();
            }
            if(dataM.runAsMobile)
            {
               _loc11_ = new Array();
               _loc9_ = 0;
               while(_loc9_ < _loc4_.items.length)
               {
                  _loc7_ = _loc4_.items[_loc9_];
                  _loc8_ = dataM.itemsDB[_loc7_.itemID];
                  if(_loc7_.equipped == 0)
                  {
                     if(_loc6_ > screensM.screenHangerInventory.MAX_ITEMS_VISIBLE_IN_INVENTORY_MOBILE)
                     {
                        if(_loc8_.type == "module")
                        {
                           _loc11_.push({
                              "finalSortID":_loc8_.finalSortID,
                              "itemSlot":_loc9_
                           });
                        }
                     }
                     else
                     {
                        _loc11_.push({
                           "finalSortID":_loc8_.finalSortID,
                           "itemSlot":_loc9_
                        });
                     }
                  }
                  _loc9_++;
               }
               _loc11_.sortOn("finalSortID",Array.NUMERIC);
               _loc12_ = -1;
               _loc9_ = 0;
               while(_loc9_ < _loc11_.length)
               {
                  _loc7_ = _loc4_.items[_loc11_[_loc9_].itemSlot];
                  if(_loc7_.playerItemID == _loc5_)
                  {
                     _loc12_ = _loc9_;
                     _loc9_ = _loc11_.length;
                  }
                  _loc9_++;
               }
               if(_loc12_ > -1)
               {
                  _loc13_ = dataM.INVENTORY_TILE_LIST_COLUMNS_MOBILE * dataM.INVENTORY_TILE_LIST_ROWS_MOBILE;
                  _loc14_ = Math.ceil((_loc12_ + 1) / _loc13_) - 1;
                  if(_loc6_ > screensM.screenHangerInventory.MAX_ITEMS_VISIBLE_IN_INVENTORY_MOBILE)
                  {
                     screensM.screenHangerInventory.itemTypeClickedSub(dataM.shopItemTypesReverseDB["module"],true,false,false,_loc14_,"exitCancelledNoAmmo");
                  }
                  else if(screensM.screenHangerInventory.getInventoryCurrentPage() != _loc14_)
                  {
                     screensM.screenHangerInventory.setInventoryCurrentPage(_loc14_);
                     screensM.screenHangerInventory.addAndRefreshInventoryTileList("hangerMenu exitCancelledNoAmmo forMobile",false);
                  }
                  screensM.screenHangerInventory.inventoryTileList.addGuideArrow(new mcGuideArrow());
                  screensM.screenHangerInventory.inventoryTileList.activateGuideArrow(_loc5_,"tileListItemID",0);
                  screensM.screenHangerInventory.inventoryTileList.activateAnimatedMarker(_loc5_,"tileListItemID",0);
               }
            }
            else
            {
               if(_loc6_ > screensM.screenHangerInventory.MAX_ITEMS_VISIBLE_IN_INVENTORY)
               {
                  if(_loc10_ != "module")
                  {
                     screensM.screenHangerInventory.itemTypeClickedSub(dataM.shopItemTypesReverseDB["module"],true,false,false,-1,"exitCancelledNoAmmo");
                  }
               }
               screensM.screenHangerInventory.inventoryTileList.addGuideArrow(new mcGuideArrow());
               screensM.screenHangerInventory.inventoryTileList.activateGuideArrow(_loc5_,"tileListItemID",this.ARROWS_AND_MARKERS_DELAY_FRAMES);
            }
         }
         else
         {
            switch(param1)
            {
               case "bullets":
                  _loc15_ = 56;
                  break;
               case "rockets":
                  _loc15_ = 61;
            }
            _loc16_ = dataM.itemsDB[_loc15_];
            if(_loc3_.gold < _loc16_.costGold)
            {
               if(this.screenStatus != "mech")
               {
                  this.mechClickedSub();
               }
               _loc17_ = "";
               _loc18_ = 0;
               _loc9_ = 0;
               while(_loc9_ < _loc4_.items.length)
               {
                  _loc7_ = _loc4_.items[_loc9_];
                  if(_loc7_.equipped == _loc4_.selectedMechID && _loc7_.itemID == param2)
                  {
                     _loc17_ = _loc7_.equipmentType;
                     _loc18_ = _loc7_.equipmentID;
                     _loc9_ = _loc4_.items.length;
                  }
                  _loc9_++;
               }
               if(_loc17_ != "")
               {
                  _loc19_ = screensM.screenHangerMech.mechEquipment[_loc17_ + _loc18_];
                  switch(_loc17_)
                  {
                     case "sideWeapon":
                        switch(_loc18_)
                        {
                           case 1:
                           case 3:
                              _loc20_ = screensM.screenHangerMech.mcTutorialArrow_unequipLong;
                              break;
                           case 2:
                           case 4:
                              _loc20_ = screensM.screenHangerMech.mcTutorialArrow_unequipShort;
                        }
                        break;
                     case "topWeapon":
                        switch(_loc18_)
                        {
                           case 1:
                           case 3:
                              _loc20_ = screensM.screenHangerMech.mcTutorialArrow_unequipLong;
                              break;
                           case 2:
                           case 4:
                              _loc20_ = screensM.screenHangerMech.mcTutorialArrow_unequipShort;
                        }
                  }
                  _loc20_.x = _loc19_.x + screensM.screenHangerMech.mechEquipment.x + dataM.EQUIPMENT_TILE_LIST_ITEM_SIZE;
                  _loc20_.y = _loc19_.y + screensM.screenHangerMech.mechEquipment.y + dataM.EQUIPMENT_TILE_LIST_ITEM_SIZE / 2;
                  _loc20_.gotoAndStop("animOn");
                  if(this.screenStatus != "mech")
                  {
                     if(dataM.runAsMobile)
                     {
                        this.mechClickedSub();
                     }
                     else
                     {
                        this.mechClicked();
                     }
                  }
               }
            }
            else
            {
               if(this.screenStatus != "shopRegular")
               {
                  if(dataM.runAsMobile)
                  {
                     this.shopRegularClickedSub();
                  }
                  else
                  {
                     this.shopRegularClicked();
                  }
               }
               screensM.screenHangerShop.subTypeClickedSub("module_bulletsRockets",true);
               screensM.screenHangerShop.itemsTileList.addGuideArrow(new mcGuideArrow());
               screensM.screenHangerShop.itemsTileList.activateGuideArrow(_loc15_,"tileListItemID",0);
               screensM.screenHangerShop.itemsTileList.activateAnimatedMarker(_loc15_,"tileListItemID",0);
            }
         }
      }
      
      private function resetNewItemsPurchased() : void
      {
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         _loc1_.newItemsPurchased = new Array();
         remoteM.lobby_exitWorkshop();
      }
      
      public function disableAllButtons() : void
      {
      }
      
      public function enableAllButtons() : void
      {
      }
      
      public function removeHanger() : void
      {
         if(dataM.hanger_sawInventory)
         {
            this.resetNewItemsPurchased();
            dataM.hanger_sawInventory = false;
         }
         if(screensM.isScreenOpened("screenHangerMenu"))
         {
            if(screensM.isScreenOpened("screenHangerInventory"))
            {
               screensM.screenHangerInventory.removeMe();
            }
            if(screensM.isScreenOpened("screenHangerShop"))
            {
               screensM.screenHangerShop.removeMe();
            }
            if(screensM.isScreenOpened("screenGlobalShop"))
            {
               screensM.screenGlobalShop.removeMe();
            }
            if(screensM.isScreenOpened("screenHangerFusion"))
            {
               screensM.screenHangerFusion.removeMe();
            }
            if(screensM.isScreenOpened("screenHangerMech"))
            {
               screensM.screenHangerMech.removeMe();
            }
            if(screensM.isScreenOpened("screenHangerGiftKeys"))
            {
               screensM.screenHangerGiftKeys.removeMe();
            }
            if(screensM.isScreenOpened("screenHangerInsertGiftKey"))
            {
               screensM.screenHangerInsertGiftKey.removeMe();
            }
            if(screensM.isScreenOpened("screenCraftMythicals"))
            {
               screensM.screenCraftMythicals.removeMe();
            }
            if(screensM.isScreenOpened("screenMythicalCrafted"))
            {
               screensM.screenMythicalCrafted.removeMe();
            }
            screensM.removeScreen("screenHangerBackground");
            screensM.removeScreen("screenHangerMenu");
            tooltip.hideToolTip();
         }
      }
      
      private function logoutClicked() : void
      {
         screensM.screenConfirmation.displayQuestionOrNotification("logout",-1,-1);
      }
      
      private function generalButtonMouseOut() : void
      {
         tooltip.hideToolTip();
      }
      
      override public function notifyClientDataReloaded() : *
      {
         dataM.playersData[dataM.player1PlayerID] = this._currentPlayerData;
      }
   }
}

