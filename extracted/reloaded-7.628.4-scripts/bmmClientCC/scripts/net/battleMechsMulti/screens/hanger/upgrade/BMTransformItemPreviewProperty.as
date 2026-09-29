package net.battleMechsMulti.screens.hanger.upgrade
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMExternalAssetsManager;
   import net.battleMechsMulti.managers.BMLanguageManager;
   import net.battleMechsMulti.mobiles.BMMovieClip;
   import net.battleMechsMulti.mobiles.itemProperties.IBMItemProperty;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3001")]
   public class BMTransformItemPreviewProperty extends BMMovieClip implements IBMItemProperty
   {
      
      public var txtOld:TextField;
      
      public var txtNew:TextField;
      
      public var iconOldSizer:Sprite;
      
      public var iconNewSizer:Sprite;
      
      public var mcArrow:Sprite;
      
      public var mcGeneralSizer:Sprite;
      
      public function BMTransformItemPreviewProperty()
      {
         super();
      }
      
      public function initNameOnly(param1:String) : void
      {
      }
      
      public function init(param1:String, param2:String, param3:Number, param4:Number, param5:Number, param6:Number, param7:Boolean = false, param8:Boolean = false, param9:Boolean = false, param10:Boolean = false) : void
      {
         var _loc15_:String = null;
         var _loc16_:MovieClip = null;
         var _loc17_:String = null;
         var _loc18_:MovieClip = null;
         var _loc11_:Number = this.iconOldSizer.width;
         var _loc12_:int = 16;
         if(BMDataManager.getInstance().languageID == BMLanguageManager.LANGUAGE_RUSSIAN)
         {
            _loc12_ = 12;
         }
         this.txtOld.text = "";
         if(param3 != 0)
         {
            if(param1 != "")
            {
               _loc16_ = BMExternalAssetsManager.getInstance().getAsset("general",param1,_loc11_,_loc11_,true,false);
               _loc16_.x = this.iconOldSizer.x;
               _loc16_.y = this.iconOldSizer.y;
               addChild(_loc16_);
            }
            else
            {
               this.txtNew.x -= this.txtOld.x;
               this.txtOld.x = 0;
            }
            _loc15_ = param5 == 0 ? param3.toString() : param3 + "-" + (param3 + param5);
            updateTextAndFormat(this.txtOld,"<font color=\'\'>" + _loc15_ + "</font> <font color=\'#7F7F7F\'>" + param2 + "</font> <font color=\'#FBA600\' size=\'" + _loc12_ + "\'>",_loc12_);
         }
         this.txtNew.text = "";
         if(param4 != 0)
         {
            if(param1 != "")
            {
               _loc18_ = BMExternalAssetsManager.getInstance().getAsset("general",param1,_loc11_,_loc11_,true,false);
               _loc18_.x = this.iconNewSizer.x;
               _loc18_.y = this.iconNewSizer.y;
               addChild(_loc18_);
            }
            _loc17_ = param6 == 0 ? param4.toString() : param4 + "-" + (param4 + param6);
            updateTextAndFormat(this.txtNew,"<font color=\'\'>" + _loc17_ + "</font> <font color=\'#7F7F7F\'>" + param2 + "</font> <font color=\'#FBA600\' size=\'" + _loc12_ + "\'>",_loc12_);
         }
         var _loc13_:String = param6 == 0 ? param4.toString() : param4 + "-" + (param4 + param6);
         var _loc14_:String = "";
         if(param3 == 0 || param4 == 0)
         {
            this.mcArrow.visible = false;
         }
         ImageUtils.swapTextFieldWithBitMap(this.txtOld,this);
         ImageUtils.swapTextFieldWithBitMap(this.txtNew,this);
      }
   }
}

