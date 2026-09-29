package net.battleMechsMulti.managers.externalImages
{
   public class BMExternalImagesManager
   {
      
      private static var _instance:BMExternalImagesManager;
      
      private static var _allowInstantiation:Boolean;
      
      private var _externalImages:Array = new Array();
      
      public function BMExternalImagesManager()
      {
         super();
         if(!_allowInstantiation)
         {
            throw new Error("Error: Instantiation failed: Use BMExternalImagesManager.getInstance() instead of new.");
         }
      }
      
      public static function gi() : BMExternalImagesManager
      {
         if(_instance == null)
         {
            _allowInstantiation = true;
            _instance = new BMExternalImagesManager();
            _allowInstantiation = false;
         }
         return _instance;
      }
      
      public function createExternalImage(param1:String, param2:Number = 0, param3:Number = 0, param4:Function = null) : BMExternalImage
      {
         var _loc7_:BMExternalImage = null;
         var _loc5_:uint = 0;
         while(_loc5_ < this._externalImages.length)
         {
            _loc7_ = this._externalImages[_loc5_];
            if(_loc7_.imageUrl == param1)
            {
               if(param2 > 0 && param3 > 0)
               {
                  _loc7_.setSize(param2,param3);
               }
               if(param4 != null)
               {
                  param4();
               }
               return _loc7_;
            }
            _loc5_++;
         }
         var _loc6_:BMExternalImage = new BMExternalImage(param1,param2,param3,param4);
         this._externalImages.push(_loc6_);
         return _loc6_;
      }
   }
}

