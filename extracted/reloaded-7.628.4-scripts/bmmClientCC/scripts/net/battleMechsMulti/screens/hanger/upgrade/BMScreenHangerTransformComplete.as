package net.battleMechsMulti.screens.hanger.upgrade
{
   import com.greensock.TimelineMax;
   import com.greensock.TweenMax;
   import com.greensock.easing.ElasticOut;
   import com.greensock.easing.Linear;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import net.battleMechsMulti.data.ItemRarityResolver;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.mobiles.itemProperties.BMItemPropertiesPanel;
   import net.battleMechsMulti.screens.BMBaseScreen;
   import net.battleMechsMulti.utils.BMItemShadowImage;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2937")]
   public class BMScreenHangerTransformComplete extends BMBaseScreen
   {
      
      public var mcButtonsHolder:Sprite;
      
      public var mcItemHolder:Sprite;
      
      public var mcItemFinalLocation:Sprite;
      
      public var mcBackground_black:Sprite;
      
      public var mcBackground_frame:Sprite;
      
      public var mcGlow:Sprite;
      
      public var mcRays:Sprite;
      
      public var mcWhiteLight:Sprite;
      
      public var mcItemTier:MovieClip;
      
      public var mcItemName:MovieClip;
      
      public var mcShineEffect:Sprite;
      
      public var mcItemProperties:MovieClip;
      
      public var btnOK:BMBasicButton;
      
      private var itemMainHolder:MovieClip;
      
      private var _itemTierTargetYPos:Number;
      
      private var _itemNameTargetYPos:Number;
      
      private var _btnOKTargetYPos:Number;
      
      private var _itemPropertiesTargetXPos:Number;
      
      private var _oldItemID:uint;
      
      private var _newItemID:uint;
      
      private var _itemPosition:Point;
      
      private var _itemInitialSize:uint;
      
      private var _oldItemDB:BMItemData;
      
      private var _newItemDB:BMItemData;
      
      private var _oldItemImage:MovieClip;
      
      private var _oldItemWhiteGlow:Sprite;
      
      private var _oldItemMask:MovieClip;
      
      private var _newItemImage:MovieClip;
      
      private var _newItemWhiteGlow:Sprite;
      
      private var _newItemMask:MovieClip;
      
      private var _targetScale:Number;
      
      private var _timeLine:TimelineMax;
      
      private var _upgardCompleted:* = false;
      
      private var _colorID:int;
      
      public function BMScreenHangerTransformComplete()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers();
         setLanguageManagerScreenName("upgrade");
         this.btnOK.addEventListener(BMIntractable.HIT,this.onOkHit);
      }
      
      public function refreshScreen(param1:uint, param2:uint, param3:Point, param4:uint, param5:int) : void
      {
         this._oldItemID = param1;
         this._newItemID = param2;
         this._itemPosition = param3;
         this._itemInitialSize = param4;
         this._colorID = param5;
         this._oldItemDB = dataM.itemsDB[this._oldItemID];
         this._newItemDB = dataM.itemsDB[this._newItemID];
         this._targetScale = 3;
         this.btnOK.disableMe();
         this._timeLine = new TimelineMax({"onComplete":this.onAnimComplete});
         this.mcBackground_black.alpha = 0;
         this.mcBackground_frame.visible = false;
         this._timeLine.to(this.mcBackground_black,1,{"alpha":1});
         this.itemMainHolder = new MovieClip();
         this.itemMainHolder.x = this._itemPosition.x;
         this.itemMainHolder.y = this._itemPosition.y;
         this.mcRays.parent.removeChild(this.mcRays);
         this.mcGlow.parent.removeChild(this.mcGlow);
         this.itemMainHolder.addChild(this.mcGlow);
         this.itemMainHolder.addChild(this.mcRays);
         this.mcRays.x = 0;
         this.mcRays.y = 0;
         this.mcRays.visible = false;
         this.mcGlow.x = 0;
         this.mcGlow.y = 0;
         this.mcGlow.visible = false;
         this.mcShineEffect.scaleX /= this._targetScale;
         this.mcShineEffect.scaleY /= this._targetScale;
         this._itemTierTargetYPos = this.mcItemTier.y;
         this._itemNameTargetYPos = this.mcItemName.y;
         this._btnOKTargetYPos = this.btnOK.y;
         this._itemPropertiesTargetXPos = this.mcItemProperties.x;
         this.mcItemTier.y -= 400;
         this.mcItemName.y += 400;
         this.btnOK.y += 400;
         this.mcItemProperties.x = -500;
         this.mcItemHolder.addChild(this.itemMainHolder);
         this.createOldItem();
         this.createNewItem();
         this.createTexts();
         this.mcWhiteLight.visible = false;
         this.mcWhiteLight.x = 0;
         this.mcWhiteLight.y = 0;
         this.mcWhiteLight.parent.removeChild(this.mcWhiteLight);
         this.itemMainHolder.addChild(this.mcWhiteLight);
         var _loc6_:Number = 0;
         this._timeLine.to(this.itemMainHolder,0.5,{
            "x":400,
            "y":240,
            "scaleX":this._targetScale,
            "scaleY":this._targetScale
         },_loc6_);
         _loc6_ = 1.5;
         this._timeLine.to(this._oldItemImage,0.4,{"colorTransform":{
            "tint":16777215,
            "tintAmount":1
         }},_loc6_);
         this._timeLine.set(this._oldItemImage,{"visible":false},_loc6_ + 0.4);
         _loc6_ = 1.9;
         this._timeLine.set(this.mcWhiteLight,{
            "visible":true,
            "scaleX":0.1,
            "scaleY":0.1
         },_loc6_ - 0.2);
         this._timeLine.to(this.mcWhiteLight,0.2,{
            "scaleX":1.2,
            "scaleY":1.2
         },_loc6_ - 0.2);
         this._timeLine.to(this.mcWhiteLight,0.2,{
            "scaleX":0.1,
            "scaleY":0.1,
            "alpha":0
         },_loc6_);
         this._timeLine.set(this.mcWhiteLight,{"visible":false},_loc6_ + 0.2);
         this._timeLine.set(this._newItemImage,{
            "visible":true,
            "colorTransform":{
               "tint":16777215,
               "tintAmount":1
            }
         },_loc6_);
         this._timeLine.to(this._newItemImage,0.4,{"colorTransform":{
            "tint":16777215,
            "tintAmount":0
         }},_loc6_);
         this._timeLine.to(this._newItemImage,0.4,{
            "scaleX":1.1,
            "scaleY":1.1,
            "ease":ElasticOut.ease
         },_loc6_ + 0.1);
         _loc6_ = 2;
         this._timeLine.set(this.mcGlow,{
            "visible":true,
            "scaleX":0.05,
            "scaleY":0.05,
            "onComplete":this.tempFunc
         },_loc6_);
         this._timeLine.to(this.mcGlow,0.7,{
            "scaleX":1,
            "scaleY":1
         },_loc6_);
         this._timeLine.set(this.mcRays,{
            "visible":true,
            "scaleX":0.05,
            "scaleY":0.05
         },_loc6_);
         this._timeLine.to(this.mcRays,0.7,{
            "scaleX":1,
            "scaleY":1
         },_loc6_);
         _loc6_ = 3;
         this._timeLine.to(this.itemMainHolder,1,{
            "x":this.mcItemFinalLocation.x,
            "y":this.mcItemFinalLocation.y,
            "scaleX":this._targetScale * 0.8,
            "scaleY":this._targetScale * 0.8
         },_loc6_);
         this._timeLine.to(this.mcItemProperties,0.4,{"x":this._itemPropertiesTargetXPos},_loc6_);
         this._timeLine.to(this.mcItemTier,0.2,{"y":this._itemTierTargetYPos},_loc6_ + 0.1);
         this._timeLine.to(this.mcItemName,0.2,{"y":this._itemNameTargetYPos},_loc6_ + 0.2);
         this._timeLine.to(this.btnOK,0.2,{"y":this._btnOKTargetYPos},_loc6_ + 0.3);
         var _loc7_:BMItemPropertiesPanel = new BMItemPropertiesPanel();
         _loc7_.propertiesPerLine = 1;
         _loc7_.propetyViewCls = BMTransformItemProperty;
         _loc7_.showDifference(this._oldItemDB,this._newItemDB,false);
         if(this._newItemDB.specialStatus == ItemRarityResolver.RARITY_ASCENDED)
         {
            updateTextAndFormat(this.mcItemProperties.txtLevel,getSpecificText("arenaShop_maxed"));
         }
         else
         {
            updateTextAndFormat(this.mcItemProperties.txtLevel,getGeneralText("levelCaps") + " " + this._newItemDB.displayLevel);
         }
         this.mcItemProperties.mcPropertiesHolder.addChild(_loc7_);
         this.mcItemProperties.y = (480 - this.mcItemProperties.height) / 2;
      }
      
      private function tempFunc() : void
      {
         TweenMax.to(this.mcRays,8,{
            "rotation":360,
            "ease":Linear.ease,
            "repeat":-1
         });
      }
      
      private function createOldItem() : void
      {
         this._oldItemImage = this.createItemImage(this._oldItemDB);
         this.itemMainHolder.addChild(this._oldItemImage);
      }
      
      private function createNewItem() : void
      {
         this._newItemImage = this.createItemImage(this._newItemDB);
         this._newItemImage.visible = false;
         this.itemMainHolder.addChild(this._newItemImage);
      }
      
      private function createItemImage(param1:BMItemData) : MovieClip
      {
         var _loc2_:uint = this._itemInitialSize;
         var _loc3_:String = dataM.itemTypeSourceDB[param1.type];
         var _loc4_:MovieClip = externalAssetsM.getAsset(_loc3_,param1.grp,0,0);
         if(this._colorID != 0)
         {
            dataM.colorItemGrp(_loc4_,this._colorID);
         }
         McUtils.resize(_loc4_,_loc2_);
         var _loc5_:uint = uint("0x" + ItemRarityResolver.getItemTierColor(param1.specialStatus));
         return BMItemShadowImage.createItemShadowImage(_loc4_,_loc2_,false,0,_loc5_,true,dataM.runAsMobile);
      }
      
      private function createTexts() : void
      {
         var _loc1_:String = "<FONT COLOR=\'#" + ItemRarityResolver.getItemTierColor(this._newItemDB.specialStatus) + "\'>";
         _loc1_ = _loc1_ + ItemRarityResolver.getItemTierName(this._newItemDB.specialStatus) + "</FONT>";
         updateTextAndFormat(this.mcItemTier.txtTitle,_loc1_);
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("itemTierTitle",[this.mcItemTier.txtTitle],"",this.mcItemTier);
         }
         this.mcItemTier.mcBackground.gotoAndStop(this._newItemDB.specialStatus);
         updateTextAndFormat(this.mcItemName.txtName,languageM.getItemNameByItemData(this._newItemDB));
         updateTextAndFormat(this.mcItemProperties.txtTitle,getScreenText("itemTransformed"));
         this.btnOK.text = getScreenText("awesome");
      }
      
      public function onUpgradeSuccess() : *
      {
         this._upgardCompleted = true;
         if(!this._timeLine.isActive())
         {
            this.btnOK.enableMe();
         }
      }
      
      private function onAnimComplete() : void
      {
         if(this._upgardCompleted)
         {
            this.btnOK.enableMe();
         }
      }
      
      private function onOkHit(param1:Event) : void
      {
         this.backClicked();
      }
      
      public function backClicked() : void
      {
         if(Boolean(this._upgardCompleted) && !this._timeLine.isActive())
         {
            screensM.screenHangerUpgrade.onUpgradeComplete();
            screensM.removeScreen("screenHangerTransformComplete");
         }
      }
   }
}

