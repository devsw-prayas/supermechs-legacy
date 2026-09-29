package net.battleMechsMulti.screens.baseBuilding
{
   public class BMBaseBuildingStructureData
   {
      
      public static const COLLECT_TYPE_NONE:uint = 0;
      
      public static const COLLECT_TYPE_GOLD_0:uint = 10;
      
      public static const COLLECT_TYPE_GOLD_1:uint = 11;
      
      public static const COLLECT_TYPE_GOLD_2:uint = 12;
      
      public static const COLLECT_TYPE_GOLD_3:uint = 13;
      
      public static const COLLECT_TYPE_GOLD_FULL:uint = 14;
      
      public static const COLLECT_TYPE_ITEMS_1:uint = 20;
      
      public static const COLLECT_TYPE_ITEMS_2:uint = 21;
      
      public static const COLLECT_TYPE_ITEMS_3:uint = 22;
      
      public static const COLLECT_TYPE_ITEMS_4_PLUS:uint = 23;
      
      private var _position:uint;
      
      private var _underConstruction:Boolean;
      
      private var _structureViewFrame:uint;
      
      private var _collectType:uint;
      
      private var _canUpgrade:Boolean;
      
      private var _highlightUpgrade:Boolean;
      
      private var _upgradeDisabled:Boolean;
      
      private var _level:uint;
      
      private var _canBuild:Boolean;
      
      private var _buildDisabled:Boolean;
      
      private var _canProduce:Boolean;
      
      private var _isIdle:Boolean;
      
      private var _produceDisabled:Boolean;
      
      private var _hasInfo:Boolean;
      
      private var _canSkip:Boolean;
      
      private var _skipCostTokensProvider:Function;
      
      private var _timerProvider:Function;
      
      public function BMBaseBuildingStructureData(param1:uint, param2:uint, param3:uint, param4:Boolean, param5:Boolean, param6:Boolean, param7:Boolean, param8:Boolean, param9:Boolean, param10:Boolean, param11:Boolean, param12:Boolean, param13:Boolean, param14:Function, param15:uint, param16:Boolean, param17:Function)
      {
         super();
         this._position = param1;
         this._underConstruction = param16;
         this._structureViewFrame = param2;
         this._collectType = param3;
         this._canUpgrade = param4;
         this._highlightUpgrade = param5;
         this._upgradeDisabled = param6;
         this._canBuild = param7;
         this._buildDisabled = param8;
         this._canProduce = param9;
         this._isIdle = param10;
         this._produceDisabled = param11;
         this._hasInfo = param12;
         this._canSkip = param13;
         this._skipCostTokensProvider = param14;
         this._level = param15;
         this._timerProvider = param17;
      }
      
      private function get _canCollect() : Boolean
      {
         return this._collectType != COLLECT_TYPE_NONE;
      }
      
      public function get position() : uint
      {
         return this._position;
      }
      
      public function get isUnderConstruction() : Boolean
      {
         return this._underConstruction;
      }
      
      public function get structureViewFrame() : uint
      {
         return this._structureViewFrame;
      }
      
      public function get canCollect() : Boolean
      {
         return this._canCollect;
      }
      
      public function get canCollectGold() : Boolean
      {
         return this._canCollect && this._collectType >= COLLECT_TYPE_GOLD_0 && this._collectType <= COLLECT_TYPE_GOLD_FULL;
      }
      
      public function get canCollectItems() : Boolean
      {
         return this._canCollect && this._collectType >= COLLECT_TYPE_ITEMS_1 && this._collectType <= COLLECT_TYPE_ITEMS_4_PLUS;
      }
      
      public function get collectType() : uint
      {
         return this._collectType;
      }
      
      public function get canUpgrade() : Boolean
      {
         return this._canUpgrade;
      }
      
      public function get upgradeDisabled() : Boolean
      {
         return this._upgradeDisabled;
      }
      
      public function get level() : uint
      {
         return this._level;
      }
      
      public function get canBuild() : Boolean
      {
         return this._canBuild;
      }
      
      public function get buildDisabled() : Boolean
      {
         return this._buildDisabled;
      }
      
      public function get canProduce() : Boolean
      {
         return this._canProduce;
      }
      
      public function get isIdle() : Boolean
      {
         return this._isIdle;
      }
      
      public function get produceDisabled() : Boolean
      {
         return this._produceDisabled;
      }
      
      public function get hasInfo() : Boolean
      {
         return this._hasInfo;
      }
      
      public function get canSkip() : Boolean
      {
         return this._canSkip;
      }
      
      public function get skipCostTokens() : uint
      {
         if(this._skipCostTokensProvider != null)
         {
            return this._skipCostTokensProvider(this._position);
         }
         return 0;
      }
      
      public function get timerProvider() : Function
      {
         return this._timerProvider;
      }
      
      public function get highlightUpgrade() : Boolean
      {
         return this._highlightUpgrade;
      }
   }
}

