package net.battleMechsMulti.managers.shop
{
   import com.greensock.TweenMax;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import net.battleMechsMulti.data.BMRewardData;
   import net.battleMechsMulti.data.ItemRarityResolver;
   import net.battleMechsMulti.events.AndroidStoreEvent;
   import net.battleMechsMulti.helpers.BMCampaignMechsHelper;
   import net.battleMechsMulti.managers.BMAndroidStoreKitManager;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMLoadingTimer;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.BMTutorialManager;
   import net.battleMechsMulti.managers.notifications.BMNotificationsManager;
   import net.battleMechsMulti.managers.sales.BMSale;
   import net.battleMechsMulti.managers.sales.BMSalesManager;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   import net.battleMechsMulti.mobiles.BMBoostData;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMPlayerData;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.BMStarterPackData;
   import net.battleMechsMulti.mobiles.BMTokenPackage;
   import net.battleMechsMulti.screens.BMScreenWatchRewardedVideo;
   import net.battleMechsMulti.screens.arenaShop.BMPlayerSkillData;
   import net.battleMechsMulti.screens.shop.BMClanShopData;
   import net.battleMechsMulti.screens.shop.BMScreenGlobalShop;
   import net.battleMechsMulti.screens.shop.BMScreenShopItemInfo;
   import net.battleMechsMulti.screens.shop.BMShopCategoryViewData;
   import net.battleMechsMulti.screens.shop.BMShopItemViewData;
   import net.battleMechsMulti.screens.shop.BMShopPremiumInfoCard;
   import net.battleMechsMulti.utils.BMPubSub;
   import net.battleMechsMulti.utils.FeatureFlags;
   import net.battleMechsMulti.utils.TextUtils;
   
   public class BMShopManager extends BMBaseClass
   {
      
      private static var inst:BMShopManager;
      
      public static const TUTORIAL_PREMIUM_PACKAGE_ID:uint = 8;
      
      public static const TUTORIAL_ITEM_BOX_PACKAGE_ID:uint = 9;
      
      public static var NUM_OF_CATEGORIES:int = 6;
      
      public static const CAT_NONE:int = -1;
      
      public static const FORTUNE_BOX_VISUAL_ID:uint = 4;
      
      public static const MIX_BOX_VISUAL_ID:uint = 25;
      
      public static const EASTER_EGG_BOX_VISUAL_ID:uint = 50;
      
      public static const FREE_ITEM_BOX_ID:uint = 999;
      
      public static const UNCLAIMED_ITEM_BOX_ID:uint = 1000;
      
      public static const MINED_TOKENS_ID:uint = 1003;
      
      private static const MIN_CLAN_BOX_ID:uint = 800;
      
      private static const MAX_CLAN_BOX_ID:uint = 899;
      
      public static const WEB_MORE_OPTIONS:uint = 998;
      
      public static const REWARDED_VIDEO_ID:uint = 997;
      
      public static const CUSTOM_ITEMS_BOX_ID:uint = 1001;
      
      public static const WORLD_MAP_ITEMS_BOX_ID:uint = 1002;
      
      public static const REGULAR_GACHA_MACHINE_ID:uint = 1;
      
      public static const TRANSFORM_TO_MYTHICAL_PACK_MACHINE_ID:uint = 4;
      
      private static const KNOWN_LOCALIZATION_FORMATS:Object = {
         "%AMOUNT%x VALUE":"buyTokens_moreValue",
         "%AMOUNT%% MORE!":"buyTokens_more"
      };
      
      private var _currentCategoryID:int = -1;
      
      private var _sourceNotificationID:int = BMNotificationsManager.NO_NOTIFICATION_ID;
      
      private var _screenSource:String = null;
      
      private var _lastShopMechID:uint = 0;
      
      private var _nextTimedBoxIsFortuneBox:Boolean = false;
      
      private var _vipTokenPackages:Array = new Array();
      
      private var _vipTokenPackagesLastSelectedSlot:uint;
      
      private var _lastSelectedTokenPackageID:uint = 0;
      
      private var _pendingClanShopItemPurchase:int;
      
      private var _saleResetTimer:Timer;
      
      private var _chainDiscountResetTimer:Timer;
      
      private var _itemsExtraChanceResetTimer:Timer;
      
      private var _lastSelectedPremiumDurationHours:uint = 0;
      
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
      
      private static function extractFormatAndAmountFromText(param1:String) : Array
      {
         var _loc2_:Array = param1.match("\\d+");
         if(_loc2_ == null || _loc2_.length != 1)
         {
            return null;
         }
         var _loc3_:String = param1.replace(_loc2_[0],"%AMOUNT%");
         var _loc4_:String = _loc2_[0];
         return [_loc3_,_loc4_];
      }
      
      public function showCategory(param1:int, param2:String, param3:Boolean = false) : *
      {
         if(param3)
         {
            if(this._currentCategoryID == param1)
            {
               return;
            }
         }
         this.addChainDiscountResetTimer();
         this.addItemsExtraChanceResetTimer();
         this.addSaleResetTimer();
         switch(param1)
         {
            case this.category_tokens:
               this.showTokens(param2);
               break;
            case this.category_itemBoxes:
               this.showItemBoxes(param2);
               break;
            case this.category_gold:
               this.showGoldPackages(param2);
               break;
            case this.category_customization:
               this.showCustomization(param2);
               break;
            case this.category_unclaimed:
               this.showUnclaimedBoxes(param2);
               break;
            case this.category_premium:
               this.showPremium(param2);
               break;
            case this.category_mechs:
               this.showMechs(param2);
               break;
            case this.category_clanShop:
            case this.category_kinShop:
               this.showClanShop(param2);
         }
      }
      
      private function get shopView() : BMScreenGlobalShop
      {
         if(!screensM.isScreenOpened(BMScreensManager.SCR_GLOBAL_SHOP))
         {
            if(screensM.isScreenOpened(BMScreensManager.SCR_CLAN_MENU))
            {
               screensM.addScreen(BMScreensManager.SCR_GLOBAL_SHOP,true,BMScreenGlobalShop_clan);
            }
            else if(screensM.isScreenOpened(BMScreensManager.SCR_KIN_SHOP))
            {
               screensM.addScreen(BMScreensManager.SCR_GLOBAL_SHOP,true,BMScreenGlobalShop_kin);
            }
            else
            {
               screensM.addScreen(BMScreensManager.SCR_GLOBAL_SHOP);
            }
            screensM.screenGlobalShop.refreshScreen();
            this.initCategories();
         }
         return screensM.screenGlobalShop;
      }
      
      public function get currentCategory() : *
      {
         return this._currentCategoryID;
      }
      
      public function isScreenOpened() : *
      {
         return screensM.isScreenOpened(BMScreensManager.SCR_GLOBAL_SHOP);
      }
      
      private function initCategories() : void
      {
         var _loc3_:BMShopCategoryViewData = null;
         if(FeatureFlags.BLOCK_SHOP)
         {
            screensM.screenConfirmation.displayQuestionOrNotification("featureNotAvailable");
            return;
         }
         var _loc1_:Array = new Array();
         var _loc2_:int = 0;
         while(_loc2_ < this.numOfCategories)
         {
            _loc3_ = new BMShopCategoryViewData();
            _loc3_.name = this.categoryNames[_loc2_];
            _loc3_.id = _loc2_;
            _loc1_.push(_loc3_);
            _loc2_++;
         }
         if(!tutorialM.isTutorialActive())
         {
            BMShopCategoryViewData(_loc1_[this.category_unclaimed]).counter = this.getFreePackagesAmount();
         }
         this.shopView.setTabs(_loc1_);
         this.shopView.tabsEnabled = !tutorialM.isTutorialActive();
      }
      
      private function refreshShopCounters() : void
      {
         this.shopView.setTabCounter(this.category_unclaimed,this.getFreePackagesAmount());
         this.shopView.setTabCounter(this.category_itemBoxes,this.getTimedItemBoxesAmount());
      }
      
      public function getFreePackagesAmount(param1:Boolean = false, param2:Boolean = false) : *
      {
         var _loc6_:Boolean = false;
         var _loc3_:BMPlayerProfile = dataM.myProfile;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_.freePackages.length)
         {
            _loc6_ = this.isGachaMachineClanReward(int(_loc3_.freePackages[_loc5_]));
            if(_loc6_ == param2)
            {
               _loc4_++;
            }
            _loc5_++;
         }
         if(param1)
         {
            _loc4_ += this.getTimedItemBoxesAmount();
         }
         if(param2 == false)
         {
            _loc4_ += dataM.boxFragmentsManager.getNumberOfBoxesReadyToBeClaimed();
         }
         return _loc4_;
      }
      
      public function getTimedItemBoxesAmount() : uint
      {
         if(dataM.getGeneralSetting("showUnclaimedTimedItemBoxes",0) == 0)
         {
            return 0;
         }
         return dataM.myProfile.freeItemBoxes;
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
         this.refreshShopCounters();
      }
      
      public function isCategoryInTutorialBlock(param1:uint) : Boolean
      {
         if(tutorialM.isTutorialActive() && param1 != this.category_itemBoxes)
         {
            return true;
         }
         return false;
      }
      
      public function resetLastCateogry() : void
      {
         this._currentCategoryID = -1;
      }
      
      public function showTokens(param1:* = null) : void
      {
         var _loc2_:BMTokenPackage = null;
         var _loc4_:uint = 0;
         var _loc5_:String = null;
         var _loc6_:Boolean = false;
         var _loc7_:uint = 0;
         var _loc8_:Boolean = false;
         var _loc9_:BMShopItemViewData = null;
         var _loc10_:int = 0;
         var _loc11_:BMStarterPackData = null;
         var _loc12_:String = null;
         var _loc13_:Array = null;
         var _loc14_:String = null;
         if(FeatureFlags.BLOCK_SHOP)
         {
            screensM.screenConfirmation.displayQuestionOrNotification("featureNotAvailable");
            return;
         }
         this.shopView.setTitle(getScreenText("tokensCAP"));
         if(!dataM.arePlatformStoreProductsAvailable)
         {
            this._currentCategoryID = this.category_tokens;
            _loc5_ = getSpecificText("buyTokens_noPackagesAvailable");
            _loc5_ = getSpecificText("buyTokens_noPackagesAvailable_android");
            _loc5_ = dataM.replaceStringInText(_loc5_,"%COLOR%","<FONT COLOR=\'#" + ItemRarityResolver.COLOR_LEGENDARY_ITEM + "\'>");
            _loc5_ = dataM.replaceStringInText(_loc5_,"%COLOREND%","</FONT>");
            this.shopView.setError(_loc5_);
            return;
         }
         var _loc3_:Array = new Array();
         _loc4_ = 0;
         while(_loc4_ < dataM.allTokenPackages.length)
         {
            _loc2_ = dataM.allTokenPackages[_loc4_];
            if(this.isTokenPackageVIPSubscription(_loc2_))
            {
               if(dataM.vipAccountData.isVIPAccountActive)
               {
                  _loc2_.sortID = 999999;
               }
               else
               {
                  _loc2_.sortID = 0;
               }
            }
            _loc4_++;
         }
         dataM.allTokenPackages.sortOn("sortID",Array.NUMERIC);
         _loc4_ = 0;
         for(; _loc4_ < dataM.allTokenPackages.length; _loc4_++)
         {
            _loc2_ = dataM.allTokenPackages[_loc4_];
            _loc6_ = this.isTokenPackageVIPSubscription(_loc2_);
            _loc8_ = false;
            if(_loc6_)
            {
               _loc11_ = dataM.starterPackData[_loc2_.starterPackID];
               _loc7_ = _loc11_.vipDays;
               if(dataM.vipAccountData.isVIPAccountActive)
               {
                  _loc8_ = true;
               }
            }
            else if(_loc2_.starterPackID != 0)
            {
               continue;
            }
            if(_loc2_.visualID != FREE_ITEM_BOX_ID)
            {
               _loc9_ = new BMShopItemViewData();
               _loc9_.isDisabled = _loc8_;
               if(_loc6_)
               {
                  _loc9_.titleTop = getSpecificText("vipSubscription_title");
                  _loc12_ = dataM.vipAccountData.dailyTokensForVIPAccount + " x " + _loc7_ + " " + getSpecificText("rankingList_days");
                  _loc9_.bodyText = _loc12_;
                  _loc9_.bodyTextSize = 27;
                  if(this._vipTokenPackages.indexOf(_loc2_.packageID) == -1)
                  {
                     this._vipTokenPackages.push(_loc2_.packageID);
                  }
               }
               _loc9_.specialBanner = _loc2_.specialBanner;
               if(_loc2_.visualID == REWARDED_VIDEO_ID)
               {
                  if(dataM.isRewardedVideoAvailable(BMScreenWatchRewardedVideo.PLACEMENT_TOKENS_SHOP,false))
                  {
                     _loc9_.timerCompleteText = getSpecificText("buyTokens_watchNow");
                     _loc9_.timerEnd = dataM.currentTime;
                  }
                  else
                  {
                     if(false)
                     {
                        continue;
                     }
                     _loc9_.timerCompleteText = getSpecificText("buyTokens_comeBackLater");
                     _loc9_.timerEnd = dataM.currentTime;
                  }
               }
               else if(_loc2_.visualID == WEB_MORE_OPTIONS)
               {
                  _loc9_.twoRowsText = getSpecificText("buyTokens_moreOptions2");
                  _loc9_.timerEnd = dataM.currentTime;
               }
               else if(BMSalesManager.gi().isSaleActive(dataM.currentTime,BMSale.STORE_SECTION_TOKENS))
               {
                  _loc9_.applaySale(BMSalesManager.gi().getSaleData());
               }
               _loc9_.id = _loc4_;
               _loc9_.price = _loc2_.price;
               _loc9_.imagePath = "general";
               _loc9_.imageName = "globalShop_tokens" + _loc2_.visualID;
               _loc10_ = _loc2_.tokens - _loc2_.bonusFromTokens;
               if(_loc10_ > 0)
               {
                  _loc9_.bodyText = TextUtils.getNumberWithComma(_loc10_);
               }
               if(_loc2_.extraValue != null)
               {
                  _loc13_ = this.getExtraValueDisplayString(_loc2_.extraValue);
                  _loc9_.extraValue_text1 = _loc13_[0];
                  _loc9_.extraValue_text2 = _loc13_[1];
               }
               else if(_loc2_.bonusFromTokens > 0)
               {
                  _loc14_ = getSpecificText("globalShop_tokensBonus");
                  _loc14_ = dataM.replaceStringInText(_loc14_,"%BONUS%",TextUtils.getNumberWithComma(_loc2_.bonusFromTokens));
                  _loc9_.bonusText = _loc14_;
               }
               else
               {
                  _loc9_.bonusText = "";
               }
               _loc9_.currency = BMShopItemViewData.CURRENCY_TYPE_MONEY;
               _loc3_.push(_loc9_);
            }
         }
         this.shopView.setItems(_loc3_,this._currentCategoryID != this.category_tokens);
         this.shopView.onSelect = this.onTokensSelect;
         this._currentCategoryID = this.category_tokens;
         this.shopView.selectCategoryTab(this._currentCategoryID);
         this._screenSource = null;
      }
      
      private function isTokenPackageVIPSubscription(param1:BMTokenPackage) : Boolean
      {
         if(param1.starterPackID == 0)
         {
            return false;
         }
         var _loc2_:BMStarterPackData = dataM.starterPackData[param1.starterPackID];
         if(_loc2_ == null)
         {
            return false;
         }
         if(_loc2_.vipDays == 0)
         {
            return false;
         }
         return true;
      }
      
      private function trackItemEvent(param1:String, param2:String, param3:Number, param4:Boolean) : *
      {
         var _loc5_:int = 5;
         if(param1 == "Buy")
         {
            _loc5_ = 2;
         }
         if(param4)
         {
            _loc5_ = BMDataManager.ANALYTICS_PRIORITY_HIGHEST;
         }
         dataM.trackEvent(_loc5_,"Shop" + param1,this.categoryTrackEventNames[this._currentCategoryID],param2,param3);
      }
      
      private function vipBuyClicked() : void
      {
         this.onTokensSelectSub(this._vipTokenPackages[this._vipTokenPackagesLastSelectedSlot]);
      }
      
      private function onTokensSelect(param1:BMShopItemViewData) : void
      {
         TsLogger.log("BMScreenGlobalShop :: onTokenSelect " + param1.id);
         var _loc2_:BMTokenPackage = dataM.allTokenPackages[param1.id];
         this.trackItemEvent("Select",_loc2_.tokenSystemPackageID + " " + _loc2_.title,_loc2_.packageID,true);
         if(this.tryToShowVIPOffer(_loc2_,param1.price))
         {
            return;
         }
         this.onTokensSelectSub(_loc2_.packageID);
      }
      
      private function tryToShowVIPOffer(param1:BMTokenPackage, param2:String) : Boolean
      {
         if(this._vipTokenPackages.indexOf(param1.packageID) == -1)
         {
            return false;
         }
         this._vipTokenPackagesLastSelectedSlot = this._vipTokenPackages.indexOf(param1.packageID);
         screensM.addScreen(BMScreensManager.SCR_YES_NO_POPUP,true,BMScreenVIPSubscriptionOffer);
         var _loc3_:String = getSpecificText("vipSubscription_title");
         var _loc4_:BMStarterPackData = dataM.starterPackData[param1.starterPackID];
         var _loc5_:String = "FFCC00";
         var _loc6_:String = getSpecificText("vipSubscription_desc1");
         _loc6_ = dataM.replaceStringInText(_loc6_,"%TOKENS%","<FONT COLOR=\'#" + _loc5_ + "\'>" + dataM.vipAccountData.dailyTokensForVIPAccount + "</FONT>");
         _loc6_ = dataM.replaceStringInText(_loc6_,"%COLOR%","<FONT COLOR=\'#" + _loc5_ + "\'>");
         _loc6_ = dataM.replaceStringInText(_loc6_,"%COLOREND%","</FONT>");
         var _loc7_:String = getSpecificText("vipSubscription_desc2");
         var _loc8_:String = String(dataM.vipAccountData.dailyTokensForVIPAccount * _loc4_.vipDays);
         var _loc9_:String = getSpecificText("arenaShop_max");
         screensM.screenYesNoPopup.displayYesNoPopup(_loc3_,_loc6_,_loc7_,this.vipBuyClicked,null,param2);
         screensM.screenYesNoPopup.setDesc3Text(_loc8_);
         screensM.screenYesNoPopup.setDesc4Text(_loc9_);
         return true;
      }
      
      private function onTokensSelectSub(param1:uint) : void
      {
         var _loc2_:BMTokenPackage = dataM.getTokenPackageByID(param1);
         this._lastSelectedTokenPackageID = param1;
         if(_loc2_.tokenSystemPackageID == String(REWARDED_VIDEO_ID))
         {
            if(dataM.isRewardedVideoAvailable(BMScreenWatchRewardedVideo.PLACEMENT_TOKENS_SHOP,false))
            {
               screensM.addScreen(BMScreensManager.SCR_WATCH_REWARDED_VIDEO);
               screensM.screenWatchRewardedVideo.refreshScreen(screensM.screenWatchRewardedVideo.TYPE_TOKENS_SHOP);
            }
            else
            {
               screensM.screenConfirmation.displayQuestionOrNotification("rewardVideosComeBackLater");
            }
         }
         else if(_loc2_.tokenSystemPackageID == String(WEB_MORE_OPTIONS))
         {
            screensM.addScreen(BMScreensManager.SCR_MORE_PAYMENT_OPTIONS);
            screensM.screenMorePaymentOptions.refreshScreen();
         }
         else if(dataM.runAsMobile == false)
         {
            dataM.trackEvent(BMDataManager.ANALYTICS_PRIORITY_HIGHEST,"MonetizationFunnel","RealMoneyPackageSelection",_loc2_.title);
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
            dataM.trackEvent(BMDataManager.ANALYTICS_PRIORITY_HIGHEST,"MonetizationFunnel","RealMoneyPackageSelection",_loc2_.title);
            this.triggerMobilePurchase(String(_loc2_.tokenSystemPackageID));
         }
      }
      
      public function startKongPurchase(param1:String) : void
      {
      }
      
      public function callPleaseWait(param1:Event) : void
      {
         screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait",-1,-1);
      }
      
      private function showBuyTokensFailedDialog() : void
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_CONFIRMATION))
         {
            screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
         }
         screensM.addScreen(BMScreensManager.SCR_YES_NO_POPUP,true,BMScreenYesNoPopup6);
         var _loc1_:String = languageM.getText("confirmation_buyTokens_failed");
         var _loc2_:String = "";
         var _loc3_:String = "";
         var _loc4_:String = getGeneralText("OK");
         var _loc5_:String = languageM.getText("options_support");
         screensM.screenYesNoPopup.displayYesNoPopup(_loc1_,_loc2_,_loc3_,null,this.showSupport,_loc4_,_loc5_);
      }
      
      private function showSupport() : void
      {
         dataM.openSupportForm("Purchase Support");
      }
      
      public function triggerKongPurchase(param1:String) : void
      {
      }
      
      public function triggerMobilePurchase(param1:String) : Boolean
      {
         TsLogger.log("BMScreenGlobalShop :: triggerPurchase() " + param1);
         return this.doAndroidPurchase(param1);
      }
      
      private function triggerPurchase(param1:String) : Boolean
      {
         TsLogger.log("BMScreenGlobalShop :: triggerPurchase()");
         return this.doAndroidPurchase(param1);
      }
      
      public function processPendingPurchases() : void
      {
         TsLogger.log("BMScreenGlobalShop :: processPendingPurchases");
         if(!BMAndroidStoreKitManager.gi().hasPendingPurchases)
         {
            return;
         }
         BMLoadingTimer.gi().showLoading("Processing purchases please wait",false);
         BMAndroidStoreKitManager.gi().addEventListener(AndroidStoreEvent.PURCHASE_SUCCEEDED,this.onPurchaseSucceeded);
         BMAndroidStoreKitManager.gi().addEventListener(AndroidStoreEvent.PURCHASE_FAILED,this.onPurchaseFailed);
         BMAndroidStoreKitManager.gi().addEventListener(AndroidStoreEvent.PURCHASE_CANCELLED,this.onPurchaseCanceled);
         BMAndroidStoreKitManager.gi().addEventListener(AndroidStoreEvent.PURCHASE_CANNOTCOMPLETE,this.onPurchaseCanNotComplete);
         BMAndroidStoreKitManager.gi().processNextPendingPurchase();
      }
      
      private function isBoxHardCurrencyOrRealMoney(param1:BMShopItemViewData) : Boolean
      {
         if(param1.id == FREE_ITEM_BOX_ID)
         {
            return false;
         }
         if(param1.currency == BMShopItemViewData.CURRENCY_TYPE_TOKENS || param1.currency == BMShopItemViewData.CURRENCY_TYPE_MONEY)
         {
            return true;
         }
         return false;
      }
      
      private function onBoxSelect(param1:BMShopItemViewData) : void
      {
         var _loc2_:uint = this.getShopItemID(param1);
         this.trackItemEvent("Select","Box" + param1.bodyText,_loc2_,this.isBoxHardCurrencyOrRealMoney(param1));
         if(param1.id == FREE_ITEM_BOX_ID)
         {
            this.tryClaimFreeBox();
            return;
         }
         var _loc3_:BMGachaMachineData = dataM.getGacheMachine(_loc2_);
         param1.imagePath = "general";
         var _loc4_:uint = _loc3_.imageID;
         if(_loc3_.isSingleItem)
         {
            _loc4_ = 2;
         }
         var _loc5_:String = "globalShop_itemInfo" + this.category_itemBoxes + "_" + _loc4_;
         param1.imageName = _loc5_;
         param1.bonusText = languageM.getGachaMachineName(_loc3_.description);
         param1.category = this.category_itemBoxes;
         var _loc6_:Class = BMScreenShopItemInfo;
         if(this.offerBuyingMultipleBoxes(param1.id))
         {
            _loc6_ = BMScreenShopItemInfoTwoOptions;
         }
         else if(_loc3_.isInChainDiscount)
         {
            _loc6_ = BMScreenShopItemInfoWithChainDiscount;
         }
         else if(_loc3_.extraChanceItemIDs.length > 0)
         {
            _loc6_ = BMScreenShopItemInfoWithExtraChance;
         }
         this.showShopItemInfoScreen(param1,_loc6_,this.tryToBuyGachaMachine);
      }
      
      private function showShopItemInfoScreen(param1:BMShopItemViewData, param2:Class, param3:Function) : void
      {
         if(this._currentCategoryID == this.category_clanShop || this._currentCategoryID == this.category_kinShop)
         {
            param3 = this.tryToBuyClanShopItem;
         }
         screensM.addScreen(BMScreensManager.SCR_SHOP_ITEM_INFO,true,param2);
         screensM.screenShopItemInfo.refreshScreen(param1,param3);
      }
      
      public function offerBuyingMultipleBoxes(param1:Number) : Boolean
      {
         if(tutorialM.isTutorialActive() == true)
         {
            return false;
         }
         var _loc2_:int = dataM.getGeneralSetting("minPlayerLevelForMultipleBoxes",30);
         var _loc3_:int = dataM.myProfile.level;
         if(_loc3_ < _loc2_)
         {
            return false;
         }
         if(this._currentCategoryID != this.category_itemBoxes)
         {
            return false;
         }
         if(param1 != REGULAR_GACHA_MACHINE_ID)
         {
            return false;
         }
         if(this.doesRegularGachaMachinePriceIncrease())
         {
            return false;
         }
         return true;
      }
      
      public function multipleBoxesAmount() : uint
      {
         return 5;
      }
      
      public function tryToBuyBox(param1:BMShopItemViewData) : void
      {
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:int = 0;
         TsLogger.log("BMScreenGlobalShop :: onBoxSelect() " + param1.id);
         this.trackItemEvent("Buy","Box" + param1.bodyText,param1.id,this.isBoxHardCurrencyOrRealMoney(param1));
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
            if(_loc6_)
            {
               screensM.screenConfirmation.displayQuestionOrNotification("notEnoughTokens",_loc3_,-1);
            }
            else
            {
               this.showGoldPackages();
            }
         }
         else if(_loc5_)
         {
            remoteM.tokens_buyPackageNew(_loc3_);
            if(dataM.gameType == BMDataManager.GAME_TYPE_DEFAULT)
            {
               screensM.screenConfirmation.displayQuestionOrNotification("buyingPackage",-1,-1);
            }
            if(dataM.packages_markItemBoxFromTutorial && _loc3_ == TUTORIAL_ITEM_BOX_PACKAGE_ID)
            {
               dataM.packages_markPremiumFromTutorial = false;
            }
         }
         else if(dataM.gameType == BMDataManager.GAME_TYPE_DEFAULT)
         {
            _loc9_ = 0;
            _loc10_ = 0;
            if(_loc4_.type == "specificItem")
            {
               _loc9_ = _loc4_.itemID;
               _loc10_ = _loc4_.costTokens;
            }
            remoteM.tokens_buyPackageNew(_loc4_.boostID,_loc9_,_loc10_);
            if(this._sourceNotificationID != BMNotificationsManager.NO_NOTIFICATION_ID)
            {
               BMNotificationsManager.getInstance().trackNotificationEvent("BoughtAdditionalBox",this._sourceNotificationID,_loc4_.boostID);
            }
            _loc11_ = _loc4_.costTokens > 0 ? BMDataManager.ANALYTICS_PRIORITY_HIGHEST : 2;
            dataM.trackEvent(_loc11_,"Economy","BuyBox",this._screenSource,_loc4_.boostID);
            screensM.screenConfirmation.displayQuestionOrNotification("buyingPackage");
         }
         else
         {
            this.buyGachaMachineLocally(_loc3_);
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
            return this.category_itemBoxes;
         }
         return CAT_NONE;
      }
      
      private function getItemBoxShopItemViewData(param1:BMGachaMachineData) : BMShopItemViewData
      {
         if(!param1.isInShop)
         {
            return null;
         }
         var _loc2_:Boolean = false;
         if(tutorialM.isTutorialActive())
         {
            if(param1.gachaMachineID != REGULAR_GACHA_MACHINE_ID)
            {
               _loc2_ = true;
            }
         }
         var _loc3_:String = languageM.getGachaMachineName(param1.name);
         var _loc4_:Boolean = param1.isInSale;
         if(this._currentCategoryID == this.category_clanShop || this._currentCategoryID == this.category_kinShop)
         {
            _loc4_ = false;
         }
         var _loc5_:BMShopItemViewData = this.convertGachaMachineData(param1.gachaMachineID,_loc3_,param1.description,param1.costGold,param1.costTokens,param1.costTokensDefault,param1.imageID,param1.extraChanceItemIDs,_loc2_,_loc4_,param1.isInChainDiscount);
         if(this._currentCategoryID == this.category_clanShop || this._currentCategoryID == this.category_kinShop)
         {
            _loc5_.defaultPrice = "0";
         }
         return _loc5_;
      }
      
      public function showItemBoxes(param1:String, param2:uint = 0) : *
      {
         var _loc5_:BMGachaMachineData = null;
         var _loc6_:BMShopItemViewData = null;
         this.shopView.setTitle(getScreenText("itemBoxesCAP"));
         var _loc3_:Array = new Array();
         var _loc4_:uint = 0;
         while(_loc4_ < dataM.gachaMachinesArray.length)
         {
            _loc5_ = dataM.gachaMachinesArray[_loc4_];
            _loc6_ = this.getItemBoxShopItemViewData(_loc5_);
            if(_loc6_ != null)
            {
               _loc3_.push(_loc6_);
            }
            _loc4_++;
         }
         if(dataM.gameType == BMDataManager.GAME_TYPE_DEFAULT)
         {
            _loc3_.push(this.createTimedBox());
         }
         _loc3_.sort(this.orderItemBoxes);
         this.shopView.setItems(_loc3_,this._currentCategoryID != this.category_itemBoxes,param2);
         this.shopView.onSelect = this.onBoxSelect;
         this._currentCategoryID = this.category_itemBoxes;
         this.shopView.selectCategoryTab(this._currentCategoryID);
         this._screenSource = param1;
         this.refreshShopCounters();
         this.addItemsExtraChanceResetTimer();
         this.addChainDiscountResetTimer();
         this.addSaleResetTimer();
      }
      
      private function getShopItemDataOrderScore(param1:BMShopItemViewData) : uint
      {
         if(param1.id == FREE_ITEM_BOX_ID)
         {
            return 100000;
         }
         if(param1.id == TRANSFORM_TO_MYTHICAL_PACK_MACHINE_ID)
         {
            if(dataM.myPlayerData.hasItemOfSpecificRarity(ItemRarityResolver.RARITY_LEGENDARY) == false)
            {
               return 0;
            }
         }
         if(param1.currency == BMShopItemViewData.CURRENCY_TYPE_GOLD)
         {
            return 300000 + (100000 - int(param1.price));
         }
         return 200000 + (100000 - int(param1.price));
      }
      
      private function orderItemBoxes(param1:BMShopItemViewData, param2:BMShopItemViewData) : int
      {
         var _loc3_:uint = this.getShopItemDataOrderScore(param1);
         var _loc4_:uint = this.getShopItemDataOrderScore(param2);
         if(_loc3_ > _loc4_)
         {
            return -1;
         }
         if(_loc3_ < _loc4_)
         {
            return 1;
         }
         return 0;
      }
      
      private function convertGachaMachineData(param1:uint, param2:String, param3:String, param4:uint, param5:uint, param6:uint, param7:uint, param8:Array, param9:Boolean = false, param10:Boolean = false, param11:Boolean = false, param12:uint = 0) : BMShopItemViewData
      {
         var _loc16_:BMSale = null;
         var _loc17_:uint = 0;
         var _loc18_:uint = 0;
         var _loc13_:BMShopItemViewData = new BMShopItemViewData();
         var _loc14_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         _loc13_.id = param1;
         _loc13_.titleBottom = param2;
         if(param5 == 0)
         {
            _loc13_.currency = BMShopItemViewData.CURRENCY_TYPE_GOLD;
            _loc13_.price = TextUtils.getNumberWithComma(param4);
            if(tutorialM.isTutorialActive() == false && param1 == REGULAR_GACHA_MACHINE_ID && this.doesRegularGachaMachinePriceIncrease())
            {
               _loc13_.extraDescription = getScreenText("boxPriceResetTimerPrefix") + "\n";
               _loc13_.timerType = BMShopItemViewData.TIMER_TYPE_EXTRA_DESCRIPTION;
               _loc13_.timerEnd = dataM.questsManager.dailyQuestsNextResetTime;
            }
            else
            {
               _loc13_.extraDescription = "";
               _loc13_.timerEnd = 0;
            }
         }
         else
         {
            _loc13_.applayCostTokens(param5,param6);
            if(param10)
            {
               _loc16_ = BMSalesManager.gi().getSaleData();
               _loc13_.applaySale(_loc16_);
            }
            else if(param11)
            {
               _loc17_ = dataM.chainDiscountsResolver.getCurrentDiscount(param1);
               _loc18_ = dataM.chainDiscountsResolver.getActiveChainDiscountEndDate(param1);
               _loc13_.applyChainDiscount(_loc17_,_loc18_);
            }
         }
         _loc13_.isDisabled = param9;
         _loc13_.imagePath = "general";
         var _loc15_:String = "globalShop_gachaMachine" + param7;
         if(param8 == null)
         {
            param8 = new Array();
         }
         if(param8.length > 0)
         {
            _loc15_ += "B";
         }
         _loc13_.imageName = _loc15_;
         if(tutorialM.isTutorialActive())
         {
            param8 = new Array();
         }
         _loc13_.extraChanceItemIDs = param8;
         if(_loc13_.extraChanceItemIDs.length > 0 && dataM.itemsExtraChanceData.isAvailable)
         {
            _loc13_.timerType = BMShopItemViewData.TIMER_TYPE_EXTRA_ITEMS;
            _loc13_.timerEnd = dataM.itemsExtraChanceData.endDate;
         }
         _loc13_.itemID = param12;
         return _loc13_;
      }
      
      private function doesRegularGachaMachinePriceIncrease() : Boolean
      {
         return !dataM.getGeneralSetting("hideRegularBoxPriceResets",false);
      }
      
      public function setNextTimedBoxToBeFortuneBox() : void
      {
         this._nextTimedBoxIsFortuneBox = true;
      }
      
      public function unsetNextTimedBoxToBeFortuneBox() : void
      {
         this._nextTimedBoxIsFortuneBox = false;
      }
      
      public function isTimedBoxFortuneBox() : Boolean
      {
         if(this._nextTimedBoxIsFortuneBox)
         {
            return true;
         }
         return dataM.getGeneralSetting("showFreeBoxAsFortuneBox",0) == 1;
      }
      
      private function createTimedBox() : BMShopItemViewData
      {
         var _loc6_:Boolean = false;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:String = null;
         var _loc10_:Array = null;
         var _loc11_:String = null;
         var _loc12_:int = 0;
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc2_:Boolean = this.isTimedBoxFortuneBox();
         var _loc3_:BMShopItemViewData = new BMShopItemViewData();
         _loc3_.id = FREE_ITEM_BOX_ID;
         if(_loc2_)
         {
            _loc3_.titleBottom = getSpecificText("buyTokens_freeFortuneBox");
         }
         else
         {
            _loc3_.titleBottom = getSpecificText("buyTokens_freeItemBox");
         }
         _loc3_.timerCompleteText = getSpecificText("buyTokens_claim");
         if(_loc1_.gotFreeItemBox + dataM.secondsForFreeItemBox < dataM.currentTime && _loc1_.freeItemBoxes < 2)
         {
            ++_loc1_.freeItemBoxes;
            _loc1_.gotFreeItemBox += dataM.secondsForFreeItemBox;
         }
         var _loc4_:int = dataM.playerSkillsManager.getSkillIDByType(BMPlayerSkillData.TYPE_FORTUNE_BOX);
         if(_loc4_ > -1)
         {
            _loc6_ = dataM.playerSkillsManager.getSkillLevel(dataM.player1PlayerID,_loc4_) > 0;
            if(_loc6_)
            {
               _loc7_ = dataM.playerSkillsManager.getSkillCurrentLevelBonus(dataM.player1PlayerID,_loc4_);
               if(_loc7_ > 0)
               {
                  _loc8_ = _loc7_ - dataM.myProfile.fortuneBoxFreeBoxCount;
                  if(_loc8_ == 0)
                  {
                     _loc2_ = true;
                     _loc3_.titleBottom = getSpecificText("buyTokens_freeFortuneBox");
                  }
                  else
                  {
                     _loc9_ = getSpecificText("arenaShop_fortuneBox_xMore");
                     _loc9_ = dataM.replaceStringInText(_loc9_,"%AMOUNT%","##");
                     _loc10_ = TextUtils.splitStringToTwoLines(_loc9_);
                     _loc11_ = "<FONT COLOR=\'#" + ItemRarityResolver.COLOR_LEGENDARY_ITEM + "\'>" + _loc8_ + "</FONT>";
                     _loc10_[0] = dataM.replaceStringInText(_loc10_[0],"##",_loc11_);
                     _loc10_[1] = dataM.replaceStringInText(_loc10_[1],"##",_loc11_);
                     _loc3_.extraDescription = _loc10_[0] + "<BR>" + _loc10_[1];
                  }
               }
            }
         }
         var _loc5_:String = "globalShop_itemBoxTimed";
         if(_loc2_)
         {
            _loc5_ = "globalShop_fortuneBoxTimed";
         }
         if(_loc1_.freeItemBoxes > 0)
         {
            _loc3_.timerEnd = dataM.currentTime;
         }
         else
         {
            _loc3_.timerEnd = _loc1_.gotFreeItemBox + dataM.secondsForFreeItemBox;
            _loc12_ = _loc1_.freeItemBoxes + 1;
            _loc12_ = _loc12_ > 2 ? 2 : _loc12_;
            _loc3_.timerCompleteImageName = _loc5_ + _loc12_;
         }
         _loc3_.imagePath = "general";
         _loc3_.imageName = _loc5_ + _loc1_.freeItemBoxes;
         if(_loc2_ == false)
         {
            _loc3_.counter = _loc1_.freeItemBoxes;
         }
         return _loc3_;
      }
      
      private function tryToBuyClanShopItem(param1:BMShopItemViewData, param2:uint) : void
      {
         var _loc3_:int = param1.id;
         this.trackItemEvent("Buy","ClanShopItem" + _loc3_,param1.id,false);
         screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
         this._pendingClanShopItemPurchase = _loc3_;
         if(this._currentCategoryID == this.category_kinShop)
         {
            dataM.kinM.buyUsingKin(_loc3_,int(param1.price),this.buyKinItemSuccess,this.buyKinItemFail);
         }
         else
         {
            remoteM.socketM.clan_buyClanShopItem(_loc3_);
         }
      }
      
      private function buyKinItemSuccess() : void
      {
         remoteM.socketM.kin_buyShopItem(this._pendingClanShopItemPurchase,dataM.kinM.lastTransactionID);
      }
      
      private function buyKinItemFail() : void
      {
         screensM.screenConfirmation.displayQuestionOrNotification("buyTokens_failed");
      }
      
      public function notifyClanShopItemPurchaseSuccess(param1:Object) : *
      {
         var _loc4_:BMRewardData = null;
         var _loc5_:int = 0;
         screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
         var _loc2_:BMClanShopData = this.getClanShopData(this._pendingClanShopItemPurchase);
         var _loc3_:int = int(_loc2_.price);
         dataM.myProfile.clanCoins -= _loc3_;
         dataM.gameOfWhalesM.boughtClanShopItem(_loc3_,_loc2_,this._lastSelectedPremiumDurationHours);
         if(this._currentCategoryID == this.category_kinShop)
         {
            dataM.kinM.kinShopItemBought(this._pendingClanShopItemPurchase);
            screensM.screenKinShop.refreshKin();
         }
         else
         {
            screensM.screenClanShop.refreshClanCoins();
         }
         if(param1.reward != null)
         {
            _loc4_ = new BMRewardData(param1.reward);
            _loc5_ = 0;
            if(_loc2_.itemType == BMClanShopData.TYPE_ITEM_BOX)
            {
               _loc5_ = int(_loc2_.itemID);
            }
            dataM.giveRewardPopup(_loc4_,"",false,-1,_loc5_);
         }
         if(param1.dPremium != null)
         {
            this.premiumBought(param1.dPremium,0);
         }
         if(_loc2_.itemType == BMClanShopData.TYPE_MECH)
         {
            this._lastShopMechID = _loc2_.itemID;
            this.mechBought();
         }
         if(this._currentCategoryID == this.category_kinShop)
         {
            this.showClanShop("",true);
         }
      }
      
      public function tryToBuyGachaMachineWhenShopIsClosed(param1:uint, param2:uint) : void
      {
         var _loc3_:BMGachaMachineData = dataM.gachaMachinesDB[param1];
         var _loc4_:BMShopItemViewData = this.convertGachaMachineData(param1,"","",0,_loc3_.costTokens,_loc3_.costTokensDefault,0,new Array());
         var _loc5_:Number = int(dataM.myProfile.starterPackData.price);
         this.tryToBuyGachaMachine(_loc4_,param2,_loc5_);
      }
      
      public function tryToBuyGachaMachine(param1:BMShopItemViewData, param2:uint, param3:uint = 0) : void
      {
         var _loc6_:uint = 0;
         var _loc4_:* = param1.id;
         var _loc5_:BMGachaMachineData = this.getGachaMachine(_loc4_);
         this.trackItemEvent("Buy",_loc5_.name,_loc5_.gachaMachineID,this.isBoxHardCurrencyOrRealMoney(param1));
         if(dataM.gameType == BMDataManager.GAME_TYPE_DEFAULT)
         {
            screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
            _loc6_ = _loc5_.costTokens;
            if(param3 > 0)
            {
               _loc6_ = param3;
            }
            remoteM.socketM.lobby_buyGachaMachine(_loc4_,param2,_loc6_);
         }
         else
         {
            this.buyGachaMachineLocally(_loc4_);
         }
      }
      
      public function tryToClaimFreeBoost(param1:int) : void
      {
         screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
         remoteM.socketM.lobby_claimFreeBoost(param1);
      }
      
      public function tryToClaimFragmentBox(param1:int) : void
      {
         screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
         remoteM.socketM.lobby_claimFragmentBox(param1);
      }
      
      public function getNextClanRewardPackageID() : int
      {
         var _loc3_:int = 0;
         var _loc4_:Boolean = false;
         var _loc1_:BMPlayerProfile = dataM.myProfile;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.freePackages.length)
         {
            _loc3_ = int(_loc1_.freePackages[_loc2_]);
            _loc4_ = this.isGachaMachineClanReward(_loc3_);
            if(_loc4_)
            {
               return _loc3_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      private function addSaleResetTimer() : void
      {
         if(BMSalesManager.gi().isSaleActive(dataM.currentTime) == false)
         {
            return;
         }
         this.removeSaleResetTimer();
         this._saleResetTimer = new Timer(BMSalesManager.gi().saleTimeLeft(dataM.currentTime) * 1000);
         this._saleResetTimer.addEventListener(TimerEvent.TIMER,this.onSaleResetTimerTrigger);
         this._saleResetTimer.start();
      }
      
      private function onSaleResetTimerTrigger(param1:TimerEvent) : void
      {
         this.removeSaleResetTimer();
         screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
         TweenMax.delayedCall(4,remoteM.socketM.lobby_getGachaMachines);
      }
      
      private function removeSaleResetTimer() : void
      {
         if(this._saleResetTimer == null)
         {
            return;
         }
         this._saleResetTimer.removeEventListener(TimerEvent.TIMER,this.onSaleResetTimerTrigger);
         this._saleResetTimer.stop();
         this._saleResetTimer = null;
      }
      
      private function addChainDiscountResetTimer() : void
      {
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc1_:Array = dataM.chainDiscountsResolver.getActiveChainDiscountGachaMachineIDs();
         if(_loc1_.length == 0)
         {
            return;
         }
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc4_ = uint(_loc1_[_loc3_]);
            _loc5_ = dataM.chainDiscountsResolver.getActiveChainDiscountEndDate(_loc4_);
            if(_loc5_ > dataM.currentTime)
            {
               if(_loc2_ == 0)
               {
                  _loc2_ = _loc5_;
               }
               else if(_loc5_ > dataM.currentTime && _loc2_ > _loc5_)
               {
                  _loc2_ = _loc5_;
               }
            }
            _loc3_++;
         }
         if(_loc2_ > dataM.currentTime)
         {
            this.removeChainDiscountTimer();
            this._chainDiscountResetTimer = new Timer((_loc2_ - dataM.currentTime) * 1000);
            this._chainDiscountResetTimer.addEventListener(TimerEvent.TIMER,this.chainDiscountTimerTrigger);
            this._chainDiscountResetTimer.start();
         }
      }
      
      private function chainDiscountTimerTrigger(param1:TimerEvent) : void
      {
         this.removeChainDiscountTimer();
         if(screensM.isScreenOpened(BMScreensManager.SCR_GLOBAL_SHOP) || screensM.isScreenOpened(BMScreensManager.SCR_MAIN_MENU))
         {
            screensM.screenConfirmation.displayQuestionOrNotification("chainDiscountEnded");
         }
         else
         {
            this.chainDiscountEndedConfirmationClosed(4);
         }
      }
      
      public function chainDiscountEndedConfirmationClosed(param1:uint = 1) : void
      {
         this.refreshGachaMachines(param1);
      }
      
      private function refreshGachaMachines(param1:uint = 1) : void
      {
         TweenMax.delayedCall(param1,remoteM.socketM.lobby_getGachaMachines);
      }
      
      public function refreshItemBoxes() : void
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_GLOBAL_SHOP) == false)
         {
            return;
         }
         if(this._currentCategoryID != this.category_itemBoxes)
         {
            return;
         }
         this.showItemBoxes(this._screenSource);
      }
      
      private function removeChainDiscountTimer() : void
      {
         if(this._chainDiscountResetTimer == null)
         {
            return;
         }
         this._chainDiscountResetTimer.removeEventListener(TimerEvent.TIMER,this.chainDiscountTimerTrigger);
         this._chainDiscountResetTimer.stop();
         this._chainDiscountResetTimer = null;
      }
      
      private function addItemsExtraChanceResetTimer() : void
      {
         if(dataM.itemsExtraChanceData.isAvailable == false)
         {
            return;
         }
         this.removeItemsExtraChanceResetTimer();
         this._itemsExtraChanceResetTimer = new Timer(dataM.itemsExtraChanceData.timeLeft * 1000);
         this._itemsExtraChanceResetTimer.addEventListener(TimerEvent.TIMER,this.itemsExtraChanceResetTimerTrigger);
         this._itemsExtraChanceResetTimer.start();
      }
      
      private function removeItemsExtraChanceResetTimer() : void
      {
         if(this._itemsExtraChanceResetTimer == null)
         {
            return;
         }
         this._itemsExtraChanceResetTimer.removeEventListener(TimerEvent.TIMER,this.itemsExtraChanceResetTimerTrigger);
         this._itemsExtraChanceResetTimer.stop();
         this._itemsExtraChanceResetTimer = null;
      }
      
      private function itemsExtraChanceResetTimerTrigger(param1:TimerEvent) : void
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_GLOBAL_SHOP) || screensM.isScreenOpened(BMScreensManager.SCR_MAIN_MENU))
         {
            screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
         }
         this.refreshGachaMachines(4);
      }
      
      public function showUnclaimedBoxes(param1:String) : *
      {
         var _loc3_:int = 0;
         var _loc6_:String = null;
         var _loc7_:Array = null;
         var _loc8_:int = 0;
         var _loc9_:BMShopItemViewData = null;
         var _loc10_:int = 0;
         var _loc11_:BMGachaMachineData = null;
         var _loc12_:uint = 0;
         var _loc13_:String = null;
         this.shopView.setTitle(getScreenText("unclaimedBoxesCAP"));
         var _loc2_:Array = new Array();
         var _loc4_:Object = new Object();
         var _loc5_:int = 0;
         while(_loc5_ < dataM.myProfile.freePackages.length)
         {
            _loc3_ = int(dataM.myProfile.freePackages[_loc5_]);
            if(!this.isGachaMachineClanReward(_loc3_))
            {
               if(_loc4_[_loc3_] == null)
               {
                  _loc4_[_loc3_] = 1;
               }
               else
               {
                  ++_loc4_[_loc3_];
               }
            }
            _loc5_++;
         }
         for(_loc6_ in _loc4_)
         {
            _loc3_ = Number(_loc6_);
            _loc10_ = int(_loc4_[_loc6_]);
            if(_loc3_ == UNCLAIMED_ITEM_BOX_ID)
            {
               _loc2_.push(this.convertUnclaimedData(UNCLAIMED_ITEM_BOX_ID,getSpecificText("globalShop_unclaimedBox"),"","globalShop_itemBoxTimed1",_loc10_));
            }
            else
            {
               _loc11_ = this.getGachaMachine(_loc3_);
               _loc12_ = _loc11_.imageID;
               if(_loc11_.isSingleItem)
               {
                  _loc12_ = 2;
               }
               _loc13_ = "globalShop_gachaMachine" + _loc11_.imageID;
               _loc2_.push(this.convertUnclaimedData(_loc11_.gachaMachineID,languageM.getGachaMachineName(_loc11_.name),languageM.getGachaMachineName(_loc11_.description),_loc13_,_loc10_));
            }
         }
         _loc7_ = [];
         for each(_loc8_ in dataM.boxFragmentsManager.getBoxesWithFragments())
         {
            _loc7_.push(this.convertBoxFragmentData(_loc8_));
         }
         _loc7_.sortOn(["isDisabled","id"],Array.NUMERIC);
         for each(_loc9_ in _loc7_)
         {
            _loc2_.push(_loc9_);
         }
         this.shopView.setItems(_loc2_,this._currentCategoryID != this.category_unclaimed);
         this.shopView.onSelect = this.onUnclaimedBoxSelect;
         this._currentCategoryID = this.category_unclaimed;
         this.shopView.selectCategoryTab(this._currentCategoryID);
         this._screenSource = param1;
         if(_loc2_.length == 0)
         {
            this.shopView.setError(getScreenText("noUnclaimedBoxes"));
         }
      }
      
      private function getGachaMachine(param1:int) : BMGachaMachineData
      {
         var _loc2_:int = 0;
         while(_loc2_ < dataM.gachaMachinesArray.length)
         {
            if(dataM.gachaMachinesArray[_loc2_].gachaMachineID == param1)
            {
               return dataM.gachaMachinesArray[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      private function getPremiumPackageData(param1:int) : BMPremiumPackageData
      {
         var _loc2_:int = 0;
         while(_loc2_ < dataM.premiumPackages.length)
         {
            if(dataM.premiumPackages[_loc2_].id == param1)
            {
               return dataM.premiumPackages[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      private function getGoldPackage(param1:int) : BMGoldPackageData
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in dataM.goldPackagesDB)
         {
            if(_loc2_.goldPackageID == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function getMechShopData(param1:uint) : BMMechShopData
      {
         var _loc2_:BMMechShopData = null;
         for each(_loc2_ in dataM.mechShopData)
         {
            if(_loc2_.packageID == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function convertUnclaimedData(param1:uint, param2:String, param3:String, param4:String, param5:int = 0) : BMShopItemViewData
      {
         var _loc6_:BMShopItemViewData = new BMShopItemViewData();
         var _loc7_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         _loc6_.id = param1;
         _loc6_.titleBottom = param2;
         _loc6_.counter = param5;
         _loc6_.price = getSpecificText("buyTokens_claim");
         _loc6_.currency = BMShopItemViewData.CURRENCY_TYPE_FREE;
         _loc6_.imagePath = "general";
         _loc6_.imageName = param4;
         return _loc6_;
      }
      
      private function convertBoxFragmentData(param1:uint) : BMShopItemViewData
      {
         var _loc3_:String = null;
         var _loc12_:BMItemData = null;
         var _loc2_:BMGachaMachineData = dataM.getGacheMachine(param1);
         var _loc4_:uint = _loc2_.imageID;
         var _loc5_:uint = 0;
         if(_loc2_.isSingleItem)
         {
            _loc4_ = 0;
            _loc5_ = _loc2_.itemID;
            _loc12_ = dataM.itemsDB[_loc5_];
            _loc3_ = _loc12_.fullName + " " + getSpecificText("fragments_title");
         }
         else
         {
            _loc3_ = languageM.getGachaMachineName(_loc2_.name) + " " + getSpecificText("fragments_title");
         }
         var _loc6_:int = dataM.boxFragmentsManager.getFragmentsRequiredForBox(param1);
         var _loc7_:int = dataM.boxFragmentsManager.getNumberOfFragmentsOwned(param1);
         var _loc8_:int = dataM.boxFragmentsManager.getNumberOfClaimsAvailableForBox(param1);
         var _loc9_:Boolean = _loc8_ > 0;
         var _loc10_:BMShopItemViewData = this.convertGachaMachineData(_loc2_.gachaMachineID,_loc3_,_loc2_.description,_loc2_.costGold,_loc2_.costTokens,_loc2_.costTokens,_loc2_.imageID,null,!_loc9_,false,false,_loc5_);
         _loc10_.currency = BMShopItemViewData.CURRENCY_TYPE_BOX_FRAGMENTS;
         var _loc11_:* = _loc7_ + " / " + _loc6_;
         _loc10_.price = _loc10_.defaultPrice = _loc11_;
         _loc10_.counter = _loc8_;
         return _loc10_;
      }
      
      private function onUnclaimedBoxSelect(param1:BMShopItemViewData) : void
      {
         this.trackItemEvent("SelectUnclaimed","Box" + param1.bodyText,param1.id,false);
         if(param1.id == MINED_TOKENS_ID)
         {
            screensM.addScreen(BMScreensManager.SCR_CLAIM_MINED_TOKENS);
         }
         else if(dataM.isInventoryFull(true))
         {
            screensM.addScreen(BMScreensManager.SCR_INVENTORY_FULL);
         }
         else if(param1.currency == BMShopItemViewData.CURRENCY_TYPE_BOX_FRAGMENTS)
         {
            this.tryToClaimFragmentBox(param1.id);
         }
         else
         {
            this.tryToClaimFreeBoost(param1.id);
         }
      }
      
      private function getBonusTokensItemViewData(param1:BMClanShopData) : BMShopItemViewData
      {
         var _loc2_:BMShopItemViewData = new BMShopItemViewData();
         _loc2_.imagePath = "general";
         _loc2_.imageName = "globalShop_tokens1";
         _loc2_.bodyText = String(param1.itemID);
         _loc2_.price = String(param1.price);
         return _loc2_;
      }
      
      private function getPremiumPackageItemViewData(param1:BMPremiumPackageData) : BMShopItemViewData
      {
         var _loc5_:uint = 0;
         var _loc2_:BMShopItemViewData = new BMShopItemViewData();
         _loc2_.id = param1.id;
         var _loc3_:String = param1.title;
         switch(param1.title)
         {
            case "PREMIUM_X_DAYS":
               _loc3_ = languageM.getText("premiumAccount_xDays");
               _loc5_ = param1.durationHours / 24;
               _loc3_ = dataM.replaceStringInText(_loc3_,"%DAYS%",String(_loc5_));
               break;
            case "PREMIUM_ONE_DAY":
               _loc3_ = languageM.getText("premiumAccount_oneDay");
               break;
            case "PREMIUM_X_HOURS":
               _loc3_ = languageM.getText("premiumAccount_xHours");
               _loc3_ = dataM.replaceStringInText(_loc3_,"%HOURS%",String(param1.durationHours));
         }
         _loc2_.bodyText = _loc3_;
         _loc2_.specialBanner = param1.specialBanner;
         _loc2_.applayCostTokens(param1.tokens,param1.costTokensDefault);
         _loc2_.imagePath = "general";
         _loc2_.imageName = "globalShop_premiumPackage" + param1.visualID;
         var _loc4_:Boolean = false;
         if(this._currentCategoryID == this.category_clanShop || this._currentCategoryID == this.category_kinShop)
         {
            _loc2_.defaultPrice = "0";
         }
         else if(BMSalesManager.gi().isSaleActive(dataM.currentTime,BMSale.STORE_SECTION_PREMIUM))
         {
            _loc4_ = true;
         }
         if(_loc4_)
         {
            _loc2_.applaySale(BMSalesManager.gi().getSaleData());
         }
         return _loc2_;
      }
      
      public function showPremium(param1:String) : void
      {
         var _loc5_:BMPremiumPackageData = null;
         var _loc2_:Array = new Array();
         var _loc3_:BMShopItemViewData = new BMShopItemViewData();
         _loc3_.viewCls = BMShopPremiumInfoCard;
         _loc2_.push(_loc3_);
         var _loc4_:int = 0;
         while(_loc4_ < dataM.premiumPackages.length)
         {
            _loc5_ = dataM.premiumPackages[_loc4_];
            _loc2_.push(this.getPremiumPackageItemViewData(_loc5_));
            _loc4_++;
         }
         this.shopView.setItems(_loc2_,this._currentCategoryID != this.category_premium);
         this.shopView.onSelect = this.onPremiumSelect;
         this._currentCategoryID = this.category_premium;
         this.shopView.selectCategoryTab(this._currentCategoryID);
         this._screenSource = param1;
      }
      
      private function onPremiumSelect(param1:BMShopItemViewData) : void
      {
         if(param1.viewCls != null)
         {
            return;
         }
         var _loc2_:uint = this.getShopItemID(param1);
         this.trackItemEvent("Select","Premium" + param1.bodyText,_loc2_,this.isBoxHardCurrencyOrRealMoney(param1));
         param1.putImageInSizer = true;
         param1.bonusText = getScreenText("premiumAccountInfo");
         param1.titleBottom = getScreenText("premiumAccount");
         param1.imageName = "globalShop_itemInfo5_" + dataM.getPremiumPackage(_loc2_).visualID;
         param1.category = this.category_premium;
         this.showShopItemInfoScreen(param1,BMScreenShopItemInfoPremium,this.buyPremium);
         this._lastSelectedPremiumDurationHours = dataM.getPremiumPackage(_loc2_).durationHours;
      }
      
      private function buyPremium(param1:BMShopItemViewData, param2:uint) : void
      {
         this.trackItemEvent("Buy","Premium" + param1.bodyText,param1.id,this.isBoxHardCurrencyOrRealMoney(param1));
         var _loc3_:Boolean = screensM.isScreenOpened(BMScreensManager.SCR_BATTLE_RESULT);
         remoteM.socketM.buyPremiumPackage(param1.id,_loc3_);
         screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
      }
      
      public function premiumBought(param1:uint, param2:uint) : void
      {
         dataM.gameOfWhalesM.boughtPremiumAccount(param2,0,this._lastSelectedPremiumDurationHours);
         if(dataM.premiumAccountTime < param1)
         {
            dataM.premiumAccountTime = param1;
         }
         dataM.myProfile.removeFromTokens(param2);
         if(this.isScreenOpened())
         {
            screensM.screenGlobalShop.refreshGoldTokensTexts();
         }
         screensM.screenConfirmation.displayCustomMessage(getScreenText("premiumAccountBought"));
         BMPubSub.pub(BMPubSub.MESSAGE_PREMIUM_PACKAGE_BOUGHT,dataM.premiumAccountTime);
      }
      
      public function buyGachaMachineLocally(param1:int) : void
      {
         var _loc4_:Array = null;
         var _loc7_:Number = NaN;
         var _loc8_:uint = 0;
         var _loc2_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc3_:BMGachaMachineData = dataM.gachaMachinesArray[0];
         _loc2_.gold -= _loc3_.costGold;
         var _loc5_:Array = new Array();
         if(_loc2_.tutorialLevel <= BMTutorialManager.TUTORIAL_LEVEL_SHOP1)
         {
            _loc4_ = [BMCampaignMechsHelper.getTutorial_hanger4_topWeapon(),BMCampaignMechsHelper.getTutorial_hanger4_module()];
         }
         else
         {
            _loc4_ = [BMCampaignMechsHelper.getTutorial_hanger4_topWeapon(),BMCampaignMechsHelper.getTutorial_hanger4_module()];
         }
         var _loc6_:uint = 0;
         while(_loc6_ < _loc4_.length)
         {
            _loc7_ = Number(_loc4_[_loc6_]);
            _loc8_ = dataM.addPlayerItemDataToInventory(dataM.player1PlayerID,_loc7_,0,0,0,0);
            _loc5_.push(_loc8_);
            _loc6_++;
         }
         ++_loc2_.itemBoxesBought_guest;
         screensM.addScreen(BMScreensManager.SCR_ITEM_CARDS);
         screensM.screenItemCards.refreshScreen(_loc4_,_loc5_,param1);
         screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
         if(_loc2_.tutorialLevel <= BMTutorialManager.TUTORIAL_LEVEL_SHOP1)
         {
            tutorialM.setTutorialLevel(BMTutorialManager.TUTORIAL_LEVEL_SHOP1 + 1);
         }
         if(screensM.screenTopBar != null)
         {
            screensM.screenTopBar.refreshScreen(false);
         }
         dataM.saveGuestData("buyGachaMachineLocally");
         if(tutorialM.isTutorialActive())
         {
            this.close();
         }
      }
      
      public function showGoldPackages(param1:String = null, param2:uint = 0) : void
      {
         var _loc4_:BMGoldPackageData = null;
         var _loc5_:Array = null;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         this.shopView.setTitle(getScreenText("goldCAP"));
         var _loc3_:Array = new Array();
         for each(_loc4_ in dataM.goldPackagesDB)
         {
            _loc3_.push({
               "goldPackageID":_loc4_.goldPackageID,
               "sortID":_loc4_.sortID
            });
         }
         _loc3_.sortOn("sortID",Array.NUMERIC);
         _loc5_ = new Array();
         _loc6_ = 0;
         while(_loc6_ < _loc3_.length)
         {
            _loc7_ = uint(_loc3_[_loc6_].goldPackageID);
            _loc4_ = dataM.goldPackagesDB[_loc7_];
            _loc5_.push(this.convertGoldPackageData(_loc4_));
            _loc6_++;
         }
         this.shopView.setItems(_loc5_,true,param2);
         this.shopView.onSelect = this.onGoldPackageSelect;
         this._currentCategoryID = this.category_gold;
         this.shopView.selectCategoryTab(this._currentCategoryID);
         this._screenSource = param1;
      }
      
      private function convertGoldPackageData(param1:BMGoldPackageData) : BMShopItemViewData
      {
         var _loc2_:BMShopItemViewData = new BMShopItemViewData();
         _loc2_.id = param1.goldPackageID;
         _loc2_.bodyText = param1.title;
         _loc2_.bonusText = param1.bonus;
         _loc2_.specialBanner = param1.banner;
         _loc2_.applayCostTokens(param1.costTokens,param1.costTokensDefault);
         var _loc3_:Boolean = false;
         if(this._currentCategoryID == this.category_clanShop || this._currentCategoryID == this.category_kinShop)
         {
            _loc2_.defaultPrice = "0";
         }
         else if(BMSalesManager.gi().isSaleActive(dataM.currentTime,BMSale.STORE_SECTION_GOLD))
         {
            _loc3_ = true;
         }
         if(_loc3_)
         {
            _loc2_.applaySale(BMSalesManager.gi().getSaleData());
         }
         _loc2_.imagePath = "general";
         _loc2_.imageName = "globalShop_goldPackage" + param1.visual;
         return _loc2_;
      }
      
      private function onGoldPackageSelect(param1:BMShopItemViewData) : void
      {
         var _loc2_:uint = this.getShopItemID(param1);
         this.trackItemEvent("Select","Gold" + param1.bodyText,_loc2_,this.isBoxHardCurrencyOrRealMoney(param1));
         param1.imagePath = "general";
         var _loc3_:String = "globalShop_itemInfo" + this.category_gold + "_" + _loc2_;
         param1.imageName = _loc3_;
         param1.titleBottom = getScreenText("goldCAP");
         param1.category = this.category_gold;
         this.showShopItemInfoScreen(param1,null,this.buyGold);
      }
      
      private function buyGold(param1:BMShopItemViewData, param2:uint) : void
      {
         var _loc3_:BMGoldPackageData = dataM.goldPackagesDB[param1.id];
         dataM.gameOfWhalesM.tokensConvertedToGold(_loc3_.costTokens,_loc3_.gold);
         this.trackItemEvent("Buy","Gold" + param1.bodyText,param1.id,this.isBoxHardCurrencyOrRealMoney(param1));
         remoteM.socketM.buyGold(param1.id);
         screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
      }
      
      public function goldBought(param1:uint, param2:uint) : void
      {
         var _loc3_:uint = param1 - dataM.myProfile.gold;
         screensM.screenConfirmation.displayQuestionOrNotification("goldBought",_loc3_,param2);
         dataM.myProfile.gold = param1;
         dataM.myProfile.removeFromTokens(param2);
         screensM.screenGlobalShop.refreshGoldTokensTexts();
      }
      
      public function showCustomization(param1:String) : *
      {
         var _loc4_:BMItemData = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         this.shopView.setTitle(getScreenText("customizationCAP"));
         var _loc2_:Array = new Array();
         var _loc3_:Array = new Array();
         for each(_loc4_ in dataM.itemsDB)
         {
            if((_loc4_.type == "perk" || _loc4_.isColorKit) && _loc4_.isInShop)
            {
               _loc6_ = 0;
               if(_loc4_.type == "perk")
               {
                  _loc6_ = 10000;
               }
               else if(int(_loc4_.animation) == 0)
               {
                  _loc6_ = 2000;
               }
               else if(int(_loc4_.animation) >= BMDataManager.PATTERN_COLORS_FIRST_ID)
               {
                  _loc6_ = uint(int(_loc4_.animation));
               }
               else
               {
                  _loc6_ = 1000 + int(_loc4_.animation);
               }
               _loc3_.push({
                  "itemID":_loc4_.itemID,
                  "sortScore":_loc6_
               });
            }
         }
         _loc3_.sortOn("sortScore",Array.NUMERIC);
         _loc5_ = 0;
         while(_loc5_ < _loc3_.length)
         {
            _loc4_ = dataM.itemsDB[_loc3_[_loc5_]["itemID"]];
            _loc2_.push(this.convertItmeData(_loc4_));
            _loc5_++;
         }
         if(dataM.isPostMythicalStarterPackActive())
         {
            _loc2_.push(this.createPostMythicalStarterItemData());
         }
         this.shopView.setItems(_loc2_,this._currentCategoryID != this.category_customization);
         this.shopView.onSelect = this.onItemSelect;
         this._currentCategoryID = this.category_customization;
         this.shopView.selectCategoryTab(this._currentCategoryID);
         this._screenSource = param1;
      }
      
      private function createPostMythicalStarterItemData() : BMShopItemViewData
      {
         var _loc1_:BMStarterPackData = dataM.myProfile.postMythicalStarterPackData;
         var _loc2_:BMBoostData = dataM.boostsDB[_loc1_.boostID];
         var _loc3_:BMItemData = dataM.itemsDB[_loc2_.itemID];
         var _loc4_:BMTokenPackage = dataM.getTokenPackageByStarterPackID(_loc1_.packID);
         var _loc5_:BMShopItemViewData = this.convertItmeData(_loc3_);
         _loc5_.price = _loc4_.price;
         _loc5_.timerEnd = _loc1_.starterPackEndDate;
         return _loc5_;
      }
      
      private function convertItmeData(param1:BMItemData) : BMShopItemViewData
      {
         var _loc2_:BMShopItemViewData = new BMShopItemViewData();
         _loc2_.id = param1.itemID;
         var _loc3_:String = languageM.getItemNameByItemData(param1);
         _loc2_.titleBottom = _loc3_;
         if(param1.costTokens > 0)
         {
            _loc2_.applayCostTokens(param1.costTokens,param1.costTokensDefault);
            if(BMSalesManager.gi().isSaleActive(dataM.currentTime,BMSale.STORE_SECTION_CUSTOMIZE))
            {
               _loc2_.applaySale(BMSalesManager.gi().getSaleData());
            }
         }
         else
         {
            _loc2_.price = TextUtils.getNumberWithComma(param1.costGold);
            _loc2_.currency = BMShopItemViewData.CURRENCY_TYPE_GOLD;
         }
         if(param1.isColorKit)
         {
            if(int(param1.animation) >= BMDataManager.PATTERN_COLORS_FIRST_ID)
            {
               _loc2_.imageYAddon = -15;
            }
         }
         _loc2_.putImageInSizer = true;
         _loc2_.imagePath = dataM.itemTypeSourceDB[param1.type];
         _loc2_.imageName = param1.grp;
         return _loc2_;
      }
      
      private function onItemSelect(param1:BMShopItemViewData) : void
      {
         var _loc2_:uint = this.getShopItemID(param1);
         TsLogger.log("BMScreenGlobalShop :: onItemSelect " + _loc2_);
         var _loc3_:BMItemData = dataM.itemsDB[_loc2_];
         if(_loc3_.isColorKit)
         {
            param1.bonusText = getScreenText("colorKitDescription");
         }
         param1.category = this.category_customization;
         this.showShopItemInfoScreen(param1,null,this.tryToBuyItem);
      }
      
      private function tryToBuyItem(param1:BMShopItemViewData, param2:uint) : void
      {
         var _loc3_:* = param1.id;
         var _loc4_:BMPlayerData = dataM.playersData[dataM.player1PlayerID];
         var _loc5_:BMItemData = dataM.itemsDB[_loc3_];
         var _loc6_:Boolean = true;
         var _loc7_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc8_:uint = uint(_loc5_.costGold);
         var _loc9_:uint = uint(_loc5_.costTokens);
         if(_loc9_ > 0)
         {
            if(_loc9_ > _loc7_.tokens)
            {
               _loc6_ = false;
            }
         }
         else if(_loc8_ > _loc7_.gold)
         {
            _loc6_ = false;
         }
         if(_loc6_)
         {
            this.buyItemConfirmed(_loc3_,1);
            if(dataM.gameType == BMDataManager.GAME_TYPE_DEFAULT)
            {
               screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
            }
         }
         else
         {
            screensM.screenConfirmation.displayQuestionOrNotification("notEnoughMoneyForItem",_loc3_,-1);
         }
      }
      
      private function buyItemConfirmed(param1:Number, param2:uint) : void
      {
         remoteM.inventory_buyItem(param1,param2);
         if(dataM.gameType == BMDataManager.GAME_TYPE_DEFAULT)
         {
            screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
         }
      }
      
      private function getMechShopItemViewData(param1:BMMechShopData) : BMShopItemViewData
      {
         var _loc8_:BMItemData = null;
         var _loc9_:String = null;
         var _loc2_:BMStarterPackData = dataM.starterPackData[param1.starterPackID];
         var _loc3_:BMShopItemViewData = new BMShopItemViewData();
         _loc3_.currency = BMShopItemViewData.CURRENCY_TYPE_GOLD;
         _loc3_.price = String(param1.goldCost);
         if(param1.tokensCost > 0)
         {
            _loc3_.currency = BMShopItemViewData.CURRENCY_TYPE_TOKENS;
            _loc3_.price = String(param1.tokensCost);
         }
         _loc3_.mechStructure = _loc2_.getMechStructure();
         var _loc4_:String = param1.mechName;
         var _loc5_:uint = 0;
         var _loc6_:Array = _loc2_.getMechItemIDs();
         var _loc7_:uint = 0;
         while(_loc7_ < _loc6_.length)
         {
            _loc8_ = dataM.itemsDB[_loc6_[_loc7_]];
            if(_loc8_.specialStatus == 3)
            {
               _loc5_++;
            }
            _loc7_++;
         }
         if(_loc5_ > 0)
         {
            _loc4_ = _loc4_ + "<BR><FONT COLOR=\'#" + ItemRarityResolver.COLOR_LEGENDARY_ITEM + "\'>";
            if(_loc5_ == 1)
            {
               _loc4_ += getScreenText("oneLegendaryItem");
            }
            else
            {
               _loc9_ = getScreenText("severalLegendaryItems");
               _loc9_ = dataM.replaceStringInText(_loc9_,"%ITEMS%",String(_loc5_));
               _loc4_ += _loc9_;
            }
         }
         _loc3_.titleTop = _loc4_;
         _loc3_.infoOnlyText1 = param1.mechName;
         _loc3_.infoOnlyText2 = getSpecificText(param1.description);
         if(dataM.myProfile.shopMechsBought[param1.packageID] != null)
         {
            if(dataM.myProfile.shopMechsBought[param1.packageID] > 0)
            {
               _loc3_.showBoughtBanner = true;
               _loc3_.isDisabled = true;
            }
         }
         _loc3_.id = param1.packageID;
         return _loc3_;
      }
      
      public function showMechs(param1:String = "") : void
      {
         var _loc5_:BMMechShopData = null;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         this.shopView.setTitle(getScreenText("mechs"));
         var _loc2_:Array = new Array();
         var _loc3_:Array = new Array();
         var _loc4_:Array = new Array();
         for each(_loc5_ in dataM.mechShopData)
         {
            if(_loc5_.isActive == 1)
            {
               _loc4_.push(_loc5_.packageID);
            }
         }
         _loc6_ = 0;
         while(_loc6_ < _loc4_.length)
         {
            _loc7_ = uint(_loc4_[_loc6_]);
            _loc5_ = dataM.mechShopData[_loc7_];
            _loc2_.push(this.getMechShopItemViewData(_loc5_));
            _loc6_++;
         }
         _loc2_.sort(this.mechsOrderResolver);
         this.shopView.setItems(_loc2_,this._currentCategoryID != this.category_mechs);
         this.shopView.onSelect = this.onMechSelect;
         this._currentCategoryID = this.category_mechs;
         this.shopView.selectCategoryTab(this._currentCategoryID);
         if(param1 != "")
         {
            this._screenSource = param1;
         }
         this.refreshShopCounters();
      }
      
      private function mechsOrderResolver(param1:BMShopItemViewData, param2:BMShopItemViewData) : Number
      {
         if(param1.isDisabled == false && param2.isDisabled)
         {
            return -1;
         }
         if(param1.isDisabled && param2.isDisabled == false)
         {
            return 1;
         }
         if(param1.id > param2.id)
         {
            return 1;
         }
         return -1;
      }
      
      private function onMechSelect(param1:BMShopItemViewData) : void
      {
         this.showShopItemInfoScreen(param1,BMScreenShopItemInfoMech,this.tryToBuyMech);
      }
      
      private function tryToBuyMech(param1:BMShopItemViewData, param2:uint) : void
      {
         if(dataM.myProfile.pendingStarterPackMech > 0)
         {
            screensM.screenConfirmation.displayQuestionOrNotification("mustRedeemStarterPackMech");
            return;
         }
         var _loc3_:BMMechShopData = dataM.mechShopData[param1.id];
         var _loc4_:Boolean = false;
         var _loc5_:Boolean = false;
         if(_loc3_.tokensCost > dataM.myProfile.tokens)
         {
            _loc4_ = true;
         }
         if(_loc3_.goldCost > dataM.myProfile.gold)
         {
            _loc5_ = true;
         }
         if(_loc4_)
         {
            this.showBuyMoreTokensYesNoPopup(_loc3_.tokensCost);
            return;
         }
         if(_loc5_)
         {
            this.showBuyMoreGoldYesNoPopup(_loc3_.goldCost);
            return;
         }
         dataM.gameOfWhalesM.boughtMech(_loc3_.tokensCost,0,param1.id);
         screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
         this._lastShopMechID = _loc3_.packageID;
         remoteM.socketM.buyShopMech(_loc3_.packageID);
      }
      
      public function mechBought() : void
      {
         if(this.useMechsShop == false)
         {
            return;
         }
         if(screensM.isScreenOpened(BMScreensManager.SCR_GLOBAL_SHOP) == false && screensM.isScreenOpened(BMScreensManager.SCR_CLAN_SHOP) == false)
         {
            return;
         }
         if(this.currentCategory != this.category_mechs && this.currentCategory != this.category_clanShop && this.currentCategory != this.category_kinShop)
         {
            return;
         }
         if(dataM.myProfile.shopMechsBought[String(this._lastShopMechID)] == null)
         {
            dataM.myProfile.shopMechsBought[String(this._lastShopMechID)] = 0;
         }
         ++dataM.myProfile.shopMechsBought[String(this._lastShopMechID)];
         var _loc1_:Boolean = dataM.tryToUnpackMechAutomatically();
         this._lastShopMechID = 0;
         if(_loc1_)
         {
            this.close();
         }
         else
         {
            if(this.currentCategory == this.category_mechs)
            {
               this.showMechs();
            }
            if(this.currentCategory == this.category_clanShop || this.currentCategory == this.category_kinShop)
            {
               this.showClanShop();
            }
         }
      }
      
      private function getShopItemID(param1:BMShopItemViewData) : uint
      {
         if(this._currentCategoryID == this.category_clanShop || this._currentCategoryID == this.category_kinShop)
         {
            return this.getClanShopData(param1.id).itemID;
         }
         return param1.id;
      }
      
      private function getClanShopData(param1:uint) : BMClanShopData
      {
         var _loc2_:Vector.<BMClanShopData> = null;
         var _loc4_:BMClanShopData = null;
         if(this.currentCategory == this.category_clanShop)
         {
            _loc2_ = dataM.clanShopItems;
         }
         else
         {
            _loc2_ = dataM.kinShopItems;
         }
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc3_];
            if(_loc4_.clanShopID == param1)
            {
               return _loc4_;
            }
            _loc3_++;
         }
         return null;
      }
      
      public function showClanShop(param1:String = "", param2:Boolean = false) : void
      {
         var _loc4_:Vector.<BMClanShopData> = null;
         var _loc6_:BMClanShopData = null;
         var _loc7_:BMShopItemViewData = null;
         var _loc8_:BMGoldPackageData = null;
         var _loc9_:BMItemData = null;
         var _loc10_:String = null;
         var _loc11_:String = null;
         var _loc12_:BMGachaMachineData = null;
         var _loc13_:BMMechShopData = null;
         var _loc14_:BMPremiumPackageData = null;
         this._currentCategoryID = this.category_clanShop;
         if(param2)
         {
            this._currentCategoryID = this.category_kinShop;
         }
         var _loc3_:Array = new Array();
         if(param2)
         {
            _loc4_ = dataM.kinShopItems;
         }
         else
         {
            _loc4_ = dataM.clanShopItems;
         }
         var _loc5_:uint = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc6_ = _loc4_[_loc5_];
            _loc7_ = null;
            switch(_loc6_.itemType)
            {
               case BMClanShopData.TYPE_GOLD:
                  _loc8_ = this.getGoldPackage(_loc6_.itemID);
                  _loc7_ = this.convertGoldPackageData(_loc8_);
                  _loc7_.titleTop = getScreenText("gold");
                  break;
               case BMClanShopData.TYPE_ITEM:
                  _loc9_ = dataM.itemsDB[_loc6_.itemID];
                  _loc7_ = this.convertItmeData(_loc9_);
                  _loc7_.titleTop = _loc7_.titleBottom;
                  _loc10_ = "<FONT COLOR=\'#" + ItemRarityResolver.getItemTierColor(_loc9_.specialStatus) + "\'>" + ItemRarityResolver.getItemTierName(_loc9_.specialStatus) + "</FONT>";
                  _loc11_ = "<FONT COLOR=\'#FFFFFF\'>";
                  if(_loc9_.displayLevel > 1)
                  {
                     _loc11_ += getSpecificText("selectAccount_level");
                     _loc11_ = dataM.replaceStringInText(_loc11_,"%LEVEL%",String(_loc9_.displayLevel));
                  }
                  _loc7_.bodyText = _loc10_ + " " + _loc11_;
                  _loc7_.bodyTextSize = 24;
                  break;
               case BMClanShopData.TYPE_ITEM_BOX:
                  _loc12_ = this.getGachaMachine(_loc6_.itemID);
                  _loc7_ = this.getItemBoxShopItemViewData(_loc12_);
                  break;
               case BMClanShopData.TYPE_MECH:
                  _loc13_ = this.getMechShopData(_loc6_.itemID);
                  _loc7_ = this.getMechShopItemViewData(_loc13_);
                  break;
               case BMClanShopData.TYPE_PREMIUM_ACCOUNT:
                  _loc14_ = this.getPremiumPackageData(_loc6_.itemID);
                  _loc7_ = this.getPremiumPackageItemViewData(_loc14_);
                  _loc7_.titleTop = getScreenText("premiumAccount");
                  break;
               case BMClanShopData.TYPE_TOKENS:
                  _loc7_ = this.getBonusTokensItemViewData(_loc6_);
                  _loc7_.titleTop = getScreenText("tokens");
            }
            if(_loc7_ != null)
            {
               _loc7_.id = _loc6_.clanShopID;
               _loc7_.price = _loc6_.price.toString();
               if(param2)
               {
                  _loc7_.currency = BMShopItemViewData.CURRENCY_TYPE_KIN;
               }
               else
               {
                  _loc7_.currency = BMShopItemViewData.CURRENCY_TYPE_CLAN_COINS;
               }
               _loc7_.specialBanner = 0;
               _loc3_.push(_loc7_);
            }
            if(this._currentCategoryID == this.category_kinShop)
            {
               if(dataM.kinM.isKinShopItemAvailableForPurchase(_loc6_.clanShopID) == false)
               {
                  _loc7_.timerEnd = dataM.questsManager.dailyQuestsNextResetTime;
                  _loc7_.timerCompleteText = "00:00";
               }
            }
            _loc5_++;
         }
         _loc3_.sort(this.orderClanShopItems);
         this.shopView.setItems(_loc3_);
         this.shopView.onSelect = this.onClanShopSelect;
         this._screenSource = param1;
      }
      
      private function onClanShopSelect(param1:BMShopItemViewData) : void
      {
         var _loc2_:int = this.getClanShopData(param1.id).itemType;
         if(this.currentCategory == this.category_kinShop)
         {
            if(dataM.kinM.isKinShopItemAvailableForPurchase(param1.id) == false)
            {
               screensM.screenConfirmation.displayCustomMessage("<BR>" + getSpecificText("kin_alreadyPurchasedItemToday"));
               return;
            }
         }
         switch(_loc2_)
         {
            case BMClanShopData.TYPE_GOLD:
               this.onGoldPackageSelect(param1);
               break;
            case BMClanShopData.TYPE_ITEM:
               this.onItemSelect(param1);
               break;
            case BMClanShopData.TYPE_ITEM_BOX:
               this.onBoxSelect(param1);
               break;
            case BMClanShopData.TYPE_MECH:
               this.onMechSelect(param1);
               break;
            case BMClanShopData.TYPE_PREMIUM_ACCOUNT:
               this.onPremiumSelect(param1);
               break;
            case BMClanShopData.TYPE_TOKENS:
               this.tryToBuyClanShopItem(param1,1);
         }
      }
      
      private function orderClanShopItems(param1:BMShopItemViewData, param2:BMShopItemViewData) : Number
      {
         if(int(param1.price) > int(param2.price))
         {
            return 1;
         }
         return -1;
      }
      
      public function get category_none() : int
      {
         return CAT_NONE;
      }
      
      public function get category_tokens() : int
      {
         return 0;
      }
      
      public function get category_itemBoxes() : int
      {
         return 1;
      }
      
      public function get category_gold() : int
      {
         return 2;
      }
      
      public function get category_customization() : int
      {
         if(this.useMechsShop)
         {
            return 4;
         }
         return 3;
      }
      
      public function get category_unclaimed() : int
      {
         if(this.useMechsShop)
         {
            return 5;
         }
         return 4;
      }
      
      public function get category_premium() : int
      {
         if(this.useMechsShop)
         {
            return 6;
         }
         return 5;
      }
      
      public function get category_mechs() : int
      {
         return 3;
      }
      
      public function get category_clanShop() : int
      {
         if(this.useMechsShop)
         {
            return 7;
         }
         return 6;
      }
      
      public function get category_kinShop() : int
      {
         if(this.useMechsShop)
         {
            return 8;
         }
         return 7;
      }
      
      public function get categoryTrackEventNames() : Array
      {
         if(this.useMechsShop)
         {
            return ["Tokens","ItemBoxes","Gold","Mechs","Customization","UnclaimedBoxes","Premium","ClanShop","KinShop"];
         }
         return ["Tokens","ItemBoxes","Gold","Customization","UnclaimedBoxes","Premium","ClanShop","KinShop"];
      }
      
      private function get categoryNames() : Array
      {
         var _loc1_:Array = [getScreenText("tokens"),getScreenText("itemBoxes"),getScreenText("gold")];
         if(this.useMechsShop)
         {
            _loc1_.push(getScreenText("mechsCap"));
         }
         _loc1_.push(getScreenText("customization"),getScreenText("unclaimedBoxes"),getScreenText("premium"));
         return _loc1_;
      }
      
      private function get numOfCategories() : uint
      {
         if(this.useMechsShop)
         {
            return NUM_OF_CATEGORIES + 1;
         }
         return NUM_OF_CATEGORIES;
      }
      
      public function get useIconTabs() : Boolean
      {
         if(dataM.clientRunningLocally)
         {
         }
         return int(dataM.getGeneralSetting("useShopIconTabs",0)) == 1;
      }
      
      public function get useMechsShop() : Boolean
      {
         if(this.useIconTabs == false)
         {
            return false;
         }
         if(this.mechShopItemsCount == 0)
         {
            return false;
         }
         if(dataM.clientRunningLocally)
         {
         }
         return int(dataM.getGeneralSetting("useMechsShop",0)) == 1;
      }
      
      private function get mechShopItemsCount() : uint
      {
         var _loc2_:BMMechShopData = null;
         var _loc1_:uint = 0;
         if(dataM.mechShopData == null)
         {
            return _loc1_;
         }
         for each(_loc2_ in dataM.mechShopData)
         {
            if(_loc2_.isActive == 1)
            {
               _loc1_++;
            }
         }
         return _loc1_;
      }
      
      public function boostsHaveBeenModified() : void
      {
         if(tutorialM.isTutorialActive() == false)
         {
            this.refresh();
            screensM.screenConfirmation.displayQuestionOrNotification("boostsHaveBeenModified",-1,-1);
         }
         if(screensM.isScreenOpened(BMScreensManager.SCR_SHOP_ITEM_INFO))
         {
            screensM.screenShopItemInfo.removeMe();
         }
      }
      
      public function buyItemSuccess(param1:Array, param2:Number) : void
      {
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:Number = NaN;
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
            _loc7_ = _loc5_.costGold * param1.length;
            dataM.gameOfWhalesM.boughtItem(_loc7_,0,0,param2);
            _loc3_.gold -= _loc7_;
            if(screensM.isScreenOpened(BMScreensManager.SCR_TOP_BAR))
            {
               screensM.screenTopBar.refreshScreen(false);
            }
         }
         else
         {
            _loc8_ = _loc5_.costTokens * param1.length;
            dataM.gameOfWhalesM.boughtItem(0,_loc8_,0,param2);
            _loc3_.tokens -= _loc8_;
            if(_loc3_.tokens_bonus >= _loc8_)
            {
               _loc3_.tokens_bonus -= _loc8_;
            }
            else
            {
               _loc8_ -= _loc3_.tokens_bonus;
               _loc3_.tokens_bonus = 0;
               _loc3_.tokens_supporter -= _loc8_;
            }
            if(screensM.isScreenOpened(BMScreensManager.SCR_TOP_BAR))
            {
               screensM.screenTopBar.refreshScreen();
            }
         }
         var _loc6_:int = _loc5_.costTokens > 0 ? BMDataManager.ANALYTICS_PRIORITY_HIGHEST : 2;
         dataM.trackEvent(_loc6_,"Shop","buyItem",_loc5_.type);
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            dataM.addPlayerItemDataToInventory(dataM.player1PlayerID,param2,param1[_loc4_],0,0,0);
            _loc4_++;
         }
         this.refresh();
         soundM.createSound("itemBought",1);
         dataM.saveGuestData("hanger buyItemSuccess");
         screensM.screenConfirmation.displayQuestionOrNotification("purchaseSuccessful");
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
      
      public function showBuyMoreGoldYesNoPopup(param1:uint) : void
      {
         screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
         screensM.addScreen(BMScreensManager.SCR_YES_NO_POPUP,true,BMScreenYesNoPopup2);
         var _loc2_:String = getSpecificText("confirmation_notEnoughGold");
         _loc2_ = dataM.replaceStringInText(_loc2_,"%COLOR%","<FONT COLOR=\'#" + dataM.COLOR_GOLD + "\'>");
         _loc2_ = dataM.replaceStringInText(_loc2_,"%GOLD%",TextUtils.getNumberWithComma(param1));
         screensM.screenYesNoPopup.displayYesNoPopup("",_loc2_,"",this.buyGoldClicked,null,getSpecificText("confirmation_buyMore"));
      }
      
      public function showBuyMoreTokensYesNoPopup(param1:uint) : void
      {
         screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
         screensM.addScreen(BMScreensManager.SCR_YES_NO_POPUP,true,BMScreenYesNoPopup2);
         var _loc2_:String = getSpecificText("confirmation_notEnoughTokens");
         _loc2_ = dataM.replaceStringInText(_loc2_,"%COLOR%","<FONT COLOR=\'#" + dataM.COLOR_GOLD + "\'>");
         _loc2_ = dataM.replaceStringInText(_loc2_,"%TOKENS%",TextUtils.getNumberWithComma(param1));
         screensM.screenYesNoPopup.displayYesNoPopup("",_loc2_,"",this.buyTokensClicked,null,getSpecificText("confirmation_buyMore"));
      }
      
      public function showNotEnoughClanCoins() : void
      {
         var _loc1_:String = getSpecificText("clanBoss_notEnoughClanCoins");
         screensM.screenConfirmation.displayCustomMessage(_loc1_);
      }
      
      public function showNotEnoughKin() : void
      {
         var _loc1_:String = "<BR>" + getSpecificText("kin_notEnoughKin");
         screensM.screenConfirmation.displayCustomMessage(_loc1_);
      }
      
      private function buyGoldClicked() : void
      {
         this.showGoldPackages();
         this.removeShopItemInfo();
      }
      
      private function buyTokensClicked() : void
      {
         this.showTokens();
         this.removeShopItemInfo();
      }
      
      public function getBoxGrpForVisualID(param1:uint, param2:Number = -1, param3:Boolean = true) : Array
      {
         var _loc5_:MovieClip = null;
         var _loc6_:MovieClip = null;
         var _loc7_:String = null;
         var _loc4_:Array = new Array();
         switch(param1)
         {
            case 1:
            case 2:
            case 3:
            case 4:
            case 5:
            case 19:
            case 21:
            case 22:
            case 23:
            case 24:
            case 100:
            case 101:
            case 102:
            case 103:
            case 104:
            case 105:
            case 106:
            case 107:
            case 108:
            case 900:
            case 901:
            case 902:
            case 903:
            case 904:
            case 905:
               _loc5_ = dataM.getLocalGraphicIcon("mcItemBox_" + param1);
               if(param3)
               {
                  _loc6_ = dataM.getLocalGraphicIcon("grpItemBox_" + param1 + "_bottom");
               }
               break;
            case EASTER_EGG_BOX_VISUAL_ID:
               _loc5_ = dataM.getLocalGraphicIcon("mcItemBox_50");
               if(param3)
               {
                  _loc6_ = dataM.getLocalGraphicIcon("grpItemBox_50_reflection");
               }
               break;
            case BMShopManager.WORLD_MAP_ITEMS_BOX_ID:
               _loc5_ = new mcItemBox_6();
               if(param3)
               {
                  _loc6_ = new grpItemBox_6_bottom();
               }
               break;
            case BMShopManager.MIX_BOX_VISUAL_ID:
            case BMShopManager.FREE_ITEM_BOX_ID:
            case BMShopManager.UNCLAIMED_ITEM_BOX_ID:
            case BMShopManager.CUSTOM_ITEMS_BOX_ID:
            default:
               _loc5_ = new mcItemBox_regular();
               if(param3)
               {
                  _loc6_ = new grpItemBox_regular_bottom();
               }
               switch(param2)
               {
                  case 21:
                     _loc7_ = "torsoLeg";
                     break;
                  case 22:
                     _loc7_ = "weapons";
                     break;
                  case 23:
                     _loc7_ = "specials";
                     break;
                  case 24:
                     _loc7_ = "modules";
                     break;
                  default:
                  case 25:
                     _loc7_ = "mix";
               }
               _loc5_.mcBottom.mcIcons.gotoAndStop(_loc7_);
               if(param3)
               {
                  _loc6_.mcIcons.gotoAndStop(_loc7_);
               }
         }
         if(_loc5_.mcOverlayEffect != null)
         {
            _loc5_.mcOverlayEffect.visible = false;
         }
         _loc4_[0] = _loc5_;
         if(param3)
         {
            _loc6_.scaleY = -1;
            _loc4_[1] = _loc6_;
         }
         return _loc4_;
      }
      
      public function showExtraCardInItemCardsScreen(param1:uint) : Boolean
      {
         if(tutorialM.isTutorialActive())
         {
            return false;
         }
         if(dataM.getGeneralSetting("offerItemBoxExtraCard",0) == 0)
         {
            return false;
         }
         if(param1 != REGULAR_GACHA_MACHINE_ID)
         {
            return false;
         }
         return dataM.isRewardedVideoAvailable(BMScreenWatchRewardedVideo.PLACEMENT_OPEN_BOX_EXTRA_CARD);
      }
      
      private function removeShopItemInfo() : void
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_SHOP_ITEM_INFO))
         {
            screensM.removeScreen(BMScreensManager.SCR_SHOP_ITEM_INFO);
         }
      }
      
      public function close() : *
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_GLOBAL_SHOP))
         {
            this.shopView.closeClicked();
         }
         if(screensM.isScreenOpened(BMScreensManager.SCR_MAIN_MENU))
         {
            screensM.screenMainMenu.refreshButtonsForTutorial();
         }
         this.removeChainDiscountTimer();
         this.removeSaleResetTimer();
      }
      
      public function notifyShopClosed() : *
      {
         this._sourceNotificationID = BMNotificationsManager.NO_NOTIFICATION_ID;
         BMPubSub.pub(BMPubSub.MESSAGE_SHOP_CLOSED);
      }
      
      public function get currentScreenSource() : String
      {
         return this._screenSource;
      }
      
      public function getExtraValueDisplayString(param1:String) : Array
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc2_:Array = extractFormatAndAmountFromText(param1);
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_[0];
            if(KNOWN_LOCALIZATION_FORMATS.hasOwnProperty(_loc3_))
            {
               _loc4_ = _loc2_[1];
               _loc5_ = KNOWN_LOCALIZATION_FORMATS[_loc3_];
               _loc3_ = languageM.getText(_loc5_,dataM.languageID);
               param1 = _loc3_.replace("%AMOUNT%",_loc4_);
            }
         }
         return TextUtils.splitStringToTwoLines(param1);
      }
      
      public function isGachaMachineClanReward(param1:uint) : Boolean
      {
         return param1 >= MIN_CLAN_BOX_ID && param1 <= MAX_CLAN_BOX_ID;
      }
      
      private function doAndroidPurchase(param1:String) : Boolean
      {
         TsLogger.log("BMScreenGlobalShop :: doAndroidPurchase()");
         screensM.screenDebugger.addTrace("PACKAGES - doAndroidPurchase:" + param1);
         BMAndroidStoreKitManager.gi().addEventListener(AndroidStoreEvent.NEW_PENDING_PURCHASES,this.onNewPendingPurchases);
         BMAndroidStoreKitManager.gi().addEventListener(AndroidStoreEvent.PURCHASE_SUCCEEDED,this.onPurchaseSucceeded);
         BMAndroidStoreKitManager.gi().addEventListener(AndroidStoreEvent.PURCHASE_FAILED,this.onPurchaseFailed);
         BMAndroidStoreKitManager.gi().addEventListener(AndroidStoreEvent.PURCHASE_CANCELLED,this.onPurchaseCanceled);
         BMAndroidStoreKitManager.gi().addEventListener(AndroidStoreEvent.PURCHASE_CANNOTCOMPLETE,this.onPurchaseCanNotComplete);
         BMAndroidStoreKitManager.gi().addEventListener(AndroidStoreEvent.PURCHASE_ORDERCREATEFAULT,this.onPurchaseOrderCreateFailed);
         return BMAndroidStoreKitManager.gi().doPurchase(param1);
      }
      
      private function onNewPendingPurchases(param1:AndroidStoreEvent) : void
      {
         this.processPendingPurchases();
      }
      
      private function onPurchaseSucceeded(param1:AndroidStoreEvent) : void
      {
         TsLogger.log("BMScreenGlobalShop :: onPurchaseSucceeded()");
         screensM.screenDebugger.addTrace("PACKAGES - onPurchaseSucceeded");
         BMAndroidStoreKitManager.gi().removeEventListener(AndroidStoreEvent.NEW_PENDING_PURCHASES,this.onNewPendingPurchases);
         BMAndroidStoreKitManager.gi().removeEventListener(AndroidStoreEvent.PURCHASE_SUCCEEDED,this.onPurchaseSucceeded);
         BMAndroidStoreKitManager.gi().removeEventListener(AndroidStoreEvent.PURCHASE_FAILED,this.onPurchaseFailed);
         BMAndroidStoreKitManager.gi().removeEventListener(AndroidStoreEvent.PURCHASE_CANCELLED,this.onPurchaseCanceled);
         BMAndroidStoreKitManager.gi().removeEventListener(AndroidStoreEvent.PURCHASE_CANNOTCOMPLETE,this.onPurchaseCanNotComplete);
         BMAndroidStoreKitManager.gi().removeEventListener(AndroidStoreEvent.PURCHASE_ORDERCREATEFAULT,this.onPurchaseOrderCreateFailed);
         screensM.screenConfirmation.displayUrgentMessage("buyTokens_thankYou");
         remoteM.socketM.lobby_tokensRefresh();
         var _loc2_:BMTokenPackage = dataM.getTokenPackageByID(this._lastSelectedTokenPackageID);
         TsLogger.log("               PACKAGE: " + JSON.stringify(_loc2_));
         dataM.gameOfWhalesM.tokensPurchased(_loc2_.priceWithoutCurrency,_loc2_.currencyCode,_loc2_.tokens,_loc2_.title);
      }
      
      private function onPurchaseFailed(param1:AndroidStoreEvent) : void
      {
         TsLogger.log("BMScreenGlobalShop :: onPurchaseFailed()");
         screensM.screenDebugger.addTrace("PACKAGES - onPurchaseFailed");
         BMAndroidStoreKitManager.gi().removeEventListener(AndroidStoreEvent.NEW_PENDING_PURCHASES,this.onNewPendingPurchases);
         BMAndroidStoreKitManager.gi().removeEventListener(AndroidStoreEvent.PURCHASE_SUCCEEDED,this.onPurchaseSucceeded);
         BMAndroidStoreKitManager.gi().removeEventListener(AndroidStoreEvent.PURCHASE_FAILED,this.onPurchaseFailed);
         BMAndroidStoreKitManager.gi().removeEventListener(AndroidStoreEvent.PURCHASE_CANCELLED,this.onPurchaseCanceled);
         BMAndroidStoreKitManager.gi().removeEventListener(AndroidStoreEvent.PURCHASE_CANNOTCOMPLETE,this.onPurchaseCanNotComplete);
         BMAndroidStoreKitManager.gi().removeEventListener(AndroidStoreEvent.PURCHASE_ORDERCREATEFAULT,this.onPurchaseOrderCreateFailed);
         this.showBuyTokensFailedDialog();
      }
      
      private function onPurchaseOrderCreateFailed(param1:AndroidStoreEvent) : void
      {
         TsLogger.log("BMScreenGlobalShop :: onPurchaseOrderCreateFailed()");
         var _loc2_:String = "N/A";
         if(param1.data != null && param1.data.description != null)
         {
            _loc2_ = param1.data.description;
         }
         dataM.trackError("PurchaseOrderCreateFailed",_loc2_);
         this.onPurchaseFailed(param1);
      }
      
      private function onPurchaseCanceled(param1:AndroidStoreEvent) : void
      {
         TsLogger.log("BMScreenGlobalShop :: onPurchaseCanceled()");
         screensM.screenDebugger.addTrace("PACKAGES - onPurchaseCanceled");
         BMAndroidStoreKitManager.gi().removeEventListener(AndroidStoreEvent.NEW_PENDING_PURCHASES,this.onNewPendingPurchases);
         BMAndroidStoreKitManager.gi().removeEventListener(AndroidStoreEvent.PURCHASE_SUCCEEDED,this.onPurchaseSucceeded);
         BMAndroidStoreKitManager.gi().removeEventListener(AndroidStoreEvent.PURCHASE_FAILED,this.onPurchaseFailed);
         BMAndroidStoreKitManager.gi().removeEventListener(AndroidStoreEvent.PURCHASE_CANCELLED,this.onPurchaseCanceled);
         BMAndroidStoreKitManager.gi().removeEventListener(AndroidStoreEvent.PURCHASE_CANNOTCOMPLETE,this.onPurchaseCanNotComplete);
         BMAndroidStoreKitManager.gi().removeEventListener(AndroidStoreEvent.PURCHASE_ORDERCREATEFAULT,this.onPurchaseOrderCreateFailed);
         screensM.screenConfirmation.displayQuestionOrNotification("buyTokens_canceled",-1,-1);
      }
      
      private function onPurchaseCanNotComplete(param1:AndroidStoreEvent) : void
      {
         TsLogger.log("BMScreenGlobalShop :: onPurchaseCanceled()");
         screensM.screenDebugger.addTrace("PACKAGES - onPurchaseCanNotComplete");
         BMAndroidStoreKitManager.gi().removeEventListener(AndroidStoreEvent.NEW_PENDING_PURCHASES,this.onNewPendingPurchases);
         BMAndroidStoreKitManager.gi().removeEventListener(AndroidStoreEvent.PURCHASE_SUCCEEDED,this.onPurchaseSucceeded);
         BMAndroidStoreKitManager.gi().removeEventListener(AndroidStoreEvent.PURCHASE_FAILED,this.onPurchaseFailed);
         BMAndroidStoreKitManager.gi().removeEventListener(AndroidStoreEvent.PURCHASE_CANCELLED,this.onPurchaseCanceled);
         BMAndroidStoreKitManager.gi().removeEventListener(AndroidStoreEvent.PURCHASE_CANNOTCOMPLETE,this.onPurchaseCanNotComplete);
         BMAndroidStoreKitManager.gi().removeEventListener(AndroidStoreEvent.PURCHASE_ORDERCREATEFAULT,this.onPurchaseOrderCreateFailed);
         screensM.screenConfirmation.displayQuestionOrNotification("buyTokens_cannotBeCompleted",-1,-1);
      }
   }
}

