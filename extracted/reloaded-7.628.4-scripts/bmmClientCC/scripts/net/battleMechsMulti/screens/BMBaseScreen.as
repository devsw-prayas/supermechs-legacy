package net.battleMechsMulti.screens
{
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   import net.battleMechsMulti.utils.BMPubSub;
   
   public class BMBaseScreen extends BMBaseClass
   {
      
      private var _pubSubTokens:Array;
      
      private var _isInteractive:Boolean;
      
      public function BMBaseScreen()
      {
         super();
         this._isInteractive = true;
         this._pubSubTokens = new Array();
      }
      
      public function set isInteractive(param1:Boolean) : void
      {
         this._isInteractive = param1;
      }
      
      public function get isInteractive() : Boolean
      {
         return this._isInteractive;
      }
      
      public function notifyClientDataReloaded() : *
      {
      }
      
      protected function trackButtonClick(param1:String, param2:Number = NaN, ... rest) : *
      {
         dataM.trackEvent(BMDataManager.ANALYTICS_PRIORITY_LOWEST,"ButtonClick",name,param1,param2,rest);
      }
      
      protected function sub(param1:String, param2:Function) : *
      {
         var _loc3_:Number = BMPubSub.sub(param1,param2);
         this._pubSubTokens.push(_loc3_);
      }
      
      public function notifyRemoved() : *
      {
         while(this._pubSubTokens.length > 0)
         {
            BMPubSub.remove(this._pubSubTokens.pop());
         }
      }
   }
}

