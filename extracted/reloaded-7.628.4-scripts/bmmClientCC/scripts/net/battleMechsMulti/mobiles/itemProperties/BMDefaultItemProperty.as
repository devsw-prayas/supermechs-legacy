package net.battleMechsMulti.mobiles.itemProperties
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMExternalAssetsManager;
   import net.battleMechsMulti.managers.BMLanguageManager;
   import net.battleMechsMulti.mobiles.BMMovieClip;
   import net.battleMechsMulti.screens.mainMenu.TextHolder;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol5063")]
   public class BMDefaultItemProperty extends BMMovieClip implements IBMItemProperty
   {
      
      public var txtMain:TextField;
      
      public var txtBonus:TextHolder;
      
      public var iconSizer:Sprite;
      
      public var mcGeneralSizer:Sprite;
      
      public function BMDefaultItemProperty()
      {
         super();
      }
      
      public function initNameOnly(param1:String) : void
      {
         this.init("",param1,0,0,0,0,false,false,false,true);
      }
      
      public function init(param1:String, param2:String, param3:Number, param4:Number, param5:Number, param6:Number, param7:Boolean = false, param8:Boolean = false, param9:Boolean = false, param10:Boolean = false) : void
      {
         var _loc16_:String = null;
         var _loc18_:String = null;
         var _loc19_:String = null;
         if(param1 != "")
         {
            this.setIcon(param1);
         }
         var _loc11_:uint = 1;
         var _loc12_:String = TextUtils.convertNumberToString(param5,param8,_loc11_,param9);
         var _loc13_:String = TextUtils.convertNumberToString(param3,param8,_loc11_,param9);
         var _loc14_:String = TextUtils.convertNumberToString(1,param8,_loc11_,param9);
         var _loc15_:String = "";
         if(param3 == 0 && param5 == 999)
         {
            _loc15_ = "        ";
            this.addInfinitIcon();
         }
         else if(param3 == 0)
         {
            _loc15_ = param5 == 1 ? _loc14_ : _loc14_ + "-" + _loc12_;
         }
         else
         {
            _loc15_ = param5 == 0 ? _loc13_ : _loc13_ + "-" + (param3 + param5);
         }
         _loc16_ = "";
         if(param4 - param3 > 0)
         {
            _loc18_ = TextUtils.convertNumberToString(param4 - param3,param8,_loc11_,param9);
            _loc19_ = TextUtils.convertNumberToString(param4 + param6 - (param3 + param5),param8,_loc11_,param9);
            _loc16_ = param6 == 0 ? "+" + _loc18_ : "+" + _loc19_;
         }
         if(param7)
         {
            this.txtMain.width *= 2;
         }
         var _loc17_:int = 17;
         switch(BMDataManager.getInstance().languageID)
         {
            case BMLanguageManager.LANGUAGE_GERMAN:
            case BMLanguageManager.LANGUAGE_RUSSIAN:
            case BMLanguageManager.LANGUAGE_POLISH:
               _loc17_ = 12;
               if(param3 == 0 && param5 == 999)
               {
                  _loc15_ = "             ";
               }
               break;
            case BMLanguageManager.LANGUAGE_HUNGARIAN:
            case BMLanguageManager.LANGUAGE_SPANISH:
            case BMLanguageManager.LANGUAGE_CHINESE:
            case BMLanguageManager.LANGUAGE_TURKISH:
               _loc17_ = 14;
         }
         if(param10)
         {
            this.txtMain.x = 2;
            updateTextAndFormat(this.txtMain,"<font color=\'#FF3300\'>" + param2,_loc17_);
         }
         else
         {
            updateTextAndFormat(this.txtMain,"<font color=\'\'>" + _loc15_ + "</font> <font color=\'#b0b0b0\'>" + param2 + "</font>",_loc17_);
         }
         ImageUtils.swapTextFieldWithBitMap(this.txtMain,this);
         if(this.txtBonus != null)
         {
            if(param7)
            {
               this.txtBonus.textField.width *= 2;
            }
            this.txtBonus.x = this.txtMain.x + this.txtMain.textWidth + 5;
            this.txtBonus.text = _loc16_;
         }
      }
      
      private function setIcon(param1:String) : void
      {
         var _loc2_:MovieClip = null;
         _loc2_ = BMExternalAssetsManager.getInstance().getAsset("general",param1,this.iconSizer.width,this.iconSizer.height,true,false);
         _loc2_.x = this.iconSizer.x;
         _loc2_.y = this.iconSizer.y;
         addChild(_loc2_);
      }
      
      private function addInfinitIcon() : void
      {
         var _loc1_:MovieClip = null;
         _loc1_ = BMExternalAssetsManager.getInstance().getAsset("general","icon_rangeInfinit",this.iconSizer.width * 1.6,this.iconSizer.width,true,false);
         _loc1_.x = this.txtMain.x + 5;
         _loc1_.y = this.txtMain.y + 3;
         addChild(_loc1_);
      }
   }
}

