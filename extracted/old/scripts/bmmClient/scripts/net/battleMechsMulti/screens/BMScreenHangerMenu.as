package net.battleMechsMulti.screens
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMShopManager;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.mobiles.BMPlayerData;
   import net.battleMechsMulti.mobiles.BMPlayerItemData;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.BMTileList;
   import net.battleMechsMulti.mobiles.BMTileListItem;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureI;
   import net.battleMechsMulti.mobiles.pointersAndMarkers.BMTutorialArrowController;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1107")]
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
      
      public var btnLogout:BMButton_pictureE;
      
      public var mcMechComplete:MovieClip;
      
      public var returnToMenuMultiPlayer:Boolean = false;
      
      public var returnToMissionBaseMap:Boolean = false;
      
      private const ARROWS_AND_MARKERS_DELAY_FRAMES:uint = 80;
      
      private var _firstRefresh:Boolean = true;
      
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
         if(dataM.isTutorialActive() == false)
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
         var _loc2_:BMPlayerItemData = null;
         var _loc3_:uint = 0;
         var _loc5_:Object = null;
         var _loc6_:Object = null;
         var _loc7_:Boolean = false;
         var _loc8_:Number = NaN;
         var _loc9_:BMTileList = null;
         var _loc10_:Boolean = false;
         var _loc11_:BMPlayerItemData = null;
         var _loc12_:BMPlayerItemData = null;
         var _loc13_:BMPlayerItemData = null;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:Boolean = false;
         var _loc18_:BMPlayerItemData = null;
         var _loc19_:BMPlayerItemData = null;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc23_:BMPlayerItemData = null;
         var _loc24_:BMPlayerItemData = null;
         var _loc25_:BMItemData = null;
         var _loc26_:Number = NaN;
         var _loc27_:Number = NaN;
         var _loc28_:Number = NaN;
         var _loc29_:Number = NaN;
         var _loc30_:BMPlayerItemData = null;
         var _loc31_:BMPlayerItemData = null;
         var _loc32_:BMPlayerItemData = null;
         var _loc33_:Number = NaN;
         var _loc34_:Number = NaN;
         var _loc35_:Number = NaN;
         var _loc36_:Number = NaN;
         var _loc37_:Boolean = false;
         var _loc38_:BMPlayerItemData = null;
         var _loc39_:BMPlayerItemData = null;
         var _loc40_:BMPlayerItemData = null;
         var _loc41_:Number = NaN;
         var _loc42_:Number = NaN;
         var _loc43_:Number = NaN;
         var _loc44_:BMPlayerItemData = null;
         var _loc45_:BMPlayerItemData = null;
         var _loc46_:BMPlayerItemData = null;
         var _loc47_:BMPlayerItemData = null;
         var _loc48_:Number = NaN;
         var _loc49_:Number = NaN;
         var _loc50_:Number = NaN;
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc4_:String = "";
         if(screensM.isScreenOpened("screenHangerShop"))
         {
            screensM.screenHangerShop.subTypeTileList.deactivateGuideArrow();
            screensM.screenHangerShop.subTypeTileList.deactivateAllAnimatedMarkers();
            screensM.screenHangerShop.itemsTileList.deactivateAllAnimatedMarkers();
         }
         this._tutorialArrowController.deactivateTutorialArrow();
         this._lastTutorialPhase = this.tutorialPhase;
         this.tutorialPhase = "none";
         if(dataM.tutorialEnabled)
         {
            _loc5_ = new Object();
            _loc3_ = 0;
            while(_loc3_ < this._currentPlayerData.items.length)
            {
               _loc2_ = this._currentPlayerData.items[_loc3_];
               if(_loc2_.equipped == 1)
               {
                  if(_loc5_[_loc2_.itemID] == null)
                  {
                     _loc5_[_loc2_.itemID] = _loc2_.playerItemID;
                  }
               }
               _loc3_++;
            }
            _loc3_ = 0;
            while(_loc3_ < this._currentPlayerData.items.length)
            {
               _loc2_ = this._currentPlayerData.items[_loc3_];
               if(_loc2_.equipped == 0)
               {
                  if(_loc5_[_loc2_.itemID] == null)
                  {
                     _loc5_[_loc2_.itemID] = _loc2_.playerItemID;
                  }
               }
               _loc3_++;
            }
            _loc6_ = new Object();
            _loc3_ = 0;
            while(_loc3_ < this._currentPlayerData.items.length)
            {
               _loc2_ = this._currentPlayerData.items[_loc3_];
               if(_loc2_.playerItemID != _loc5_[_loc2_.itemID])
               {
                  _loc6_[_loc2_.playerItemID] = _loc2_.playerItemID;
               }
               _loc3_++;
            }
            _loc7_ = false;
            for each(_loc8_ in _loc6_)
            {
               dataM.removePlayerItemData(dataM.player1PlayerID,_loc8_);
               _loc7_ = true;
            }
            if(_loc7_)
            {
               if(screensM.isScreenOpened("screenHangerInventory"))
               {
                  screensM.screenHangerInventory.refreshScreen();
               }
            }
            if(_loc1_.level > _loc1_.lastLevel && this._stppedTutorialForLevelUpBonus == false)
            {
               this.tutorialPhase = "levelUpBonus_level2";
               this._stppedTutorialForLevelUpBonus = true;
            }
            else
            {
               if(screensM.isScreenOpened("screenHangerInventory"))
               {
                  _loc9_ = screensM.screenHangerInventory.inventoryTileList;
               }
               if(_loc1_.tutorialLevel <= BMDataManager.TUTORIAL_LEVEL_LONE_BATTLE1)
               {
                  _loc10_ = false;
                  if(_loc1_.tutorialLevel == BMDataManager.TUTORIAL_LEVEL_LONE_BATTLE1)
                  {
                     _loc10_ = true;
                  }
                  else
                  {
                     dataM.setTutorialLevel(BMDataManager.TUTORIAL_LEVEL_MECH1,"screenHangerMenu refreshTutorial hanger1");
                     _loc14_ = -1;
                     _loc15_ = -1;
                     _loc16_ = -1;
                     _loc3_ = 0;
                     while(_loc3_ < this._currentPlayerData.items.length)
                     {
                        _loc2_ = this._currentPlayerData.items[_loc3_];
                        switch(_loc2_.itemID)
                        {
                           case dataM.TUTORIAL_TORSO_ID:
                              _loc11_ = this._currentPlayerData.items[_loc3_];
                              _loc14_ = _loc9_.findTileIDByTileListItemID(_loc11_.playerItemID);
                              break;
                           case dataM.TUTORIAL_LEG_ID:
                              _loc12_ = this._currentPlayerData.items[_loc3_];
                              _loc15_ = _loc9_.findTileIDByTileListItemID(_loc12_.playerItemID);
                              break;
                           case dataM.TUTORIAL_WEAPON_ID:
                              _loc13_ = this._currentPlayerData.items[_loc3_];
                              _loc16_ = _loc9_.findTileIDByTileListItemID(_loc13_.playerItemID);
                        }
                        _loc3_++;
                     }
                     if(_loc11_ != null && _loc12_ != null && _loc13_ != null)
                     {
                        if(_loc11_.equipped == 0)
                        {
                           this.tutorialPhase = "equip_torsoLevel0";
                           this.displayTutorialMarker_inventory(_loc14_,true);
                        }
                        else if(_loc12_.equipped == 0)
                        {
                           this.tutorialPhase = "equip_legLevel0";
                           this.displayTutorialMarker_inventory(_loc15_,true);
                        }
                        else if(_loc13_.equipped == 0)
                        {
                           this.tutorialPhase = "equip_sideWeaponLevel0";
                           this.displayTutorialMarker_inventory(_loc16_,true);
                        }
                        else
                        {
                           _loc10_ = true;
                        }
                     }
                     else
                     {
                        TsLogger.log(" ! ! ! ERROR - ITEMS MISSING >> TUTORIAL ABORTED");
                     }
                  }
                  if(_loc10_)
                  {
                     this.tutorialPhase = "goToBattle1";
                     screensM.screenHangerMech.mechGlowHandler = true;
                     screensM.screenHangerMech.mechGlowCounter = 0;
                     dataM.setTutorialLevel(BMDataManager.TUTORIAL_LEVEL_LONE_BATTLE1);
                  }
               }
               else if(_loc1_.tutorialLevel <= BMDataManager.TUTORIAL_LEVEL_LONE_BATTLE2)
               {
                  _loc17_ = false;
                  if(_loc1_.tutorialLevel == BMDataManager.TUTORIAL_LEVEL_LONE_BATTLE2)
                  {
                     _loc17_ = true;
                  }
                  else
                  {
                     dataM.setTutorialLevel(BMDataManager.TUTORIAL_LEVEL_MECH2,"screenHangerMenu refreshTutorial hanger2");
                     _loc20_ = -1;
                     _loc21_ = -1;
                     if(dataM.gameType == BMDataManager.GAME_TYPE_GUEST)
                     {
                        if(this._currentPlayerData.items.length == 3)
                        {
                           _loc22_ = 20;
                           dataM.addPlayerItemDataToInventory(dataM.player1PlayerID,dataM.TUTORIAL_BUY_TORSO1_ID,0,0,0,0);
                           dataM.addPlayerItemDataToInventory(dataM.player1PlayerID,dataM.TUTORIAL_BUY_SIDE_WEAPON1_ID,0,0,0,0);
                           dataM.addPlayerItemDataToInventory(dataM.player1PlayerID,dataM.TUTORIAL_BUY_TORSO2_ID,0,0,0,_loc22_);
                           dataM.addPlayerItemDataToInventory(dataM.player1PlayerID,dataM.TUTORIAL_BUY_SIDE_WEAPON2_ID,0,0,0,0);
                           dataM.hanger_newItemsForDisplay = new Array();
                           dataM.hanger_newItemsForDisplay.push(dataM.TUTORIAL_BUY_TORSO1_ID);
                           dataM.hanger_newItemsForDisplay.push(dataM.TUTORIAL_BUY_SIDE_WEAPON1_ID);
                           dataM.hanger_newItemsForDisplay.push(dataM.TUTORIAL_BUY_TORSO2_ID);
                           dataM.hanger_newItemsForDisplay.push(dataM.TUTORIAL_BUY_SIDE_WEAPON2_ID);
                           screensM.screenHangerInventory.addAndRefreshInventoryTileList("hangerMenu refreh tutotrial",false);
                           dataM.saveGuestData("battle cleanBattle");
                        }
                     }
                     _loc3_ = 0;
                     while(_loc3_ < this._currentPlayerData.items.length)
                     {
                        _loc2_ = this._currentPlayerData.items[_loc3_];
                        switch(_loc2_.itemID)
                        {
                           case dataM.TUTORIAL_BUY_TORSO1_ID:
                              _loc18_ = this._currentPlayerData.items[_loc3_];
                              _loc20_ = _loc9_.findTileIDByTileListItemID(_loc18_.playerItemID);
                              break;
                           case dataM.TUTORIAL_BUY_SIDE_WEAPON1_ID:
                              _loc19_ = this._currentPlayerData.items[_loc3_];
                              _loc21_ = _loc9_.findTileIDByTileListItemID(_loc19_.playerItemID);
                        }
                        _loc3_++;
                     }
                     screensM.screenHangerInventory.hideAllItemTypeInterface();
                     if(_loc18_.equipped == 0)
                     {
                        this.tutorialPhase = "equip_torsoLevel1";
                        this.displayTutorialMarker_inventory(_loc20_,true);
                     }
                     else if(_loc19_.equipped == 0)
                     {
                        this.tutorialPhase = "equip_sideWeaponLevel1";
                        this.displayTutorialMarker_inventory(_loc21_,true);
                     }
                     else
                     {
                        _loc17_ = true;
                     }
                  }
                  if(_loc17_)
                  {
                     this.tutorialPhase = "goToBattle2";
                     screensM.screenHangerMech.mechGlowHandler = true;
                     screensM.screenHangerMech.mechGlowCounter = 0;
                     dataM.setTutorialLevel(BMDataManager.TUTORIAL_LEVEL_LONE_BATTLE2);
                  }
               }
               else if(_loc1_.tutorialLevel <= BMDataManager.TUTORIAL_LEVEL_MECH3)
               {
                  dataM.setTutorialLevel(BMDataManager.TUTORIAL_LEVEL_MECH3,"screenHangerMenu refreshTutorial hanger3");
                  _loc3_ = 0;
                  for(; _loc3_ < this._currentPlayerData.items.length; _loc3_++)
                  {
                     _loc2_ = this._currentPlayerData.items[_loc3_];
                     _loc25_ = dataM.itemsDB[_loc2_.itemID];
                     if(_loc25_.level != 2)
                     {
                        continue;
                     }
                     switch(_loc25_.type)
                     {
                        case "torso":
                           _loc23_ = _loc2_;
                           break;
                        case "sideWeapon":
                           _loc24_ = _loc2_;
                     }
                  }
                  switch(this.screenStatus)
                  {
                     case "mech":
                        if(_loc23_.equipped == 0)
                        {
                           this.tutorialPhase = "equip_torsoLevel2";
                        }
                        else if(_loc24_.equipped == 0)
                        {
                           this.tutorialPhase = "equip_sideWeaponLevel2";
                        }
                        else
                        {
                           this.tutorialPhase = "goToBattle3";
                           screensM.screenHangerMech.mechGlowHandler = true;
                           screensM.screenHangerMech.mechGlowCounter = 0;
                           dataM.setTutorialLevel(BMDataManager.TUTORIAL_LEVEL_MECH3 + 1);
                        }
                  }
                  switch(this.tutorialPhase)
                  {
                     case "equip_torsoLevel2":
                        _loc26_ = _loc9_.findTileIDByTileListItemID(_loc23_.playerItemID);
                        this.displayTutorialMarker_inventory(_loc26_,true);
                        break;
                     case "equip_sideWeaponLevel2":
                        _loc27_ = _loc9_.findTileIDByTileListItemID(_loc24_.playerItemID);
                        this.displayTutorialMarker_inventory(_loc27_,true);
                  }
               }
               else if(_loc1_.tutorialLevel <= BMDataManager.TUTORIAL_LEVEL_MECH4)
               {
                  dataM.setTutorialLevel(BMDataManager.TUTORIAL_LEVEL_MECH4,"screenHangerMenu refreshTutorial hanger4");
                  _loc28_ = 0;
                  _loc29_ = 0;
                  _loc3_ = 0;
                  while(_loc3_ < this._currentPlayerData.items.length)
                  {
                     _loc2_ = this._currentPlayerData.items[_loc3_];
                     _loc33_ = Number(dataM.itemsDB[_loc2_.itemID].level);
                     if(_loc33_ == 2 && _loc2_.equipmentType == "sideWeapon")
                     {
                        _loc28_++;
                        if(_loc2_.equipped)
                        {
                           _loc29_++;
                        }
                        else
                        {
                           _loc30_ = _loc2_;
                        }
                     }
                     else if(_loc2_.equipmentType == "topWeapon")
                     {
                        _loc31_ = _loc2_;
                     }
                     else if(_loc2_.equipmentType == "module")
                     {
                        _loc32_ = _loc2_;
                     }
                     _loc3_++;
                  }
                  switch(this.screenStatus)
                  {
                     case "mech":
                        if(_loc28_ < 2 || _loc31_ == null || _loc32_ == null)
                        {
                           this.tutorialPhase = "switchToShop";
                        }
                        else if(_loc29_ < 2)
                        {
                           this.tutorialPhase = "equip_sideWeaponLevel2Again";
                        }
                        else if(_loc31_.equipped == false)
                        {
                           this.tutorialPhase = "equip_topWeaponLevel2";
                        }
                        else if(_loc32_.equipped == false)
                        {
                           this.tutorialPhase = "equip_moduleLevel2";
                        }
                        else
                        {
                           this.tutorialPhase = "goToBattle4";
                           screensM.screenHangerMech.mechGlowHandler = true;
                           screensM.screenHangerMech.mechGlowCounter = 0;
                           dataM.setTutorialLevel(BMDataManager.TUTORIAL_LEVEL_MECH4 + 1);
                        }
                        break;
                     case "shopRegular":
                        if(_loc28_ < 2)
                        {
                           this.tutorialPhase = "buy_sideWeaponLevel2Again";
                        }
                        else if(_loc31_ == null)
                        {
                           this.tutorialPhase = "buy_topWeaponLevel2";
                        }
                        else if(_loc32_ == null)
                        {
                           this.tutorialPhase = "buy_moduleLevel2";
                        }
                        else
                        {
                           this.tutorialPhase = "switchToMechFromShop";
                        }
                        break;
                     case "shopCombined":
                        if(_loc31_ == null)
                        {
                           this.tutorialPhase = "buy_mixBox";
                        }
                        else
                        {
                           this.tutorialPhase = "switchToMechFromShop";
                        }
                  }
                  switch(this.tutorialPhase)
                  {
                     case "switchToShop":
                     case "switchToMechFromShop":
                     case "buy_mixBox":
                        break;
                     case "buy_sideWeaponLevel2Again":
                        switch(screensM.screenHangerShop.getTargetSubType())
                        {
                           case "sideWeapon_physical":
                              this.displayTutorialMarker_shop(3,true);
                              break;
                           default:
                              this.displayTutorialMarker_subType(dataM.SUB_TYPE_SIDE_WEAPON_PHYSICAL,true);
                        }
                        break;
                     case "buy_topWeaponLevel2":
                        switch(screensM.screenHangerShop.getTargetSubType())
                        {
                           case "topWeapon_electric":
                              this.displayTutorialMarker_shop(0,true);
                              break;
                           default:
                              this.displayTutorialMarker_subType(dataM.SUB_TYPE_TOP_WEAPON_ELECTRIC,true);
                        }
                        break;
                     case "buy_moduleLevel2":
                        switch(screensM.screenHangerShop.getTargetSubType())
                        {
                           case "module_bulletsRockets":
                              this.displayTutorialMarker_shop(0,true);
                              break;
                           default:
                              this.displayTutorialMarker_subType(dataM.SUB_TYPE_MODULE_BULLETS_ROCKETS,true);
                        }
                        break;
                     case "equip_sideWeaponLevel2Again":
                        _loc34_ = _loc9_.findTileIDByTileListItemID(_loc30_.playerItemID);
                        this.displayTutorialMarker_inventory(_loc34_,true);
                        break;
                     case "equip_topWeaponLevel2":
                        _loc35_ = _loc9_.findTileIDByTileListItemID(_loc31_.playerItemID);
                        this.displayTutorialMarker_inventory(_loc35_,true);
                        break;
                     case "equip_moduleLevel2":
                        _loc36_ = _loc9_.findTileIDByTileListItemID(_loc32_.playerItemID);
                        this.displayTutorialMarker_inventory(_loc36_,true);
                  }
               }
               else if(_loc1_.tutorialLevel <= BMDataManager.TUTORIAL_LEVEL_MECH5)
               {
                  dataM.setTutorialLevel(BMDataManager.TUTORIAL_LEVEL_MECH5);
                  _loc37_ = false;
                  _loc3_ = 0;
                  while(_loc3_ < this._currentPlayerData.items.length)
                  {
                     _loc2_ = this._currentPlayerData.items[_loc3_];
                     if(_loc2_.itemID == dataM.TUTORIAL_BOX_LEG_ID && _loc2_.equipped == 0)
                     {
                        _loc39_ = _loc2_;
                        _loc37_ = true;
                     }
                     else if(_loc2_.itemID == dataM.TUTORIAL_BOX_MODULE_ID && _loc2_.equipped == 0)
                     {
                        _loc40_ = _loc2_;
                        _loc37_ = true;
                     }
                     else if(_loc2_.itemID == dataM.TUTORIAL_BOX_DRONE_ID && _loc2_.equipped == 0)
                     {
                        _loc38_ = _loc2_;
                        _loc37_ = true;
                     }
                     _loc3_++;
                  }
                  if(_loc37_)
                  {
                     if(_loc39_ != null)
                     {
                        _loc41_ = _loc9_.findTileIDByTileListItemID(_loc39_.playerItemID);
                        this.displayTutorialMarker_inventory(_loc41_,true);
                        this.tutorialPhase = "equip_fromBox_leg";
                     }
                     else if(_loc40_ != null)
                     {
                        _loc42_ = _loc9_.findTileIDByTileListItemID(_loc40_.playerItemID);
                        this.displayTutorialMarker_inventory(_loc42_,true);
                        this.tutorialPhase = "equip_fromBox_module";
                     }
                     else
                     {
                        _loc43_ = _loc9_.findTileIDByTileListItemID(_loc38_.playerItemID);
                        this.displayTutorialMarker_inventory(_loc43_,true);
                        this.tutorialPhase = "equip_fromBox_drone";
                     }
                  }
                  else
                  {
                     _loc4_ = "goToFusion";
                     this.updateMech();
                     dataM.setTutorialLevel(BMDataManager.TUTORIAL_LEVEL_FUSION);
                  }
               }
               else if(_loc1_.tutorialLevel <= BMDataManager.TUTORIAL_LEVEL_FUSION)
               {
                  if(screensM.isScreenOpened("screenHangerFusion"))
                  {
                     screensM.screenHangerInventory.hideAllItemTypeInterface();
                     dataM.setTutorialLevel(BMDataManager.TUTORIAL_LEVEL_FUSION,"screenHangerMenu refreshTutorial hanger5");
                     _loc48_ = 0;
                     _loc3_ = 0;
                     while(_loc3_ < this._currentPlayerData.items.length)
                     {
                        _loc2_ = this._currentPlayerData.items[_loc3_];
                        switch(_loc2_.itemID)
                        {
                           case dataM.TUTORIAL_BUY_TORSO2_ID:
                              _loc44_ = _loc2_;
                              break;
                           case dataM.TUTORIAL_TORSO_ID:
                              _loc45_ = _loc2_;
                              _loc48_++;
                              break;
                           case dataM.TUTORIAL_LEG_ID:
                              _loc46_ = _loc2_;
                              _loc48_++;
                              break;
                           case dataM.TUTORIAL_WEAPON_ID:
                              _loc47_ = _loc2_;
                              _loc48_++;
                        }
                        _loc3_++;
                     }
                     screensM.screenHangerFusion.deactivateTutorialFusionMarker();
                     if(_loc48_ > 0)
                     {
                        if(screensM.screenHangerFusion.getTargetPlayerItemID() != _loc44_.playerItemID)
                        {
                           this.tutorialPhase = "fusion_equipTargetItem";
                           _loc49_ = _loc9_.findTileIDByTileListItemID(_loc44_.playerItemID);
                           this.displayTutorialMarker_inventory(_loc49_,false);
                        }
                        else if(screensM.screenHangerFusion.getSourcePlayerItemIDs().length >= 3)
                        {
                           this.tutorialPhase = "fusion_activate";
                           screensM.screenHangerFusion.activateTutorialFusionMarker();
                        }
                        else if(screensM.screenHangerFusion.getSourcePlayerItemIDs().length == 0)
                        {
                           if(_loc45_ != null)
                           {
                              this.tutorialPhase = "fusion_equipSourceTorso1";
                              _loc50_ = _loc9_.findTileIDByTileListItemID(_loc45_.playerItemID);
                              this.displayTutorialMarker_inventory(_loc50_,false);
                           }
                        }
                        else if(screensM.screenHangerFusion.getSourcePlayerItemIDs().length == 1)
                        {
                           if(_loc46_ != null)
                           {
                              this.tutorialPhase = "fusion_equipSourceLeg1";
                              _loc50_ = _loc9_.findTileIDByTileListItemID(_loc46_.playerItemID);
                              this.displayTutorialMarker_inventory(_loc50_,false);
                           }
                        }
                        else if(screensM.screenHangerFusion.getSourcePlayerItemIDs().length == 2)
                        {
                           if(_loc47_ != null)
                           {
                              this.tutorialPhase = "fusion_equipSourceWeapon1";
                              _loc50_ = _loc9_.findTileIDByTileListItemID(_loc47_.playerItemID);
                              this.displayTutorialMarker_inventory(_loc50_,false);
                           }
                        }
                     }
                     else
                     {
                        this.tutorialPhase = "switchToMechFromFusion";
                        dataM.setTutorialLevel(BMDataManager.TUTORIAL_LEVEL_SHOP2,"screenHangerMenu refreshTutorial fusion");
                        screensM.readdScreenIntoTopLayer("screenHangerMenu");
                        this._tutorialArrowController.activateTutorialArrow(this,this.btnBack.x + this.btnBack.width,this.btnBack.y + this.btnBack.height / 2);
                     }
                  }
                  else
                  {
                     _loc4_ = "goToFusion";
                  }
               }
               else if(_loc1_.tutorialLevel <= BMDataManager.TUTORIAL_LEVEL_SHOP2)
               {
               }
            }
         }
         this.refreshButtons(_loc4_);
      }
      
      public function refreshButtons(param1:String = "") : void
      {
         if(dataM.isTutorialActive())
         {
            this.btnBack.visible = false;
            this.btnFusion.visible = false;
            this.btnMech.visible = false;
            this.btnChangeMechsOrder.visible = false;
            this.txtMech.visible = false;
            this.txtFusion.visible = false;
            this.txtChangeMechsOrder.visible = false;
            if(dataM.myProfile.tutorialLevel >= BMDataManager.TUTORIAL_LEVEL_MECH5)
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
                  case BMDataManager.TUTORIAL_LEVEL_SHOP2:
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
         trace("displayTutorialMarker_inventory $tileID:" + param1);
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
         if(dataM.gameType == BMDataManager.GAME_TYPE_GUEST)
         {
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
         else
         {
            if(_loc1_.missionID > 0)
            {
               remoteM.socketM.mission_getData();
            }
            else
            {
               _loc1_.currentMissionSlot = 0;
               if(_loc1_.mapProgress[0] == "v")
               {
                  _loc1_.currentMissionSlot = 1;
               }
               remoteM.socketM.mission_create(0,1,_loc1_.currentMissionSlot,"");
            }
            screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
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
               if(_loc2_ || dataM.isTutorialActive())
               {
                  _loc11_ = true;
               }
               if(_loc11_ || _loc10_)
               {
                  remoteM.inventory_updateMechs(_loc11_,_loc3_,_loc4_,_loc10_,_loc6_.selectedMechID);
                  if(dataM.gameType == BMDataManager.GAME_TYPE_ONLINE)
                  {
                     screensM.screenConfirmation.displayQuestionOrNotification("savingMech",-1,-1);
                  }
               }
               else
               {
                  this.backClickedSub(true,false);
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
         if(dataM.isTutorialActive())
         {
            if(dataM.getTutorialDestination() == BMDataManager.TUTORIAL_DESTINATION_FUSION)
            {
               screensM.removeScreen("screenConfirmation");
            }
            else if(dataM.myProfile.tutorialLevel == BMDataManager.TUTORIAL_LEVEL_MECH5)
            {
               screensM.removeScreen("screenConfirmation");
               dataM.setTutorialLevel(dataM.myProfile.tutorialLevel + 1,"screenHanger");
               this.refreshTutorial();
            }
            else
            {
               this.updateMechBeforeGoingToBattleInTutorialIsDone();
            }
         }
         else
         {
            screensM.removeScreen("screenConfirmation");
            this.backClickedSub(true,false);
         }
      }
      
      private function updateMechBeforeGoingToBattleInTutorialIsDone() : void
      {
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(dataM.getTutorialDestination() == BMDataManager.TUTORIAL_DESTINATION_LONE_BATTLE)
         {
            this.tutorialLaunchBattleVSComputer();
         }
         else if(dataM.getTutorialDestination() == BMDataManager.TUTORIAL_DESTINATION_MISSION)
         {
            screensM.removeScreen("screenConfirmation");
            this.backClickedSub(true,false);
         }
      }
      
      public function backClicked() : void
      {
         if(dataM.isTutorialActive())
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
      
      private function backToMenu() : void
      {
         if(dataM.runAsMobile)
         {
            screensM.screenBlack.activateBlackScreen(this.backToMenuSub,true,true,null,0);
         }
         else
         {
            this.backToMenuSub();
         }
      }
      
      private function backToMenuSub() : void
      {
         this.resetNewItemsPurchased();
         if(this.returnToMissionBaseMap)
         {
            this.returnToMissionBaseMap = false;
            screensM.addScreen("screenMissionBaseMap");
            screensM.screenMissionBaseMap.refreshScreen(false,true);
         }
         else if(this.returnToMenuMultiPlayer)
         {
            TsLogger.log("MUST FIX THIS!!!!!!!!!!!!!!!!!!!!!!");
            this.returnToMenuMultiPlayer = false;
         }
         else
         {
            screensM.addScreen("screenMissionWorldMap");
            screensM.screenMissionWorldMap.refreshScreen();
         }
         this.removeHanger();
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

