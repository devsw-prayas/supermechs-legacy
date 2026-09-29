package net.battleMechsMulti.screens.battleResult
{
   import flash.display.Sprite;
   import net.battleMechsMulti.data.BMRewardData;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.sales.BMSale;
   import net.battleMechsMulti.managers.sales.BMSalesManager;
   import net.battleMechsMulti.screens.BMBaseScreen;
   
   public class BMScreenBattleResultBase extends BMBaseScreen
   {
      
      protected var _gold:Number;
      
      protected var _xp:Number;
      
      protected var _nukes:Number;
      
      protected var _arenaCoins:Number;
      
      protected var _reward:BMRewardData;
      
      public function BMScreenBattleResultBase()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("battleResult");
      }
      
      public function setPrizes(param1:Number, param2:Number, param3:Number, param4:Number, param5:BMRewardData = null) : void
      {
         this._gold = param1;
         this._xp = param2;
         this._nukes = param4;
         this._arenaCoins = param3;
         this._nukes = param4;
         this._reward = param5;
      }
      
      public function refreshScreen() : void
      {
      }
      
      public function get isInNextMissionMode() : Boolean
      {
         return false;
      }
      
      public function onEnterFrameTrigger() : void
      {
      }
      
      public function addSpark(param1:Sprite) : void
      {
      }
      
      public function removeMe() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_BATTLE_RESULT);
      }
      
      public function backClicked() : *
      {
      }
      
      protected function getRewardSaleEffect(param1:uint) : uint
      {
         var _loc2_:BMSale = null;
         if(BMSalesManager.gi().isSaleActive(dataM.currentTime))
         {
            _loc2_ = BMSalesManager.gi().getSaleData();
            if(_loc2_.saleType == BMSale.SALE_TYPE_REWARD_INCREASE && _loc2_.saleStoreSection == param1)
            {
               return _loc2_.saleEffect;
            }
         }
         return 0;
      }
   }
}

