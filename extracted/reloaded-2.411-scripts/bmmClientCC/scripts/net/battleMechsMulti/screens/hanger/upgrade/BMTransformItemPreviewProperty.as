package net.battleMechsMulti.screens.hanger.upgrade
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMExternalAssetsManager;
   import net.battleMechsMulti.mobiles.itemProperties.IBMItemProperty;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1547")]
   public class BMTransformItemPreviewProperty extends MovieClip implements IBMItemProperty
   {
      
      public var txtOld:TextField;
      
      public var txtNew:TextField;
      
      public var iconOldSizer:Sprite;
      
      public var iconNewSizer:Sprite;
      
      public var mcArrow:Sprite;
      
      public function BMTransformItemPreviewProperty()
      {
         super();
      }
      
      public function init(param1:String, param2:String, param3:Number, param4:Number, param5:Number, param6:Number, param7:Boolean = false) : void
      {
         var _loc11_:String = null;
         var _loc12_:MovieClip = null;
         var _loc13_:String = null;
         var _loc14_:MovieClip = null;
         var _loc8_:Number = this.iconOldSizer.width;
         this.txtOld.text = "";
         if(param3 != 0)
         {
            if(param1 != "")
            {
               _loc12_ = BMExternalAssetsManager.getInstance().getAsset("general",param1,_loc8_,_loc8_,true,false);
               _loc12_.x = this.iconOldSizer.x;
               _loc12_.y = this.iconOldSizer.y;
               addChild(_loc12_);
            }
            _loc11_ = param5 == 0 ? param3.toString() : param3 + "-" + (param3 + param5);
            this.txtOld.htmlText = "<font color=\'\'>" + _loc11_ + "</font> <font color=\'#7F7F7F\'>" + param2 + "</font> <font color=\'#FBA600\' size=\'16\'>";
         }
         this.txtNew.text = "";
         if(param4 != 0)
         {
            if(param1 != "")
            {
               _loc14_ = BMExternalAssetsManager.getInstance().getAsset("general",param1,_loc8_,_loc8_,true,false);
               _loc14_.x = this.iconNewSizer.x;
               _loc14_.y = this.iconNewSizer.y;
               addChild(_loc14_);
            }
            _loc13_ = param6 == 0 ? param4.toString() : param4 + "-" + (param4 + param6);
            this.txtNew.htmlText = "<font color=\'\'>" + _loc13_ + "</font> <font color=\'#7F7F7F\'>" + param2 + "</font> <font color=\'#FBA600\' size=\'16\'>";
         }
         var _loc9_:String = param6 == 0 ? param4.toString() : param4 + "-" + (param4 + param6);
         var _loc10_:String = "";
         if(param3 == 0 || param4 == 0)
         {
            this.mcArrow.visible = false;
         }
         ImageUtils.swapTextFieldWithBitMap(this.txtOld,this);
         ImageUtils.swapTextFieldWithBitMap(this.txtNew,this);
      }
   }
}

