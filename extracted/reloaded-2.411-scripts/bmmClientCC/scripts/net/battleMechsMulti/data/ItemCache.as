package net.battleMechsMulti.data
{
   import flash.net.registerClassAlias;
   import flash.utils.getQualifiedClassName;
   import net.battleMechsMulti.mobiles.BMItemData;
   
   public class ItemCache
   {
      
      private static var _instance:ItemCache = null;
      
      private const _itemsDBKey:* = "itemsDB";
      
      private const _itemsMaxLevelsDBKey:* = "itemsMaxLevelsDB";
      
      private const _itemsSubTypeDBKey:* = "subTypeDB";
      
      private const _versionKey:* = "version";
      
      private const _codeVersionKey:* = "codeVersion";
      
      private const _codeVersionValue:* = "5";
      
      private var _storage:Storage;
      
      private var _versionSaved:String = null;
      
      private var _itemsDBSaved:Object = null;
      
      private var _itemsDBRawSaved:String = null;
      
      private var _itemDBLoaderSaved:ItemDBLoader = null;
      
      private var _itemsMaxLevelsDBSaved:Object = null;
      
      private var _itemsSubTypeDBSaved:Object = null;
      
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
         registerClassAlias(getQualifiedClassName(BMItemData),BMItemData);
      }
      
      public function getItemDBDumper(param1:Object) : ItemDBDumper
      {
         return new ItemDBDumper(param1);
      }
      
      public function setItems(param1:String, param2:Object, param3:ItemDBDumper, param4:Object, param5:Object) : void
      {
         var _loc6_:String = param3.getResult();
         TsLogger.log("ItemCache :: rawItemDB Size " + _loc6_.length);
         this._versionSaved = param1;
         this._itemsDBSaved = param2;
         this._itemsDBRawSaved = _loc6_;
         this._itemsMaxLevelsDBSaved = param4;
         this._itemsSubTypeDBSaved = param5;
         this._itemDBLoaderSaved = null;
         this._storage.setItem(this._itemsDBKey,_loc6_,true);
         this._storage.setItem(this._itemsMaxLevelsDBKey,param4);
         this._storage.setItem(this._itemsSubTypeDBKey,param5);
         this._storage.setItem(this._versionKey,param1,true);
         this._storage.setItem(this._codeVersionKey,this._codeVersionValue,true);
         this._storage.flush();
         TsLogger.log("ItemCache :: setItems settings version to " + param1);
      }
      
      public function deleteCache() : *
      {
         this._storage.setItem(this._versionKey,"deleted",true);
         this._versionSaved = null;
         this._itemsDBSaved = null;
         this._itemsDBRawSaved = null;
         this._itemsMaxLevelsDBSaved = null;
         this._itemsSubTypeDBSaved = null;
         this._itemDBLoaderSaved = null;
         this._storage.flush();
      }
      
      public function getItemDBLoader() : ItemDBLoader
      {
         if(this._itemDBLoaderSaved != null)
         {
            return this._itemDBLoaderSaved;
         }
         if(this._itemsDBRawSaved == null)
         {
            this._itemsDBRawSaved = this._storage.getItem(this._itemsDBKey,true) as String;
         }
         this._itemDBLoaderSaved = new ItemDBLoader(this._itemsDBRawSaved);
         return this._itemDBLoaderSaved;
      }
      
      public function getItemsDB(param1:ItemDBLoader) : Object
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         if(!this._itemsDBSaved)
         {
            _loc2_ = param1.getResult();
            this._itemsDBSaved = new Object();
            for each(_loc3_ in _loc2_)
            {
               this._itemsDBSaved[_loc3_.itemID] = _loc3_ as BMItemData;
            }
         }
         return this._itemsDBSaved;
      }
      
      public function getItemsMaxLevelsDB() : Object
      {
         if(!this._itemsMaxLevelsDBSaved)
         {
            this._itemsMaxLevelsDBSaved = this._storage.getItem(this._itemsMaxLevelsDBKey);
         }
         return this._itemsMaxLevelsDBSaved;
      }
      
      public function getItemsSubTypeDB() : Object
      {
         if(!this._itemsSubTypeDBSaved)
         {
            this._itemsSubTypeDBSaved = this._storage.getItem(this._itemsSubTypeDBKey);
         }
         return this._itemsSubTypeDBSaved;
      }
      
      public function getVersion() : String
      {
         if(this._versionSaved != null)
         {
            return this._versionSaved;
         }
         var _loc1_:String = String(this._storage.getItem(this._versionKey,true));
         if(!_loc1_)
         {
            TsLogger.log("ItemCache :: getVersion mismatch: itemCacheVersion " + _loc1_);
            return null;
         }
         var _loc2_:String = String(this._storage.getItem(this._codeVersionKey,true));
         if(_loc2_ != this._codeVersionValue)
         {
            TsLogger.log("ItemCache :: codeVersion mismatch: found " + _loc1_ + " expected: " + this._codeVersionValue);
            return null;
         }
         this._versionSaved = _loc1_;
         return this._versionSaved;
      }
   }
}

import flash.net.SharedObject;

class Storage
{
   
   private var _name:String;
   
   private var _avialable:Boolean = true;
   
   private var _localSharedObject:SharedObject;
   
   public function Storage(param1:String)
   {
      super();
      this._name = param1;
      this._localSharedObject = SharedObject.getLocal(this._name);
   }
   
   private function fixKey(param1:String) : String
   {
      return param1;
   }
   
   public function getItem(param1:String, param2:* = false) : Object
   {
      if(!this._avialable)
      {
         return null;
      }
      param1 = this.fixKey(param1);
      return this._localSharedObject.data[param1];
   }
   
   public function setItem(param1:String, param2:Object, param3:* = false) : void
   {
      if(!this._avialable)
      {
         return;
      }
      param1 = this.fixKey(param1);
      this._localSharedObject.data[param1] = param2;
   }
   
   public function flush() : void
   {
      var flushStatus:String = null;
      if(!this._avialable)
      {
         return;
      }
      flushStatus = null;
      try
      {
         flushStatus = this._localSharedObject.flush();
      }
      catch(error:Error)
      {
         TsLogger.log("ItemCache :: SetItems unable to write: " + flushStatus + " " + error);
      }
   }
}
