package net.battleMechsMulti.screens.hanger.upgrade
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMExternalAssetsManager;
   import net.battleMechsMulti.mobiles.itemProperties.IBMItemProperty;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1542")]
   public class BMTransformItemProperty extends MovieClip implements IBMItemProperty
   {
      
      public var txtMain:TextField;
      
      public var iconSizer:Sprite;
      
      public var mcNew:Sprite;
      
      public function BMTransformItemProperty()
      {
         super();
      }
      
      public function init(param1:String, param2:String, param3:Number, param4:Number, param5:Number, param6:Number, param7:Boolean = false) : void
      {
         var _loc10_:MovieClip = null;
         if(param1 != "")
         {
            _loc10_ = BMExternalAssetsManager.getInstance().getAsset("general",param1,this.iconSizer.width,this.iconSizer.height,true,false);
            _loc10_.x = this.iconSizer.x;
            _loc10_.y = this.iconSizer.y;
            addChild(_loc10_);
         }
         var _loc8_:String = param6 == 0 ? param4.toString() : param4 + "-" + (param4 + param6);
         var _loc9_:String = "";
         this.txtMain.htmlText = "<font color=\'\'>" + _loc8_ + "</font> <font color=\'#7F7F7F\'>" + param2 + "</font> <font color=\'#FBA600\' size=\'16\'>" + _loc9_ + "</font>";
         if(param3 == param4)
         {
            this.mcNew.visible = false;
         }
         ImageUtils.swapTextFieldWithBitMap(this.txtMain,this);
      }
   }
}

