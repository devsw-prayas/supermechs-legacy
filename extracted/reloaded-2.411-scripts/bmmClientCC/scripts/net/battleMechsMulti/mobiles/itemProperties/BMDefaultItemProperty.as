package net.battleMechsMulti.mobiles.itemProperties
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMExternalAssetsManager;
   import net.battleMechsMulti.screens.mainMenu.TextHolder;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2571")]
   public class BMDefaultItemProperty extends MovieClip implements IBMItemProperty
   {
      
      public var txtMain:TextField;
      
      public var txtBonus:TextHolder;
      
      public var iconSizer:Sprite;
      
      public function BMDefaultItemProperty()
      {
         super();
      }
      
      public function init(param1:String, param2:String, param3:Number, param4:Number, param5:Number, param6:Number, param7:Boolean = false) : void
      {
         if(param1 != "")
         {
            this.setIcon(param1);
         }
         var _loc8_:String = "";
         if(param3 == 0 && param5 == 999)
         {
            _loc8_ = "        ";
            this.addInfinitIcon();
         }
         else if(param3 == 0)
         {
            _loc8_ = param5 == 1 ? "1" : "1-" + param5;
         }
         else
         {
            _loc8_ = param5 == 0 ? param3.toString() : param3 + "-" + (param3 + param5);
         }
         var _loc9_:String = "";
         if(param4 - param3 > 0)
         {
            _loc9_ = param6 == 0 ? "+" + (param4 - param3).toString() : "+" + (param4 + param6 - (param3 + param5));
         }
         if(param7)
         {
            this.txtMain.width *= 2;
         }
         this.txtMain.htmlText = "<font color=\'\'>" + _loc8_ + "</font> <font color=\'#7F7F7F\'>" + param2.toUpperCase() + "</font>";
         ImageUtils.swapTextFieldWithBitMap(this.txtMain,this);
         if(this.txtBonus != null)
         {
            if(param7)
            {
               this.txtBonus.textField.width *= 2;
            }
            this.txtBonus.x = this.txtMain.x + this.txtMain.textWidth + 5;
            this.txtBonus.text = _loc9_;
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
         var _loc1_:MovieClip = BMExternalAssetsManager.getInstance().getAsset("general","icon_rangeInfinit",this.iconSizer.width * 1.6,this.iconSizer.width,true,false);
         _loc1_.x = this.txtMain.x + 5;
         _loc1_.y = this.txtMain.y + 3;
         addChild(_loc1_);
      }
   }
}

