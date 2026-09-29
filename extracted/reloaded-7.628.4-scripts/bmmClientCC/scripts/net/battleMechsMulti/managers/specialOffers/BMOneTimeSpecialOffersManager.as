package net.battleMechsMulti.managers.specialOffers
{
   import flash.net.SharedObject;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.singlePlayer.BMSinglePlayerManager;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   import net.battleMechsMulti.utils.FeatureFlags;
   
   public class BMOneTimeSpecialOffersManager extends BMBaseClass
   {
      
      private static var _inst:BMOneTimeSpecialOffersManager;
      
      private static const OFFER_INDEX_CAMPAIGN:int = -1;
      
      private static const OFFER_INDEX_LONG_WAIT:int = 3;
      
      private var _shortWaitMilliSec:int = 30000;
      
      private var _longWaitMilliSec:int = 60000;
      
      private var _userEnterWorkshopTimesBeforeShow:int = 2;
      
      private var _onTimeOffers:Vector.<OneTimeSpecialOffersData>;
      
      private var _sharedObject:SharedObject;
      
      private var debugIndex:int = 0;
      
      public function BMOneTimeSpecialOffersManager()
      {
         super();
         generateSingletonClassesPointers("");
         this.init();
      }
      
      public static function getInstance() : BMOneTimeSpecialOffersManager
      {
         if(_inst == null)
         {
            _inst = new BMOneTimeSpecialOffersManager();
         }
         return _inst;
      }
      
      public static function gi() : BMOneTimeSpecialOffersManager
      {
         return getInstance();
      }
      
      private function init() : *
      {
         this._sharedObject = SharedObject.getLocal("BMMOneTimeSpecialOffersSO","/");
         if(!this._sharedObject.data.offerIndex)
         {
            this.offerIndex = OFFER_INDEX_CAMPAIGN;
         }
      }
      
      public function parseData(param1:Object) : void
      {
         var _loc3_:OneTimeSpecialOffersData = null;
         this._shortWaitMilliSec = param1.shortWaitSec * 1000;
         this._longWaitMilliSec = param1.longWaitSec * 1000;
         this._userEnterWorkshopTimesBeforeShow = param1.userEnterWorkshopTimesBeforeShow;
         this._onTimeOffers = new Vector.<OneTimeSpecialOffersData>();
         var _loc2_:int = 0;
         while(_loc2_ < param1.offers.length)
         {
            _loc3_ = new OneTimeSpecialOffersData();
            _loc3_.id = param1.offers[_loc2_].id;
            _loc3_.starterPackId = param1.offers[_loc2_].starterPackId;
            _loc3_.text = param1.offers[_loc2_].text;
            this._onTimeOffers.push(_loc3_);
            _loc2_++;
         }
      }
      
      private function isDisplayingOffersAllowed() : Boolean
      {
         if(screensM.screensDirector.hasTasks())
         {
            return false;
         }
         if(FeatureFlags.BLOCK_ON_TIME_OFFERS)
         {
            return false;
         }
         if(dataM.myProfile.pendingStarterPackMech > 0)
         {
            return false;
         }
         if(dataM.isStarterPackActive() || tutorialM.isTutorialActive())
         {
            return false;
         }
         return true;
      }
      
      public function tryShowOfferInCampaign() : Boolean
      {
         if(this.isDisplayingOffersAllowed() == false)
         {
            return false;
         }
         if(this.hasOfferInCampaign())
         {
            this.showOffer();
            return true;
         }
         return false;
      }
      
      public function tryShowOfferInWorkshop() : void
      {
         if(this.isDisplayingOffersAllowed() == false)
         {
            return;
         }
         if(this.hasOfferInWorkshop())
         {
            this.showOffer();
         }
         else
         {
            ++this.workshopEnterCount;
         }
      }
      
      private function hasOfferInCampaign() : Boolean
      {
         var _loc1_:uint = uint(BMSinglePlayerManager.STORY_ID_CAMPAIGN_1V1);
         return this.offerIndex == OFFER_INDEX_CAMPAIGN && dataM.starterPack_goBackToScreen != "singlePlayer" && dataM.singlePlayerM.didCompleteSlot(_loc1_,5,0);
      }
      
      private function hasOfferInWorkshop() : Boolean
      {
         return this.offerIndex != OFFER_INDEX_CAMPAIGN && new Date().time > this.timerEnd && (this.workshopEnterCount >= this._userEnterWorkshopTimesBeforeShow || this.offerIndex == OFFER_INDEX_LONG_WAIT);
      }
      
      private function showOffer() : void
      {
         this.workshopEnterCount = 0;
         var _loc1_:OneTimeSpecialOffersData = this.calcNextOffer();
         if(_loc1_ == null)
         {
            TsLogger.log("BMOneTimeSpecialOffersManager::showOffer ERROR cannot find any offers for SpentSegment:" + this.getSpentSegment());
            return;
         }
         TsLogger.log("BMOneTimeSpecialOffersManager::showOffer segmentId:" + _loc1_.id);
         screensM.addScreen(BMScreensManager.SCR_ONE_TIME_SPECIAL_OFFERS);
         screensM.screenOneTimeSpecialOffers.setData(_loc1_);
      }
      
      private function calcNextOffer() : OneTimeSpecialOffersData
      {
         var _loc1_:OneTimeSpecialOffersData = null;
         var _loc4_:String = null;
         var _loc2_:int = this.offerIndex;
         var _loc3_:int = 0;
         while(true)
         {
            if(_loc2_ == OFFER_INDEX_CAMPAIGN || _loc2_ == OFFER_INDEX_LONG_WAIT)
            {
               _loc2_ = 0;
            }
            if(_loc2_ < 2)
            {
               _loc4_ = this.getSpentSegment() + "-" + (_loc2_ + 1);
               this.timerEnd = new Date().time + this._shortWaitMilliSec;
               _loc2_++;
            }
            else
            {
               _loc4_ = Math.random() > 0.5 ? "5-1" : "5-2";
               this.timerEnd = new Date().time + this._longWaitMilliSec;
               _loc2_ = OFFER_INDEX_LONG_WAIT;
            }
            _loc1_ = this.getOfferByID(_loc4_);
            if(_loc3_ > 10 && _loc1_ == null)
            {
               break;
            }
            if(_loc1_ != null)
            {
               this.offerIndex = _loc2_;
               return _loc1_;
            }
         }
         this.timerEnd = new Date().time + this._shortWaitMilliSec;
         return null;
      }
      
      private function getOfferByID(param1:String) : OneTimeSpecialOffersData
      {
         var _loc2_:int = 0;
         while(_loc2_ < this._onTimeOffers.length)
         {
            if(this._onTimeOffers[_loc2_].id == param1)
            {
               return this._onTimeOffers[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public function debugShowOffer() : void
      {
         TsLogger.log("BMOneTimeSpecialOffersManager::debugShowOffer " + this._onTimeOffers[this.debugIndex].id);
         screensM.addScreen(BMScreensManager.SCR_ONE_TIME_SPECIAL_OFFERS);
         screensM.screenOneTimeSpecialOffers.setData(this._onTimeOffers[this.debugIndex]);
         ++this.debugIndex;
         if(this.debugIndex == this._onTimeOffers.length)
         {
            this.debugIndex = 0;
         }
      }
      
      private function getSpentSegment() : int
      {
         var _loc1_:Number = dataM.estimatedDollarsSpent();
         if(_loc1_ == 0)
         {
            return 1;
         }
         if(_loc1_ < 50)
         {
            return 2;
         }
         if(_loc1_ < 100)
         {
            return 3;
         }
         return 4;
      }
      
      public function get timerEnd() : Number
      {
         return this._sharedObject.data.timerEnd;
      }
      
      public function set timerEnd(param1:Number) : void
      {
         var val:Number = param1;
         this._sharedObject.data.timerEnd = val;
         try
         {
            this._sharedObject.flush();
         }
         catch(err:Error)
         {
            TsLogger.log("BMOneTimeSpecialOffersManager Error: shared object couldn\'t flush");
         }
      }
      
      public function get workshopEnterCount() : int
      {
         return this._sharedObject.data.workshopEnterCount;
      }
      
      public function set workshopEnterCount(param1:int) : void
      {
         var val:int = param1;
         this._sharedObject.data.workshopEnterCount = val;
         try
         {
            this._sharedObject.flush();
         }
         catch(err:Error)
         {
            TsLogger.log("BMOneTimeSpecialOffersManager Error: shared object couldn\'t flush");
         }
      }
      
      public function get offerIndex() : int
      {
         return this._sharedObject.data.offerIndex;
      }
      
      public function set offerIndex(param1:int) : void
      {
         var val:int = param1;
         this._sharedObject.data.offerIndex = val;
         try
         {
            this._sharedObject.flush();
         }
         catch(err:Error)
         {
            TsLogger.log("BMOneTimeSpecialOffersManager Error: shared object couldn\'t flush");
         }
      }
   }
}

