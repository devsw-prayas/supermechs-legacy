package net.battleMechsMulti.screens.baseBuilding
{
   import com.greensock.TweenMax;
   import fl.motion.Color;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMLanguageManager;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.mobiles.BMMovieClip;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.mobiles.itemList.BMInterfaceItemView;
   import net.battleMechsMulti.utils.BMPubSub;
   import net.battleMechsMulti.utils.TextUtils;
   import net.battleMechsMulti.utils.TimeUtils;
   
   public class BMItemFactoryItemType extends BMMovieClip implements BMInterfaceItemView
   {
      
      public var txtTitle:TextField;
      
      public var txtDesc:TextField;
      
      public var btnBuild:BMBasicButton;
      
      public var btnLocked:BMBasicButton;
      
      public var btnSkip:BMBasicButton;
      
      public var btnPlus:BMBasicButton;
      
      public var btnMinus:BMBasicButton;
      
      public var mcRollOverEffect:Sprite;
      
      public var mcGrpHolder:Sprite;
      
      public var mcGeneralHitArea:Sprite;
      
      public var txtTimer:TextField;
      
      public var mcTutorialArrow:Sprite;
      
      private var _data:BMItemFactoryItemTypeData;
      
      private const MAX_ITEMS_IN_QUEUE:uint = 99;
      
      private var _initialized:Boolean = false;
      
      private var _timerPubsubToken:Number = 0;
      
      public function BMItemFactoryItemType()
      {
         super();
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      }
      
      private function get _currentAmount() : uint
      {
         return this._data.amountInQueue - this._data.amountReady;
      }
      
      public function setData(param1:Object) : void
      {
         var _loc3_:MovieClip = null;
         this._data = param1 as BMItemFactoryItemTypeData;
         if(this._initialized == false)
         {
            updateTextAndFormat(this.txtTitle,this._data.title);
            updateTextAndFormat(this.txtDesc,this._data.desc);
            this.btnPlus.addEventListener(BMIntractable.HIT,this.onPlusClicked);
            this.btnMinus.addEventListener(BMIntractable.HIT,this.onMinusClicked);
            this.btnBuild.addEventListener(BMIntractable.HIT,this.onBuildClicked);
            this.btnSkip.addEventListener(BMIntractable.HIT,this.onSkipClicked);
            this.btnBuild.text = this._data.goldCost.toString();
            _loc3_ = BMDataManager.getInstance().getLocalGraphicIcon("mcItemFactoryItemType" + this._data.visualID);
            _loc3_.scaleX = 0.72;
            _loc3_.scaleY = 0.72;
            this.mcGrpHolder.addChild(_loc3_);
            this._initialized = true;
         }
         this.refreshButtons();
         var _loc2_:Color = new Color();
         if(this._data.interactable)
         {
            _loc2_.setTint(16777215,0);
         }
         else
         {
            _loc2_.setTint(0,0.6);
         }
         transform.colorTransform = _loc2_;
         this.mcTutorialArrow.visible = false;
      }
      
      private function getTimerSecondsLeft() : Number
      {
         if(this._data.endBuildTime > 0)
         {
            return this._data.endBuildTime - BMDataManager.getInstance().currentTime;
         }
         return 0;
      }
      
      private function onPlusClicked(param1:Event) : void
      {
         this.screenBaseBuilding.notifyAddItemToQueueRequested(this.ID);
      }
      
      private function onMinusClicked(param1:Event) : void
      {
         this.screenBaseBuilding.notifyRemoveItemFromQueueRequested(this.ID);
      }
      
      private function refreshButtons() : void
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         if(this._currentAmount == 0)
         {
            this.btnPlus.visible = false;
            this.btnMinus.visible = false;
            this.btnBuild.visible = true;
            this.btnSkip.visible = false;
            this.txtDesc.visible = true;
            this.txtTimer.visible = false;
            if(this._data.locked && this._data.lockedLevel > 0)
            {
               this.btnBuild.visible = false;
               this.btnSkip.visible = false;
               this.btnLocked.visible = true;
               _loc1_ = BMLanguageManager.getInstance().getText("baseBuilding_itemTypeUnlockLevel");
               _loc2_ = BMDataManager.getInstance().replaceStringInText(_loc1_,"%LEVEL%",this._data.lockedLevel.toString());
               this.btnLocked.text = TextUtils.splitStringToTwoLines(_loc2_).join("\n");
            }
            else
            {
               this.btnLocked.visible = false;
            }
         }
         else
         {
            this.btnLocked.visible = false;
            this.txtTimer.visible = true;
            this.btnBuild.visible = false;
            this.btnSkip.visible = true;
            this.btnSkip.text = BMLanguageManager.getInstance().getText("baseBuilding_skipAction");
            if(this._data.tokensCost > 0)
            {
               this.btnSkip.subText = this._data.tokensCost.toString();
            }
            else
            {
               this.btnSkip.subText = BMLanguageManager.getInstance().getText("general_free");
            }
            this.btnPlus.visible = true;
            this.btnMinus.visible = true;
            this.txtDesc.visible = false;
            this.btnPlus.enableMe();
            this.btnMinus.enableMe();
            if(this._currentAmount >= this.MAX_ITEMS_IN_QUEUE)
            {
               this.btnPlus.disableMe();
            }
            else if(this._currentAmount <= 0)
            {
               this.btnMinus.disableMe();
            }
            this.refreshTimerText();
         }
      }
      
      private function refreshTimerText() : *
      {
         var _loc1_:String = BMLanguageManager.getInstance().getText("baseBuilding_productionProgress");
         _loc1_ = BMDataManager.getInstance().replaceStringInText(_loc1_,"%AMOUNT1%",(this._data.amountReady + 1).toString());
         _loc1_ = BMDataManager.getInstance().replaceStringInText(_loc1_,"%AMOUNT2%",this._data.amountInQueue.toString());
         var _loc2_:String = TimeUtils.formatTimeLeftWithDays(this.getTimerSecondsLeft());
         updateTextAndFormat(this.txtTimer,_loc1_ + "<BR>" + _loc2_);
      }
      
      private function onBuildClicked(param1:Event) : void
      {
         this.screenBaseBuilding.notifyBuildItemRequested(this.ID);
      }
      
      private function onSkipClicked(param1:Event) : void
      {
         this.screenBaseBuilding.notifySkipBuildItemQueueRequested(this.ID);
      }
      
      private function generalHitAreaClicked() : void
      {
         if(this.btnBuild.visible == false)
         {
            return;
         }
         if(this.mcTutorialArrow.visible)
         {
            return;
         }
         this.mcTutorialArrow.visible = true;
         this.mcTutorialArrow.y = this.btnBuild.y;
         TweenMax.to(this.mcTutorialArrow,0.2,{
            "y":this.mcTutorialArrow.y - 30,
            "repeat":2,
            "yoyo":true,
            "onComplete":this.finishArrowGuide
         });
      }
      
      private function finishArrowGuide() : void
      {
         this.mcTutorialArrow.visible = false;
      }
      
      public function isEnabled() : Boolean
      {
         return this._data.locked == false;
      }
      
      public function get ID() : uint
      {
         return this._data.level;
      }
      
      public function getItemWidth() : Number
      {
         return width;
      }
      
      public function getItemHeight() : Number
      {
         return height;
      }
      
      public function handleMouseClick(param1:Point) : *
      {
         if(!(this.hitTestButton(param1,this.btnBuild) || this.hitTestButton(param1,this.btnSkip) || this.hitTestButton(param1,this.btnPlus) || this.hitTestButton(param1,this.btnMinus)))
         {
            if(this.mcGeneralHitArea.hitTestPoint(param1.x,param1.y))
            {
               this.generalHitAreaClicked();
            }
         }
      }
      
      private function hitTestButton(param1:Point, param2:BMBasicButton) : Boolean
      {
         if(param2.visible && param2.hitTestPoint(param1.x,param1.y))
         {
            param2.injectClick();
            return true;
         }
         return false;
      }
      
      private function get screenBaseBuilding() : BMScreenBaseBuildingMain
      {
         return BMScreensManager.getInstance().screenBaseBuildingMain;
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
         TweenMax.killTweensOf(this.mcTutorialArrow);
         BMPubSub.remove(this._timerPubsubToken);
         this._timerPubsubToken = 0;
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         this._timerPubsubToken = BMPubSub.sub(BMPubSub.MESSAGE_SECOND_PASSED,this.handleSecondPassed);
      }
      
      private function handleSecondPassed(param1:String, param2:Object) : void
      {
         if(this._currentAmount > 0)
         {
            this.refreshTimerText();
         }
      }
      
      public function removeMe() : void
      {
      }
   }
}

