package net.battleMechsMulti.mobiles
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Linear;
   import com.greensock.easing.Power1;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.battleMechsMulti.data.ItemRarityResolver;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol5184")]
   public class BMItemCard extends BMBaseClass
   {
      
      public static const EXTRA_CARD:uint = 100;
      
      public var txtName:TextField;
      
      public var txtDescription:TextField;
      
      public var txtBonus:TextField;
      
      public var txtRarity:TextField;
      
      public var mcSizer_item:Sprite;
      
      public var mcSizer_icon1:Sprite;
      
      public var mcSizer_icon2:Sprite;
      
      public var mcSizer_icon3:Sprite;
      
      public var mcSizer_icon4:Sprite;
      
      public var mcMouseHitArea:Sprite;
      
      public var mcItemHolder:Sprite;
      
      public var mcInnerGlowHolder:Sprite;
      
      public var mcCardFront:Sprite;
      
      public var mcCardBack:MovieClip;
      
      public var mcCardBackHolder:Sprite;
      
      public var mcCardFrontHolder:Sprite;
      
      public var mcLightEffect:MovieClip;
      
      public var rarity:uint = 0;
      
      public var glowCounter:Number = -1;
      
      public var targetXPos:Number;
      
      public var targetYPos:Number;
      
      public var mcOuterGlow1:Sprite;
      
      public var mcOuterGlow2:Sprite;
      
      public var mcFrontOuterGlowHolder:Sprite;
      
      private var mcItem:BMItem;
      
      private var _cardID:Number;
      
      private var _clickAllowed:Boolean;
      
      private var _cardFrontVisible:Boolean;
      
      private var _itemOriginalYPos:Number;
      
      private var coverBMD:BitmapData;
      
      private var coverBM:Bitmap;
      
      private var textsBMD:BitmapData;
      
      private var textsBM:Bitmap;
      
      private var _itemAnimationDistance:uint = 5;
      
      private var _itemAnimationSegmentDuration:Number = 2;
      
      private var _rotationAngle:int;
      
      private var mcGlow:Sprite;
      
      public function BMItemCard()
      {
         super();
      }
      
      public function initialize(param1:Number, param2:Number, param3:Boolean, param4:Boolean, param5:Boolean) : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("itemCards");
         this._cardID = param1;
         this._cardFrontVisible = param5;
         this.mcItem = new BMItem();
         var _loc6_:BMItemData = null;
         this.rarity = ItemRarityResolver.RARITY_COMMON;
         if(param2 > 0)
         {
            _loc6_ = dataM.itemsDB[param2];
            this.rarity = _loc6_.specialStatusForDisplay;
         }
         else
         {
            this.rarity = EXTRA_CARD;
         }
         if(dataM.clientRunningLocally)
         {
         }
         switch(this.rarity)
         {
            case ItemRarityResolver.RARITY_RARE:
               this.mcCardBack = new grpItemCardBack1();
               break;
            case ItemRarityResolver.RARITY_EPIC:
               this.mcCardBack = new grpItemCardBack2();
               break;
            case ItemRarityResolver.RARITY_LEGENDARY:
               this.mcCardBack = new grpItemCardBack3();
               break;
            case ItemRarityResolver.RARITY_MYTHICAL:
               this.mcCardBack = new grpItemCardBack4();
               break;
            case EXTRA_CARD:
               this.mcCardBack = new grpItemCardBack100();
               break;
            default:
               this.mcCardBack = new grpItemCardBack0();
         }
         this.mcCardBack.visible = param4;
         this.mcCardBackHolder.addChild(this.mcCardBack);
         if(dataM.runAsMobile == false)
         {
            this.mcMouseHitArea.addEventListener(MouseEvent.CLICK,this.cardClicked);
         }
         if(_loc6_ != null)
         {
            this.addCardItemAndTexts(param2);
         }
      }
      
      public function activateLightEffect(param1:Number = 0) : void
      {
         TweenMax.fromTo(this.mcLightEffect,0.3,{"y":-235},{
            "delay":param1,
            "y":125,
            "ease":Linear.easeNone
         });
      }
      
      public function addOuterGlow() : void
      {
         if(this.mcOuterGlow1 == null)
         {
            return;
         }
         if(this.mcOuterGlow1.parent == null)
         {
            return;
         }
         this.mcOuterGlow1.visible = true;
         this.mcOuterGlow2.visible = true;
         var _loc1_:uint = Math.ceil(Math.random() * 360);
         this.mcOuterGlow1.rotation += _loc1_;
         this.mcOuterGlow2.rotation += _loc1_;
         TweenMax.to(this.mcOuterGlow1,40,{
            "rotation":this.mcOuterGlow1.rotation + 360,
            "repeat":-1,
            "ease":Linear.easeNone
         });
         TweenMax.to(this.mcOuterGlow2,55,{
            "rotation":this.mcOuterGlow2.rotation - 360,
            "repeat":-1,
            "ease":Linear.easeNone
         });
      }
      
      public function removeOuterGlow() : void
      {
         if(this.mcOuterGlow1 == null)
         {
            return;
         }
         if(this.mcOuterGlow1.parent == null)
         {
            return;
         }
         this.mcOuterGlow1.parent.removeChild(this.mcOuterGlow1);
         this.mcOuterGlow2.parent.removeChild(this.mcOuterGlow2);
         this.mcOuterGlow1 = null;
         this.mcOuterGlow2 = null;
      }
      
      public function switchOuterGlowToFrontMask() : void
      {
         if(this.mcOuterGlow1 == null)
         {
            return;
         }
         if(this.mcOuterGlow1.visible == false)
         {
            return;
         }
         if(this.mcOuterGlow1.parent == null)
         {
            return;
         }
         this.mcOuterGlow1.parent.removeChild(this.mcOuterGlow1);
         this.mcOuterGlow2.parent.removeChild(this.mcOuterGlow2);
         this.mcFrontOuterGlowHolder.addChild(this.mcOuterGlow1);
         this.mcFrontOuterGlowHolder.addChild(this.mcOuterGlow2);
      }
      
      public function addCardItemAndTexts(param1:uint) : void
      {
         var _loc2_:BMItemData = dataM.itemsDB[param1];
         var _loc3_:MovieClip = externalAssetsM.getAsset(dataM.itemTypeSourceDB[_loc2_.type],_loc2_.grp,0,0,false,true);
         if(_loc3_.loading)
         {
            externalAssetsM.modifyExternalAssetDuplicationContainer(_loc3_,true,0,this.addCardItemAndTextsSub,[param1]);
         }
         else
         {
            this.addCardItemAndTextsSub(_loc3_,[param1]);
         }
      }
      
      public function get fixedWidth() : Number
      {
         return this.mcMouseHitArea.width;
      }
      
      public function get fixedHeight() : Number
      {
         return this.mcMouseHitArea.height;
      }
      
      private function addCardItemAndTextsSub(param1:MovieClip, param2:Array) : void
      {
         var _loc3_:uint = uint(param2[0]);
         var _loc4_:BMItemData = dataM.itemsDB[_loc3_];
         this.rarity = _loc4_.specialStatusForDisplay;
         if(dataM.clientRunningLocally)
         {
         }
         switch(this.rarity)
         {
            case ItemRarityResolver.RARITY_RARE:
               this.mcCardFront = new grpItemCardFront1();
               break;
            case ItemRarityResolver.RARITY_EPIC:
               this.mcCardFront = new grpItemCardFront2();
               break;
            case ItemRarityResolver.RARITY_LEGENDARY:
               this.mcCardFront = new grpItemCardFront3();
               break;
            case ItemRarityResolver.RARITY_MYTHICAL:
               this.mcCardFront = new grpItemCardFront4();
               break;
            case EXTRA_CARD:
               this.mcCardFront = new grpItemCardFront0();
               break;
            default:
               this.mcCardFront = new grpItemCardFront0();
         }
         this.mcCardFrontHolder.addChild(this.mcCardFront);
         this.mcCardFront.visible = this._cardFrontVisible;
         var _loc5_:Number = 1;
         var _loc6_:String = "";
         var _loc7_:String = "";
         switch(_loc4_.type)
         {
            case BMMechStructure.KIT:
            case BMMechStructure.MODULE:
               _loc5_ = 0.8;
         }
         var _loc8_:String = languageM.getItemNameByItemData(_loc4_);
         var _loc9_:String = getGeneralText(_loc4_.type);
         var _loc10_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc11_:String = _loc9_;
         switch(_loc4_.specialStatus)
         {
            case ItemRarityResolver.RARITY_COMMON:
               _loc6_ = "<FONT COLOR=\'#" + ItemRarityResolver.COLOR_COMMON_ITEM + "\'>" + getGeneralText("common") + "</FONT>";
               break;
            case ItemRarityResolver.RARITY_RARE:
               _loc6_ = "<FONT COLOR=\'#" + ItemRarityResolver.COLOR_RARE_ITEM + "\'>" + getGeneralText("rare") + "</FONT>";
               break;
            case ItemRarityResolver.RARITY_EPIC:
               _loc6_ = "<FONT COLOR=\'#" + ItemRarityResolver.COLOR_EPIC_ITEM + "\'>" + getGeneralText("epic") + "</FONT>";
               break;
            case ItemRarityResolver.RARITY_LEGENDARY:
               _loc6_ = "<FONT COLOR=\'#" + ItemRarityResolver.COLOR_LEGENDARY_ITEM + "\'>" + getGeneralText("legendary") + "</FONT>";
               break;
            case ItemRarityResolver.RARITY_MYTHICAL:
               _loc6_ = "<FONT COLOR=\'#" + ItemRarityResolver.COLOR_MYTHICAL_ITEM + "\'>" + getGeneralText("mythical") + "</FONT>";
               break;
            default:
               _loc6_ = "<FONT COLOR=\'#" + ItemRarityResolver.COLOR_PERK + "\'>" + getGeneralText("perk") + "</FONT>";
         }
         this.mcItem.initialize(_loc3_,this.mcSizer_item.width,this.mcSizer_item.height,param1,0,0,true,null,dataM.runAsMobile);
         if(dataM.runAsMobile)
         {
            this.mcItem.convertMeIntoBitmap(true);
         }
         if(_loc5_ != 1)
         {
            this.mcItem.width *= _loc5_;
            this.mcItem.height *= _loc5_;
         }
         this.mcItem.x = this.mcSizer_item.x + this.mcSizer_item.width / 2 - this.mcItemHolder.x;
         this._itemOriginalYPos = this.mcSizer_item.y + this.mcSizer_item.height / 2;
         this.mcItem.y = this._itemOriginalYPos;
         TextUtils.updateTextFormat(this.txtName,13);
         TextUtils.updateTextFormat(this.txtDescription,13);
         TextUtils.updateTextFormat(this.txtBonus,25);
         TextUtils.updateTextFormat(this.txtBonus,14);
         updateTextAndFormat(this.txtName,_loc8_);
         if(this.txtName.numLines == 1)
         {
            this.txtName.y += 8;
         }
         updateTextAndFormat(this.txtDescription,_loc11_);
         if(this.txtName.numLines == 1)
         {
            this.txtDescription.y -= 9;
         }
         updateTextAndFormat(this.txtRarity,_loc6_);
         updateTextAndFormat(this.txtBonus,_loc7_);
         if(dataM.runAsMobile)
         {
            this.completeConvertionOfAssetsToBitmaps();
         }
         this.mcItemHolder.addChild(this.mcItem);
      }
      
      public function activateRotation(param1:uint) : void
      {
         this._rotationAngle = param1;
         this.rotationAnimHandler();
      }
      
      private function rotationAnimHandler() : void
      {
         if(Math.abs(this._rotationAngle) < 1)
         {
            return;
         }
         if(this._rotationAngle > 0)
         {
            --this._rotationAngle;
         }
         else
         {
            this._rotationAngle += 1;
         }
         this._rotationAngle *= -1;
         TweenMax.to(this,0.05,{
            "rotation":this._rotationAngle,
            "onComplete":this.rotationAnimHandler
         });
      }
      
      private function rotationOnEnterFrame(param1:Event) : void
      {
         if(Math.abs(this._rotationAngle) < 1)
         {
            rotation = 0;
            removeEventListener(Event.ENTER_FRAME,this.rotationOnEnterFrame);
            return;
         }
         rotation = this._rotationAngle;
         if(this._rotationAngle > 0)
         {
            --this._rotationAngle;
         }
         else
         {
            this._rotationAngle += 1;
         }
         this._rotationAngle *= -1;
      }
      
      public function activateItemInnerGlow() : void
      {
         if(this.mcGlow != null)
         {
            return;
         }
         switch(this.rarity)
         {
            case ItemRarityResolver.RARITY_EPIC:
               this.mcGlow = new itemCardInnerGlow2();
               break;
            case ItemRarityResolver.RARITY_LEGENDARY:
               this.mcGlow = new itemCardInnerGlow3();
               break;
            case ItemRarityResolver.RARITY_MYTHICAL:
               this.mcGlow = new itemCardInnerGlow4();
               break;
            default:
               return;
         }
         TweenMax.to(this.mcGlow,50,{
            "rotation":360,
            "repeat":-1,
            "ease":Linear.easeNone
         });
         this.mcInnerGlowHolder.addChild(this.mcGlow);
      }
      
      public function activateItemAnimation() : void
      {
         if(this.mcItem == null)
         {
            return;
         }
         this.itemAnimComplete("down1");
      }
      
      private function itemAnimComplete(param1:String) : void
      {
         var _loc3_:String = null;
         var _loc2_:int = this._itemOriginalYPos;
         var _loc4_:* = Power1.easeOut;
         switch(param1)
         {
            case "down1":
               _loc3_ = "down2";
               _loc2_ += this._itemAnimationDistance;
               break;
            case "down2":
               _loc4_ = Power1.easeIn;
               _loc3_ = "up1";
               break;
            case "up1":
               _loc3_ = "up2";
               _loc2_ -= this._itemAnimationDistance;
               break;
            case "up2":
               _loc4_ = Power1.easeIn;
               _loc3_ = "down1";
         }
         TweenMax.to(this.mcItem,this._itemAnimationSegmentDuration,{
            "y":_loc2_,
            "ease":_loc4_,
            "onComplete":this.itemAnimComplete,
            "onCompleteParams":[_loc3_]
         });
      }
      
      private function completeConvertionOfAssetsToBitmaps() : void
      {
         this.txtName.x += this.fixedWidth / 2;
         this.txtName.y += this.fixedHeight / 2;
         this.txtDescription.x += this.fixedWidth / 2;
         this.txtDescription.y += this.fixedHeight / 2;
         this.txtBonus.x += this.fixedWidth / 2;
         this.txtBonus.y += this.fixedHeight / 2;
         this.txtRarity.x += this.fixedWidth / 2;
         this.txtRarity.y += this.fixedHeight / 2;
         var _loc1_:Array = new Array();
         _loc1_.push(this.txtName,this.txtDescription,this.txtBonus,this.txtRarity);
         var _loc2_:Array = screensM.createAssetsBitmap(_loc1_,[],0,0);
         this.textsBMD = _loc2_[0];
         this.textsBM = _loc2_[1];
         this.textsBM.x -= this.fixedWidth / 2;
         this.textsBM.y -= this.fixedHeight / 2;
         this.mcItemHolder.addChild(this.textsBM);
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
         if(this._clickAllowed == false)
         {
            return;
         }
         if(dataM.runAsMobile == false)
         {
            this.mcMouseHitArea.removeEventListener(MouseEvent.CLICK,this.cardClicked);
         }
         screensM.screenItemCards.itemCardClicked(this._cardID);
      }
      
      public function readdClickEvent() : void
      {
         if(dataM.runAsMobile == false)
         {
            this.mcMouseHitArea.addEventListener(MouseEvent.CLICK,this.cardClicked);
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
      
      public function get isEpicOrBetter() : Boolean
      {
         return this.isEpic || this.isLegendary || this.isMythical;
      }
      
      public function get isLegendaryOrBetter() : Boolean
      {
         return this.isLegendary || this.isMythical;
      }
      
      public function get isEpic() : Boolean
      {
         return this.rarity == ItemRarityResolver.RARITY_EPIC;
      }
      
      public function get isLegendary() : Boolean
      {
         return this.rarity == ItemRarityResolver.RARITY_LEGENDARY;
      }
      
      public function get isMythical() : Boolean
      {
         return this.rarity == ItemRarityResolver.RARITY_MYTHICAL;
      }
      
      public function removeMe() : void
      {
         TweenMax.killTweensOf(this.mcItem);
         TweenMax.killTweensOf(this.mcOuterGlow1);
         TweenMax.killTweensOf(this.mcOuterGlow2);
         TweenMax.killTweensOf(this.mcLightEffect);
         removeEventListener(Event.ENTER_FRAME,this.rotationOnEnterFrame);
         if(this.mcItem != null)
         {
            this.mcItem.removeMe();
            this.mcItem = null;
         }
         if(this.textsBM != null)
         {
            this.textsBMD.dispose();
            this.textsBM.parent.removeChild(this.textsBM);
            this.textsBM = null;
            this.textsBMD = null;
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

