package net.battleMechsMulti.screens.hanger.upgrade
{
   import com.greensock.TimelineMax;
   import com.greensock.TweenMax;
   import com.greensock.easing.Cubic;
   import com.greensock.easing.Linear;
   import com.greensock.easing.Sine;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import net.battleMechsMulti.managers.upgrade.BMItemUpgradeData;
   import net.battleMechsMulti.managers.upgrade.BMUpgradeManager;
   import net.battleMechsMulti.mobiles.BMBar;
   import net.battleMechsMulti.mobiles.BMItem;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.mobiles.itemProperties.BMDefaultItemProperty;
   import net.battleMechsMulti.mobiles.itemProperties.BMItemPropertiesPanel;
   import net.battleMechsMulti.mobiles.pointersAndMarkers.BMTutorialArrowController;
   import net.battleMechsMulti.screens.BMBaseScreen;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1501")]
   public class BMScreenHangerBoostComplete extends BMBaseScreen
   {
      
      public var itemProperties:BMItemPropertiesPanel;
      
      public var targetItemSizer:Sprite;
      
      public var btnOK:BMBasicButton;
      
      public var mcRays:MovieClip;
      
      public var mcGlow:MovieClip;
      
      public var mcDetails:MovieClip;
      
      public var mcNameAndPower:MovieClip;
      
      public var mcTutorialArrow:MovieClip;
      
      private var _sourcePower:Number;
      
      private var _targetItmID:Number;
      
      private var _currentPower:int;
      
      private var _addedPower:int;
      
      private var _upgradeManager:BMUpgradeManager;
      
      private var _timeLine:TimelineMax;
      
      private var _itemLevelUpTimeLine:TimelineMax = new TimelineMax();
      
      private var _itemHolder:Sprite;
      
      private var _boostLevel:int;
      
      private var _upgardCompleted:Boolean;
      
      private var _tutorialArrowController:BMTutorialArrowController;
      
      private var _upgardeData:BMItemUpgradeData;
      
      private var _itemData:BMItemData;
      
      public function BMScreenHangerBoostComplete()
      {
         this._timeLine = new TimelineMax({"onComplete":this.onAnimComplete});
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         this._upgradeManager = BMUpgradeManager.gi();
         this.itemProperties = new BMItemPropertiesPanel();
         this.mcDetails.addChild(this.itemProperties);
         this.itemProperties.x = this.mcDetails.itemPropertiesLocation.x;
         this.itemProperties.y = this.mcDetails.itemPropertiesLocation.y;
         this.itemProperties.propertiesPerLine = 1;
         this._itemHolder = new Sprite();
         addChild(this._itemHolder);
         this.itemProperties.propetyViewCls = BMBoostCompleteItemProperty;
         this.mcDetails.mcItemTier.txtTitle.text = "";
         this.btnOK.text = "SWEET!";
         this.btnOK.addEventListener(BMIntractable.HIT,this.onOkHit);
         this.initializeTutorialArrow();
      }
      
      public function setData(param1:Number, param2:int, param3:int, param4:Point) : *
      {
         this._targetItmID = param1;
         this._currentPower = param2;
         this._addedPower = param3;
         this._upgardCompleted = false;
         this.btnOK.disableMe();
         this._upgardeData = this._upgradeManager.getUpgradeData(this._targetItmID,this._currentPower,this._addedPower);
         this._itemData = dataM.itemsDB[this._targetItmID];
         this.mcDetails.mcItemTier.mcBackground.gotoAndStop(this._itemData.specialStatus);
         this.setInfo(this._itemData);
         this.setItemImage(this._itemData);
         if(this._upgardeData.newItemData.isMaxLevel())
         {
            this._addedPower = this._upgardeData.newItemData.minPowerToHave - param2;
         }
         this.boostLevel = 0;
         this.sourcePower = 0;
         var _loc5_:Number = 0.3;
         var _loc6_:Point = new Point(this.targetItemSizer.x + this.targetItemSizer.width / 2,this.targetItemSizer.y + this.targetItemSizer.height / 2);
         this._timeLine.to(this._itemHolder,_loc5_,{
            "x":_loc6_.x,
            "y":_loc6_.y,
            "scaleX":1,
            "scaleY":1,
            "onComplete":this.doUpgradeAnim
         },0);
         this._timeLine.to(this.mcDetails,0.3,{"x":this.mcDetails.x},0.2);
         this._timeLine.to(this.mcNameAndPower,0.3,{"y":this.mcNameAndPower.y},0.4);
         this._timeLine.to(this.btnOK,0.3,{"y":this.btnOK.y},0.6);
         this._timeLine.set(this.mcGlow,{
            "visible":true,
            "scaleX":0.1,
            "scaleY":0.1
         },_loc5_);
         this._timeLine.set(this.mcRays,{
            "visible":true,
            "scaleX":0.1,
            "scaleY":0.1
         },_loc5_);
         this._timeLine.to(this.mcGlow,1,{
            "scaleX":1,
            "scaleY":1,
            "onComplete":this.glowSizeIncrease
         },_loc5_);
         this._timeLine.to(this.mcRays,1,{
            "scaleX":1,
            "scaleY":1,
            "onComplete":this.raysSizeIncrease
         },_loc5_);
         TweenMax.to(this.mcRays,15,{
            "rotation":360,
            "ease":Linear.easeNone,
            "repeat":-1
         });
         this._timeLine.set(this._itemHolder,{
            "x":param4.x,
            "y":param4.y,
            "scaleX":0.6,
            "scaleY":0.6
         },0);
         this._timeLine.set(this.mcDetails,{"x":this.mcDetails.x - 500},0);
         this._timeLine.set(this.mcNameAndPower,{"y":this.mcNameAndPower.y + 500},0);
         this._timeLine.set(this.btnOK,{"y":this.btnOK.y + 500},0);
         this._timeLine.set(this.mcGlow,{"visible":false},0);
         this._timeLine.set(this.mcRays,{"visible":false},0);
      }
      
      private function doUpgradeAnim() : void
      {
         var _loc1_:int = Math.abs(this._upgardeData.newItemData.displayLevel - this._itemData.displayLevel);
         this.doAnim(_loc1_,this._upgardeData.newItemData);
      }
      
      private function raysSizeIncrease() : void
      {
         TweenMax.to(this.mcRays,2,{
            "scaleX":1.1,
            "scaleY":1.1,
            "onComplete":this.raysSizeDecrease
         });
      }
      
      private function raysSizeDecrease() : void
      {
         TweenMax.to(this.mcRays,2,{
            "scaleX":0.9,
            "scaleY":0.9,
            "onComplete":this.raysSizeIncrease
         });
      }
      
      private function glowSizeIncrease() : void
      {
         TweenMax.to(this.mcGlow,2.6,{
            "scaleX":1.1,
            "scaleY":1.1,
            "onComplete":this.glowSizeDecrease
         });
      }
      
      private function glowSizeDecrease() : void
      {
         TweenMax.to(this.mcGlow,2.6,{
            "scaleX":1,
            "scaleY":1,
            "onComplete":this.glowSizeIncrease
         });
      }
      
      private function doAnim(param1:int, param2:BMItemData) : void
      {
         var _loc3_:Number = 0.6 + param1 * 0.2;
         if(_loc3_ > 4)
         {
            _loc3_ = 4;
         }
         this._timeLine.to(this._itemHolder,0.3,{
            "scaleX":1.2,
            "scaleY":1.2
         });
         this._timeLine.to(this._itemHolder,0.3,{
            "scaleX":1,
            "scaleY":1,
            "ease":Cubic.easeInOut
         });
         this._timeLine.to(this,_loc3_,{
            "sourcePower":this._addedPower,
            "ease":Sine.easeOut
         });
         this._timeLine.addLabel("brb");
         this._timeLine.addLabel("props","brb+=0.5");
         this._timeLine.call(this.addPropertiesAnim,null,"props");
         this._timeLine.call(this.setInfo,[param2],"props+=0.3");
      }
      
      private function addPropertiesAnim() : void
      {
         var _loc2_:BMDefaultItemProperty = null;
         this._timeLine.to(this.mcDetails.txtBoostLevel,0.5,{
            "x":this.mcDetails.txtBoostLevel.x - 80,
            "autoAlpha":0
         },"props");
         var _loc1_:int = 0;
         while(_loc1_ < this.itemProperties.numChildren)
         {
            _loc2_ = this.itemProperties.getChildAt(_loc1_) as BMDefaultItemProperty;
            if(_loc2_.txtBonus.text != "")
            {
               this._timeLine.to(_loc2_.txtBonus,0.5,{
                  "x":_loc2_.txtBonus.x - 120,
                  "autoAlpha":0
               },"props");
            }
            _loc1_++;
         }
      }
      
      public function onUpgradeSuccess() : *
      {
         if(this._upgardCompleted && !this._timeLine.isActive())
         {
            this.enableOKButton();
         }
         this._upgardCompleted = true;
      }
      
      private function onAnimComplete() : void
      {
         if(this._upgardCompleted && !this._timeLine.isActive())
         {
            this.enableOKButton();
         }
      }
      
      private function enableOKButton() : void
      {
         this.btnOK.enableMe();
         if(tutorialM.isTutorialActive())
         {
            this.activateBackTutorialArrow();
         }
      }
      
      private function onOkHit(param1:Event) : void
      {
         this.backClicked();
      }
      
      public function backClicked() : void
      {
         if(this._upgardCompleted && !this._timeLine.isActive())
         {
            screensM.screenHangerUpgrade.onUpgradeComplete();
            screensM.removeScreen("screenHangerBoostComplete");
         }
      }
      
      private function setInfo(param1:BMItemData) : void
      {
         this.itemName = param1.fullName;
         this.level = "Level " + param1.displayLevel + " / " + this._upgradeManager.getItemMaxLevel(param1.itemID);
         this.itemProperties.show(param1);
         this.mcDetails.y = (dataM.STAGE_HEIGHT - this.mcDetails.height) / 2;
      }
      
      private function setItemImage(param1:BMItemData) : void
      {
         var _loc2_:BMItem = null;
         while(this._itemHolder.numChildren > 0)
         {
            this._itemHolder.removeChildAt(0);
         }
         _loc2_ = new BMItem();
         var _loc3_:MovieClip = externalAssetsM.getAsset(dataM.itemTypeSourceDB[param1.type],param1.grp,0,0,true,true);
         _loc3_.filters = [new GlowFilter(0,1,4,4,7)];
         _loc2_.initialize(-1,this.targetItemSizer.width,this.targetItemSizer.height,_loc3_,6,6,false,null,false);
         dataM.colorItem(_loc2_,dataM.getItemColorByLevel(param1.displayLevel,param1.type));
         _loc2_.x = -this.targetItemSizer.width / 2;
         _loc2_.y = -this.targetItemSizer.height / 2;
         this._itemHolder.addChild(_loc2_);
      }
      
      public function set sourcePower(param1:Number) : void
      {
         this._sourcePower = param1;
         var _loc2_:int = int(this._sourcePower);
         var _loc3_:BMItemUpgradeData = this._upgradeManager.getUpgradeData(this._targetItmID,this._currentPower,_loc2_);
         var _loc4_:BMItemData = _loc3_.newItemData;
         var _loc5_:BMItemData = dataM.itemsDB[this._targetItmID];
         var _loc6_:BMBar = this.mcNameAndPower.mcBar;
         if(_loc4_.isMaxLevel())
         {
            this.mcNameAndPower.txtPower.text = "MAX LEVEL";
            _loc6_.setFill(1);
         }
         else
         {
            this.mcNameAndPower.txtPower.text = dataM.getNumberWithComma(_loc3_.newPower) + " / " + dataM.getNumberWithComma(_loc4_.powerToUpgrade);
            _loc6_.setFill((_loc3_.newPower + this._sourcePower - _loc2_ - _loc3_.newItemData.minPowerToHave) / (_loc3_.newItemData.powerToUpgrade - _loc3_.newItemData.minPowerToHave));
         }
         var _loc7_:int = _loc4_.displayLevel - _loc5_.displayLevel;
         if(this._boostLevel != _loc7_)
         {
            this._itemLevelUpTimeLine.stop();
            this._itemLevelUpTimeLine = new TimelineMax();
            this._itemLevelUpTimeLine.to(this._itemHolder,0.05,{"colorTransform":{
               "tint":16777215,
               "tintAmount":0.3
            }});
            this._itemLevelUpTimeLine.call(this.setItemImage,[_loc4_]);
            this._itemLevelUpTimeLine.to(this._itemHolder,0.1,{"colorTransform":{
               "tint":16777215,
               "tintAmount":0
            }});
         }
         this.boostLevel = _loc7_;
         this.itemProperties.showDifference(_loc5_,_loc4_,false);
         ImageUtils.swapTextFieldWithBitMap(this.mcNameAndPower.txtPower,this.mcNameAndPower);
      }
      
      public function get sourcePower() : Number
      {
         return this._sourcePower;
      }
      
      private function set boostLevel(param1:int) : void
      {
         this._boostLevel = param1;
         if(param1 <= 0)
         {
            param1 = 0;
            this.mcDetails.txtBoostLevel.text = "";
         }
         else
         {
            this.mcDetails.txtBoostLevel.text = "+" + param1;
         }
      }
      
      private function set level(param1:String) : *
      {
         this.mcDetails.txtLevel.text = param1;
         this.mcDetails.txtBoostLevel.x = this.mcDetails.txtLevel.x + this.mcDetails.txtLevel.textWidth + 5;
         ImageUtils.swapTextFieldWithBitMap(this.mcDetails.txtLevel,this.mcDetails);
      }
      
      private function set itemName(param1:String) : *
      {
         this.mcNameAndPower.txtItemName.text = param1;
         ImageUtils.swapTextFieldWithBitMap(this.mcNameAndPower.txtItemName,this.mcNameAndPower);
      }
      
      private function initializeTutorialArrow() : void
      {
         if(this._tutorialArrowController == null)
         {
            this._tutorialArrowController = new BMTutorialArrowController(this.mcTutorialArrow);
         }
      }
      
      public function activateBackTutorialArrow() : void
      {
         this.initializeTutorialArrow();
         var _loc1_:Number = this.btnOK.x;
         var _loc2_:Number = this.btnOK.y + this.btnOK.height / 2;
         this._tutorialArrowController.activateTutorialArrowWithTimer(this,_loc1_,_loc2_,180);
      }
   }
}

