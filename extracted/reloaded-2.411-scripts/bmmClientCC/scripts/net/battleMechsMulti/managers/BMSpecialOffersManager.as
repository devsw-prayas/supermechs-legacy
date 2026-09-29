package net.battleMechsMulti.managers
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import net.battleMechsMulti.managers.sales.BMSalesManager;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.screens.specialOffers.BMScreenSpecialOffers;
   import net.battleMechsMulti.screens.specialOffers.BMScreenSpecialOffersPackageBoxes;
   import net.battleMechsMulti.screens.specialOffers.BMScreenSpecialOffersPackageMech;
   import net.battleMechsMulti.screens.specialOffers.BMScreenSpecialOffersSmall;
   
   public class BMSpecialOffersManager extends BMBaseClass
   {
      
      private static var _inst:BMSpecialOffersManager;
      
      public static const STARTER_PACK_ID:uint = 100;
      
      public static const GLOBAL_SALE_ID:uint = 101;
      
      private static const SECONDS_PER_SALE:uint = 10;
      
      public var specialOffersResetTime:Number = 0;
      
      private var _resetTimer:Timer;
      
      private var _specialOfferIDs:Array = new Array();
      
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
         BMDataManager.getInstance().trackEvent("SpecialOffers",param1,param2,param3);
      }
      
      public function refreshSpecialOffersBoostIDs() : *
      {
         TsLogger.log("BMSpecialOffersManager::refreshSpecialOffersBoostIDs");
         this._specialOfferIDs = new Array();
         if(dataM.isStarterPackActive())
         {
            this._specialOfferIDs.push(STARTER_PACK_ID);
         }
         if(BMSalesManager.gi().isSaleActive(dataM.currentTime))
         {
            this._specialOfferIDs.push(GLOBAL_SALE_ID);
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
         return this._specialOfferIDs != null && this._specialOfferIDs.length > 0;
      }
      
      public function showBigBanner(param1:Sprite, param2:Number = 1) : void
      {
         this.showSpecialOffers(param1,param2,true);
      }
      
      public function showSmallBanner(param1:Sprite) : void
      {
         this.showSpecialOffers(param1,1,false);
      }
      
      private function showSpecialOffers(param1:Sprite, param2:Number = 1, param3:* = true) : void
      {
         if(this.hasSpecialOffers())
         {
            this._isBigBanner = param3;
            this._location = new Point(param1.x,param1.y);
            this._scale = param2;
            this.refreshSpecialOffers();
            this.stopTimer();
            this.startTimer();
         }
      }
      
      private function refreshSpecialOffers() : *
      {
         var _loc1_:Class = null;
         if(this._location != null)
         {
            if(dataM.isStarterPackActive())
            {
               dataM.updateStarterPackActive();
            }
            this.refreshSpecialOffersBoostIDs();
            if(!this.hasSpecialOffers())
            {
               return;
            }
            _loc1_ = this.getBanner(this.currentOfferID);
            if(screensM.screenSpecialOffers is _loc1_ == false)
            {
               if(screensM.screenSpecialOffers != null)
               {
                  screensM.screenSpecialOffers.removeMe();
               }
               screensM.addScreen("screenSpecialOffers",true,_loc1_);
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
         else
         {
            trace("WARNING: specialOffersManager called refreshSpecialOffers when not supposed to");
         }
      }
      
      private function getBanner(param1:uint) : Class
      {
         var _loc2_:Class = null;
         var _loc3_:BMPlayerProfile = null;
         if(!this._isBigBanner)
         {
            return BMScreenSpecialOffersSmall;
         }
         switch(param1)
         {
            case STARTER_PACK_ID:
               _loc3_ = dataM.myProfile;
               if(_loc3_.starterPackData.boostID > 0)
               {
                  _loc2_ = BMScreenSpecialOffersPackageBoxes;
               }
               else
               {
                  _loc2_ = BMScreenSpecialOffersPackageMech;
               }
               break;
            case GLOBAL_SALE_ID:
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
         var _loc1_:BMPlayerProfile = null;
         var _loc2_:int = 0;
         if(this.currentOfferID == STARTER_PACK_ID)
         {
            _loc1_ = BMDataManager.getInstance().myProfile;
            return int(_loc1_.starterPackData.tokenPackageID);
         }
         if(this.currentOfferID == GLOBAL_SALE_ID)
         {
            return BMSalesManager.gi().getSaleData().saleID;
         }
         return this.currentOfferID;
      }
      
      public function doCurrentAction(param1:String) : void
      {
         var _loc2_:int = this.getAnalyticsOfferID();
         trace("Analytics Offer ID : " + _loc2_);
         trackSpecialOffersEvent("Click",param1,_loc2_);
         if(this.currentOfferID == STARTER_PACK_ID)
         {
            screensM.screenNewMenu.openBuyStarterPack(param1);
            return;
         }
         switch(BMSalesManager.gi().getSaleData().clickTarget)
         {
            case 0:
               break;
            case 1:
               BMShopManager.gi().showSpecialBoxses(param1,BMSalesManager.gi().getSaleData().clickTargetItemID);
               break;
            case 2:
               BMShopManager.gi().showPowerKits(param1);
               break;
            case 3:
               BMShopManager.gi().showSpecialOffers(param1);
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
         if(screensM.isScreenOpened("screenMultiPlayerLadder"))
         {
            screensM.screenMultiPlayerLadder.refreshSpecialOffers();
         }
      }
      
      public function removeSpecialOffer() : *
      {
         this.stopTimer();
         this._location = null;
         if(screensM.isScreenOpened("screenSpecialOffers"))
         {
            screensM.screenSpecialOffers.removeMe();
         }
      }
   }
}

