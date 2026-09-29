package net.battleMechsMulti.screens.quests
{
   import com.greensock.TweenMax;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.utils.Timer;
   import net.battleMechsMulti.managers.BMGoogleGamesManager;
   import net.battleMechsMulti.managers.quests.BMPlayerQuestData;
   import net.battleMechsMulti.managers.quests.BMQuestData;
   import net.battleMechsMulti.managers.quests.BMQuestsManager;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.screens.BMBaseScreen;
   import net.battleMechsMulti.screens.mainMenu.TextHolder;
   import net.battleMechsMulti.utils.TimeUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol674")]
   public class BMScreenQuests extends BMBaseScreen
   {
      
      public var mcButtonsHolder:Sprite;
      
      public var mcSizer_btnClose:Sprite;
      
      public var mcSizer_btnGoogleAchievements:Sprite;
      
      public var mcTabs1BG:MovieClip;
      
      public var mcTabs2BG:MovieClip;
      
      public var mcTab1Btn:MovieClip;
      
      public var mcTab2Btn:MovieClip;
      
      public var mcCounter1:TextHolder;
      
      public var mcCounter2:TextHolder;
      
      public var mcBorderRightBtn:BMBasicButton;
      
      public var mcBorderLeftBtn:BMBasicButton;
      
      public var btnClose:BMButton_pictureE;
      
      public var btnGoogleAchievements:BMButton_pictureE;
      
      public var mcListSizer:Sprite;
      
      public var mcTileListHolder:MovieClip;
      
      public var iconLoading:MovieClip;
      
      public var txtLoading:TextField;
      
      private var _targetScrollX:Number;
      
      private var _scrollActive:Boolean = false;
      
      private var _scrollingSpeed:Number = 0;
      
      private var _scrollXPos:Array = new Array();
      
      private var _scrollAbsoluteDeltaX:uint = 0;
      
      private var _resetTimer:Timer;
      
      private var _selcetdTab:int = 1;
      
      public function BMScreenQuests()
      {
         super();
         this._targetScrollX = this.mcTileListHolder.x = this.mcListSizer.x;
         x = 20;
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         this.initButtons();
         this.initScrolling();
         this.initTimer();
         this.refreshCountrs();
         this.loadQuestsData();
      }
      
      public function initTimer() : *
      {
         this._resetTimer = new Timer(1000,0);
         this._resetTimer.addEventListener(TimerEvent.TIMER,this.onTimerTick);
         this.timerTxt = "";
      }
      
      private function initScrolling() : void
      {
         if(dataM.runAsMobile)
         {
            this.mcListSizer.addEventListener(MouseEvent.MOUSE_DOWN,this.onScrollDown);
            this.mcListSizer.addEventListener(MouseEvent.MOUSE_UP,this.onScrollUp);
         }
         else
         {
            this.mcListSizer.visible = false;
            this.mcBorderLeftBtn.addEventListener(BMIntractable.HIT,this.onScrollLeftClick);
            this.mcBorderRightBtn.addEventListener(BMIntractable.HIT,this.onScrollRightClick);
         }
      }
      
      private function initButtons() : void
      {
         this.mcTab1Btn.addEventListener(MouseEvent.CLICK,this.onTabClick);
         this.mcTab1Btn.id = BMQuestsManager.TYPE_DAILY_QUEST;
         this.mcTab1Btn.visible = false;
         this.mcTab2Btn.addEventListener(MouseEvent.CLICK,this.onTabClick);
         this.mcTab2Btn.id = BMQuestsManager.TYPE_ACHIEVEMENT_QUEST;
         this.mcTab2Btn.visible = false;
         screensM.createButtonFromSizer("screenQuests","btnClose","pictureE");
         this.btnClose.initialize("","",externalAssetsM.getAsset("general","interface_cancel"),null,this.backClicked,false);
         screensM.createButtonFromSizer("screenQuests","btnGoogleAchievements","pictureE");
         this.btnGoogleAchievements.initialize("","",externalAssetsM.getAsset("general","interface_googleAchievements"),null,this.onGoogleAchievementsClicked,false);
         this.btnGoogleAchievements.visible = false;
         this.btnGoogleAchievements.visible = BMGoogleGamesManager.gi().isFullyLoggedIn();
         this.resteScrollButtons();
      }
      
      private function onGoogleAchievementsClicked() : void
      {
         BMGoogleGamesManager.gi().showAchievements();
      }
      
      private function onTabClick(param1:MouseEvent) : void
      {
         var _loc2_:int = int(param1.currentTarget.id);
         this.selectTab(_loc2_);
      }
      
      private function selectTab(param1:int) : *
      {
         var _loc2_:MovieClip = this["mcTabs" + this._selcetdTab + "BG"];
         this._selcetdTab = param1;
         var _loc3_:MovieClip = this["mcTabs" + this._selcetdTab + "BG"];
         this.setItems(dataM.questsManager.getQuestsOfType(this._selcetdTab));
         if(!dataM.runAsMobile)
         {
            this.refreshScrollButtons();
         }
         if(getChildIndex(_loc3_) < getChildIndex(_loc2_))
         {
            this.swapChildren(_loc3_,_loc2_);
         }
         TweenMax.fromTo(_loc3_,0.12,{"alpha":0},{"alpha":1});
         TweenMax.to(_loc2_,0,{"alpha":1});
      }
      
      public function setItems(param1:Vector.<BMQuestData>) : void
      {
         this.resetScrolling();
         this.mcTileListHolder.removeChildren();
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            this.addItem(param1[_loc2_]);
            _loc2_++;
         }
      }
      
      private function addItem(param1:BMQuestData) : *
      {
         var _loc2_:BMQuestView = null;
         if(param1.type == 1)
         {
            _loc2_ = new BMDailyQuestView();
         }
         else
         {
            _loc2_ = new BMAchievementQuestView();
         }
         _loc2_.setData(param1);
         _loc2_.x = this.mcTileListHolder.numChildren * _loc2_.width;
         _loc2_.addEventListener(BMIntractable.HIT,this.onItemClick);
         this.mcTileListHolder.addChild(_loc2_);
      }
      
      private function onItemClick(param1:Event) : void
      {
         var _loc2_:int = BMQuestView(param1.target).playerQuestID;
         this.claimReward(_loc2_);
      }
      
      private function claimReward(param1:int) : void
      {
         var _loc2_:BMPlayerQuestData = dataM.questsManager.getPlayerQuest(param1);
         if(_loc2_ != null && _loc2_.isReadyToClaim)
         {
            dataM.questsManager.claimQuestReward(param1);
         }
      }
      
      public function doOpenAnim() : *
      {
         TweenMax.fromTo(this,0.5,{"y":-height},{"y":52});
      }
      
      public function doCloseAnim() : *
      {
         TweenMax.to(this,0.3,{
            "y":-height,
            "onComplete":this.onCloseAnimComplete
         });
         if(screensM.isScreenOpened("screenMainMenu"))
         {
            screensM.screenMainMenu.onHideQuestsScreen();
         }
      }
      
      private function onCloseAnimComplete() : void
      {
         screensM.removeScreen("screenQuests");
      }
      
      private function onTimerTick(param1:TimerEvent) : void
      {
         var _loc2_:int = dataM.questsManager.dailyQuestsSecLeft;
         if(_loc2_ <= 0)
         {
            _loc2_ = 0;
            this._resetTimer.stop();
            this.loadQuestsData();
         }
         this.timerTxt = TimeUtils.formatTimeLeft(_loc2_);
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(dataM.runAsMobile)
         {
            this.scrollingOnEnterFrameMobile();
         }
      }
      
      private function set timerTxt(param1:String) : void
      {
         this.mcTabs1BG.txtTimer.text = param1;
         ImageUtils.swapTextFieldWithBitMap(this.mcTabs1BG.txtTimer,this.mcTabs1BG);
      }
      
      public function loadQuestsData() : void
      {
         this.mcTab1Btn.visible = false;
         this.mcTab2Btn.visible = false;
         TweenMax.fromTo(this.iconLoading,1.5,{
            "alpha":0,
            "visible":true
         },{"alpha":1});
         TweenMax.fromTo(this.txtLoading,1.5,{
            "alpha":0,
            "visible":true
         },{"alpha":1});
         dataM.questsManager.loadQuestData();
      }
      
      public function onQuestsDataUpdated() : void
      {
         TweenMax.killTweensOf(this.iconLoading);
         TweenMax.killTweensOf(this.txtLoading);
         this.iconLoading.visible = this.txtLoading.visible = false;
         this.selectTab(this._selcetdTab);
         this.mcTab1Btn.visible = true;
         this.mcTab2Btn.visible = true;
         this.refreshCountrs();
         this._resetTimer.start();
         this.timerTxt = TimeUtils.formatTimeLeft(dataM.questsManager.dailyQuestsSecLeft);
      }
      
      private function refreshCountrs() : void
      {
         this.refreshCounter(this.mcCounter1,BMQuestsManager.TYPE_DAILY_QUEST);
         this.refreshCounter(this.mcCounter2,BMQuestsManager.TYPE_ACHIEVEMENT_QUEST);
      }
      
      private function refreshCounter(param1:TextHolder, param2:uint) : *
      {
         var _loc3_:int = dataM.questsManager.getNumOfCompletedQuests(param2);
         param1.visible = _loc3_ > 0;
         param1.text = _loc3_ + "";
      }
      
      public function backClicked() : void
      {
         this.doCloseAnim();
      }
      
      private function onScrollLeftClick(param1:Event) : void
      {
         this.scrollBy(3);
      }
      
      private function onScrollRightClick(param1:Event) : void
      {
         this.scrollBy(-3);
      }
      
      private function scrollBy(param1:int) : void
      {
         if(this.mcTileListHolder.numChildren == 0)
         {
            return;
         }
         this._targetScrollX += param1 * this.mcTileListHolder.getChildAt(0).width;
         if(this._targetScrollX > this.mcListSizer.x)
         {
            this._targetScrollX = this.mcListSizer.x;
         }
         else if(this._targetScrollX + this.mcTileListHolder.width < this.mcListSizer.x + this.mcListSizer.width)
         {
            this._targetScrollX = this.mcListSizer.x + this.mcListSizer.width - this.mcTileListHolder.width;
         }
         this.refreshScrollButtons();
         TweenMax.to(this.mcTileListHolder,0.3,{
            "x":this._targetScrollX,
            "onComplete":this.refreshScrollButtons
         });
      }
      
      private function resteScrollButtons() : void
      {
         TweenMax.killTweensOf(this.mcBorderLeftBtn);
         this.mcBorderLeftBtn.visible = false;
         TweenMax.killTweensOf(this.mcBorderRightBtn);
         this.mcBorderRightBtn.visible = false;
      }
      
      private function refreshScrollButtons() : *
      {
         this.resteScrollButtons();
         if(this.mcTileListHolder.x == this.mcListSizer.x)
         {
            TweenMax.to(this.mcBorderLeftBtn,0.3,{
               "alpha":0,
               "visible":false
            });
         }
         if(this._targetScrollX != this.mcListSizer.x)
         {
            this.mcBorderLeftBtn.visible = true;
            TweenMax.to(this.mcBorderLeftBtn,0.3,{"alpha":1});
         }
         if(int(this.mcTileListHolder.x) == int(this.mcListSizer.x + this.mcListSizer.width - this.mcTileListHolder.width))
         {
            TweenMax.to(this.mcBorderRightBtn,0.3,{
               "alpha":0,
               "visible":false
            });
         }
         if(int(this._targetScrollX) != int(this.mcListSizer.x + this.mcListSizer.width - this.mcTileListHolder.width))
         {
            this.mcBorderRightBtn.visible = true;
            TweenMax.to(this.mcBorderRightBtn,0.3,{"alpha":1});
         }
      }
      
      private function onScrollDown(param1:MouseEvent) : void
      {
         if(this.mcTileListHolder.width <= this.mcListSizer.width)
         {
            return;
         }
         this._scrollActive = true;
         this._scrollAbsoluteDeltaX = 0;
         this._scrollXPos.push(mouseX);
      }
      
      private function onScrollUp(param1:MouseEvent) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(this._scrollAbsoluteDeltaX < 50 && Math.abs(this._scrollingSpeed) < 2)
         {
            _loc2_ = mouseX - this.mcListSizer.x;
            _loc3_ = this.mcTileListHolder.x - this.mcListSizer.x;
            _loc4_ = (_loc2_ - _loc3_) / this.mcTileListHolder.getChildAt(0).width;
            _loc5_ = BMQuestView(this.mcTileListHolder.getChildAt(_loc4_)).playerQuestID;
            this.claimReward(_loc5_);
         }
         this._scrollXPos = new Array();
         this._scrollActive = false;
      }
      
      private function scrollingOnEnterFrameMobile() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:uint = 0;
         if(this._scrollActive)
         {
            this._scrollXPos.push(mouseX);
            if(this._scrollXPos.length > 10)
            {
               this._scrollXPos.splice(0,1);
            }
            if(this._scrollXPos.length > 1)
            {
               this._scrollAbsoluteDeltaX += Math.abs(mouseX - this._scrollXPos[this._scrollXPos.length - 2]);
            }
         }
         if(this._scrollXPos.length > 0)
         {
            _loc1_ = 0;
            _loc2_ = 1;
            while(_loc2_ < this._scrollXPos.length)
            {
               _loc1_ += this._scrollXPos[_loc2_] - this._scrollXPos[_loc2_ - 1];
               _loc2_++;
            }
            _loc1_ /= this._scrollXPos.length - 1;
            if(_loc1_ > this._scrollingSpeed)
            {
               if(_loc1_ > this._scrollingSpeed + 15)
               {
                  _loc1_ = this._scrollingSpeed + 15;
               }
            }
            else if(_loc1_ < this._scrollingSpeed - 15)
            {
               _loc1_ = this._scrollingSpeed - 15;
            }
            this._scrollingSpeed = _loc1_;
            if(this._scrollingSpeed > 50)
            {
               this._scrollingSpeed = 50;
            }
            else if(this._scrollingSpeed < -50)
            {
               this._scrollingSpeed = -50;
            }
         }
         else if(this._scrollingSpeed > 0)
         {
            this._scrollingSpeed -= 0.5;
            if(this._scrollingSpeed < 0)
            {
               this._scrollingSpeed = 0;
            }
         }
         else
         {
            this._scrollingSpeed += 0.5;
            if(this._scrollingSpeed > 0)
            {
               this._scrollingSpeed = 0;
            }
         }
         if(this._scrollingSpeed != 0)
         {
            this.mcTileListHolder.x += this._scrollingSpeed;
            if(this.mcTileListHolder.x > this.mcListSizer.x)
            {
               this.mcTileListHolder.x = this.mcListSizer.x;
            }
            else if(this.mcTileListHolder.x + this.mcTileListHolder.width < this.mcListSizer.x + this.mcListSizer.width)
            {
               this.mcTileListHolder.x = this.mcListSizer.x + this.mcListSizer.width - this.mcTileListHolder.width;
            }
         }
      }
      
      private function resetScrolling() : void
      {
         TweenMax.killTweensOf(this.mcTileListHolder);
         this._scrollActive = false;
         this._scrollingSpeed = 0;
         this._scrollXPos = new Array();
         this._scrollAbsoluteDeltaX = 0;
         this._targetScrollX = this.mcTileListHolder.x = this.mcListSizer.x;
      }
      
      override public function notifyClientDataReloaded() : *
      {
         this.onQuestsDataUpdated();
      }
   }
}

