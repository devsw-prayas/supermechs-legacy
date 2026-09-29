package net.battleMechsMulti.screens.baseBuilding
{
   import com.greensock.TweenMax;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMLanguageManager;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.BMTutorialManager;
   import net.battleMechsMulti.mobiles.BMMovieClip;
   import net.battleMechsMulti.mobiles.timer.BMTimer;
   import net.battleMechsMulti.screens.mainMenu.TextHolder;
   
   public class BMBaseBuildingStructureDisplay extends BMMovieClip
   {
      
      public static const STRUCTURE_STATE_EMPTY:String = "empty";
      
      public static const STRUCTURE_STATE_UNDER_CONSTRUCTION:String = "underConstruction";
      
      public static const STRUCTURE_STATE_BUILT:String = "built";
      
      public static const PRODUCTION_STATE_COLLECT_GOLD:String = "collectGold";
      
      public static const PRODUCTION_STATE_COLLECT_GOLD_FULL:String = "collectGoldFull";
      
      public static const PRODUCTION_STATE_ITEMS_QUEUE:String = "itemsQueue";
      
      public static const PRODUCTION_STATE_COLLECT_ITEMS:String = "collectItems";
      
      public var mcGeneralHitArea:Sprite;
      
      public var mcCollectHitArea:Sprite;
      
      public var mcStrcutureView:MovieClip;
      
      public var mcUnderConstruction:Sprite;
      
      public var mcCollectIndicator:MovieClip;
      
      public var mcCanUpgrade:Sprite;
      
      public var mcCanBuild:Sprite;
      
      public var mcLevel:TextHolder;
      
      public var mcTimer:BMTimer;
      
      public var mcBase:MovieClip;
      
      public var txtIdle:TextField;
      
      private var _ID:uint;
      
      private var _generalClickedCallback:Function;
      
      private var _collectClickedCallback:Function;
      
      private var _data:BMBaseBuildingStructureData;
      
      private var _selected:Boolean = false;
      
      public function BMBaseBuildingStructureDisplay()
      {
         super();
      }
      
      public function initialize(param1:uint, param2:BMBaseBuildingStructureData, param3:Function, param4:Function) : void
      {
         this._ID = param1;
         this._generalClickedCallback = param3;
         this._collectClickedCallback = param4;
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
         this.refreshView(param2);
         this.setHitArea();
      }
      
      public function refreshView(param1:BMBaseBuildingStructureData) : void
      {
         this._data = param1;
         this.refreshStructureView();
         this.refreshCollectIndicator();
         this.refreshUnderConstructionIndicator();
         this.refreshTimer();
         this.refreshLevel();
         this.refreshCanUpgradeIndicator();
         this.refreshCanBuildIndicator();
         this.refreshIsIdle();
      }
      
      private function setHitArea() : void
      {
         if(this.mcGeneralHitArea == null)
         {
            return;
         }
         this.mcGeneralHitArea.addEventListener(MouseEvent.CLICK,this.generalHitAreaClicked);
      }
      
      private function refreshStructureView() : void
      {
         if(this.mcStrcutureView == null)
         {
            return;
         }
         mouseEnabled = false;
         this.mcStrcutureView.mouseEnabled = false;
         this.mcStrcutureView.mouseChildren = false;
         this.mcStrcutureView.gotoAndStop(this._data.structureViewFrame);
      }
      
      private function refreshCollectIndicator() : void
      {
         if(this.mcCollectIndicator == null)
         {
            return;
         }
         this.mcCollectIndicator.visible = this._data.canCollect && this._data.collectType != BMBaseBuildingStructureData.COLLECT_TYPE_GOLD_0;
         switch(this._data.collectType)
         {
            case BMBaseBuildingStructureData.COLLECT_TYPE_GOLD_1:
               this.mcCollectIndicator.gotoAndStop(1);
               break;
            case BMBaseBuildingStructureData.COLLECT_TYPE_GOLD_2:
               this.mcCollectIndicator.gotoAndStop(2);
               break;
            case BMBaseBuildingStructureData.COLLECT_TYPE_GOLD_3:
               this.mcCollectIndicator.gotoAndStop(3);
               break;
            case BMBaseBuildingStructureData.COLLECT_TYPE_GOLD_FULL:
               this.mcCollectIndicator.gotoAndStop(4);
               break;
            case BMBaseBuildingStructureData.COLLECT_TYPE_ITEMS_1:
               this.mcCollectIndicator.gotoAndStop(1);
               break;
            case BMBaseBuildingStructureData.COLLECT_TYPE_ITEMS_2:
               this.mcCollectIndicator.gotoAndStop(2);
               break;
            case BMBaseBuildingStructureData.COLLECT_TYPE_ITEMS_3:
               this.mcCollectIndicator.gotoAndStop(3);
               break;
            case BMBaseBuildingStructureData.COLLECT_TYPE_ITEMS_4_PLUS:
               this.mcCollectIndicator.gotoAndStop(4);
         }
         if(this.mcCollectHitArea != null)
         {
            this.mcCollectHitArea.visible = this._data.canCollect;
            if(this.mcCollectIndicator.visible)
            {
               this.mcCollectHitArea.addEventListener(MouseEvent.CLICK,this.collectHitAreaClicked);
            }
         }
         TweenMax.to(this.mcCollectIndicator,0.5,{
            "scaleX":1.05,
            "scaleY":1.05,
            "repeat":-1,
            "yoyo":true
         });
      }
      
      private function collectHitAreaClicked(param1:Event) : void
      {
         this._collectClickedCallback(this.ID);
      }
      
      private function refreshUnderConstructionIndicator() : void
      {
         if(this.mcUnderConstruction == null)
         {
            return;
         }
         this.mcUnderConstruction.visible = this._data.isUnderConstruction;
      }
      
      private function refreshTimer() : void
      {
         if(this.mcTimer == null)
         {
            return;
         }
         if(this._data.timerProvider == null)
         {
            this.mcTimer.visible = false;
            return;
         }
         this.mcTimer.initialize(this.getTimerProvider,null,0,true);
      }
      
      private function getTimerProvider() : Number
      {
         return this._data.timerProvider(this._data.position);
      }
      
      public function refreshCanUpgradeIndicator() : void
      {
         if(this.mcCanUpgrade == null)
         {
            return;
         }
         this.mcCanUpgrade.visible = this._data.canUpgrade && this._data.highlightUpgrade;
         TweenMax.to(this.mcCanUpgrade,0.6,{
            "y":this.mcCanUpgrade.y - 2,
            "repeat":-1,
            "yoyo":true
         });
      }
      
      public function refreshCanBuildIndicator() : void
      {
         if(this.mcCanBuild == null)
         {
            return;
         }
         this.mcCanBuild.visible = this._data.canBuild && this._data.buildDisabled == false;
         if(this.mcCanBuild.visible)
         {
            TweenMax.to(this.mcCanBuild,0.3,{
               "scaleX":1.1,
               "scaleY":1.1,
               "repeat":-1,
               "yoyo":true
            });
         }
      }
      
      public function refreshIsIdle() : void
      {
         var _loc1_:String = null;
         if(this.txtIdle == null)
         {
            return;
         }
         if(this._data.isIdle)
         {
            _loc1_ = "- " + BMLanguageManager.getInstance().getText("baseBuilding_produceAction") + " -";
            updateTextAndFormat(this.txtIdle,_loc1_);
         }
         else
         {
            updateTextAndFormat(this.txtIdle,"");
         }
         if(BMDataManager.getInstance().runAsMobile)
         {
            BMScreensManager.getInstance().createMultipleTextsBitmap(name + "_idle",[this.txtIdle],"",this);
         }
      }
      
      public function refreshLevel() : void
      {
         if(this.mcLevel == null)
         {
            return;
         }
         if(this._data.level == 0)
         {
            this.mcLevel.visible = false;
            return;
         }
         this.mcLevel.visible = true;
         this.mcLevel.text = String(this._data.level);
      }
      
      public function get ID() : uint
      {
         return this._ID;
      }
      
      private function generalHitAreaClicked(param1:MouseEvent) : void
      {
         if(BMTutorialManager.gi().isAllowedToClickOnMovieClip(this))
         {
            this._generalClickedCallback(this.ID);
         }
      }
      
      public function set selected(param1:Boolean) : void
      {
         this._selected = param1;
         if(this._selected)
         {
            this.mcBase.gotoAndStop("selected");
         }
         else
         {
            this.mcBase.gotoAndStop("default");
         }
      }
      
      public function removeMe() : void
      {
         if(this.parent == null)
         {
            throw Error("Cannot remove BMBaseBuildingStructureDisplay because it has no parent");
         }
         this.parent.removeChild(this);
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
         TweenMax.killTweensOf(this.mcCollectIndicator);
         TweenMax.killTweensOf(this.mcCanUpgrade);
         TweenMax.killTweensOf(this.mcCanBuild);
      }
   }
}

