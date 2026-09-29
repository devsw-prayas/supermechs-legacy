package net.battleMechsMulti.screens.shop
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.mobiles.BMTileListItem;
   import net.battleMechsMulti.mobiles.timer.BMTimer;
   
   public class BMScreenShopItemInfoWithExtraChance extends BMScreenShopItemInfo
   {
      
      public var txtExtraChance:TextField;
      
      public var mcExtraChanceItemsHolder:Sprite;
      
      public var mcTimer:BMTimer;
      
      public function BMScreenShopItemInfoWithExtraChance()
      {
         super();
      }
      
      override public function initItemsExtraChance() : void
      {
         updateTextAndFormat(this.txtExtraChance,getSpecificText("globalShop_extraChance") + ":");
         this.addItems();
         this.mcTimer.initialize(this.timerProvider,this.timerEnded);
      }
      
      private function timerProvider() : uint
      {
         return dataM.itemsExtraChanceData.timeLeft;
      }
      
      private function timerEnded() : void
      {
         removeMe();
      }
      
      private function addItems() : void
      {
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:BMTileListItem = null;
         var _loc8_:Number = NaN;
         var _loc1_:BMShopItemViewData = getShopItemData();
         var _loc2_:uint = _loc1_.extraChanceItemIDs.length;
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = uint(_loc1_.extraChanceItemIDs[_loc3_]);
            _loc5_ = 70;
            _loc6_ = 8;
            _loc7_ = dataM.createItemTileListItem(_loc4_,_loc5_,0,false,this.itemClicked,null,null,true);
            _loc8_ = 0;
            if(_loc2_ == 1)
            {
               _loc8_ -= _loc5_ / 2;
            }
            else
            {
               _loc8_ -= (_loc2_ * _loc5_ + (_loc2_ - 1) * _loc6_) / 2;
               _loc8_ = _loc8_ + _loc3_ * _loc5_;
               if(_loc3_ > 0)
               {
                  _loc8_ += _loc3_ * _loc6_;
               }
            }
            _loc7_.x = _loc8_;
            this.mcExtraChanceItemsHolder.addChild(_loc7_);
            _loc3_++;
         }
      }
      
      private function itemClicked(param1:uint, param2:uint) : void
      {
         screensM.addScreen(BMScreensManager.SCR_CONTENT_PACK_ITEM_INFO);
         screensM.screenContentPackItemInfo.showItemInfo(param2,false);
      }
   }
}

