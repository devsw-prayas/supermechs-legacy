package net.tacticsoft.utils
{
   import flash.utils.getQualifiedClassName;
   import flash.utils.unescapeMultiByte;
   
   public dynamic class FlashVars
   {
      
      private var _fv_overrides:Array = [];
      
      public function FlashVars(param1:Object, param2:Boolean = false)
      {
         super();
         this.parse(param1,param2);
      }
      
      public function getOverrides() : Array
      {
         return this._fv_overrides;
      }
      
      protected function onParseError(param1:String, param2:String, param3:Error) : void
      {
      }
      
      protected function getValue(param1:Object, param2:String, param3:Boolean) : String
      {
         return param3 ? unescapeMultiByte(param1[param2]) : param1[param2];
      }
      
      protected function parse(param1:Object, param2:Boolean = false) : void
      {
         var key:String = null;
         var value:String = null;
         var type:String = null;
         var params:Object = param1;
         var unescapeValues:Boolean = param2;
         for(key in params)
         {
            value = this.getValue(params,key,unescapeValues);
            type = "default";
            try
            {
               if(this[key] != undefined)
               {
                  type = getQualifiedClassName(this[key]);
               }
            }
            catch(error:Error)
            {
            }
            try
            {
               switch(type)
               {
                  case "Array":
                     this[key] = value.split(",");
                     break;
                  case "Boolean":
                     this[key] = this.toBoolean(value);
                     break;
                  case "int":
                     this[key] = int(value);
                     break;
                  case "Number":
                     this[key] = Number(value);
                     break;
                  case "XML":
                     this[key] = XML(value);
                     break;
                  case "XMLList":
                     this[key] = XMLList(value);
                     break;
                  case "uint":
                     this[key] = uint(value);
                     break;
                  case "Date":
                     this[key] = Boolean(value.match(/^[0-9]+[\.]?[0-9]+$/)) ? new Date(Number(value) * 1000) : new Date(value);
                     break;
                  default:
                     this[key] = value;
               }
            }
            catch(error:Error)
            {
               onParseError(key,value,error);
            }
         }
      }
      
      protected function toBoolean(param1:String) : Boolean
      {
         param1 = param1.toLowerCase();
         return param1 == "1" || param1 == "true" ? true : false;
      }
   }
}

