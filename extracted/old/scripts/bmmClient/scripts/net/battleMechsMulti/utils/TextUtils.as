package net.battleMechsMulti.utils
{
   import flash.text.AntiAliasType;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import net.battleMechsMulti.managers.BMDataManager;
   
   public class TextUtils
   {
      
      public function TextUtils()
      {
         super();
         throw new Error("Do not instantiate this class");
      }
      
      public static function updateTextFormat(param1:TextField, param2:uint = 0, param3:uint = 0) : void
      {
         param1.antiAliasType = AntiAliasType.ADVANCED;
         switch(BMDataManager.getInstance().languageID)
         {
            case 3:
            case 4:
            case 6:
            case 7:
            case 8:
            case 9:
            case 10:
               param1.embedFonts = false;
               if(param2 == 0)
               {
                  param2 = 18;
               }
               if(param3 == 0)
               {
                  param1.defaultTextFormat = new TextFormat("_sans",param2,null,true);
                  param1.setTextFormat(new TextFormat("_sans",param2,null,true));
               }
               else
               {
                  param1.defaultTextFormat = new TextFormat("_sans",param2,null,true,null,null,null,null,null,null,null,null,param3);
                  param1.setTextFormat(new TextFormat("_sans",param2,null,true,null,null,null,null,null,null,null,null,param3));
               }
               break;
            default:
               param1.embedFonts = true;
               if(param2 == 0)
               {
                  param2 = 20;
               }
               if(param3 == 0)
               {
                  param1.defaultTextFormat = new TextFormat("American Captain Eternal",param2);
                  param1.setTextFormat(new TextFormat("American Captain Eternal",param2));
               }
               else
               {
                  param1.defaultTextFormat = new TextFormat("American Captain Eternal",param2,null,null,null,null,null,null,null,null,null,null,param3);
                  param1.setTextFormat(new TextFormat("American Captain Eternal",param2,null,null,null,null,null,null,null,null,null,null,param3));
               }
         }
      }
      
      public static function getTextFont(param1:uint = 0, param2:Number = 0) : String
      {
         var _loc3_:String = "";
         switch(BMDataManager.getInstance().languageID)
         {
            case 3:
            case 4:
            case 6:
            case 7:
            case 8:
            case 9:
            case 10:
               if(param1 == 0)
               {
                  if(param2 == 0)
                  {
                     _loc3_ = "<FONT FACE=\'_sans\'><B>";
                  }
                  else
                  {
                     _loc3_ = "<FONT FACE=\'_sans\'><B><TEXTFORMAT LEADING=\'" + param2 + "\'>";
                  }
               }
               else if(param2 == 0)
               {
                  _loc3_ = "<FONT FACE=\'_sans\' SIZE = \'" + param1 + "\'><B>";
               }
               else
               {
                  _loc3_ = "<FONT FACE=\'_sans\' SIZE = \'" + param1 + "\'><B><TEXTFORMAT LEADING=\'" + param2 + "\'>";
               }
               break;
            default:
               if(param1 == 0)
               {
                  _loc3_ = "<FONT FACE=\'American Captain Eternal\'>";
               }
               else
               {
                  _loc3_ = "<FONT FACE=\'American Captain Eternal\' SIZE = \'" + param1 + "\'>";
               }
         }
         return _loc3_;
      }
      
      public static function getTextFont_short() : String
      {
         var _loc1_:String = "";
         switch(BMDataManager.getInstance().languageID)
         {
            case 3:
            case 4:
            case 6:
            case 7:
            case 8:
            case 9:
            case 10:
               _loc1_ = "_sans";
               break;
            default:
               _loc1_ = "American Captain Eternal";
         }
         return _loc1_;
      }
   }
}

