package net.battleMechsMulti.screens.missionDifficulty
{
   import com.greensock.TweenMax;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.battleMechsMulti.data.BMRewardRange;
   import net.battleMechsMulti.managers.BMLanguageManager;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.nukes.BMNukesResolver;
   import net.battleMechsMulti.managers.shop.BMGachaMachineData;
   import net.battleMechsMulti.managers.shop.BMShopManager;
   import net.battleMechsMulti.managers.singlePlayer.BMSinglePlayerManager;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.mobiles.worldMap.BMWorldMapLocationData;
   import net.battleMechsMulti.screens.BMBaseScreen;
   import net.battleMechsMulti.screens.BMScreenWatchRewardedVideo;
   import net.battleMechsMulti.screens.battleCredits.BMScreenFillBattleCredits;
   import net.battleMechsMulti.screens.inventory.BMInventoryTileListItem;
   import net.battleMechsMulti.utils.BMPubSub;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol833")]
   public class BMScreenMissionDifficulty extends BMBaseScreen
   {
      
      private static const REWARD_TOKENS:String = "Tokens";
      
      private static const REWARD_GOLD:String = "Gold";
      
      private static const REWARD_BOXES:String = "Boxes";
      
      private static const REWARD_XP:String = "XP";
      
      private static const REWARD_CLAN_BOSS_TICKETS:String = "ClanBossTickets";
      
      private static const REWARD_ITEM_FRAGMENTS:String = "ItemFragments";
      
      public var txtScreenTitle:TextField;
      
      public var txtRewardsTitle:TextField;
      
      public var mcRewardsHolder:Sprite;
      
      public var btnTab0:MovieClip;
      
      public var btnTab1:MovieClip;
      
      public var btnTab2:MovieClip;
      
      public var mcStar0:MovieClip;
      
      public var mcStar1:MovieClip;
      
      public var mcStar2:MovieClip;
      
      public var mcTabsBg:MovieClip;
      
      public var mcPremium:MovieClip;
      
      public var battleBtn:BMBasicButton;
      
      public var battleLockedBtn:BMBasicButton;
      
      public var nukeBtn:BMBasicButton;
      
      public var nukeEmptyBtn:BMBasicButton;
      
      public var closeBtn:BMBasicButton;
      
      public var videoBtn:BMBasicButton;
      
      public var premiumBtn:BMBasicButton;
      
      private var _selectedTab:int = 0;
      
      private var _startX:Number;
      
      private var _startY:Number;
      
      private var _isOpen:Boolean = false;
      
      private var _missionSlot:int;
      
      private var _battleBtnOriginXPos:Number;
      
      private const MAX_REWARD_ROWS:int = 4;
      
      private const REWARD_ROW_PADDING_PIXELS:int = 7;
      
      private var _rewardsToDisplay:Array;
      
      private var _rewardsCounter:uint;
      
      public function BMScreenMissionDifficulty()
      {
         super();
         this._startX = x;
         this._startY = y;
         this._battleBtnOriginXPos = this.battleBtn.x;
         x = this._startX + width + 100;
         sub(BMPubSub.MESSAGE_PREMIUM_PACKAGE_BOUGHT,this.onPremiumPackageBought);
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemoved);
         this.initialize();
      }
      
      public static function getTextForMode(param1:int) : String
      {
         switch(param1)
         {
            case 0:
               return BMLanguageManager.getInstance().getText("general_normal");
            case 1:
               return BMLanguageManager.getInstance().getText("general_hard");
            case 2:
               return BMLanguageManager.getInstance().getText("general_insane");
            default:
               return "";
         }
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("missionDifficulty");
         this.initButtons();
         this.initTexts();
         ImageUtils.swapTextFieldWithBitMap(this.txtRewardsTitle,this);
         this.mcPremium.visible = false;
         if(dataM.isPremiumAccountActive())
         {
            this.activatePremium();
         }
      }
      
      private function initButtons() : void
      {
         var _loc1_:Boolean = false;
         this.btnTab0.addEventListener(MouseEvent.CLICK,this.onTabClick);
         this.btnTab0.id = 0;
         this.btnTab1.addEventListener(MouseEvent.CLICK,this.onTabClick);
         this.btnTab1.id = 1;
         this.btnTab2.addEventListener(MouseEvent.CLICK,this.onTabClick);
         this.btnTab2.id = 2;
         this.battleBtn.addEventListener(BMIntractable.HIT,this.onBattleClick);
         this.battleLockedBtn.addEventListener(BMIntractable.HIT,this.onBattleLockedClick);
         this.closeBtn.addEventListener(BMIntractable.HIT,this.onCloseClick);
         this.premiumBtn.addEventListener(BMIntractable.HIT,this.onPremiumClick);
         this.videoBtn.addEventListener(BMIntractable.HIT,this.onVideoClick);
         this.nukeBtn.addEventListener(BMIntractable.HIT,this.onNukeClicked);
         this.nukeEmptyBtn.addEventListener(BMIntractable.HIT,this.onNukeClicked);
         _loc1_ = dataM.isRewardedVideoAvailable(BMScreenWatchRewardedVideo.PLACEMENT_PRE_CAMPAIGN_MISSION_BONUS);
         this.videoBtn.visible = !tutorialM.isTutorialActive() && _loc1_ && !dataM.isPremiumAccountActive();
         this.premiumBtn.visible = !_loc1_ && !tutorialM.isTutorialActive() && !dataM.isPremiumAccountActive();
         if(dataM.myProfile.nextMissionBonus == BMPlayerProfile.MISSION_BONUS_HP)
         {
            this.videoBtn.disableMe();
         }
         else
         {
            this.videoBtn.enableMe();
         }
         if(this.videoBtn.visible || this.premiumBtn.visible)
         {
            y = 22;
         }
         else
         {
            y = this._startY;
         }
      }
      
      private function initTexts() : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         updateTextAndFormat(this.txtRewardsTitle,getScreenText("rewards"));
         this.battleLockedBtn.text = getScreenText("locked");
         var _loc1_:uint = 20;
         if(this.premiumBtn.visible)
         {
            _loc2_ = getScreenText("getPremiumForHPBonus");
            _loc2_ = dataM.replaceStringInText(_loc2_,"%RATIO%",String(_loc1_));
            this.premiumBtn.text = _loc2_;
         }
         if(this.videoBtn.visible)
         {
            _loc3_ = getScreenText("watchVideoForHPBonus");
            _loc3_ = dataM.replaceStringInText(_loc3_,"%RATIO%",String(_loc1_));
            this.videoBtn.text = _loc3_;
         }
      }
      
      private function onCloseClick(param1:Event) : void
      {
         this.backClicked();
      }
      
      private function onBattleClick(param1:Event) : void
      {
         var _loc2_:uint = uint(this.getBattleCreditsCostForMode(this.currentMode));
         if(dataM.myProfile.battleCredits < _loc2_)
         {
            screensM.addScreen(BMScreensManager.SCR_FILL_BATTLE_CREDITS);
            screensM.screenFillBattleCredits.setPosition(BMScreenFillBattleCredits.POSITION_ON_MISSION_DIFFICULTY);
         }
         else
         {
            dataM.myProfile.setCurrentMissionMode(this.currentMode);
            screensM.screenMissionWorldMap.enterMission();
         }
      }
      
      private function onVideoClick(param1:Event) : void
      {
         screensM.addScreen(BMScreensManager.SCR_WATCH_REWARDED_VIDEO,false);
         screensM.screenWatchRewardedVideo.refreshScreen(screensM.screenWatchRewardedVideo.TYPE_PRE_CAMPAIGN_MISSION_BONUS,this._missionSlot);
      }
      
      public function onVideoWatched() : void
      {
         if(dataM.myProfile.nextMissionBonus == BMPlayerProfile.MISSION_BONUS_HP)
         {
            this.videoBtn.disableMe();
         }
         else
         {
            this.videoBtn.enableMe();
         }
      }
      
      private function get storyID() : uint
      {
         return screensM.screenMissionWorldMap.storyID;
      }
      
      private function onBattleLockedClick(param1:Event) : void
      {
         var _loc2_:int = BMSinglePlayerManager.getInstance().getMissionStartState(this.storyID,this._missionSlot,this.currentMode);
         var _loc3_:String = "";
         if(_loc2_ == BMSinglePlayerManager.MISSION_START_STATE_MUST_COMPLETE_PREVIOUS_MISSION)
         {
            _loc3_ = getScreenText("mustCompletePreviousMission");
            trace("message:" + _loc3_);
            _loc3_ = dataM.replaceStringInText(_loc3_,"%DIFFICULTY%",getTextForMode(this.currentMode));
         }
         else if(_loc2_ == BMSinglePlayerManager.MISSION_START_STATE_MUST_COMPLETE_PREVIOUS_MODE_CHAPTER)
         {
            _loc3_ = getScreenText("mustCompleteZone");
            trace("message:" + _loc3_);
            _loc3_ = dataM.replaceStringInText(_loc3_,"%DIFFICULTY1%",getTextForMode(this.currentMode - 1));
            _loc3_ = dataM.replaceStringInText(_loc3_,"%DIFFICULTY2%",getTextForMode(this.currentMode));
         }
         else if(_loc2_ == BMSinglePlayerManager.MISSION_START_STATE_MUST_COMPLETE_PREVIOUS_MISSION_DIFFICULTY)
         {
            _loc3_ = getScreenText("mustCompleteDifficulty");
            trace("message:" + _loc3_);
            _loc3_ = dataM.replaceStringInText(_loc3_,"%DIFFICULTY%",getTextForMode(this.currentMode - 1));
         }
         trace("message:" + _loc3_);
         screensM.screenConfirmation.displayCustomMessage(_loc3_);
      }
      
      private function onTabClick(param1:MouseEvent) : void
      {
         var _loc2_:int = int(param1.currentTarget.id);
         if(_loc2_ != this._selectedTab)
         {
            this.selectTab(_loc2_);
         }
      }
      
      private function getCurrentTabMovieClip() : MovieClip
      {
         return this.mcTabsBg["mcTabBg" + this._selectedTab];
      }
      
      private function selectTab(param1:int) : void
      {
         var _loc2_:MovieClip = this.getCurrentTabMovieClip();
         this._selectedTab = param1;
         dataM.myProfile.setLastSelectedMissionSlotAndMode(this.storyID,this._missionSlot,this._selectedTab);
         var _loc3_:MovieClip = this.getCurrentTabMovieClip();
         updateTextAndFormat(_loc3_.txt0,getTextForMode(0));
         updateTextAndFormat(_loc3_.txt1,getTextForMode(1));
         updateTextAndFormat(_loc3_.txt2,getTextForMode(2));
         this.mcTabsBg.addChild(_loc3_);
         TweenMax.fromTo(_loc3_,0.12,{"alpha":0},{"alpha":1});
         TweenMax.to(_loc2_,0,{"alpha":1});
         this.refreshTabContents();
         this.updateBattleButtonText();
      }
      
      private function refreshTabContents() : *
      {
         var _loc3_:int = 0;
         var _loc4_:Object = null;
         this._rewardsToDisplay = new Array();
         this._rewardsCounter = 0;
         var _loc1_:BMRewardRange = this.getRewardsRangeForMode(this.currentMode);
         this.mcRewardsHolder.removeChildren();
         if(this.hasBoxFragmentsReward(this.currentMode))
         {
            _loc3_ = this.getBoxFragmentsGachaMachineIDForMode(this.currentMode);
            this.shouldAddReward(REWARD_ITEM_FRAGMENTS,0,this.getBoxFragmentsAmountForMode(this.currentMode));
         }
         this.shouldAddReward(REWARD_TOKENS,this.getTokensRewardForMode(this.currentMode),this.getTokensRewardForMode(this.currentMode));
         this.shouldAddReward(REWARD_GOLD,_loc1_.min.gold,_loc1_.max.gold);
         this.shouldAddReward(REWARD_BOXES,_loc1_.min.boxes.length,_loc1_.max.boxes.length);
         this.shouldAddReward(REWARD_XP,_loc1_.min.xp,_loc1_.max.xp);
         this.shouldAddReward(REWARD_CLAN_BOSS_TICKETS,this.getClanBossTicketsRewardForMode(this.currentMode),this.getClanBossTicketsRewardForMode(this.currentMode));
         var _loc2_:uint = 0;
         while(_loc2_ < this._rewardsToDisplay.length)
         {
            _loc4_ = this._rewardsToDisplay[_loc2_];
            this.addRewardRow(_loc4_.type,_loc4_.minValue,_loc4_.maxValue);
            _loc2_++;
         }
         this.nukeBtn.visible = false;
         this.nukeEmptyBtn.visible = false;
         this.battleBtn.x = this._battleBtnOriginXPos;
         if(this.isModePlayable(this.currentMode))
         {
            this.battleBtn.visible = true;
            this.battleBtn.text = getScreenText("battle") + " <font color=\'#FFDD57\'>" + this.getBattleCreditsCostForMode(this.currentMode) + "</font>";
            this.battleLockedBtn.visible = false;
            if(BMNukesResolver.gi().canActivateNukeInMission(this.storyID,this._missionSlot,this.currentMode))
            {
               if(dataM.myProfile.nukes == 0)
               {
                  this.nukeEmptyBtn.visible = true;
               }
               else
               {
                  this.nukeBtn.visible = true;
               }
               this.battleBtn.x -= 30;
            }
         }
         else
         {
            this.battleBtn.visible = false;
            this.battleLockedBtn.visible = true;
         }
      }
      
      private function shouldAddReward(param1:String, param2:uint, param3:uint) : void
      {
         if(param1 == REWARD_ITEM_FRAGMENTS)
         {
            this._rewardsToDisplay.push({
               "type":param1,
               "minValue":param2,
               "maxValue":param3
            });
            return;
         }
         if(param1 == REWARD_CLAN_BOSS_TICKETS)
         {
            if(dataM.myProfile.isClanBossCollectingTicketsPhase == false)
            {
               return;
            }
         }
         if(param3 > 0 && this.mcRewardsHolder.numChildren < this.MAX_REWARD_ROWS)
         {
            this._rewardsToDisplay.push({
               "type":param1,
               "minValue":param2,
               "maxValue":param3
            });
         }
      }
      
      private function get showTwoRewardsInOneRow() : Boolean
      {
         return this._rewardsToDisplay.length > 4;
      }
      
      private function addRewardRow(param1:String, param2:uint, param3:uint) : *
      {
         var _loc4_:MissionReward = null;
         var _loc5_:String = null;
         var _loc7_:Number = NaN;
         var _loc9_:uint = 0;
         var _loc10_:int = 0;
         var _loc11_:BMGachaMachineData = null;
         var _loc12_:BMInventoryTileListItem = null;
         ++this._rewardsCounter;
         if(param1 == REWARD_ITEM_FRAGMENTS)
         {
            _loc4_ = new MissionDifficultyRewardFragments();
         }
         else if(this.showTwoRewardsInOneRow)
         {
            _loc4_ = new MissionDifficultyRewardSmaller();
         }
         else
         {
            _loc4_ = new MissionReward();
         }
         if(param2 == param3)
         {
            _loc5_ = TextUtils.getNumberWithComma(param3);
         }
         else
         {
            _loc5_ = TextUtils.getNumberWithComma(param2) + " - " + TextUtils.getNumberWithComma(param3);
         }
         var _loc6_:MovieClip = null;
         switch(param1)
         {
            case REWARD_TOKENS:
               _loc6_ = new localIcon_tokensCentered();
               break;
            case REWARD_GOLD:
               _loc6_ = new localIcon_gold();
               break;
            case REWARD_BOXES:
               _loc6_ = new mcEmptyItemBox();
               break;
            case REWARD_XP:
               _loc6_ = new localIcon_xpStar();
               break;
            case REWARD_CLAN_BOSS_TICKETS:
               _loc6_ = new localIcon_clanBossTicketCentered();
               break;
            case REWARD_ITEM_FRAGMENTS:
               _loc9_ = 100;
               _loc10_ = this.getBoxFragmentsGachaMachineIDForMode(this.currentMode);
               _loc11_ = dataM.gachaMachinesDB[_loc10_];
               _loc12_ = dataM.createItemFragmentTileListItem(_loc11_.itemID,_loc9_,this.itemFragmentClicked,true);
               _loc12_.x -= _loc12_.width / 2;
               _loc12_.y -= _loc12_.height / 2;
               _loc6_ = new MovieClip();
               _loc6_.addChild(_loc12_);
               _loc5_ += "  " + languageM.getText("fragments_title");
         }
         _loc4_.text = _loc5_;
         _loc4_.setIcon(_loc6_);
         this.mcRewardsHolder.addChild(_loc4_);
         var _loc8_:Number = 0;
         if(this.showTwoRewardsInOneRow)
         {
            _loc8_ = (this._rewardsCounter - 1) % 2 * 140;
            _loc7_ = (_loc4_.height + this.REWARD_ROW_PADDING_PIXELS) * (Math.ceil(this._rewardsCounter / 2) - 1);
            if(param1 == REWARD_ITEM_FRAGMENTS)
            {
               ++this._rewardsCounter;
            }
         }
         else
         {
            _loc7_ = (_loc4_.height + this.REWARD_ROW_PADDING_PIXELS) * (this._rewardsCounter - 1);
         }
         _loc4_.x = _loc8_;
         _loc4_.y = _loc7_;
      }
      
      public function show(param1:int, param2:int) : void
      {
         var _loc4_:String = null;
         this._isOpen = true;
         this._missionSlot = param1;
         var _loc3_:BMWorldMapLocationData = dataM.singlePlayerM.getSpecificMissionDB(this.storyID,this._missionSlot);
         if(_loc3_.name != "")
         {
            _loc4_ = _loc3_.name;
         }
         else if(_loc3_.mainPath)
         {
            _loc4_ = getScreenText("mission");
         }
         else
         {
            _loc4_ = getScreenText("sideMission");
         }
         _loc4_ = dataM.replaceStringInText(_loc4_,"%VALUE%",String(_loc3_.displayNumber));
         this.setTitle(_loc4_);
         this.selectTab(param2);
         TweenMax.to(this,0.3,{"x":this._startX});
         this.refrashStars();
         this.updateBattleButtonText();
      }
      
      private function itemFragmentClicked(param1:int, param2:int) : void
      {
         var _loc3_:int = this.getBoxFragmentsGachaMachineIDForMode(this.currentMode);
         var _loc4_:uint = uint(dataM.boxFragmentsManager.getFragmentsRequiredForBox(_loc3_));
         var _loc5_:uint = uint(dataM.boxFragmentsManager.getNumberOfFragmentsOwned(_loc3_));
         var _loc6_:String = languageM.getText("fragments_required");
         _loc6_ = dataM.replaceStringInText(_loc6_,"%AMOUNT%",String(_loc5_));
         _loc6_ = dataM.replaceStringInText(_loc6_,"%REQUIRED%",String(_loc4_));
         screensM.addScreen(BMScreensManager.SCR_CONTENT_PACK_ITEM_INFO);
         screensM.screenContentPackItemInfo.showItemInfo(param2,false,_loc6_);
      }
      
      private function refrashStars() : void
      {
         var _loc2_:MovieClip = null;
         var _loc1_:* = 0;
         while(_loc1_ < BMSinglePlayerManager.NUM_DIFFICULTY_MODES)
         {
            _loc2_ = this["mcStar" + _loc1_] as MovieClip;
            if(BMSinglePlayerManager.getInstance().didCompleteSlot(this.storyID,this._missionSlot,_loc1_))
            {
               _loc2_.gotoAndStop(2);
            }
            else
            {
               _loc2_.gotoAndStop(1);
            }
            _loc1_++;
         }
      }
      
      private function updateBattleButtonText() : void
      {
         var _loc1_:uint = uint(dataM.singlePlayerM.getMissionDifficulty(this.storyID,this._missionSlot));
         var _loc2_:BMWorldMapLocationData = dataM.singlePlayerM.getSpecificMissionDB(this.storyID,this._missionSlot);
         var _loc3_:uint = dataM.campaignMissionRewardsRepository.getMissionBattleCreditsCost(this.storyID,_loc2_.campaignID,this._selectedTab,_loc1_);
         this.battleBtn.text = getScreenText("battle") + " " + _loc3_;
      }
      
      public function setTitle(param1:String) : *
      {
         updateTextAndFormat(this.txtScreenTitle,param1);
         ImageUtils.swapTextFieldWithBitMap(this.txtScreenTitle,this);
      }
      
      public function hide() : void
      {
         this._isOpen = false;
         TweenMax.to(this,0.3,{"x":this._startX + width + 100});
      }
      
      public function backClicked() : void
      {
         screensM.screenMissionWorldMap.unSelectMission();
      }
      
      public function get isOpen() : Boolean
      {
         return this._isOpen;
      }
      
      private function get currentMode() : int
      {
         return this._selectedTab;
      }
      
      private function getBattleCreditsCostForMode(param1:int) : int
      {
         return screensM.screenMissionWorldMap.getBattleCreditsCost(this._missionSlot,param1);
      }
      
      private function getRewardsRangeForMode(param1:int) : BMRewardRange
      {
         var _loc2_:BMWorldMapLocationData = dataM.singlePlayerM.getSpecificMissionDB(this.storyID,this._missionSlot);
         return dataM.campaignMissionRewardsRepository.getMissionRewards(this.storyID,_loc2_.campaignID,param1);
      }
      
      private function getTokensRewardForMode(param1:int) : int
      {
         var _loc2_:BMWorldMapLocationData = null;
         if(BMSinglePlayerManager.getInstance().didCompleteSlot(this.storyID,this._missionSlot,param1))
         {
            return 0;
         }
         _loc2_ = dataM.singlePlayerM.getSpecificMissionDB(this.storyID,this._missionSlot);
         return BMSinglePlayerManager.getInstance().getMissionFirstClearBonusTokens(this.storyID,_loc2_.campaignID,param1);
      }
      
      private function getClanBossTicketsRewardForMode(param1:int) : int
      {
         var _loc2_:BMWorldMapLocationData = dataM.singlePlayerM.getSpecificMissionDB(this.storyID,this._missionSlot);
         return BMSinglePlayerManager.getInstance().getMissionClanBossTickets(this.storyID,_loc2_.campaignID,param1);
      }
      
      private function hasBoxFragmentsReward(param1:int) : Boolean
      {
         return this.getBoxFragmentsGachaMachineIDForMode(param1) > 0;
      }
      
      private function getBoxFragmentsGachaMachineIDForMode(param1:int) : int
      {
         var _loc2_:BMWorldMapLocationData = dataM.singlePlayerM.getSpecificMissionDB(this.storyID,this._missionSlot);
         return BMSinglePlayerManager.getInstance().getMissionBoxFragmentsGachaMachineID(this.storyID,_loc2_.campaignID,param1);
      }
      
      private function getBoxFragmentsAmountForMode(param1:int) : int
      {
         var _loc2_:BMWorldMapLocationData = dataM.singlePlayerM.getSpecificMissionDB(this.storyID,this._missionSlot);
         return BMSinglePlayerManager.getInstance().getMissionBoxFragmentsMax(this.storyID,_loc2_.campaignID,param1);
      }
      
      private function isModePlayable(param1:int) : Boolean
      {
         var _loc2_:BMWorldMapLocationData = dataM.singlePlayerM.getSpecificMissionDB(this.storyID,this._missionSlot);
         var _loc3_:int = dataM.singlePlayerM.getMissionStartState(this.storyID,this._missionSlot,param1);
         return _loc2_.subType == BMWorldMapLocationData.SUB_TYPE_MISSION_DUNGEON || _loc3_ == BMSinglePlayerManager.MISSION_START_STATE_CAN_START;
      }
      
      private function onNukeClicked(param1:Event) : void
      {
         screensM.addScreen(BMScreensManager.SCR_LAUNCH_NUKES);
         var _loc2_:uint = uint(this.getBattleCreditsCostForMode(this.currentMode));
         screensM.screenLaunchNukes.setData(this.storyID,this._missionSlot,this.currentMode,_loc2_);
      }
      
      private function onPremiumClick(param1:Event) : void
      {
         BMShopManager.gi().showPremium("BattleResultPremium");
      }
      
      private function onPremiumPackageBought(param1:String, param2:Object) : void
      {
         BMShopManager.gi().close();
         this.activatePremium();
      }
      
      private function activatePremium() : void
      {
         this.mcPremium.visible = true;
         this.videoBtn.visible = false;
         this.premiumBtn.visible = false;
         y = this._startY;
      }
      
      private function onRemoved(param1:Event) : void
      {
         notifyRemoved();
      }
   }
}

