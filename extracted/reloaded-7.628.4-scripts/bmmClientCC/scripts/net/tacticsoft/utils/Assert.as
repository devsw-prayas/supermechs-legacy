package net.tacticsoft.utils
{
   import flash.utils.Dictionary;
   
   public class Assert
   {
      
      public function Assert()
      {
         super();
      }
      
      private static function checkMessage(param1:String) : void
      {
         if(!param1 || param1 == "")
         {
            throw new ArgumentError("Parameter message cannot be null");
         }
      }
      
      private static function throwError(param1:String, param2:Class) : void
      {
         switch(param2)
         {
            case null:
               throw new ArgumentError(param1);
            default:
               throw new param2(param1);
         }
      }
      
      public static function NotNullOrEmpty(param1:Array, param2:String, param3:Class = null) : void
      {
         checkMessage(param2);
         if(param1 == null || param1.length < 1)
         {
            throwError(param2,param3);
         }
      }
      
      public static function NotNull(param1:*, param2:String, param3:Class = null) : void
      {
         checkMessage(param2);
         if(param1 == null)
         {
            throwError(param2,param3);
         }
      }
      
      public static function GreaterThan(param1:Number, param2:Number, param3:String, param4:Class = null) : void
      {
         checkMessage(param3);
         if(param1 < param2)
         {
            throwError(param3,param4);
         }
      }
      
      public static function Compatible(param1:*, param2:Class, param3:String, param4:Class = null) : void
      {
         checkMessage(param3);
         if(!(param1 is param2))
         {
            throwError(param3,param4);
         }
      }
      
      public static function State(param1:Boolean, param2:String, param3:Class = null) : void
      {
         checkMessage(param2);
         if(!param1)
         {
            throwError(param2,param3);
         }
      }
      
      public static function DictionaryKeysOfType(param1:Dictionary, param2:Class, param3:String, param4:Class = null) : void
      {
         var _loc5_:Object = null;
         checkMessage(param3);
         for(_loc5_ in param1)
         {
            if(!(_loc5_ is param2))
            {
               throwError(param3,param4);
            }
         }
      }
   }
}

