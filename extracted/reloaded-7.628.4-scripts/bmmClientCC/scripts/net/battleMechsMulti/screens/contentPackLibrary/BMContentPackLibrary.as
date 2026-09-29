package net.battleMechsMulti.screens.contentPackLibrary
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   
   public class BMContentPackLibrary extends MovieClip
   {
      
      public var btnPrevious:BMBasicButton;
      
      public var btnNext:BMBasicButton;
      
      public var packsHolder:Sprite;
      
      public var mcPackSizer:Sprite;
      
      private var _packWidth:uint;
      
      private var _packHeight:uint;
      
      private var _firstPackInView:uint;
      
      private var _totalPacksInView:uint;
      
      private var _packsMax:uint;
      
      private var _itemsData:Array;
      
      private var _tabsInView:Array;
      
      private var _packs:Array;
      
      private var _itemClicked:Function;
      
      private var _animationActive:Boolean = false;
      
      private var _unlockAnimationComplete:Function;
      
      public function BMContentPackLibrary()
      {
         super();
      }
      
      public function initialize(param1:uint, param2:Array, param3:Function, param4:uint = 0) : void
      {
         this._packWidth = this.mcPackSizer.width;
         this._packHeight = this.mcPackSizer.height;
         this._totalPacksInView = param1;
         this._itemsData = param2;
         this._itemClicked = param3;
         this._packsMax = this._itemsData.length;
         this.initPacksInViewData(param4);
         this.addPacks();
         this.initButtons();
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
      }
      
      private function initPacksInViewData(param1:uint = 0) : void
      {
         this._firstPackInView = 0;
         this._tabsInView = new Array();
         if(param1 + this._totalPacksInView > this._packsMax)
         {
            param1 = Math.max(0,this._packsMax - this._totalPacksInView);
         }
         this._firstPackInView = param1;
         this.packsHolder.x -= this._packWidth * param1;
         var _loc2_:uint = 0;
         while(_loc2_ < this._packsMax)
         {
            if(_loc2_ >= param1 && _loc2_ < param1 + this._totalPacksInView)
            {
               this._tabsInView[_loc2_] = true;
            }
            else
            {
               this._tabsInView[_loc2_] = false;
            }
            _loc2_++;
         }
      }
      
      private function addPacks() : void
      {
         var _loc2_:Array = null;
         var _loc3_:Boolean = false;
         var _loc4_:Boolean = false;
         var _loc5_:BMContentPackLibraryPack = null;
         this._packs = new Array();
         var _loc1_:uint = 0;
         while(_loc1_ < this._packsMax)
         {
            _loc2_ = this._itemsData[_loc1_];
            _loc3_ = Boolean(this._tabsInView[_loc1_]);
            _loc4_ = BMDataManager.getInstance().contentPackResolver.isPackUnlocked(_loc1_) == false;
            _loc5_ = new BMContentPackLibraryPack(_loc1_,this._packWidth,this._packHeight,_loc2_,this._itemClicked,_loc3_,_loc4_);
            _loc5_.x = _loc1_ * this._packWidth;
            this.packsHolder.addChild(_loc5_);
            this._packs.push(_loc5_);
            _loc1_++;
         }
      }
      
      public function addPackLockMessage(param1:uint, param2:MovieClip) : void
      {
         var _loc3_:BMContentPackLibraryPack = this._packs[param1];
         _loc3_.addLockedMessage(param2);
      }
      
      private function initButtons() : void
      {
         this.btnPrevious.addEventListener(BMIntractable.HIT,this.previousClicked);
         this.btnNext.addEventListener(BMIntractable.HIT,this.nextClicked);
         this.refreshNavigationButtons();
      }
      
      private function refreshNavigationButtons() : void
      {
         this.btnPrevious.enableMe();
         this.btnNext.enableMe();
         if(this._animationActive)
         {
            this.btnNext.disableMe();
            this.btnPrevious.disableMe();
            return;
         }
         if(this._firstPackInView == 0)
         {
            this.btnPrevious.disableMe();
         }
         if(this._firstPackInView + this._totalPacksInView == this._packsMax)
         {
            this.btnNext.disableMe();
         }
      }
      
      private function previousClicked(param1:Event) : void
      {
         var _loc2_:uint = this._firstPackInView + this._totalPacksInView - 1;
         var _loc3_:BMContentPackLibraryPack = this._packs[_loc2_];
         _loc3_.inView = false;
         var _loc4_:uint = this._firstPackInView - 1;
         _loc3_ = this._packs[_loc4_];
         _loc3_.inView = true;
         --this._firstPackInView;
         this.packsHolder.x += this._packWidth;
         this.refreshNavigationButtons();
      }
      
      private function nextClicked(param1:Event) : void
      {
         var _loc2_:uint = this._firstPackInView;
         var _loc3_:BMContentPackLibraryPack = this._packs[_loc2_];
         _loc3_.inView = false;
         var _loc4_:uint = this._firstPackInView + this._totalPacksInView;
         _loc3_ = this._packs[_loc4_];
         _loc3_.inView = true;
         ++this._firstPackInView;
         this.packsHolder.x -= this._packWidth;
         this.refreshNavigationButtons();
      }
      
      public function startUnlockPackAnimation(param1:uint, param2:Function) : void
      {
         if(this._animationActive)
         {
            return;
         }
         this._animationActive = true;
         this._unlockAnimationComplete = param2;
         this.refreshNavigationButtons();
         var _loc3_:BMContentPackLibraryPack = this._packs[param1];
         _loc3_.startUnlockPackAnimation(this.unlockPackAnimationEnded);
      }
      
      private function unlockPackAnimationEnded() : void
      {
         this._animationActive = false;
         this.refreshNavigationButtons();
         this._unlockAnimationComplete();
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
      }
   }
}

