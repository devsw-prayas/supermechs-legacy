package net.battleMechsMulti.managers.specialOffers
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.sales.BMSalesManager;
   import net.battleMechsMulti.managers.shop.BMShopManager;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.BMStarterPackData;
   import net.battleMechsMulti.screens.buyStarterPack.BMBuyStarterPackScreenChooser;
   import net.battleMechsMulti.screens.screensDirector.BMScreensDirectorTask;
   import net.battleMechsMulti.screens.specialOffers.BMScreenSpecialOffers;
   import net.battleMechsMulti.screens.specialOffers.BMScreenSpecialOffersBundle;
   import net.battleMechsMulti.screens.specialOffers.BMScreenSpecialOffersPackageBoxes;
   import net.battleMechsMulti.screens.specialOffers.BMScreenSpecialOffersPackageGold;
   import net.battleMechsMulti.screens.specialOffers.BMScreenSpecialOffersPackageGoldAndTokens;
   import net.battleMechsMulti.screens.specialOffers.BMScreenSpecialOffersPackageImproveYourMech;
   import net.battleMechsMulti.screens.specialOffers.BMScreenSpecialOffersPackageItemAndTokens;
   import net.battleMechsMulti.screens.specialOffers.BMScreenSpecialOffersPackageMech;
   import net.battleMechsMulti.screens.specialOffers.BMScreenSpecialOffersPackageTokens;
   import net.battleMechsMulti.screens.specialOffers.BMScreenSpecialOffersSmall;
   
   public class BMSpecialOffersManager extends BMBaseClass
   {
      
      private static var _inst:BMSpecialOffersManager;
      
      public static const STARTER_PACK_ID:uint = 100;
      
      public static const GLOBAL_SALE_ID:uint = 101;
      
      public static const POST_MYTHICAL_STARTER_PACK_ID:uint = 102;
      
      private static const SECONDS_PER_SALE:uint = 10;
      
      public var specialOffersResetTime:Number = 0;
      
      private var _resetTimer:Timer;
      
      private var _specialOfferIDs:Array = new Array();
      
      private var _smlBannerSpecialOfferIDs:Array = new Array();
      
      private var _currentOfferSlot:uint = 0;
      
      private var _location:Point;
      
      private var _scale:Number = 1;
      
      private var _isBigBanner:* = true;
      
      public function BMSpecialOffersManager()
      {
         super();
         generateSingletonClassesPointers("");
      }
      
      public static function getInstance() : BMSpecialOffersManager
      {
         if(_inst == null)
         {
            _inst = new BMSpecialOffersManager();
         }
         return _inst;
      }
      
      public static function gi() : BMSpecialOffersManager
      {
         return getInstance();
      }
      
      public static function trackSpecialOffersEvent(param1:String, param2:String, param3:int) : *
      {
         BMDataManager.getInstance().trackEvent(BMDataManager.ANALYTICS_PRIORITY_HIGHEST,"SpecialOffers",param1,param2,param3);
      }
      
      public function refreshSpecialOffersBoostIDs() : *
      {
         TsLogger.log("BMSpecialOffersManager::refreshSpecialOffersBoostIDs");
         this._specialOfferIDs = new Array();
         this._smlBannerSpecialOfferIDs = new Array();
         BMSalesManager.gi().generateSaleStarterPackData();
         if(dataM.isStarterPackActive())
         {
            this._specialOfferIDs.push(STARTER_PACK_ID);
            this._smlBannerSpecialOfferIDs.push(STARTER_PACK_ID);
         }
         else if(dataM.isPostMythicalStarterPackActive())
         {
            this._smlBannerSpecialOfferIDs.push(POST_MYTHICAL_STARTER_PACK_ID);
         }
         if(BMSalesManager.gi().isSaleActive(dataM.currentTime))
         {
            if(BMSalesManager.gi().shouldDisplaySaleInMainScreen(BMSalesManager.gi().getSaleData()))
            {
               this._specialOfferIDs.push(GLOBAL_SALE_ID);
               this._smlBannerSpecialOfferIDs.push(GLOBAL_SALE_ID);
            }
         }
         if(this._currentOfferSlot >= this._specialOfferIDs.length && this._currentOfferSlot > 0)
         {
            this._currentOfferSlot = this._specialOfferIDs.length - 1;
         }
      }
      
      public function get specialOfferIDs() : Array
      {
         return this._specialOfferIDs;
      }
      
      public function hasSpecialOffers() : Boolean
      {
         if(dataM.myProfile.pendingStarterPackMech > 0)
         {
            return false;
         }
         return this._specialOfferIDs != null && this._specialOfferIDs.length > 0 && BMBuyStarterPackScreenChooser.isStarterPackLegit();
      }
      
      public function hasSmlBannerSpecialOffers() : Boolean
      {
         return this._smlBannerSpecialOfferIDs != null && this._smlBannerSpecialOfferIDs.length > 0;
      }
      
      public function showBigBanner(param1:Sprite, param2:Number = 1) : void
      {
         if(this.hasSpecialOffers() == false)
         {
            return;
         }
         this._isBigBanner = true;
         this._location = new Point(param1.x,param1.y);
         this._scale = param2;
         this.refreshSpecialOffers();
         this.stopTimer();
         this.startTimer();
      }
      
      public function showSmallBanner(param1:Sprite) : void
      {
         if(this.hasSmlBannerSpecialOffers() == false)
         {
            return;
         }
         this._isBigBanner = false;
         this._location = new Point(param1.x,param1.y);
         this._scale = 1;
         this.refreshSpecialOffers();
         this.stopTimer();
         this.startTimer();
      }
      
      private function refreshSpecialOffers() : *
      {
         if(this._location == null)
         {
            trace("WARNING: specialOffersManager called refreshSpecialOffers when not supposed to");
            return;
         }
         if(dataM.isStarterPackActive())
         {
            dataM.updateStarterPackActive();
         }
         this.refreshSpecialOffersBoostIDs();
         if(!this.hasSpecialOffers())
         {
            return;
         }
         var _loc1_:Class = this.getBanner(this.currentOfferID);
         if(_loc1_ == null)
         {
            return;
         }
         if(screensM.screenSpecialOffers is _loc1_ == false)
         {
            if(screensM.screenSpecialOffers != null)
            {
               screensM.screenSpecialOffers.removeMe();
            }
            screensM.addScreen(BMScreensManager.SCR_SPECIAL_OFFERS,true,_loc1_);
         }
         if(screensM.screenSpecialOffers != null)
         {
            screensM.screenSpecialOffers.x = this._location.x;
            screensM.screenSpecialOffers.y = this._location.y;
            screensM.screenSpecialOffers.refreshScreen();
            screensM.screenSpecialOffers.scaleX = this._scale;
            screensM.screenSpecialOffers.scaleY = this._scale;
         }
      }
      
      private function getBanner(param1:uint) : Class
      {
         var _loc2_:Class = null;
         if(!this._isBigBanner)
         {
            return BMScreenSpecialOffersSmall;
         }
         var _loc3_:BMPlayerProfile = dataM.myProfile;
         if(param1 == STARTER_PACK_ID || param1 == GLOBAL_SALE_ID && BMSalesManager.gi().isStarterPackSale())
         {
            if(_loc3_.starterPackData.getStarterPackType() == BMStarterPackData.TYPE_BUNDLE)
            {
               _loc2_ = BMScreenSpecialOffersBundle;
            }
            else if(_loc3_.starterPackData.boostID > 0)
            {
               _loc2_ = BMScreenSpecialOffersPackageBoxes;
            }
            else if(BMBuyStarterPackScreenChooser.isImproveYourMechStarterPackID(_loc3_.starterPackData.packID))
            {
               _loc2_ = BMScreenSpecialOffersPackageImproveYourMech;
            }
            else if(_loc3_.starterPackData.getStarterPackType() == BMStarterPackData.TYPE_TOKENS)
            {
               _loc2_ = BMScreenSpecialOffersPackageTokens;
            }
            else if(_loc3_.starterPackData.getStarterPackType() == BMStarterPackData.TYPE_GOLD)
            {
               _loc2_ = BMScreenSpecialOffersPackageGold;
            }
            else if(_loc3_.starterPackData.getStarterPackType() == BMStarterPackData.TYPE_GOLD_AND_TOKENS)
            {
               _loc2_ = BMScreenSpecialOffersPackageGoldAndTokens;
            }
            else if(_loc3_.starterPackData.getStarterPackType() == BMStarterPackData.TYPE_ITEM_AND_TOKENS)
            {
               _loc2_ = BMScreenSpecialOffersPackageItemAndTokens;
            }
            else
            {
               _loc2_ = BMScreenSpecialOffersPackageMech;
            }
         }
         else
         {
            _loc2_ = BMScreenSpecialOffers;
         }
         return _loc2_;
      }
      
      public function get currentOfferID() : uint
      {
         return this._specialOfferIDs[this._currentOfferSlot];
      }
      
      private function getAnalyticsOfferID() : int
      {
         switch(BMSpecialOffersManager.gi().currentOfferID)
         {
            case BMSpecialOffersManager.STARTER_PACK_ID:
               return dataM.myProfile.starterPackData.packID;
            case BMSpecialOffersManager.GLOBAL_SALE_ID:
               return BMSalesManager.gi().getSaleData().saleID;
            case BMSpecialOffersManager.POST_MYTHICAL_STARTER_PACK_ID:
               return dataM.myProfile.postMythicalStarterPackData.tokenPackageID;
            default:
               return this.currentOfferID;
         }
      }
      
      public function doCurrentAction(param1:String) : void
      {
         var _loc2_:int = 0;
         if(screensM.screensDirector.hasTasks())
         {
            return;
         }
         if(this.currentOfferID == STARTER_PACK_ID)
         {
            _loc2_ = this.getAnalyticsOfferID();
            trackSpecialOffersEvent("Click",param1,_loc2_);
            screensM.screenTransitionsManager.openBuyStarterPack(param1);
            return;
         }
         if(this.currentOfferID == GLOBAL_SALE_ID)
         {
            if(BMSalesManager.gi().isStarterPackSale())
            {
               screensM.screenTransitionsManager.openBuyStarterPack(param1);
               return;
            }
         }
         this.doAction(param1,BMSalesManager.gi().getSaleData().clickTarget,BMSalesManager.gi().getSaleData().clickTargetItemID);
      }
      
      public function doAction(param1:String, param2:uint, param3:uint) : void
      {
         var _loc4_:int = this.getAnalyticsOfferID();
         trackSpecialOffersEvent("Click",param1,_loc4_);
         switch(param2)
         {
            case 0:
               break;
            case 1:
               BMShopManager.gi().showTokens(param1);
               break;
            case 2:
               BMShopManager.gi().showGoldPackages(param1);
               break;
            case 3:
               BMShopManager.gi().showItemBoxes(param1,param3);
               break;
            case 4:
               BMShopManager.gi().showCustomization(param1);
               break;
            case 5:
               BMShopManager.gi().showPremium(param1);
               break;
            case 6:
               if(screensM.isScreenOpened(BMScreensManager.SCR_MAIN_MENU))
               {
                  screensM.screenMainMenu.onCampaignButtonHitSub();
               }
               else
               {
                  screensM.screensDirector.addLocationTask(BMScreensDirectorTask.LOCATION_MAIN_MENU);
                  screensM.screensDirector.addLocationTask(BMScreensDirectorTask.LOCATION_CAMPAIGNS_MENU);
               }
               break;
            case 7:
               screensM.screenTransitionsManager.multiplayerLadderClicked();
               break;
            case 8:
               screensM.screenTransitionsManager.communityNewsClicked();
               break;
            case 9:
               if(screensM.isScreenOpened(BMScreensManager.SCR_MAIN_MENU))
               {
                  screensM.screenMainMenu.showQuestsScreen(2);
               }
               else
               {
                  screensM.screensDirector.addLocationTask(BMScreensDirectorTask.LOCATION_MAIN_MENU);
                  screensM.screensDirector.addLocationTask(BMScreensDirectorTask.LOCATION_QUESTS,{"selectedTab":2});
               }
               break;
            case 10:
               BMShopManager.gi().showMechs(param1);
         }
      }
      
      private function startTimer() : *
      {
         this._resetTimer = new Timer(1000 * SECONDS_PER_SALE,0);
         this._resetTimer.addEventListener(TimerEvent.TIMER,this.resetTimerEvent);
         this._resetTimer.start();
      }
      
      private function resetTimerEvent(param1:Event) : void
      {
         if(this._specialOfferIDs.length <= 1)
         {
            return;
         }
         this._currentOfferSlot = (this._currentOfferSlot + 1) % this._specialOfferIDs.length;
         this.refreshSpecialOffers();
      }
      
      private function stopTimer() : void
      {
         if(this._resetTimer != null)
         {
            this._resetTimer.stop();
            this._resetTimer.removeEventListener(TimerEvent.TIMER,this.resetTimerEvent);
            this._resetTimer = null;
         }
      }
      
      public function offerTimerEnded() : void
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_MULTIPLAYER_LADDER))
         {
            screensM.screenMultiPlayerLadder.refreshSpecialOffers();
         }
      }
      
      public function removeSpecialOffer() : *
      {
         this.stopTimer();
         this._location = null;
         if(screensM.isScreenOpened(BMScreensManager.SCR_SPECIAL_OFFERS))
         {
            screensM.screenSpecialOffers.removeMe();
         }
      }
   }
}

