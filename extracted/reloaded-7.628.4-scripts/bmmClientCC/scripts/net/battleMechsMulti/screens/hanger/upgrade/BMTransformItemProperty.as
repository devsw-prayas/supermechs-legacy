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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2996")]
   public class BMTransformItemProperty extends BMMovieClip implements IBMItemProperty
   {
      
      public var txtMain:TextField;
      
      public var iconSizer:Sprite;
      
      public var mcNew:Sprite;
      
      public var mcGeneralSizer:Sprite;
      
      public function BMTransformItemProperty()
      {
         super();
      }
      
      public function initNameOnly(param1:String) : void
      {
         this.init("",param1,0,0,0,0,false,false,false,true);
      }
      
      public function init(param1:String, param2:String, param3:Number, param4:Number, param5:Number, param6:Number, param7:Boolean = false, param8:Boolean = false, param9:Boolean = false, param10:Boolean = false) : void
      {
         var _loc14_:MovieClip = null;
         if(param1 != "")
         {
            _loc14_ = BMExternalAssetsManager.getInstance().getAsset("general",param1,this.iconSizer.width,this.iconSizer.height,true,false);
            _loc14_.x = this.iconSizer.x;
            _loc14_.y = this.iconSizer.y;
            addChild(_loc14_);
         }
         var _loc11_:String = param6 == 0 ? param4.toString() : param4 + "-" + (param4 + param6);
         var _loc12_:String = "";
         var _loc13_:int = 16;
         if(BMDataManager.getInstance().languageID == BMLanguageManager.LANGUAGE_RUSSIAN)
         {
            _loc13_ = 12;
         }
         if(param10)
         {
            this.txtMain.x = 79;
            updateTextAndFormat(this.txtMain,"<font color=\'#FF3300\'>" + param2);
         }
         else
         {
            updateTextAndFormat(this.txtMain,"<font color=\'\'>" + _loc11_ + "</font> <font color=\'#7F7F7F\'>" + param2 + "</font> <font color=\'#FBA600\' size=\'" + _loc13_ + "\'>" + _loc12_ + "</font>");
         }
         if(param3 == param4)
         {
            this.mcNew.visible = false;
         }
         ImageUtils.swapTextFieldWithBitMap(this.txtMain,this);
      }
   }
}

