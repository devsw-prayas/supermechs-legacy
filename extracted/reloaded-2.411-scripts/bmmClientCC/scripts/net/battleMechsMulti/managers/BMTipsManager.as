package net.battleMechsMulti.managers
{
   import net.battleMechsMulti.mobiles.BMBaseClass;
   import net.tacticsoft.utils.RandomUtils;
   
   public class BMTipsManager extends BMBaseClass
   {
      
      private static var _instance:BMTipsManager;
      
      private var _lastTipSlot:Number = -1;
      
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
         _instance.generateSingletonClassesPointers("");
      }
      
      public function getTip(param1:Boolean = true) : String
      {
         var _loc2_:Number = this._lastTipSlot;
         while(_loc2_ == this._lastTipSlot)
         {
            _loc2_ = RandomUtils.chooseRandomIndex(dataM.tipsDB);
         }
         this._lastTipSlot = _loc2_;
         var _loc3_:String = dataM.tipsDB[_loc2_];
         if(param1)
         {
            _loc3_ = "Tip: " + _loc3_;
         }
         return _loc3_;
      }
   }
}

