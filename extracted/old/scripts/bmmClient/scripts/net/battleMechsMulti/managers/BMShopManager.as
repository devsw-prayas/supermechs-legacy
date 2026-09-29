package net.battleMechsMulti.managers
{
   import flash.events.Event;
   import net.battleMechsMulti.managers.notifications.BMNotificationsManager;
   import net.battleMechsMulti.managers.sales.BMSalesManager;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   import net.battleMechsMulti.mobiles.BMBoostData;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMPlayerData;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.BMTokenPackage;
   import net.battleMechsMulti.screens.BMScreenWatchRewardedVideo;
   import net.battleMechsMulti.screens.shop.BMScreenGlobalShop;
   import net.battleMechsMulti.screens.shop.BMShopCategoryData;
   import net.battleMechsMulti.screens.shop.BMShopItemData;
   
   public class BMShopManager extends BMBaseClass
   {
      
      private static var inst:BMShopManager;
      
      public static const TUTORIAL_PREMIUM_PACKAGE_ID:uint = 8;
      
      public static const TUTORIAL_ITEM_BOX_PACKAGE_ID:uint = 9;
      
      public static const CAT_NONE:int = -1;
      
      public static const CAT_TOKENS:int = 0;
      
      public static const CAT_SPECIAL_BOXSES:int = 1;
      
      public static const CAT_ITEM_BOXSES:int = 2;
      
      public static const CAT_POWER_KITS:int = 3;
      
      public static const CAT_SPECIAL_OFFERS:int = 4;
      
      public static const FREE_ITEM_BOX_ID:uint = 999;
      
      public static const WEB_MORE_OPTIONS:uint = 998;
      
      public static const REWARDED_VIDEO_ID:uint = 997;
      
      private var _currentCategoryID:int = -1;
      
      private var _sourceNotificationID:int = -1;
      
      private var _screenSource:String = null;
      
      public function BMShopManager()
      {
         super();
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("globalShop");
      }
      
      public static function getInstance() : BMShopManager
      {
         if(inst == null)
         {
            inst = new BMShopManager();
         }
         return inst;
      }
      
      public static function gi() : BMShopManager
      {
         return getInstance();
      }
      
      public function showCategory(param1:int, param2:String) : *
      {
         if(this.isCategoryInGuestBlock(param1))
         {
            screensM.screenConfirmation.displayQuestionOrNotification("mustRegister");
         }
         else
         {
            switch(param1)
            {
               case CAT_NONE:
                  this.showCategoriesScreen(param2);
                  break;
               case CAT_TOKENS:
                  this.showTokens(param2);
                  break;
               case CAT_SPECIAL_BOXSES:
                  this.showSpecialBoxses(param2);
                  break;
               case CAT_ITEM_BOXSES:
                  this.showItemBoxses(param2);
                  break;
               case CAT_POWER_KITS:
                  this.showPowerKits(param2);
                  break;
               case CAT_SPECIAL_OFFERS:
                  this.showSpecialOffers(param2);
            }
         }
      }
      
      private function get shopView() : BMScreenGlobalShop
      {
         if(!screensM.isScreenOpened("screenGlobalShop"))
         {
            screensM.addScreen("screenGlobalShop");
            screensM.screenGlobalShop.refreshScreen();
         }
         return screensM.screenGlobalShop;
      }
      
      public function get currentCategory() : *
      {
         return this._currentCategoryID;
      }
      
      public function isScreenOpened() : *
      {
         return screensM.isScreenOpened("screenGlobalShop");
      }
      
      public function showCategoriesScreen(param1:String) : *
      {
         var _loc4_:int = 0;
         var _loc7_:Array = null;
         var _loc8_:BMShopCategoryData = null;
         var _loc2_:Array = [getScreenText("tokens"),getScreenText("specialBoxes"),getScreenText("itemBoxes"),getScreenText("powerKits"),getScreenText("specialOffers")];
         var _loc3_:Array = new Array();
         while(_loc4_ < 5)
         {
            _loc8_ = new BMShopCategoryData();
            _loc8_.imageName = "globalShop_category" + (_loc4_ + 1);
            _loc8_.name = _loc2_[_loc4_];
            _loc8_.id = _loc4_;
            _loc3_.push(_loc8_);
            _loc4_++;
         }
         var _loc5_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc6_:uint = _loc5_.getAllFreePackagesAmount();
         if(_loc5_.level > 3 && _loc6_ > 0)
         {
            BMShopCategoryData(_loc3_[CAT_SPECIAL_BOXSES]).counter = _loc5_.getAllFreePackagesAmount();
         }
         if(dataM.isTutorialActive())
         {
            _loc7_ = [true,true,false,true,true];
         }
         this.shopView.setCategories(_loc3_,_loc7_);
         this._currentCategoryID = -1;
         this._screenSource = param1;
      }
      
      public function setSourceNotificationID(param1:int) : *
      {
         this._sourceNotificationID = param1;
      }
      
      public function refresh() : *
      {
         if(!this.isScreenOpened())
         {
            return;
         }
         this.showCategory(this._currentCategoryID,this._screenSource);
         this.shopView.refreshGoldTokensTexts();
      }
      
      public function isCategoryInGuestBlock(param1:uint) : Boolean
      {
         var _loc2_:Boolean = false;
         if(dataM.gameType == BMDataManager.GAME_TYPE_GUEST)
         {
            switch(param1)
            {
               case CAT_TOKENS:
               case CAT_SPECIAL_OFFERS:
               case CAT_POWER_KITS:
                  _loc2_ = true;
            }
         }
         return _loc2_;
      }
      
      public function isCategoryInTutorialBlock(param1:uint) : Boolean
      {
         var _loc2_:Boolean = false;
         if(dataM.isTutorialActive())
         {
            _loc2_ = true;
            switch(param1)
            {
               case CAT_ITEM_BOXSES:
                  _loc2_ = false;
            }
         }
         return _loc2_;
      }
      
      public function isTokensInGuestBlock() : Boolean
      {
         return this.isCategoryInGuestBlock(CAT_TOKENS);
      }
      
      public function resetLastCateogry() : void
      {
         this._currentCategoryID = -1;
      }
      
      public function showBuyGold() : void
      {
         if(dataM.gameType == BMDataManager.GAME_TYPE_GUEST)
         {
            screensM.screenConfirmation.displayQuestionOrNotification("mustRegister");
         }
         else
         {
            screensM.addScreen("screenBuyGold");
            screensM.screenBuyGold.refreshScreen();
         }
      }
      
      public function showTokens(param1:* = null) : void
      {
         var _loc4_:BMTokenPackage = null;
         var _loc5_:BMShopItemData = null;
         var _loc6_:int = 0;
         var _loc7_:String = null;
         this.shopView.setTitle(getScreenText("tokensCAP"));
         if(!dataM.arePlatformStoreProductsAvailable)
         {
            this._currentCategoryID = CAT_TOKENS;
            this.shopView.setError(getSpecificText("buyTokens_noPackagesAvailable"));
            return;
         }
         var _loc2_:Array = new Array();
         var _loc3_:uint = 0;
         while(_loc3_ < dataM.allTokenPackages.length)
         {
            _loc4_ = dataM.allTokenPackages[_loc3_];
            if(_loc4_.starterPackID == 0)
            {
               if(_loc4_.visualID != FREE_ITEM_BOX_ID)
               {
                  _loc5_ = new BMShopItemData();
                  if(_loc4_.visualID == REWARDED_VIDEO_ID)
                  {
                     if(dataM.isRewardedVideoAvailable(BMScreenWatchRewardedVideo.PLACEMENT_TOKENS_SHOP))
                     {
                        _loc5_.timerCompleteText = getSpecificText("buyTokens_watchNow");
                        _loc5_.timerEnd = dataM.currentTime;
                     }
                     else
                     {
                        _loc5_.timerCompleteText = getSpecificText("buyTokens_comeBackLater");
                        _loc5_.timerEnd = dataM.currentTime;
                     }
                  }
                  else if(_loc4_.visualID == WEB_MORE_OPTIONS)
                  {
                     _loc5_.twoRowsText = getSpecificText("buyTokens_moreOptions2");
                     _loc5_.timerEnd = dataM.currentTime;
                  }
                  _loc5_.id = _loc3_;
                  _loc5_.price = _loc4_.price;
                  _loc5_.imagePath = "general";
                  _loc5_.imageName = "globalShop_tokens" + _loc4_.visualID;
                  _loc5_.specialBanner = _loc4_.specialBanner;
                  _loc6_ = _loc4_.tokens - _loc4_.bonusFromTokens;
                  if(_loc6_ > 0)
                  {
                     _loc5_.bodyText = dataM.getNumberWithComma(_loc6_);
                  }
                  if(_loc4_.bonusFromTokens > 0)
                  {
                     _loc7_ = getSpecificText("shop_tokensBonus");
                     _loc7_ = dataM.replaceStringInText(_loc7_,"%BONUS%",dataM.getNumberWithComma(_loc4_.bonusFromTokens));
                     _loc5_.bonusText = _loc7_;
                  }
                  else
                  {
                     _loc5_.bonusText = "";
                  }
                  _loc5_.currency = BMShopItemData.CURRENCY_TYPE_MONEY;
                  _loc2_.push(_loc5_);
               }
            }
            _loc3_++;
         }
         this.shopView.setItems(_loc2_,this._currentCategoryID != CAT_TOKENS);
         this.shopView.onSelect = this.onTokensSelect;
         this._currentCategoryID = CAT_TOKENS;
         this._screenSource = null;
      }
      
      private function onTokensSelect(param1:BMShopItemData) : void
      {
         TsLogger.log("BMScreenGlobalShop :: onTokenSelect " + param1.id);
         var _loc2_:BMTokenPackage = dataM.allTokenPackages[param1.id];
         if(_loc2_.tokenSystemPackageID == String(REWARDED_VIDEO_ID))
         {
            if(dataM.isRewardedVideoAvailable(BMScreenWatchRewardedVideo.PLACEMENT_TOKENS_SHOP))
            {
               screensM.addScreen("screenWatchRewardedVideo");
               screensM.screenWatchRewardedVideo.refreshScreen(screensM.screenWatchRewardedVideo.TYPE_TOKENS_SHOP);
            }
            else
            {
               screensM.screenConfirmation.displayQuestionOrNotification("rewardVideosComeBackLater");
            }
         }
         else if(_loc2_.tokenSystemPackageID == String(WEB_MORE_OPTIONS))
         {
            screensM.addScreen("screenMorePaymentOptions");
            screensM.screenMorePaymentOptions.refreshScreen();
         }
         else if(dataM.runAsMobile == false)
         {
            dataM.trackEvent("MonetizationFunnel","RealMoneyPackageSelection",_loc2_.title);
            if(dataM.needToRegisterToBuyRealMoney)
            {
               screensM.screenConfirmation.displayQuestionOrNotification("mustRegister",1);
            }
            else
            {
               dataM.openBuyTokensPage_paypal(int(_loc2_.tokenSystemPackageID));
            }
         }
         else
         {
            screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
            dataM.trackEvent("MonetizationFunnel","RealMoneyPackageSelection",_loc2_.title);
            this.triggerMobilePurchase(String(_loc2_.tokenSystemPackageID));
         }
      }
      
      private function callPleaseWait(param1:Event) : void
      {
         screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait",-1,-1);
      }
      
      private function triggerKongPurchase(param1:String) : void
      {
      }
      
      public function triggerMobilePurchase(param1:String) : Boolean
      {
         TsLogger.log("BMScreenGlobalShop :: triggerPurchase() " + param1);
         return false;
      }
      
      private function triggerPurchase(param1:String) : Boolean
      {
         TsLogger.log("BMScreenGlobalShop :: triggerPurchase()");
         return false;
      }
      
      public function processPendingPurchases() : void
      {
         TsLogger.log("BMScreenGlobalShop :: processPendingPurchases");
      }
      
      public function showItemBoxses(param1:String) : *
      {
         this.shopView.setTitle(getScreenText("itemBoxesCAP"));
         var _loc2_:Array = new Array();
         if(dataM.isTutorialActive() == false && dataM.gameType != BMDataManager.GAME_TYPE_GUEST)
         {
            _loc2_.push(this.createTimedBox());
         }
         var _loc3_:Boolean = dataM.isTutorialActive();
         _loc2_.push(this.convertItemBoxData(dataM.boostsDB[25]));
         _loc2_.push(this.convertItemBoxData(dataM.boostsDB[21],_loc3_));
         _loc2_.push(this.convertItemBoxData(dataM.boostsDB[22],_loc3_));
         _loc2_.push(this.convertItemBoxData(dataM.boostsDB[23],_loc3_));
         _loc2_.push(this.convertItemBoxData(dataM.boostsDB[24],_loc3_));
         this.shopView.setItems(_loc2_,this._currentCategoryID != CAT_ITEM_BOXSES);
         this.shopView.onSelect = this.onBoxSelect;
         this._currentCategoryID = CAT_ITEM_BOXSES;
         this._screenSource = param1;
      }
      
      private function convertItemBoxData(param1:BMBoostData, param2:Boolean = false) : BMShopItemData
      {
         var _loc3_:BMShopItemData = new BMShopItemData();
         var _loc4_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         _loc3_.id = param1.boostID;
         switch(_loc3_.id)
         {
            case WEB_MORE_OPTIONS:
               _loc3_.titleTop = getSpecificText("buyTokens_moreOptions");
               break;
            case REWARDED_VIDEO_ID:
               _loc3_.titleTop = getSpecificText("buyTokens_freeTokens");
               break;
            default:
               _loc3_.titleBottom = getSpecificText("shopCombined_box" + param1.boostID);
         }
         var _loc5_:Boolean = false;
         if(BMSpecialOffersManager.gi().specialOffersResetTime > dataM.currentTime)
         {
            if(param1.costTokens < param1.costTokensDefault)
            {
               _loc5_ = true;
            }
            else if(param1.ratioMythical < param1.ratioMythicalDefault)
            {
               _loc5_ = true;
            }
            else if(param1.ratioNewMythical < param1.ratioNewMythicalDefault)
            {
               _loc5_ = true;
            }
         }
         if(_loc5_)
         {
            _loc3_.useBottomTimer = false;
            _loc3_.timerEnd = BMSpecialOffersManager.gi().specialOffersResetTime;
         }
         var _loc6_:int = _loc4_.getFreePackageAmount(param1.boostID);
         if(param1.costTokens == 0)
         {
            _loc3_.currency = BMShopItemData.CURRENCY_TYPE_GOLD;
            _loc3_.price = dataM.getNumberWithComma(dataM.getBoostGoldCost(param1.boostID));
            if(_loc6_ > 0)
            {
               _loc3_.price = getGeneralText("free") + " x" + _loc6_;
               _loc3_.currency = BMShopItemData.CURRENCY_TYPE_FREE;
            }
         }
         else
         {
            _loc3_.currency = BMShopItemData.CURRENCY_TYPE_TOKENS;
            _loc3_.price = dataM.getNumberWithComma(param1.costTokens);
            if(_loc6_ > 0)
            {
               _loc3_.price = getGeneralText("free") + " x" + _loc6_;
               _loc3_.currency = BMShopItemData.CURRENCY_TYPE_FREE;
            }
            if(param1.costTokensDefault > param1.costTokens)
            {
               _loc3_.defaultPrice = dataM.getNumberWithComma(param1.costTokensDefault);
               _loc3_.specialBanner = 3;
               _loc3_.discount = Math.floor((param1.costTokensDefault - param1.costTokens) / param1.costTokensDefault * 100);
            }
         }
         _loc3_.itemBox_cards = param1.amount;
         _loc3_.itemBox_ratio1 = param1.ratioRare;
         _loc3_.itemBox_ratio2 = param1.ratioEpic;
         _loc3_.itemBox_ratio3 = param1.ratioLegendary;
         _loc3_.itemBox_ratio4 = param1.ratioMythical;
         _loc3_.ratioNewMythical = param1.ratioNewMythical;
         _loc3_.isDisabled = param2;
         _loc3_.imagePath = "general";
         _loc3_.imageName = "globalShop_itemBox" + param1.boostID;
         return _loc3_;
      }
      
      private function createTimedBox() : BMShopItemData
      {
         var _loc3_:int = 0;
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc2_:BMShopItemData = new BMShopItemData();
         _loc2_.id = FREE_ITEM_BOX_ID;
         _loc2_.titleBottom = getSpecificText("buyTokens_freeItemBox");
         _loc2_.timerCompleteText = getSpecificText("buyTokens_claim");
         if(_loc1_.gotFreeItemBox + dataM.secondsForFreeItemBox < dataM.currentTime && _loc1_.freeItemBoxes < 2)
         {
            ++_loc1_.freeItemBoxes;
            _loc1_.gotFreeItemBox += dataM.secondsForFreeItemBox;
         }
         if(_loc1_.freeItemBoxes > 0)
         {
            _loc2_.timerEnd = dataM.currentTime;
         }
         else
         {
            _loc2_.timerEnd = _loc1_.gotFreeItemBox + dataM.secondsForFreeItemBox;
            _loc3_ = _loc1_.freeItemBoxes + 1;
            _loc3_ = _loc3_ > 2 ? 2 : _loc3_;
            _loc2_.timerCompleteImageName = "globalShop_itemBoxTimed" + _loc3_;
         }
         _loc2_.imagePath = "general";
         _loc2_.imageName = "globalShop_itemBoxTimed" + _loc1_.freeItemBoxes;
         return _loc2_;
      }
      
      private function onBoxSelect(param1:BMShopItemData) : void
      {
         if(param1.id == FREE_ITEM_BOX_ID)
         {
            this.tryToBuyBox(param1);
         }
         else if(dataM.myProfile.getFreePackageAmount(param1.id) > 0)
         {
            this.tryToBuyBox(param1);
         }
         else
         {
            screensM.addScreen("screenBuyItemBox");
            screensM.screenBuyItemBox.refreshScreen(param1);
         }
      }
      
      public function tryToBuyBox(param1:BMShopItemData) : void
      {
         var _loc9_:Boolean = false;
         var _loc10_:BMPlayerData = null;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         TsLogger.log("BMScreenGlobalShop :: onBoxSelect() " + param1.id);
         if(param1.id == FREE_ITEM_BOX_ID)
         {
            this.tryClaimFreeBox();
            return;
         }
         var _loc2_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc3_:uint = param1.id;
         var _loc4_:BMBoostData = dataM.boostsDB[_loc3_];
         var _loc5_:Boolean = false;
         if(_loc2_.getFreePackageAmount(_loc3_) > 0)
         {
            _loc5_ = true;
         }
         var _loc6_:Boolean = false;
         var _loc7_:Boolean = false;
         var _loc8_:uint = dataM.getBoostGoldCost(_loc4_.boostID);
         if(_loc4_.costTokens > _loc2_.tokens)
         {
            _loc6_ = true;
         }
         if(_loc8_ > _loc2_.gold)
         {
            _loc7_ = true;
         }
         if(_loc5_ == false && (_loc6_ || _loc7_))
         {
            if(dataM.gameType == BMDataManager.GAME_TYPE_GUEST)
            {
               if(_loc6_)
               {
                  screensM.screenConfirmation.displayQuestionOrNotification("mustRegister",-1,-1);
               }
               else
               {
                  screensM.screenConfirmation.displayQuestionOrNotification("notEnoughGold",_loc3_,-1);
               }
            }
            else if(_loc6_)
            {
               screensM.screenConfirmation.displayQuestionOrNotification("notEnoughTokens",_loc3_,-1);
            }
            else
            {
               screensM.screenTopBar.getGoldClicked();
            }
         }
         else
         {
            _loc9_ = false;
            if(_loc4_.type == "randomItems")
            {
               if(dataM.gameType == BMDataManager.GAME_TYPE_GUEST)
               {
                  _loc10_ = dataM.playersData[dataM.player1PlayerID];
                  if(_loc10_.items.length + _loc4_.amount > dataM.GUEST_MAX_ITEMS)
                  {
                     _loc9_ = true;
                  }
               }
            }
            if(_loc9_)
            {
               screensM.screenConfirmation.displayQuestionOrNotification("mustRegisterInventoryBlocked",-1,-1);
            }
            else if(_loc5_)
            {
               remoteM.tokens_buyPackageNew(_loc3_);
               if(dataM.gameType == BMDataManager.GAME_TYPE_ONLINE)
               {
                  screensM.screenConfirmation.displayQuestionOrNotification("buyingPackage",-1,-1);
               }
               if(dataM.packages_markItemBoxFromTutorial && _loc3_ == TUTORIAL_ITEM_BOX_PACKAGE_ID)
               {
                  dataM.packages_markPremiumFromTutorial = false;
               }
            }
            else if(dataM.gameType == BMDataManager.GAME_TYPE_ONLINE)
            {
               _loc11_ = 0;
               _loc12_ = 0;
               if(_loc4_.type == "specificItem")
               {
                  _loc11_ = _loc4_.itemID;
                  _loc12_ = _loc4_.costTokens;
               }
               remoteM.tokens_buyPackageNew(_loc4_.boostID,_loc11_,_loc12_);
               if(this._sourceNotificationID != BMNotificationsManager.NO_NOTIFICATION_ID)
               {
                  BMNotificationsManager.getInstance().trackNotificationEvent("BoughtAdditionalBox",this._sourceNotificationID,_loc4_.boostID);
               }
               dataM.trackEvent("Economy","BuyBox",this._screenSource,_loc4_.boostID);
               screensM.screenConfirmation.displayQuestionOrNotification("buyingPackage");
            }
            else
            {
               this.buyPackageLocally(_loc4_.boostID);
            }
         }
      }
      
      private function get canClaimFreeBox() : Boolean
      {
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         return _loc1_.freeItemBoxes > 0 || _loc1_.gotFreeItemBox + dataM.secondsForFreeItemBox < dataM.currentTime;
      }
      
      private function tryClaimFreeBox() : *
      {
         if(this.canClaimFreeBox)
         {
            remoteM.socketM.lobby_getFreeItemBox();
            screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
         }
         else
         {
            screensM.screenConfirmation.displayQuestionOrNotification("noFreeBoxes");
         }
      }
      
      public function onGoFreeItemBox() : *
      {
      }
      
      public function getCategoryForPackageID(param1:int) : *
      {
         if(param1 == 5 || param1 == 6 || param1 == 20 || param1 == 19)
         {
            return CAT_SPECIAL_BOXSES;
         }
         return CAT_NONE;
      }
      
      public function showSpecialBoxses(param1:String, param2:uint = 0) : *
      {
         this.shopView.setTitle(getScreenText("specialBoxesCAP"));
         var _loc3_:Array = new Array();
         _loc3_.push(this.convertItemBoxData(dataM.boostsDB[5]));
         _loc3_.push(this.convertItemBoxData(dataM.boostsDB[6]));
         _loc3_.push(this.convertItemBoxData(dataM.boostsDB[20]));
         _loc3_.push(this.convertItemBoxData(dataM.boostsDB[19]));
         this.shopView.setItems(_loc3_,this._currentCategoryID != CAT_SPECIAL_BOXSES,param2);
         this.shopView.onSelect = this.onBoxSelect;
         this._currentCategoryID = CAT_SPECIAL_BOXSES;
         this._screenSource = param1;
      }
      
      public function buyPackageLocally(param1:Number) : void
      {
         var _loc2_:BMPlayerProfile = null;
         var _loc3_:BMBoostData = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Array = null;
         var _loc9_:uint = 0;
         var _loc10_:Number = NaN;
         _loc2_ = dataM["player" + dataM.player1PlayerID + "Profile"];
         _loc3_ = dataM.boostsDB[param1];
         var _loc4_:Boolean = false;
         switch(_loc3_.type)
         {
            case "resources":
               _loc2_.gold += int(_loc3_.bonusGold);
               screensM.screenConfirmation.displayQuestionOrNotification("packageBought",param1,-1);
               break;
            case "randomItems":
               _loc6_ = _loc2_.level;
               _loc7_ = _loc2_.level + _loc3_.levelDifference;
               if(_loc2_.tutorialLevel <= BMDataManager.TUTORIAL_LEVEL_SHOP1)
               {
                  _loc8_ = [dataM.TUTORIAL_BUY_SIDE_WEAPON4_ID,dataM.TUTORIAL_BUY_TOP_WEAPON1_ID,dataM.TUTORIAL_BUY_MODULE_ID];
               }
               else
               {
                  _loc8_ = dataM.getBonusItems(_loc6_,_loc2_.level,_loc7_,_loc3_.amount,_loc3_.ratioRare,_loc3_.ratioEpic,_loc3_.ratioLegendary,_loc3_.itemType,_loc3_.ratioPowerKit);
               }
               _loc9_ = 0;
               while(_loc9_ < _loc8_.length)
               {
                  _loc10_ = Number(_loc8_[_loc9_]);
                  dataM.addPlayerItemDataToInventory(dataM.player1PlayerID,_loc10_,0,0,0,0);
                  _loc9_++;
               }
               ++_loc2_.itemBoxesBought_guest;
               screensM.addScreen("screenItemCards");
               screensM.screenItemCards.refreshScreen(_loc8_,_loc3_.boostID);
               screensM.removeScreen("screenConfirmation");
               if(_loc2_.tutorialLevel <= BMDataManager.TUTORIAL_LEVEL_SHOP1)
               {
                  dataM.setTutorialLevel(BMDataManager.TUTORIAL_LEVEL_SHOP1 + 1,"screenHangerPackages buyPackageLocally premiumAccount");
               }
               else if(_loc2_.tutorialLevel <= BMDataManager.TUTORIAL_LEVEL_SHOP2)
               {
                  dataM.setTutorialLevel(BMDataManager.TUTORIAL_LEVEL_SHOP2 + 1,"screenHangerPackages buyPackageLocally premiumAccount");
                  _loc4_ = true;
               }
               break;
            case "specificItem":
         }
         var _loc5_:Boolean = false;
         if(_loc2_.getFreePackageAmount(param1) > 0)
         {
            _loc2_.removeFreePackage(param1);
            _loc5_ = true;
         }
         if(_loc5_ == false)
         {
            if(_loc3_.costTokens > 0)
            {
               _loc2_.tokens -= int(_loc3_.costTokens);
            }
            else
            {
               _loc2_.gold -= dataM.getBoostGoldCost(_loc3_.boostID);
            }
         }
         if(screensM.screenTopBar != null)
         {
            screensM.screenTopBar.refreshScreen(false);
         }
         dataM.saveGuestData("packages buyPackageLocally");
         if(screensM.isScreenOpened("screenHangerInventory"))
         {
            screensM.screenHangerInventory.refreshScreen();
            screensM.screenHangerMenu.refreshTutorial();
         }
         if(_loc4_ || dataM.isTutorialActive())
         {
            this.close();
         }
      }
      
      public function showPowerKits(param1:String) : *
      {
         var _loc4_:BMItemData = null;
         var _loc5_:BMShopItemData = null;
         var _loc6_:String = null;
         this.shopView.setTitle(getScreenText("powerKitsCAP"));
         var _loc2_:Array = new Array();
         var _loc3_:Array = new Array();
         for each(_loc4_ in dataM.itemsDB)
         {
            if(_loc4_.type == "kit" && _loc4_.subType == "power" && _loc4_.isInShop)
            {
               _loc3_.push(_loc4_);
            }
         }
         _loc3_.sortOn("power",Array.NUMERIC);
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = this.convertItmeData(_loc4_);
            _loc6_ = getSpecificText("shop_power");
            _loc6_ = dataM.replaceStringInText(_loc6_,"%POWER%",dataM.getNumberWithComma(_loc4_.power));
            _loc5_.bonusText = _loc6_;
            if(_loc4_.costTokens < _loc4_.costTokensDefault)
            {
               _loc5_.moveGrpHolderUpPixels = 30;
               _loc5_.moveBonusTextUpPixels = 30;
            }
            else
            {
               _loc5_.moveGrpHolderUpPixels = 20;
               _loc5_.moveBonusTextUpPixels = 10;
            }
            _loc2_.push(_loc5_);
         }
         this.shopView.setItems(_loc2_,this._currentCategoryID != CAT_ITEM_BOXSES);
         this.shopView.onSelect = this.onItemSelect;
         this._currentCategoryID = CAT_POWER_KITS;
         this._sourceNotificationID = BMNotificationsManager.NO_NOTIFICATION_ID;
         this._screenSource = param1;
      }
      
      private function convertItmeData(param1:BMItemData) : BMShopItemData
      {
         var _loc2_:BMShopItemData = new BMShopItemData();
         _loc2_.id = param1.itemID;
         _loc2_.titleTop = param1.fullName;
         if(param1.costTokens > 0)
         {
            _loc2_.price = dataM.getNumberWithComma(param1.costTokens);
            if(param1.costTokensDefault > param1.costTokens)
            {
               _loc2_.defaultPrice = dataM.getNumberWithComma(param1.costTokensDefault);
               _loc2_.discount = Math.floor((param1.costTokensDefault - param1.costTokens) / param1.costTokensDefault * 100);
               if(BMSalesManager.gi().isSaleActive(dataM.currentTime))
               {
                  _loc2_.specialBanner = 3;
                  _loc2_.useBottomTimer = false;
                  _loc2_.timerEnd = BMSalesManager.gi().getSaleData().startDate + BMSalesManager.gi().getSaleData().duration;
               }
            }
            _loc2_.currency = BMShopItemData.CURRENCY_TYPE_TOKENS;
         }
         else
         {
            _loc2_.price = dataM.getNumberWithComma(param1.costGold);
            _loc2_.currency = BMShopItemData.CURRENCY_TYPE_GOLD;
         }
         _loc2_.imagePath = "items3";
         _loc2_.imageName = param1.grp;
         return _loc2_;
      }
      
      private function onItemSelect(param1:BMShopItemData) : void
      {
         TsLogger.log("BMScreenGlobalShop :: onItemSelect " + param1.id);
         var _loc2_:BMItemData = dataM.itemsDB[param1.id];
         screensM.addScreen("screenBuyItem");
         screensM.screenBuyItem.refreshScreen(param1.id);
         screensM.sound_buttonClicked();
      }
      
      private function isUltraPowerKit(param1:BMItemData) : Boolean
      {
         var _loc2_:Boolean = false;
         if(param1.level > dataM.LEVEL_MAX)
         {
            if(param1.specialStatus == 2 && param1.type == "kit" && param1.subType == "power")
            {
               _loc2_ = true;
            }
         }
         return _loc2_;
      }
      
      public function tryToBuyItem(param1:Number, param2:uint) : void
      {
         var _loc5_:BMPlayerData = null;
         var _loc6_:BMItemData = null;
         var _loc7_:Boolean = false;
         var _loc8_:BMPlayerProfile = null;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc3_:BMPlayerData = dataM.playersData[dataM.player1PlayerID];
         var _loc4_:Boolean = false;
         if(dataM.gameType == BMDataManager.GAME_TYPE_GUEST)
         {
            _loc5_ = dataM.playersData[dataM.player1PlayerID];
            if(_loc5_.items.length >= dataM.GUEST_MAX_ITEMS)
            {
               _loc4_ = true;
            }
         }
         if(_loc4_)
         {
            screensM.screenConfirmation.displayQuestionOrNotification("mustRegisterInventoryBlocked",-1,-1);
         }
         else
         {
            _loc6_ = dataM.itemsDB[param1];
            _loc7_ = true;
            _loc8_ = dataM["player" + dataM.player1PlayerID + "Profile"];
            _loc9_ = _loc6_.costGold * param2;
            _loc10_ = _loc6_.costTokens * param2;
            if(_loc10_ > 0)
            {
               if(_loc10_ > _loc8_.tokens)
               {
                  _loc7_ = false;
               }
            }
            else if(_loc9_ > _loc8_.gold)
            {
               _loc7_ = false;
            }
            if(_loc7_)
            {
               this.buyItemConfirmed(param1,param2);
               if(dataM.gameType == BMDataManager.GAME_TYPE_ONLINE)
               {
                  screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
               }
            }
            else if(_loc6_.costTokens > 0 && dataM.runAsMobile == false && dataM.usePersonaly)
            {
               screensM.screenGetTokens.refreshScreen(0,_loc6_.costTokens,"shopItem");
               screensM.addScreen("screenGetTokens");
            }
            else
            {
               screensM.screenConfirmation.displayQuestionOrNotification("notEnoughMoneyForItem",param1,-1);
            }
         }
      }
      
      private function buyItemConfirmed(param1:Number, param2:uint) : void
      {
         remoteM.inventory_buyItem(param1,param2);
         if(dataM.gameType == BMDataManager.GAME_TYPE_ONLINE)
         {
            screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
         }
      }
      
      public function showSpecialOffers(param1:String) : *
      {
         var _loc3_:BMItemData = null;
         this.shopView.setTitle(getScreenText("specialOffersCAP"));
         var _loc2_:Array = new Array();
         for each(_loc3_ in dataM.itemsDB)
         {
            if(_loc3_.type == "perk" && _loc3_.isInShop)
            {
               _loc2_.push(this.convertItmeData(_loc3_));
            }
         }
         this.shopView.setItems(_loc2_,this._currentCategoryID != CAT_SPECIAL_OFFERS);
         this.shopView.onSelect = this.onItemSelect;
         this._currentCategoryID = CAT_SPECIAL_OFFERS;
         this._screenSource = param1;
      }
      
      public function boostsHaveBeenModified() : void
      {
         if(dataM.isTutorialActive() == false)
         {
            this.refresh();
            screensM.screenConfirmation.displayQuestionOrNotification("boostsHaveBeenModified",-1,-1);
         }
         if(screensM.isScreenOpened("screenBuyItemBox"))
         {
            screensM.screenBuyItemBox.backClicked();
         }
         if(screensM.isScreenOpened("screenBuyItem"))
         {
            screensM.screenBuyItem.backClicked();
         }
      }
      
      public function buyItemSuccess(param1:Array, param2:Number) : void
      {
         var _loc4_:uint = 0;
         var _loc6_:Number = NaN;
         var _loc3_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_.newItemsPurchased.push(param1[_loc4_]);
            _loc4_++;
         }
         var _loc5_:BMItemData = dataM.itemsDB[param2];
         if(_loc5_.costTokens == 0)
         {
            _loc3_.gold -= _loc5_.costGold * param1.length;
            screensM.screenTopBar.refreshScreen(false);
         }
         else
         {
            _loc6_ = _loc5_.costTokens * param1.length;
            _loc3_.tokens -= _loc6_;
            if(_loc3_.tokens_bonus >= _loc6_)
            {
               _loc3_.tokens_bonus -= _loc6_;
            }
            else
            {
               _loc6_ -= _loc3_.tokens_bonus;
               _loc3_.tokens_bonus = 0;
               _loc3_.tokens_supporter -= _loc6_;
            }
            if(screensM.isScreenOpened("screenTopBar"))
            {
               screensM.screenTopBar.refreshScreen(false);
            }
            else if(screensM.isScreenOpened("screenTopBarNew"))
            {
               screensM.screenTopBarNew.refreshScreen(false);
            }
         }
         if(dataM.gameType == BMDataManager.GAME_TYPE_ONLINE)
         {
            dataM.trackEvent("Shop","buyItem",_loc5_.type);
         }
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            dataM.addPlayerItemDataToInventory(dataM.player1PlayerID,param2,param1[_loc4_],0,0,0);
            _loc4_++;
         }
         this.refresh();
         soundM.createSound("itemBought",1);
         if(screensM.isScreenOpened("screenHangerInventory"))
         {
            screensM.screenHangerInventory.refreshScreen();
         }
         dataM.saveGuestData("hanger buyItemSuccess");
         screensM.screenConfirmation.displayQuestionOrNotification("purchaseSuccessful");
         if(_loc5_.type == "perk")
         {
            if(screensM.isScreenOpened("screenHangerMech"))
            {
               screensM.screenHangerMech.mechEquipment.refreshEquipemnt(false,false);
            }
         }
      }
      
      public function buyItemLocally(param1:Number, param2:uint) : void
      {
         var _loc6_:Number = NaN;
         var _loc3_:BMPlayerData = dataM.playersData[dataM.player1PlayerID];
         var _loc4_:Array = new Array();
         var _loc5_:uint = 0;
         while(_loc5_ < param2)
         {
            _loc6_ = _loc3_.playerItemIDCounter;
            ++_loc3_.playerItemIDCounter;
            _loc4_.push(_loc6_);
            _loc5_++;
         }
         this.buyItemSuccess(_loc4_,param1);
      }
      
      public function close() : *
      {
         this.shopView.closeClicked();
         if(screensM.isScreenOpened("screenMainMenu"))
         {
            screensM.screenMainMenu.refreshButtonsForTutorial();
         }
      }
      
      public function notifyShopClosed() : *
      {
         this._sourceNotificationID = BMNotificationsManager.NO_NOTIFICATION_ID;
      }
      
      public function get currentScreenSource() : String
      {
         return this._screenSource;
      }
   }
}

