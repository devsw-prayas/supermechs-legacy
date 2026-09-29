package net.battleMechsMulti.mobiles
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2637")]
   public class BMItemCard extends BMBaseClass
   {
      
      public var txtName:TextField;
      
      public var txtDescription:TextField;
      
      public var txtBonus:TextField;
      
      public var mcSizer_item:Sprite;
      
      public var mcSizer_icon1:Sprite;
      
      public var mcSizer_icon2:Sprite;
      
      public var mcSizer_icon3:Sprite;
      
      public var mcSizer_icon4:Sprite;
      
      public var mcMouseHitArea:Sprite;
      
      public var mcItemHolder:Sprite;
      
      public var mcCardFront:Sprite;
      
      public var mcCardBack:MovieClip;
      
      public var mcCardBackHolder:Sprite;
      
      public var mcCardFrontHolder:Sprite;
      
      public var mcLightEffect:MovieClip;
      
      public var rarity:uint = 0;
      
      public var glowCounter:Number = -1;
      
      private var mcItem:BMItem;
      
      private var _cardID:Number;
      
      private var _clickAllowed:Boolean;
      
      private var coverBMD:BitmapData;
      
      private var coverBM:Bitmap;
      
      private var backgroundBMD:BitmapData;
      
      private var backgroundBM:Bitmap;
      
      public function BMItemCard()
      {
         super();
      }
      
      public function initialize(param1:Number, param2:String, param3:Number, param4:Boolean = false, param5:Boolean = false) : void
      {
         var _loc6_:BMItemData = null;
         var _loc7_:MovieClip = null;
         var _loc9_:String = null;
         var _loc10_:String = null;
         var _loc11_:String = null;
         var _loc12_:String = null;
         var _loc13_:Sprite = null;
         var _loc14_:String = null;
         var _loc15_:BMPlayerProfile = null;
         var _loc16_:* = undefined;
         var _loc17_:Array = null;
         var _loc18_:Array = null;
         var _loc19_:Array = null;
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("itemCards");
         this._cardID = param1;
         this.mcItem = new BMItem();
         if(param2 == "item")
         {
            _loc6_ = dataM.itemsDB[param3];
            this.rarity = _loc6_.specialStatus;
         }
         if(param4)
         {
            this.rarity = 0;
         }
         switch(this.rarity)
         {
            case 1:
               this.mcCardBack = new grpItemCardBack1();
               this.mcCardFront = new grpItemCardFront1();
               break;
            case 2:
               this.mcCardBack = new grpItemCardBack2();
               this.mcCardFront = new grpItemCardFront2();
               break;
            case 3:
               this.mcCardBack = new grpItemCardBack3();
               this.mcCardFront = new grpItemCardFront3();
               break;
            case 4:
               this.mcCardBack = new grpItemCardBack4();
               this.mcCardFront = new grpItemCardFront4();
               break;
            default:
               this.mcCardBack = new grpItemCardBack0();
               this.mcCardFront = new grpItemCardFront0();
         }
         if(param5)
         {
            _loc13_ = new grpCardPowerIcon();
            _loc13_.x = 75;
            _loc13_.y = 123;
            this.mcCardBack.addChild(_loc13_);
         }
         this.mcCardFrontHolder.addChild(this.mcCardFront);
         this.mcCardFront.visible = false;
         this.mcCardBackHolder.addChild(this.mcCardBack);
         var _loc8_:Number = 1;
         _loc9_ = "";
         switch(param2)
         {
            case "gold":
               _loc7_ = new mcItemCardPic_gold();
               _loc10_ = "BONUS CARD";
               _loc11_ = "CREDITS";
               _loc12_ = "<FONT COLOR=\'#" + dataM.COLOR_GOLD + "\'>+" + dataM.getNumberWithComma(param3) + "</FONT>";
               break;
            case "XP":
               _loc7_ = new mcItemCardPic_XP();
               _loc10_ = "BONUS CARD";
               _loc11_ = "EXPERIENCE<BR>POINTS";
               _loc12_ = "+" + dataM.getNumberWithComma(param3);
               break;
            default:
               _loc7_ = externalAssetsM.getAsset(dataM.itemTypeSourceDB[_loc6_.type],_loc6_.grp,0,0,false,true);
               switch(_loc6_.type)
               {
                  case "kit":
                  case "module":
                     _loc8_ = 0.8;
               }
               _loc10_ = _loc6_.fullName;
               if(dataM.languageID == 2)
               {
                  _loc10_ = getSpecificText("item_" + _loc6_.itemID);
               }
               _loc14_ = getGeneralText(_loc6_.type);
               _loc15_ = dataM["player" + dataM.player1PlayerID + "Profile"];
               if(_loc6_.specialStatus == 4)
               {
                  _loc11_ = _loc14_;
               }
               else
               {
                  _loc16_ = String(_loc6_.level);
                  _loc11_ = getScreenText("description");
                  _loc11_ = dataM.replaceStringInText(_loc11_,"%TYPE%",_loc14_);
                  _loc11_ = dataM.replaceStringInText(_loc11_,"%LEVEL%",_loc16_);
               }
               _loc11_ = _loc9_ + _loc11_;
               _loc12_ = "";
         }
         this.mcItem.initialize(param3,this.mcSizer_item.width,this.mcSizer_item.height,_loc7_,0,0,true,null,dataM.runAsMobile);
         if(dataM.runAsMobile)
         {
            this.mcItem.convertMeIntoBitmap(true);
         }
         if(_loc8_ != 1)
         {
            this.mcItem.width *= _loc8_;
            this.mcItem.height *= _loc8_;
         }
         this.mcItem.x = this.mcSizer_item.x + this.mcSizer_item.width / 2 - this.mcItemHolder.x;
         this.mcItem.y = this.mcSizer_item.y + this.mcSizer_item.height / 2;
         TextUtils.updateTextFormat(this.txtName,13);
         TextUtils.updateTextFormat(this.txtDescription,13);
         TextUtils.updateTextFormat(this.txtBonus,25);
         this.txtName.htmlText = TextUtils.getTextFont() + _loc9_ + _loc10_;
         if(this.txtName.numLines == 1)
         {
            this.txtName.y += 8;
         }
         this.txtDescription.htmlText = TextUtils.getTextFont() + _loc11_;
         if(this.txtDescription.numLines == 1)
         {
            this.txtDescription.y += 12;
         }
         else if(param2 == "XP")
         {
            this.txtDescription.y += 3;
         }
         this.txtBonus.htmlText = TextUtils.getTextFont() + _loc12_;
         if(dataM.runAsMobile)
         {
            this.txtName.x += this.mcCardFront.width / 2;
            this.txtDescription.x += this.mcCardFront.width / 2;
            this.txtBonus.x += this.mcCardFront.width / 2;
            _loc17_ = new Array();
            _loc17_.push(this.txtName,this.txtDescription,this.txtBonus);
            _loc18_ = new Array();
            this.mcCardFront.visible = true;
            _loc18_.push(this.mcCardFront);
            _loc19_ = screensM.createAssetsBitmap(_loc17_,_loc18_,0,0);
            this.backgroundBMD = _loc19_[0];
            this.backgroundBM = _loc19_[1];
            this.mcItemHolder.addChild(this.backgroundBM);
            this.coverBMD = new BitmapData(this.mcCardBack.mcCoverGrp.width,this.mcCardBack.mcCoverGrp.height,true,0);
            this.coverBMD.draw(this.mcCardBack);
            this.coverBM = new Bitmap(this.coverBMD);
            this.mcCardBack.mcCoverGrp.parent.removeChild(this.mcCardBack.mcCoverGrp);
            this.mcCardBack.mcCoverGrp = null;
            this.mcCardBack.addChild(this.coverBM);
         }
         else
         {
            this.mcMouseHitArea.addEventListener(MouseEvent.CLICK,this.cardClicked);
         }
         this.mcItemHolder.addChild(this.mcItem);
      }
      
      public function disableClicks() : void
      {
         this._clickAllowed = false;
      }
      
      public function enableClicks() : void
      {
         this._clickAllowed = true;
      }
      
      private function cardClicked(param1:MouseEvent) : void
      {
         if(this._clickAllowed)
         {
            screensM.screenItemCards.itemCardClicked(this._cardID);
            if(dataM.runAsMobile == false)
            {
               this.mcMouseHitArea.removeEventListener(MouseEvent.CLICK,this.cardClicked);
            }
         }
      }
      
      private function cardMouseOver(param1:MouseEvent) : void
      {
         screensM.screenItemCards.cardMouseOver(this._cardID);
      }
      
      private function cardMouseOut(param1:MouseEvent) : void
      {
         screensM.screenItemCards.cardMouseOut(this._cardID);
      }
      
      public function removeMe() : void
      {
         if(this.mcItem != null)
         {
            this.mcItem.removeMe();
            this.mcItem = null;
         }
         if(this.backgroundBM != null)
         {
            this.backgroundBMD.dispose();
            this.backgroundBM.parent.removeChild(this.backgroundBM);
            this.backgroundBM = null;
            this.backgroundBMD = null;
         }
         if(this.coverBM != null)
         {
            this.coverBMD.dispose();
            this.coverBM.parent.removeChild(this.coverBM);
            this.coverBM = null;
            this.coverBMD = null;
         }
         if(parent != null)
         {
            parent.removeChild(this);
         }
      }
   }
}

