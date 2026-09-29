package net.battleMechsMulti.utils
{
   import flash.text.AntiAliasType;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMLanguageManager;
   
   public class TextUtils
   {
      
      public static const SIZE_KEEP_CURRENT:int = -1;
      
      private static const FONT_AMERICAN_CAPTAIN_ETERNAL:String = "American Captain Eternal";
      
      private static const FONT_SANS:String = "_sans";
      
      private static const FONT_OPEN_SANS_SEMIBOLD:String = "Open Sans Semibold";
      
      public function TextUtils()
      {
         super();
         throw new Error("Do not instantiate this class");
      }
      
      public static function getState(param1:TextField, param2:Boolean = false) : TextOriginState
      {
         var _loc3_:TextOriginState = new TextOriginState();
         _loc3_.x = param1.x;
         _loc3_.y = param1.y;
         _loc3_.width = param1.width;
         _loc3_.height = param1.height;
         var _loc4_:TextFormat = param1.getTextFormat();
         if(param2)
         {
            _loc4_.color = null;
         }
         _loc3_.textFormat = _loc4_;
         return _loc3_;
      }
      
      public static function setWithOriginState(param1:TextField, param2:TextOriginState) : void
      {
         if(param2 == null)
         {
            return;
         }
         param1.x = param2.x;
         param1.y = param2.y;
         param1.width = param2.width;
         param1.height = param2.height;
         param1.setTextFormat(param2.textFormat);
      }
      
      public static function updateTextFormatNew(param1:TextField, param2:int = 0, param3:uint = 0, param4:String = "", param5:TextOriginState = null, param6:Boolean = false) : TextOriginState
      {
         var _loc11_:Object = null;
         var _loc12_:Object = null;
         var _loc7_:TextOriginState = param5;
         if(_loc7_ == null)
         {
            _loc7_ = TextUtils.getState(param1,param6);
         }
         TextUtils.setWithOriginState(param1,_loc7_);
         param1.antiAliasType = AntiAliasType.ADVANCED;
         var _loc8_:String = param4;
         if(_loc8_ == "" && (BMDataManager.getInstance().languageID == BMLanguageManager.LANGUAGE_ENGLISH || BMDataManager.getInstance().languageID == BMLanguageManager.LANGUAGE_GERMAN))
         {
            if(_loc7_.textFormat.font == FONT_OPEN_SANS_SEMIBOLD)
            {
               _loc8_ = FONT_OPEN_SANS_SEMIBOLD;
            }
         }
         var _loc9_:Boolean = BMDataManager.getInstance().languageID != BMLanguageManager.LANGUAGE_ENGLISH && param2 <= 0;
         if(param2 == SIZE_KEEP_CURRENT)
         {
            _loc11_ = param1.getTextFormat().size;
            if(param1.text.length > 0)
            {
               _loc12_ = param1.getTextFormat(0,1).size;
               if(_loc12_ != null)
               {
                  _loc11_ = _loc12_;
               }
            }
            if(_loc11_ != null)
            {
               param2 = int(_loc11_);
            }
            else
            {
               param2 = 12;
            }
         }
         switch(BMDataManager.getInstance().languageID)
         {
            case BMLanguageManager.LANGUAGE_ENGLISH:
            case BMLanguageManager.LANGUAGE_GERMAN:
               if(_loc8_ == "")
               {
                  _loc8_ = FONT_AMERICAN_CAPTAIN_ETERNAL;
                  param1.embedFonts = true;
               }
               else
               {
                  param1.embedFonts = false;
               }
               if(param2 == 0)
               {
                  param2 = 20;
               }
               if(param3 == 0)
               {
                  param1.defaultTextFormat = new TextFormat(_loc8_,param2);
                  param1.setTextFormat(new TextFormat(_loc8_,param2));
               }
               else
               {
                  param1.defaultTextFormat = new TextFormat(_loc8_,param2,null,null,null,null,null,null,null,null,null,null,param3);
                  param1.setTextFormat(new TextFormat(_loc8_,param2,null,null,null,null,null,null,null,null,null,null,param3));
               }
               break;
            default:
               if(_loc8_ == "")
               {
                  _loc8_ = FONT_SANS;
               }
               param1.embedFonts = false;
               if(param2 == 0)
               {
                  param2 = 18;
               }
               if(param3 == 0)
               {
                  param1.defaultTextFormat = new TextFormat(_loc8_,param2,null,true);
                  param1.setTextFormat(new TextFormat(_loc8_,param2,null,true));
               }
               else
               {
                  param1.defaultTextFormat = new TextFormat(_loc8_,param2,null,true,null,null,null,null,null,null,null,null,param3);
                  param1.setTextFormat(new TextFormat(_loc8_,param2,null,true,null,null,null,null,null,null,null,null,param3));
               }
         }
         if(_loc9_)
         {
            autoresizeOneLineTextField(param1,param2);
         }
         var _loc10_:Number = int(_loc7_.textFormat.size) - int(param1.getTextFormat().size);
         if(_loc10_ > 6)
         {
            _loc10_ = 6;
         }
         else if(_loc10_ < -3)
         {
            _loc10_ = -3;
         }
         param1.y = _loc7_.y + _loc10_ * 1;
         return _loc7_;
      }
      
      public static function updateTextFormat(param1:TextField, param2:int = 0, param3:uint = 0, param4:String = "", param5:Object = null) : TextOriginState
      {
         var _loc6_:TextOriginState = null;
         var _loc9_:Object = null;
         if(param5 != null && param5[param1.name] != null)
         {
            _loc6_ = param5[param1.name];
         }
         else
         {
            _loc6_ = TextUtils.getState(param1);
         }
         TextUtils.setWithOriginState(param1,_loc6_);
         param1.antiAliasType = AntiAliasType.ADVANCED;
         var _loc7_:String = param4;
         var _loc8_:Boolean = BMDataManager.getInstance().languageID != BMLanguageManager.LANGUAGE_ENGLISH && param2 <= 0;
         if(param2 == SIZE_KEEP_CURRENT)
         {
            _loc9_ = param1.getTextFormat().size;
            if(_loc9_ != null)
            {
               param2 = int(_loc9_);
            }
            else
            {
               param2 = 12;
            }
         }
         switch(BMDataManager.getInstance().languageID)
         {
            case BMLanguageManager.LANGUAGE_RUSSIAN:
            case BMLanguageManager.LANGUAGE_TURKISH:
            case BMLanguageManager.LANGUAGE_ITALIAN:
            case BMLanguageManager.LANGUAGE_PORTUGUESE:
            case BMLanguageManager.LANGUAGE_SPANISH:
            case BMLanguageManager.LANGUAGE_POLISH:
            case BMLanguageManager.LANGUAGE_HUNGARIAN:
               if(_loc7_ == "")
               {
                  _loc7_ = FONT_SANS;
               }
               param1.embedFonts = false;
               if(param2 == 0)
               {
                  param2 = 18;
               }
               if(param3 == 0)
               {
                  param1.defaultTextFormat = new TextFormat(_loc7_,param2,null,true);
                  param1.setTextFormat(new TextFormat(_loc7_,param2,null,true));
               }
               else
               {
                  param1.defaultTextFormat = new TextFormat(_loc7_,param2,null,true,null,null,null,null,null,null,null,null,param3);
                  param1.setTextFormat(new TextFormat(_loc7_,param2,null,true,null,null,null,null,null,null,null,null,param3));
               }
               break;
            default:
               if(_loc7_ == "")
               {
                  _loc7_ = FONT_AMERICAN_CAPTAIN_ETERNAL;
               }
               param1.embedFonts = true;
               if(param2 == 0)
               {
                  param2 = 20;
               }
               if(param3 == 0)
               {
                  param1.defaultTextFormat = new TextFormat(_loc7_,param2);
                  param1.setTextFormat(new TextFormat(_loc7_,param2));
               }
               else
               {
                  param1.defaultTextFormat = new TextFormat(_loc7_,param2,null,null,null,null,null,null,null,null,null,null,param3);
                  param1.setTextFormat(new TextFormat(_loc7_,param2,null,null,null,null,null,null,null,null,null,null,param3));
               }
         }
         if(_loc8_)
         {
            autoresizeOneLineTextField(param1,param2);
         }
         return _loc6_;
      }
      
      public static function getTextFont(param1:uint = 0, param2:Number = 0) : String
      {
         var _loc3_:String = "";
         switch(BMDataManager.getInstance().languageID)
         {
            case BMLanguageManager.LANGUAGE_RUSSIAN:
            case BMLanguageManager.LANGUAGE_TURKISH:
            case BMLanguageManager.LANGUAGE_ITALIAN:
            case BMLanguageManager.LANGUAGE_PORTUGUESE:
            case BMLanguageManager.LANGUAGE_SPANISH:
            case BMLanguageManager.LANGUAGE_POLISH:
            case BMLanguageManager.LANGUAGE_HUNGARIAN:
               if(param1 == 0)
               {
                  if(param2 == 0)
                  {
                     _loc3_ = "<FONT FACE=\'" + FONT_SANS + "\'><B>";
                  }
                  else
                  {
                     _loc3_ = "<FONT FACE=\'" + FONT_SANS + "\'><B><TEXTFORMAT LEADING=\'" + param2 + "\'>";
                  }
               }
               else if(param2 == 0)
               {
                  _loc3_ = "<FONT FACE=\'" + FONT_SANS + "\' SIZE = \'" + param1 + "\'><B>";
               }
               else
               {
                  _loc3_ = "<FONT FACE=\'" + FONT_SANS + "\' SIZE = \'" + param1 + "\'><B><TEXTFORMAT LEADING=\'" + param2 + "\'>";
               }
               break;
            default:
               if(param1 == 0)
               {
                  _loc3_ = "<FONT FACE=\'" + FONT_AMERICAN_CAPTAIN_ETERNAL + "\'>";
               }
               else
               {
                  _loc3_ = "<FONT FACE=\'" + FONT_AMERICAN_CAPTAIN_ETERNAL + "\' SIZE = \'" + param1 + "\'>";
               }
         }
         return _loc3_;
      }
      
      public static function getTextFont_short(param1:uint = 0) : String
      {
         var _loc2_:String = "";
         if(param1 == 0)
         {
            param1 = BMDataManager.getInstance().languageID;
         }
         switch(param1)
         {
            case BMLanguageManager.LANGUAGE_ENGLISH:
            case BMLanguageManager.LANGUAGE_GERMAN:
               _loc2_ = FONT_AMERICAN_CAPTAIN_ETERNAL;
               break;
            default:
               _loc2_ = "_sans";
         }
         return _loc2_;
      }
      
      public static function autoresizeOneLineTextField(param1:TextField, param2:int) : int
      {
         if(param2 <= 0)
         {
            throw Error("autoresizeOneLineTextField must receive positive argument. Got " + param2);
         }
         var _loc3_:* = param1.width;
         var _loc4_:* = param1.height;
         var _loc5_:* = param1.x;
         var _loc6_:* = param1.y;
         var _loc7_:* = param1.autoSize;
         var _loc8_:TextFormat = param1.getTextFormat();
         if(_loc8_.align == TextFormatAlign.LEFT || _loc8_.align == TextFormatAlign.JUSTIFY)
         {
            param1.autoSize = TextFieldAutoSize.LEFT;
         }
         else if(_loc8_.align == TextFormatAlign.RIGHT)
         {
            param1.autoSize = TextFieldAutoSize.RIGHT;
         }
         else
         {
            param1.autoSize = TextFieldAutoSize.CENTER;
         }
         _loc8_.size = param2;
         while(param1.width > _loc3_ && param2 > 7)
         {
            param2--;
            _loc8_.size = param2;
            param1.defaultTextFormat = _loc8_;
            param1.setTextFormat(_loc8_);
         }
         param1.autoSize = _loc7_;
         _loc8_.size = param2;
         param1.defaultTextFormat = _loc8_;
         param1.setTextFormat(_loc8_);
         param1.width = _loc3_;
         param1.height = _loc4_;
         param1.x = _loc5_;
         param1.y = _loc6_;
         return param2;
      }
      
      public static function getNumberWithComma(param1:Number) : String
      {
         var _loc2_:Boolean = false;
         if(param1 < 0)
         {
            _loc2_ = true;
            param1 *= -1;
         }
         var _loc3_:String = String(param1);
         if(_loc3_.length == 4)
         {
            _loc3_ = _loc3_.substr(0,1) + "," + _loc3_.substr(1,3);
         }
         else if(_loc3_.length == 5)
         {
            _loc3_ = _loc3_.substr(0,2) + "," + _loc3_.substr(2,3);
         }
         else if(_loc3_.length == 6)
         {
            _loc3_ = _loc3_.substr(0,3) + "," + _loc3_.substr(3,3);
         }
         else if(_loc3_.length == 7)
         {
            _loc3_ = _loc3_.substr(0,1) + "," + _loc3_.substr(1,3) + "," + _loc3_.substr(4,3);
         }
         else if(_loc3_.length == 8)
         {
            _loc3_ = _loc3_.substr(0,2) + "," + _loc3_.substr(2,3) + "," + _loc3_.substr(5,3);
         }
         else if(_loc3_.length == 9)
         {
            _loc3_ = _loc3_.substr(0,3) + "," + _loc3_.substr(3,3) + "," + _loc3_.substr(6,3);
         }
         else if(_loc3_.length == 10)
         {
            _loc3_ = _loc3_.substr(0,1) + "," + _loc3_.substr(1,3) + "," + _loc3_.substr(4,3) + "," + _loc3_.substr(7,3);
         }
         if(_loc2_)
         {
            _loc3_ = "-" + _loc3_;
         }
         return _loc3_;
      }
      
      public static function doesStringOnlyContainsSpaces(param1:String) : Boolean
      {
         var _loc3_:String = null;
         var _loc2_:uint = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = param1.substr(_loc2_,1);
            if(_loc3_ != " ")
            {
               return false;
            }
            _loc2_++;
         }
         return true;
      }
      
      public static function getPriceWithoutCurrency(param1:String) : Number
      {
         var _loc5_:String = null;
         var _loc2_:String = "";
         var _loc3_:Array = ["1","2","3","4","5","6","7","8","9","0",".",","];
         var _loc4_:uint = 0;
         while(_loc4_ < param1.length)
         {
            _loc5_ = param1.substr(_loc4_,1);
            if(_loc3_.indexOf(_loc5_) != -1)
            {
               if(_loc5_ == ",")
               {
                  _loc5_ = ".";
               }
               _loc2_ += _loc5_;
            }
            _loc4_++;
         }
         return Number(_loc2_);
      }
      
      public static function getCurrency(param1:String, param2:Boolean = false) : String
      {
         var _loc4_:uint = 0;
         var _loc5_:String = null;
         var _loc6_:Array = null;
         var _loc7_:Array = null;
         var _loc3_:String = "";
         if(param2)
         {
            _loc6_ = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"];
            _loc4_ = 0;
            while(_loc4_ < param1.length)
            {
               _loc5_ = param1.substr(_loc4_,1).toUpperCase();
               if(_loc6_.indexOf(_loc5_) != -1)
               {
                  _loc3_ += _loc5_;
               }
               _loc4_++;
            }
         }
         else
         {
            _loc7_ = ["1","2","3","4","5","6","7","8","9","0",".",","," "];
            _loc4_ = 0;
            while(_loc4_ < param1.length)
            {
               _loc5_ = param1.substr(_loc4_,1);
               if(_loc7_.indexOf(_loc5_) <= -1)
               {
                  _loc3_ += _loc5_;
               }
               _loc4_++;
            }
         }
         return _loc3_;
      }
      
      public static function convertNumberToString(param1:Number, param2:Boolean, param3:uint, param4:Boolean) : String
      {
         if(param2)
         {
            param1 /= 10;
         }
         var _loc5_:String = param1.toString();
         var _loc6_:int = _loc5_.indexOf(".");
         if(_loc6_ > -1)
         {
            if(_loc5_.length > _loc6_ + param3 + 1)
            {
               _loc5_.substr(0,_loc6_ + param3 + 1);
            }
         }
         if(param4)
         {
            _loc5_ += "%";
         }
         return _loc5_;
      }
      
      public static function splitStringToTwoLines(param1:String) : Array
      {
         var _loc2_:int = findSpaceClosestToMiddle(param1);
         if(_loc2_ == -1 || _loc2_ == param1.length)
         {
            return [param1,""];
         }
         var _loc3_:String = param1.substr(0,_loc2_);
         var _loc4_:String = param1.substr(_loc2_ + 1,param1.length - _loc2_ - 1);
         return [_loc3_,_loc4_];
      }
      
      private static function findSpaceClosestToMiddle(param1:String) : *
      {
         var _loc2_:int = int(param1.length / 2);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(param1.charAt(_loc2_ + _loc3_) == " ")
            {
               return _loc2_ + _loc3_;
            }
            if(param1.charAt(_loc2_ - _loc3_) == " ")
            {
               return _loc2_ - _loc3_;
            }
            _loc3_++;
         }
         return -1;
      }
   }
}

