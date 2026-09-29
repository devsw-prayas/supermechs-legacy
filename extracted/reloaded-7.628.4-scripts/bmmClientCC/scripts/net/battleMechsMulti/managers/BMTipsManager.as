package net.battleMechsMulti.managers
{
   import net.battleMechsMulti.utils.FeatureFlags;
   import net.tacticsoft.utils.RandomUtils;
   
   public class BMTipsManager
   {
      
      private static var _instance:BMTipsManager;
      
      public static const TIP_TYPE_DEFAULT:uint = 1;
      
      public static const TIP_TYPE_PVE_LOSS:uint = 2;
      
      private var _lastTipSlot:Number = -1;
      
      private var _lastTipType:uint = 1;
      
      private var _defaultTipsDB:Array = new Array();
      
      private var _pveLossTipsDB:Array = new Array();
      
      public function BMTipsManager()
      {
         super();
      }
      
      public static function getInstance() : BMTipsManager
      {
         if(_instance == null)
         {
            initialize();
         }
         return _instance;
      }
      
      private static function initialize() : void
      {
         _instance = new BMTipsManager();
      }
      
      public function getTip(param1:Boolean = true, param2:uint = 1) : String
      {
         if(FeatureFlags.ENABLE_LOSING_TIPS == false)
         {
            param2 = TIP_TYPE_DEFAULT;
         }
         this.generateTipsDB();
         if(this._lastTipType != param2)
         {
            this._lastTipSlot = -1;
         }
         this._lastTipType = param2;
         var _loc3_:Number = this._lastTipSlot;
         var _loc4_:Array = this._defaultTipsDB;
         if(param2 == TIP_TYPE_PVE_LOSS)
         {
            _loc4_ = this._pveLossTipsDB;
         }
         while(_loc3_ == this._lastTipSlot)
         {
            _loc3_ = RandomUtils.chooseRandomIndex(_loc4_[BMDataManager.getInstance().languageID]);
         }
         this._lastTipSlot = _loc3_;
         var _loc5_:String = _loc4_[BMDataManager.getInstance().languageID][_loc3_];
         if(param1)
         {
            _loc5_ = "Tip: " + _loc5_;
         }
         return _loc5_;
      }
      
      private function generateTipsDB() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:String = null;
         if(this._defaultTipsDB[BMDataManager.getInstance().languageID] != null)
         {
            return;
         }
         this._defaultTipsDB[BMDataManager.getInstance().languageID] = new Array();
         this._pveLossTipsDB[BMDataManager.getInstance().languageID] = new Array();
         _loc1_ = 1;
         while(_loc1_ <= 100)
         {
            _loc2_ = BMLanguageManager.getInstance().getText("tip_" + String(_loc1_));
            if(_loc2_ != "")
            {
               this._defaultTipsDB[BMDataManager.getInstance().languageID].push(_loc2_);
            }
            _loc1_++;
         }
         _loc1_ = 1;
         while(_loc1_ <= 100)
         {
            _loc2_ = BMLanguageManager.getInstance().getText("tipPVELoss_" + String(_loc1_));
            if(_loc2_ != "")
            {
               this._pveLossTipsDB[BMDataManager.getInstance().languageID].push(_loc2_);
            }
            _loc1_++;
         }
         if(false)
         {
            _loc1_ = 1;
            while(_loc1_ <= 100)
            {
               _loc2_ = BMLanguageManager.getInstance().getText("tipWeb_" + String(_loc1_));
               if(_loc2_ != "")
               {
                  this._defaultTipsDB[BMDataManager.getInstance().languageID].push(_loc2_);
               }
               _loc1_++;
            }
         }
      }
   }
}

