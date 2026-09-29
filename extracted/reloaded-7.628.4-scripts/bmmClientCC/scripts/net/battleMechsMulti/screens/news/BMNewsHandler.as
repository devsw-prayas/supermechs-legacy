package net.battleMechsMulti.screens.news
{
   import net.battleMechsMulti.managers.sales.BMSalesManager;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   
   public class BMNewsHandler extends BMBaseClass
   {
      
      internal static const NEWS_TYPE_STICKY:uint = 1;
      
      internal static const NEWS_TYPE_REGULAR:uint = 2;
      
      internal static const NEWS_SUB_TYPE_REGULAR:uint = 1;
      
      internal static const NEWS_SUB_TYPE_SPECIAL_SALE:uint = 2;
      
      internal static const NEWS_SUB_TYPE_WEB_VIEW:uint = 3;
      
      internal static const NEWS_SUB_TYPE_SEASON_RESULTS:uint = 4;
      
      internal static const NEWS_CATEGORY_IMAGE:uint = 1;
      
      private var _stickyNewsItems:Array;
      
      private var _regularNewsItems:Array;
      
      private var _oldestRegularNewItemSlot:Number = -1;
      
      private var _newsDisplayedThisSession:Boolean = false;
      
      public function BMNewsHandler()
      {
         super();
         generateSingletonClassesPointers("");
      }
      
      public function setNews(param1:Array, param2:Object) : void
      {
         var _loc5_:BMNewsItemData = null;
         this._stickyNewsItems = new Array();
         this._regularNewsItems = new Array();
         var _loc3_:BMNewsItemData = this.getSaleItemData(param2);
         if(_loc3_ != null)
         {
            this._stickyNewsItems.push(_loc3_);
         }
         var _loc4_:uint = 0;
         while(_loc4_ < param1.length)
         {
            _loc5_ = new BMNewsItemData(param1[_loc4_]);
            if(this.correctPlatform(_loc5_.platform) != false)
            {
               if(!this.isItemOutdated(_loc5_))
               {
                  if(_loc5_.sticky)
                  {
                     this._stickyNewsItems.push(_loc5_);
                  }
                  else
                  {
                     if(dataM["player" + dataM.ONLINE_PLAYER_ID + "Profile"].lastNewsID < _loc5_.startDate)
                     {
                        this._oldestRegularNewItemSlot = _loc4_;
                     }
                     this._regularNewsItems.push(_loc5_);
                  }
               }
            }
            _loc4_++;
         }
      }
      
      private function getSaleItemData(param1:Object) : BMNewsItemData
      {
         if(param1 == null)
         {
            return null;
         }
         if(BMSalesManager.gi().isSaleActive(dataM.currentTime,-1,true) == false)
         {
            return null;
         }
         var _loc2_:Object = new Object();
         _loc2_.category = NEWS_CATEGORY_IMAGE;
         _loc2_.startDate = param1.startDate;
         _loc2_.duration = param1.duration;
         _loc2_.imageUrl = param1.newsImageLink;
         _loc2_.clickTarget = param1.clickTarget;
         _loc2_.clickTargetItemID = param1.clickTargetItemID;
         return new BMNewsItemData(_loc2_,true);
      }
      
      public function setsale() : void
      {
      }
      
      private function correctPlatform(param1:uint) : Boolean
      {
         switch(param1)
         {
            case 0:
               return true;
            case 1:
               if(false)
               {
                  return true;
               }
               break;
            case 2:
               break;
            case 3:
               return true;
         }
         return false;
      }
      
      public function isNewsItemNew(param1:uint) : Boolean
      {
         if(param1 <= this._oldestRegularNewItemSlot)
         {
            return true;
         }
         return false;
      }
      
      private function removeRegularOutdatedItems() : void
      {
         var _loc1_:Number = this._regularNewsItems.length - 1;
         while(_loc1_ >= 0)
         {
            if(this.isItemOutdated(this._regularNewsItems[_loc1_]))
            {
               if(_loc1_ <= this._oldestRegularNewItemSlot)
               {
                  --this._oldestRegularNewItemSlot;
               }
               this._regularNewsItems.splice(_loc1_,1);
            }
            _loc1_--;
         }
      }
      
      private function isItemOutdated(param1:BMNewsItemData) : Boolean
      {
         if(param1.startDate > dataM.currentTime)
         {
            return true;
         }
         if(param1.startDate + param1.duration < dataM.currentTime)
         {
            return true;
         }
         return false;
      }
      
      public function hasNewNews(param1:Boolean = false) : Boolean
      {
         if(tutorialM.isTutorialActive())
         {
            return false;
         }
         if(this._newsDisplayedThisSession)
         {
            return false;
         }
         if(param1)
         {
            return this._oldestRegularNewItemSlot > -1;
         }
         return this._oldestRegularNewItemSlot > -1 || this._stickyNewsItems.length > 0;
      }
      
      public function hasNews() : Boolean
      {
         this.removeRegularOutdatedItems();
         if(this._regularNewsItems.length > 0)
         {
            return true;
         }
         if(this._stickyNewsItems.length > 0)
         {
            return true;
         }
         return false;
      }
      
      public function getNews(param1:Boolean = false) : Array
      {
         if(this._oldestRegularNewItemSlot > -1)
         {
            remoteM.socketM.lobby_setLastNewsID();
         }
         if(tutorialM.isTutorialActive())
         {
            return [new Array(),new Array()];
         }
         if(this._newsDisplayedThisSession == false && this._oldestRegularNewItemSlot == -1 && param1 == false)
         {
            return [this._stickyNewsItems,new Array()];
         }
         if(this._newsDisplayedThisSession == false || this._oldestRegularNewItemSlot > -1 || param1)
         {
            return [this._stickyNewsItems,this._regularNewsItems];
         }
         return [this._stickyNewsItems,new Array()];
      }
      
      public function get newsDisplayedThisSession() : Boolean
      {
         return this._newsDisplayedThisSession;
      }
      
      public function newsDisplayed() : void
      {
         this._oldestRegularNewItemSlot = -1;
         this._newsDisplayedThisSession = true;
      }
      
      public function resetNewsDisplayedThisSession() : void
      {
         this._newsDisplayedThisSession = false;
      }
   }
}

