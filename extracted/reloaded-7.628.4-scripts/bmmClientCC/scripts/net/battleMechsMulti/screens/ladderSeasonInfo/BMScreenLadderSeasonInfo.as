package net.battleMechsMulti.screens.ladderSeasonInfo
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.utils.Timer;
   import net.battleMechsMulti.mobiles.BMCountdownTimerText;
   import net.battleMechsMulti.mobiles.BMTileListItem;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.mobiles.itemList.BMHorizontalItemsScroller;
   import net.battleMechsMulti.screens.BMBaseScreen;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2695")]
   public class BMScreenLadderSeasonInfo extends BMBaseScreen
   {
      
      private static const TAB_RANKS_AND_PRIZES:uint = 1;
      
      private static const TAB_STRUCTURE_AND_RULES:uint = 2;
      
      public var mcItemsScrollerPosition:Sprite;
      
      public var mcTabs:MovieClip;
      
      public var txtRanksAndPrizes:TextField;
      
      public var txtRules:TextField;
      
      public var txtSeasonTimeLeft:TextField;
      
      public var txtRulesInfo:TextField;
      
      public var txtTopClanReward:TextField;
      
      public var mcPlayersRewards:MovieClip;
      
      public var btnClose:BMBasicButton;
      
      public var itemsScroller:BMHorizontalItemsScroller;
      
      public var mcTab1HitArea:Sprite;
      
      public var mcTab2HitArea:Sprite;
      
      public var mcRulesFrames:Sprite;
      
      private var _clanRewardItems:Array = new Array();
      
      private var _currentTab:uint = 0;
      
      private var _tournamentTimer:Timer;
      
      public function BMScreenLadderSeasonInfo()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers();
         setLanguageManagerScreenName("ladderSeasonInfo");
         this.btnClose.addEventListener(BMIntractable.HIT,this.onCloseHit);
         this.mcTab1HitArea.addEventListener(MouseEvent.CLICK,this.tab1Clicked);
         this.mcTab2HitArea.addEventListener(MouseEvent.CLICK,this.tab2Clicked);
         this.goToTab(TAB_RANKS_AND_PRIZES);
         this.initTournamentCountdown();
      }
      
      private function tab1Clicked(param1:MouseEvent) : void
      {
         this.goToTab(TAB_RANKS_AND_PRIZES);
      }
      
      private function tab2Clicked(param1:MouseEvent) : void
      {
         this.goToTab(TAB_STRUCTURE_AND_RULES);
      }
      
      private function goToTab(param1:uint) : void
      {
         if(this._currentTab == param1)
         {
            return;
         }
         this._currentTab = param1;
         switch(this._currentTab)
         {
            case TAB_RANKS_AND_PRIZES:
               this.showRanksAndPrizes();
               break;
            case TAB_STRUCTURE_AND_RULES:
               this.showStructureAndRules();
         }
      }
      
      private function showRanksAndPrizes() : void
      {
         this.txtRulesInfo.visible = false;
         this.mcPlayersRewards.visible = false;
         this.removeClanRewardItems();
         updateTextAndFormat(this.txtRulesInfo,"");
         updateTextAndFormat(this.txtTopClanReward,"");
         updateTextColor(this.txtRanksAndPrizes,16777215);
         updateTextColor(this.txtRules,6710886);
         updateTextAndFormat(this.txtRanksAndPrizes,"<FONT COLOR=\'#FFFFFF\'>" + getScreenText("ranksAndPrizesTitle"));
         updateTextAndFormat(this.txtRules,"<FONT COLOR=\'#666666\'>" + getScreenText("rulesTitle"));
         this.mcTabs.gotoAndStop(1);
         this.mcRulesFrames.visible = false;
         dataM.updatePlayerPositionInLadderSeasonEndRewards();
         this.itemsScroller.visible = true;
         if(this.itemsScroller.isInitiated())
         {
            return;
         }
         this.itemsScroller.setViewClass(BMLadderSeasonEndRewardView);
         var _loc1_:uint = BMHorizontalItemsScroller.NAVIGATION_TYPE_NONE;
         if(dataM.ladderSeasonEndRewardsData.length > 6)
         {
            if(dataM.runAsMobile)
            {
               _loc1_ = BMHorizontalItemsScroller.NAVIGATION_TYPE_FINGER_SCROLLING;
            }
            else
            {
               _loc1_ = BMHorizontalItemsScroller.NAVIGATION_TYPE_BUTTONS;
            }
         }
         this.itemsScroller.activateScrolling(_loc1_);
         this.itemsScroller.setItemSelectedFunction(this.itemSelected);
         this.createItems();
      }
      
      private function showStructureAndRules() : void
      {
         var _loc1_:String = null;
         _loc1_ = getScreenText("rulesInfo");
         var _loc2_:uint = 7;
         this.txtRulesInfo.visible = true;
         _loc1_ = dataM.replaceStringInText(_loc1_,"%DAYS%",String(_loc2_));
         updateTextAndFormat(this.txtRulesInfo,_loc1_);
         this.itemsScroller.visible = false;
         updateTextColor(this.txtRanksAndPrizes,6710886);
         updateTextColor(this.txtRules,16777215);
         updateTextAndFormat(this.txtRanksAndPrizes,getScreenText("ranksAndPrizesTitle"));
         updateTextAndFormat(this.txtRules,getScreenText("rulesTitle"));
         updateTextAndFormat(this.mcPlayersRewards.txtTopPlayersRewards,getSpecificText("rankingList_topPlayersRewards"));
         this.displayClanRewardItems();
         this.mcPlayersRewards.visible = true;
         this.mcTabs.gotoAndStop(2);
         this.mcRulesFrames.visible = true;
      }
      
      private function itemSelected(param1:uint) : void
      {
         var _loc2_:BMLadderSeasonEndRewardData = dataM.ladderSeasonEndRewardsData[param1];
         trace(_loc2_.groupName);
      }
      
      private function onCloseHit(param1:Event) : void
      {
         this.removeMe();
      }
      
      private function createItems() : void
      {
         this.itemsScroller.setItems(dataM.ladderSeasonEndRewardsData,dataM.getPlayerPositionInLadderSeasonEndRewards());
      }
      
      private function removeTopClanReward() : void
      {
         this.removeClanRewardItems();
         updateTextAndFormat(this.txtTopClanReward,"");
      }
      
      private function displayClanRewardItems() : void
      {
         var _loc5_:Number = NaN;
         var _loc6_:Function = null;
         var _loc7_:Function = null;
         var _loc8_:BMTileListItem = null;
         if(dataM.weeklyTopClanRewards.length > 0)
         {
            updateTextAndFormat(this.txtTopClanReward,getSpecificText("rankingList_topClanReward"));
         }
         else
         {
            updateTextAndFormat(this.txtTopClanReward,"");
         }
         this.removeClanRewardItems();
         this._clanRewardItems = new Array();
         var _loc1_:uint = dataM.REWARD_TILE_LIST_ITEM_SIZE;
         if(dataM.runAsMobile)
         {
            _loc1_ = dataM.REWARD_TILE_LIST_ITEM_SIZE_MOBILE;
         }
         var _loc2_:uint = 8;
         var _loc3_:Number = this.txtTopClanReward.x + this.txtTopClanReward.width / 2 - dataM.weeklyTopClanRewards.length * _loc1_ / 2;
         if(dataM.weeklyTopClanRewards.length > 1)
         {
            _loc3_ -= _loc2_ * (dataM.weeklyTopClanRewards.length - 1) / 2;
         }
         var _loc4_:uint = 0;
         while(_loc4_ < dataM.weeklyTopClanRewards.length)
         {
            _loc5_ = Number(dataM.weeklyTopClanRewards[_loc4_]);
            _loc6_ = this.rewardItemMouseOver;
            _loc7_ = this.rewardItemMouseOut;
            if(dataM.runAsMobile)
            {
               _loc6_ = null;
               _loc7_ = null;
            }
            _loc8_ = dataM.createShopTileListItem_basedOnItemID(_loc5_,"reward",null,null,null,_loc6_,_loc7_,true);
            _loc8_.x = _loc3_ + _loc4_ * (_loc1_ + _loc2_);
            _loc8_.y = this.txtTopClanReward.y + 35;
            addChild(_loc8_);
            this._clanRewardItems.push(_loc8_);
            _loc4_++;
         }
      }
      
      private function rewardItemMouseOver(param1:Number, param2:Number) : void
      {
      }
      
      private function rewardItemMouseOut(param1:Number, param2:Number) : void
      {
      }
      
      private function removeClanRewardItems() : void
      {
         var _loc2_:BMTileListItem = null;
         var _loc1_:uint = 0;
         while(_loc1_ < this._clanRewardItems.length)
         {
            _loc2_ = this._clanRewardItems[_loc1_];
            _loc2_.removeMe();
            this._clanRewardItems[_loc1_] = null;
            _loc1_++;
         }
         this._clanRewardItems = new Array();
      }
      
      private function initTournamentCountdown() : void
      {
         this._tournamentTimer = new Timer(1000);
         this._tournamentTimer.start();
         this._tournamentTimer.addEventListener(TimerEvent.TIMER,this.tournamentCountdownTimerTrigger);
         this.refreshTournamentCountdown();
      }
      
      private function tournamentCountdownTimerTrigger(param1:TimerEvent) : void
      {
         this.refreshTournamentCountdown();
      }
      
      private function refreshTournamentCountdown() : void
      {
         this.txtSeasonTimeLeft.text = BMCountdownTimerText.getCountdownTimerText(dataM.getSecondsLeftToLeagueEnding());
      }
      
      private function removeTournamentCountdown() : void
      {
         if(this._tournamentTimer == null)
         {
            return;
         }
         this._tournamentTimer.stop();
         this._tournamentTimer = null;
      }
      
      private function removeMe() : void
      {
         this.removeTournamentCountdown();
         this.mcTab1HitArea.removeEventListener(MouseEvent.CLICK,this.tab1Clicked);
         this.mcTab2HitArea.removeEventListener(MouseEvent.CLICK,this.tab2Clicked);
         screensM.removeScreen("screenLadderSeasonInfo");
      }
   }
}

