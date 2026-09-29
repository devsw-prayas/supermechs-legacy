package net.battleMechsMulti.screens.baseBuilding
{
   import com.greensock.TweenMax;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import net.battleMechsMulti.managers.BMLanguageManager;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   
   public class BMBaseBuildingFlowerMenu extends MovieClip
   {
      
      public var btnInfo:BMBasicButton;
      
      public var btnUpgrade:BMBasicButton;
      
      public var btnUpgradeDisabled:BMBasicButton;
      
      public var btnCollectGold:BMBasicButton;
      
      public var btnCollectItems:BMBasicButton;
      
      public var btnBuild:BMBasicButton;
      
      public var btnBuildDisabled:BMBasicButton;
      
      public var btnProduce:BMBasicButton;
      
      public var btnProduceDisabled:BMBasicButton;
      
      public var btnSkip:BMBasicButton;
      
      public var mcShadow:Sprite;
      
      private var _callback:Function;
      
      private var _originItemPos:Object;
      
      private var _shadowOriginHeight:Number;
      
      public const BTN_INFO:String = "btnInfo";
      
      public const BTN_UPGRADE:String = "btnUpgrade";
      
      public const BTN_UPGRADE_DISABLED:String = "btnUpgradeDisabled";
      
      public const BTN_COLLECT_GOLD:String = "btnCollectGold";
      
      public const BTN_COLLECT_ITEMS:String = "btnCollectItems";
      
      public const BTN_BUILD:String = "btnBuild";
      
      public const BTN_BUILD_DISABLED:String = "btnBuildDisabled";
      
      public const BTN_PRODUCE:String = "btnProduce";
      
      public const BTN_PRODUCE_DISABLED:String = "btnProduceDisabled";
      
      public const BTN_SKIP:String = "btnSkip";
      
      private const ALL_BUTTONS:Array = [this.BTN_INFO,this.BTN_COLLECT_GOLD,this.BTN_COLLECT_ITEMS,this.BTN_BUILD,this.BTN_BUILD_DISABLED,this.BTN_PRODUCE,this.BTN_PRODUCE_DISABLED,this.BTN_UPGRADE,this.BTN_UPGRADE_DISABLED,this.BTN_SKIP];
      
      private const CONSTANT_POSITION_BUTTONS:Array = [this.BTN_INFO];
      
      private const DYNAMIC_POSITION_BUTTONS:Array = [this.BTN_COLLECT_GOLD,this.BTN_COLLECT_ITEMS,this.BTN_PRODUCE,this.BTN_PRODUCE_DISABLED,this.BTN_UPGRADE,this.BTN_UPGRADE_DISABLED,this.BTN_SKIP,this.BTN_BUILD,this.BTN_BUILD_DISABLED];
      
      public function BMBaseBuildingFlowerMenu()
      {
         var _loc2_:String = null;
         super();
         this._originItemPos = new Object();
         var _loc1_:uint = 0;
         while(_loc1_ < this.ALL_BUTTONS.length)
         {
            _loc2_ = this.ALL_BUTTONS[_loc1_];
            this._originItemPos[_loc2_] = new Point(this[_loc2_].x,this[_loc2_].y);
            _loc1_++;
         }
         this._shadowOriginHeight = this.mcShadow.height;
         this.mcShadow.mouseEnabled = false;
         this.mcShadow.mouseChildren = false;
         mouseEnabled = false;
      }
      
      public function getDynamicButtonOriginPos(param1:int) : Point
      {
         if(param1 == 0)
         {
            return this._originItemPos[this.BTN_UPGRADE];
         }
         return this._originItemPos[this.BTN_COLLECT_GOLD];
      }
      
      public function getButtonOriginPos(param1:String) : Point
      {
         return this._originItemPos[param1];
      }
      
      private function onInfoHit(param1:Event) : void
      {
         this.fireCallback(this.BTN_INFO);
      }
      
      private function onUpgradeHit(param1:Event) : void
      {
         this.fireCallback(this.BTN_UPGRADE);
      }
      
      private function onCollectGoldHit(param1:Event) : void
      {
         this.fireCallback(this.BTN_COLLECT_GOLD);
      }
      
      private function onCollectItemsHit(param1:Event) : void
      {
         this.fireCallback(this.BTN_COLLECT_ITEMS);
      }
      
      private function onBuildHit(param1:Event) : void
      {
         this.fireCallback(this.BTN_BUILD);
      }
      
      private function onBuildDisabledHit(param1:Event) : void
      {
         this.fireCallback(this.BTN_BUILD_DISABLED);
      }
      
      private function onProduceHit(param1:Event) : void
      {
         this.fireCallback(this.BTN_PRODUCE);
      }
      
      private function onProduceDisabledHit(param1:Event) : void
      {
         this.fireCallback(this.BTN_PRODUCE_DISABLED);
      }
      
      private function onSkipHit(param1:Event) : void
      {
         this.fireCallback(this.BTN_SKIP);
      }
      
      private function fireCallback(param1:String) : void
      {
         this._callback(param1);
      }
      
      public function init(param1:Function) : void
      {
         this.btnInfo.addEventListener(BMIntractable.HIT,this.onInfoHit);
         this.btnUpgrade.addEventListener(BMIntractable.HIT,this.onUpgradeHit);
         this.btnUpgradeDisabled.addEventListener(BMIntractable.HIT,this.onUpgradeHit);
         this.btnCollectGold.addEventListener(BMIntractable.HIT,this.onCollectGoldHit);
         this.btnCollectItems.addEventListener(BMIntractable.HIT,this.onCollectItemsHit);
         this.btnBuild.addEventListener(BMIntractable.HIT,this.onBuildHit);
         this.btnBuildDisabled.addEventListener(BMIntractable.HIT,this.onBuildDisabledHit);
         this.btnProduce.addEventListener(BMIntractable.HIT,this.onProduceHit);
         this.btnProduceDisabled.addEventListener(BMIntractable.HIT,this.onProduceDisabledHit);
         this.btnSkip.addEventListener(BMIntractable.HIT,this.onSkipHit);
         var _loc2_:BMLanguageManager = BMLanguageManager.getInstance();
         this.btnUpgrade.text = _loc2_.getText("baseBuilding_upgradeAction");
         this.btnUpgradeDisabled.text = _loc2_.getText("baseBuilding_upgradeAction");
         this.btnCollectGold.text = _loc2_.getText("baseBuilding_collectAction");
         this.btnCollectItems.text = _loc2_.getText("baseBuilding_collectAction");
         this.btnBuild.text = _loc2_.getText("baseBuilding_buildAction");
         this.btnBuildDisabled.text = _loc2_.getText("baseBuilding_buildAction");
         this.btnProduce.text = _loc2_.getText("baseBuilding_produceAction");
         this.btnProduceDisabled.text = _loc2_.getText("baseBuilding_produceAction");
         this.btnSkip.text = _loc2_.getText("baseBuilding_skipAction");
         this._callback = param1;
         visible = false;
      }
      
      public function open(param1:Point, param2:BMBaseBuildingStructureData) : void
      {
         var _loc5_:String = null;
         var _loc6_:BMBasicButton = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Point = null;
         visible = true;
         x = param1.x;
         y = param1.y;
         this.btnCollectGold.visible = param2.canCollectGold;
         this.btnCollectItems.visible = param2.canCollectItems;
         this.btnUpgrade.visible = param2.canUpgrade;
         this.btnUpgradeDisabled.visible = param2.canUpgrade;
         this.btnBuild.visible = param2.canBuild && param2.buildDisabled == false;
         this.btnBuildDisabled.visible = param2.canBuild && param2.buildDisabled == true;
         this.btnProduce.visible = param2.canProduce && param2.produceDisabled == false;
         this.btnProduceDisabled.visible = param2.canProduce && param2.produceDisabled == true;
         this.btnInfo.visible = param2.hasInfo;
         this.btnSkip.visible = param2.canSkip && !param2.canCollect;
         if(this.btnSkip.visible)
         {
            if(param2.skipCostTokens == 0)
            {
               this.btnSkip.subText = BMLanguageManager.getInstance().getText("general_free");
            }
            else
            {
               this.btnSkip.subText = param2.skipCostTokens.toString();
            }
         }
         if(param2.upgradeDisabled)
         {
            this.btnUpgrade.visible = false;
         }
         else
         {
            this.btnUpgradeDisabled.visible = false;
         }
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         while(_loc4_ < this.ALL_BUTTONS.length)
         {
            _loc5_ = this.ALL_BUTTONS[_loc4_];
            _loc6_ = this[_loc5_];
            _loc7_ = -_loc6_.width / 2;
            _loc8_ = -_loc6_.height / 2;
            _loc9_ = Number(this._originItemPos[_loc5_].x);
            _loc10_ = Number(this._originItemPos[_loc5_].y);
            if(this.DYNAMIC_POSITION_BUTTONS.indexOf(_loc5_) != -1)
            {
               if(_loc6_.visible)
               {
                  _loc11_ = this.getDynamicButtonOriginPos(_loc3_);
                  _loc9_ = _loc11_.x;
                  _loc10_ = _loc11_.y;
                  _loc3_++;
               }
            }
            TweenMax.fromTo(_loc6_,0.3,{
               "x":_loc7_,
               "y":_loc8_
            },{
               "x":_loc9_,
               "y":_loc10_
            });
            _loc4_++;
         }
         this.mcShadow.visible = true;
         this.mcShadow.height = this._shadowOriginHeight;
         if(_loc3_ == 0)
         {
            this.mcShadow.visible = false;
         }
         else if(_loc3_ == 1)
         {
            this.mcShadow.height = this._shadowOriginHeight * 0.65;
         }
      }
      
      public function close() : void
      {
         visible = false;
      }
   }
}

