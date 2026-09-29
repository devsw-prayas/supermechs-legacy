package net.battleMechsMulti.data
{
   public class ItemCache
   {
      
      private static var _instance:ItemCache = null;
      
      private const _itemsKey:* = "items";
      
      private const _versionKey:* = "version";
      
      private var _storage:Storage;
      
      private var _versionSaved:String = null;
      
      public function ItemCache()
      {
         super();
      }
      
      public static function gi() : ItemCache
      {
         if(_instance == null)
         {
            _instance = new ItemCache();
            _instance.init();
         }
         return _instance;
      }
      
      private function init() : void
      {
         this._storage = new Storage("net/battleMechsMulti/data/ItemCache");
      }
      
      public function setItems(param1:String, param2:Object) : void
      {
         this._storage.setItem(this._versionKey,param1);
         this._storage.setItem(this._itemsKey,param2);
         this._storage.flush();
         this._versionSaved = null;
         TsLogger.log("ItemCache :: setItems settings version to " + param1);
      }
      
      public function getItems() : Object
      {
         return this._storage.getItem(this._itemsKey);
      }
      
      public function getVersion() : String
      {
         var _loc3_:* = undefined;
         if(this._versionSaved != null)
         {
            return this._versionSaved;
         }
         var _loc1_:String = String(this._storage.getItem(this._versionKey));
         if(!_loc1_)
         {
            TsLogger.log("ItemCache :: getVersion mismatch: itemCacheVersion " + _loc1_);
            return null;
         }
         var _loc2_:Object = this.getItems();
         if(!_loc2_)
         {
            TsLogger.log("ItemCache :: getVersion items false: " + _loc2_);
            return null;
         }
         var _loc4_:int = 0;
         var _loc5_:* = _loc2_;
         for(_loc3_ in _loc5_)
         {
            TsLogger.log("ItemCache :: getVersion hit version: " + _loc1_);
            this._versionSaved = _loc1_;
            return this._versionSaved;
         }
         TsLogger.log("ItemCache :: getVersion no items");
         return null;
      }
   }
}

import flash.external.ExternalInterface;
import net.battleMechsMulti.data.Serializer;

class Storage
{
   
   private var _name:String;
   
   public function Storage(param1:String)
   {
      super();
      this._name = param1;
   }
   
   private function fixKey(param1:String) : String
   {
      return this._name + "/" + param1;
   }
   
   public function getItem(param1:String) : Object
   {
      var $key:String = param1;
      $key = this.fixKey($key);
      try
      {
         return Serializer.deserializeFromString(ExternalInterface.call("localStorage.getItem",$key));
      }
      catch(err:Error)
      {
         TsLogger.log("ItemCache :: Storage :: getItem unable to get item: " + $key);
      }
      return null;
   }
   
   public function setItem(param1:String, param2:Object) : void
   {
      var $key:String = param1;
      var $value:Object = param2;
      $key = this.fixKey($key);
      try
      {
         ExternalInterface.call("localStorage.setItem",$key,Serializer.serializeToString($value));
      }
      catch(err:Error)
      {
         TsLogger.log("ItemCache :: Storage :: setItem unable to set item " + $key);
      }
   }
   
   public function flush() : void
   {
   }
}
