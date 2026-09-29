package net.battleMechsMulti.managers
{
   import flash.net.SharedObject;
   import net.battleMechsMulti.session.BMDomainResolver;
   import net.battleMechsMulti.session.BMPlatformUtils;
   import net.battlegate.events.BGSocketEvent;
   import net.tacticsoft.global.BMMClientFlashVars;
   import net.tacticsoft.managers.BMMSocketManager;
   
   public class BMGuestABTestManager
   {
      
      private static var guestSocketM:BMMSocketManager;
      
      private static const SHARED_OBJECT_NAME:String = "BMGuestABTestManager";
      
      public function BMGuestABTestManager()
      {
         super();
      }
      
      private static function doABTestGet(param1:*) : void
      {
         var lastDevice:String = null;
         var $event:* = param1;
         lastDevice = "2";
         var minLimit:uint = uint.MAX_VALUE / 2;
         var maxLimit:uint = uint.MAX_VALUE;
         var range:uint = maxLimit - minLimit;
         var so:SharedObject = SharedObject.getLocal(SHARED_OBJECT_NAME);
         var id:uint = uint(so.data.id);
         if(!id)
         {
            id = Math.ceil(Math.random() * range) + minLimit;
            so.data.id = id;
            try
            {
               so.flush();
            }
            catch(err:Error)
            {
               TsLogger.log("BMGuestABTestManager Error: shared object couldn\'t flush");
            }
         }
         guestSocketM.sendCommand("BMM_GUEST_GET_AB_TEST_DEFINITION",{
            "version":BMExternalAssetsManager.getInstance().getVersionNumber(),
            "platform":BMPlatformUtils.sourcePlatform,
            "lastDevice":lastDevice,
            "id":id
         });
      }
      
      private static function onABTestGotData(param1:*) : void
      {
         var so:SharedObject;
         var $event:* = param1;
         var data:Object = guestSocketM.bgSocket.dataStack.pop().data;
         guestSocketM.close();
         so = SharedObject.getLocal(SHARED_OBJECT_NAME);
         so.data.exists = true;
         so.data.abTestFlags = data.abTestFlags;
         so.data.definitionID = data.definitionID;
         try
         {
            so.flush();
         }
         catch(err:Error)
         {
            TsLogger.log("BMGuestABTestManager Error: shared object couldn\'t flush");
         }
         TsLogger.log("Got bucket: " + so.data.definitionID);
      }
      
      public static function fetchData() : void
      {
         var _loc1_:SharedObject = SharedObject.getLocal(SHARED_OBJECT_NAME);
         if(_loc1_.data.exists)
         {
            return;
         }
         guestSocketM = new BMMSocketManager(false);
         guestSocketM.addEventListener(BGSocketEvent.CONNECTED,doABTestGet);
         guestSocketM.addEventListener(BGSocketEvent.DATA_AVAILABLE,onABTestGotData);
         var _loc2_:BMMClientFlashVars = new BMMClientFlashVars(GlobalAccess.stage);
         guestSocketM.connect(BMDomainResolver.getDomain(true),_loc2_.authServicePort);
      }
      
      public static function hasData() : Boolean
      {
         var _loc1_:SharedObject = SharedObject.getLocal(SHARED_OBJECT_NAME);
         return Boolean(_loc1_.data.exists);
      }
      
      public static function hasKey(param1:String) : Boolean
      {
         var _loc2_:SharedObject = SharedObject.getLocal(SHARED_OBJECT_NAME);
         return _loc2_.data.abTestFlags.hasOwnProperty(param1);
      }
      
      public static function getValue(param1:String) : *
      {
         var _loc2_:SharedObject = SharedObject.getLocal(SHARED_OBJECT_NAME);
         return _loc2_.data.abTestFlags[param1];
      }
      
      public static function getDefinitionID() : int
      {
         var _loc1_:SharedObject = SharedObject.getLocal(SHARED_OBJECT_NAME);
         return _loc1_.data.definitionID;
      }
      
      public static function clear() : void
      {
         var _loc1_:SharedObject = SharedObject.getLocal(SHARED_OBJECT_NAME);
         _loc1_.clear();
      }
   }
}

