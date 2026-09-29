package net.battleMechsMulti.screens.battleResult
{
   import com.greensock.TimelineMax;
   import com.greensock.TweenMax;
   import com.greensock.easing.Back;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.battleMechsMulti.data.BMRewardData;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.ads.BMAdsManager;
   import net.battleMechsMulti.managers.sales.BMSale;
   import net.battleMechsMulti.managers.shop.BMShopManager;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.screens.BMScreenWatchRewardedVideo;
   import net.battleMechsMulti.screens.levelUp.BMLevelUpPrize;
   import net.battleMechsMulti.screens.mainMenu.TextHolder;
   import net.battleMechsMulti.utils.BMPubSub;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3655")]
   public class BMScreenBattleResultPremium extends BMScreenBattleResultBase
   {
      
      public var mcBonusPrizePanel:MovieClip;
      
      public var mcRegularPrizePanel:MovieClip;
      
      public var mcTitle:TextHolder;
      
      public var mcBanner:MovieClip;
      
      public var btnPremium:BMBasicButton;
      
      public var txtBottom:TextField;
      
      public var mcBg:Sprite;
      
      public var mcSkipHitArea:MovieClip;
      
      private var _btnVideo:BMBasicButton;
      
      private var _btnClaim:BMBasicButton;
      
      private var _btnSkip:BMBasicButton;
      
      private var _timLine:TimelineMax;
      
      private var _isAnimComplete:Boolean = false;
      
      public function BMScreenBattleResultPremium()
      {
         super();
         sub(BMPubSub.MESSAGE_REWARDED_VIDEO_WATCHED,this.onRewardedVideoWatched);
         sub(BMPubSub.MESSAGE_REWARDED_VIDEO_FAILED,this.onRewardedVideoFailed);
         sub(BMPubSub.MESSAGE_PREMIUM_PACKAGE_BOUGHT,this.onPremiumPackageBought);
      }
      
      override public function initialize() : void
      {
         super.initialize();
         this.mcRegularPrizePanel.mcDisabledOverlay.visible = false;
         this.initBtns();
         this.initTexts();
         if(dataM.isPremiumAccountActive())
         {
            this.activatePremium();
         }
      }
      
      private function initBtns() : void
      {
         this.mcSkipHitArea.addEventListener(MouseEvent.CLICK,this.onSkipAnimClick);
         this._btnVideo = this.mcBonusPrizePanel.btnVideo;
         this._btnClaim = this.mcBonusPrizePanel.btnClaim;
         this._btnSkip = this.mcRegularPrizePanel.btnSkip;
         this._btnVideo.addEventListener(BMIntractable.HIT,this.onVideoClick);
         this._btnSkip.addEventListener(BMIntractable.HIT,this.onSkipClick);
         this._btnVideo.text = getScreenText("watchVideo");
         if(dataM.runAsMobile || BMAdsManager.gi().isRewardedVideoAvailable(BMScreenWatchRewardedVideo.PLACEMENT_PVP_INCREASE_REWARD_SCREEN))
         {
            this.btnPremium.visible = true;
            this._btnVideo.visible = true;
            this._btnClaim.visible = false;
            this.btnPremium.text = getScreenText("getPremium");
            this.btnPremium.addEventListener(BMIntractable.HIT,this.onPremiumClick);
         }
         else
         {
            this.btnPremium.visible = false;
            this._btnVideo.visible = false;
            this._btnClaim.visible = true;
            this._btnClaim.text = getScreenText("getPremium");
            this._btnClaim.addEventListener(BMIntractable.HIT,this.onPremiumClick);
         }
      }
      
      private function initTexts() : void
      {
         var _loc1_:TextHolder = this.mcRegularPrizePanel.txtTitle;
         _loc1_.text = getScreenText("regularPrize");
         var _loc2_:BMBasicButton = this.mcRegularPrizePanel.btnSkip;
         _loc2_.text = getScreenText("skipBonus");
         this.mcTitle.text = getScreenText("battleRewards");
         updateTextAndFormat(this.txtBottom,getScreenText("getPremiumInfo"));
         if(dataM.runAsMobile)
         {
            ImageUtils.swapTextFieldWithBitMap(this.txtBottom,this);
         }
      }
      
      private function activatePremium() : void
      {
         this.activatePremiumClaimState();
         this.txtBottom.visible = false;
         this.btnPremium.visible = false;
         if(dataM.runAsMobile)
         {
            ImageUtils.swapTextFieldWithBitMap(this.txtBottom,this);
         }
      }
      
      private function get didLose() : Boolean
      {
         return dataM.myProfile.lastBattleResult == BMDataManager.BATTLE_RESULT_LOSS;
      }
      
      private function updateWinState() : void
      {
         var _loc2_:uint = 0;
         var _loc1_:String = getScreenText("bonusPrize");
         if(this.didLose)
         {
            _loc2_ = 100;
            this.mcBanner.gotoAndStop(2);
         }
         else
         {
            _loc2_ = 50;
            this.mcBanner.gotoAndStop(1);
         }
         _loc1_ = dataM.replaceStringInText(_loc1_,"%BONUS%",String(_loc2_));
         this.mcBonusPrizePanel.txtTitle.text = _loc1_;
      }
      
      override public function refreshScreen() : void
      {
         super.refreshScreen();
         screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
         if(screensM.isScreenOpened(BMScreensManager.SCR_BATTLE_OPTIONS))
         {
            screensM.removeScreen(BMScreensManager.SCR_BATTLE_OPTIONS);
         }
         if(screensM.isScreenOpened(BMScreensManager.SCR_BATTLE_INTERFACE_TOP))
         {
            screensM.screenBattleInterfaceTop.moveScreenUp();
         }
         this.updateWinState();
         this.doAnim();
      }
      
      private function doAnim() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc8_:BMLevelUpPrize = null;
         this._isAnimComplete = false;
         this.mcRegularPrizePanel.txtTitle.alpha = 0;
         this.mcRegularPrizePanel.mcLightsTop.alpha = 0;
         this.mcRegularPrizePanel.mcLightsBottom.alpha = 0;
         this.mcBonusPrizePanel.txtTitle.alpha = 0;
         this.mcBonusPrizePanel.mcLightsTop.alpha = 0;
         this.mcBonusPrizePanel.mcLightsBottom.alpha = 0;
         var _loc7_:Number = 1.5;
         if(dataM.myProfile.lastBattleResult == BMDataManager.BATTLE_RESULT_LOSS)
         {
            _loc7_ = 2;
         }
         if(dataM.isPremiumAccountActive())
         {
            _loc1_ = Math.ceil(_xp / _loc7_);
            _loc2_ = Math.ceil(_gold / _loc7_);
            _loc3_ = Math.ceil(_arenaCoins / _loc7_);
            _loc4_ = _xp;
            _loc5_ = _gold;
            _loc6_ = _arenaCoins;
         }
         else
         {
            _loc1_ = _xp;
            _loc2_ = _gold;
            _loc3_ = _arenaCoins;
            _loc4_ = Math.ceil(_xp * _loc7_);
            _loc5_ = Math.ceil(_gold * _loc7_);
            _loc6_ = Math.ceil(_arenaCoins * _loc7_);
         }
         this._timLine = new TimelineMax({"onComplete":this.onAnimComplete});
         this._timLine.timeScale(1.1);
         this._timLine.fromTo(this.mcBanner,0.4,{"y":-58.75},{
            "y":this.mcBanner.y,
            "ease":Back.easeOut
         },0.1);
         this._timLine.fromTo(this.mcTitle,0.4,{"alpha":0},{"alpha":1},"-=0.1");
         this._timLine.fromTo(this.mcRegularPrizePanel,0.3,{
            "scaleX":1.1,
            "scaleY":1.1,
            "alpha":0
         },{
            "scaleX":1,
            "scaleY":1,
            "alpha":1,
            "ease":Back.easeOut
         });
         this._timLine.fromTo(this.mcBonusPrizePanel,0.3,{
            "scaleX":1.1,
            "scaleY":1.1,
            "alpha":0
         },{
            "scaleX":1,
            "scaleY":1,
            "alpha":1,
            "ease":Back.easeOut
         },"-=0.1");
         this.addPanelLightsAnim(this.mcRegularPrizePanel);
         this.addPanelLightsAnim(this.mcBonusPrizePanel);
         if(_loc3_ > 0)
         {
            _loc8_ = this.addPrize(new localIcon_arenaCoinsCentered(),_loc3_,BattleResultPrize3,this.mcRegularPrizePanel.mcPrizesHolder);
            this._timLine.add(_loc8_.getShowTimeLine(1.5));
            _loc8_ = this.addPrize(new localIcon_arenaCoinsCentered(),_loc6_,BattleResultPrize2,this.mcBonusPrizePanel.mcPrizesHolder);
            this._timLine.add(_loc8_.getShowTimeLine(1.5),"-=0.1");
         }
         var _loc9_:Boolean = this.xpSalePercentEffect > 0;
         if(_nukes > 0)
         {
            _loc8_ = this.addPrize(new localIcon_nukes(),_nukes,BattleResultPrize3,this.mcRegularPrizePanel.mcPrizesHolder);
         }
         else
         {
            _loc8_ = this.addPrize(new localIcon_xpStar(),_loc1_,BattleResultPrize3,this.mcRegularPrizePanel.mcPrizesHolder,_loc9_);
         }
         this._timLine.add(_loc8_.getShowTimeLine(1.5));
         if(_nukes > 0)
         {
            _loc8_ = this.addPrize(new localIcon_nukes(),_nukes,BattleResultPrize2,this.mcBonusPrizePanel.mcPrizesHolder);
         }
         else
         {
            _loc8_ = this.addPrize(new localIcon_xpStar(),_loc4_,BattleResultPrize2,this.mcBonusPrizePanel.mcPrizesHolder,_loc9_);
         }
         this._timLine.add(_loc8_.getShowTimeLine(1.5),"-=0.1");
         var _loc10_:Boolean = this.goldSalePercentEffect > 0;
         _loc8_ = this.addPrize(new localIcon_gold(),_loc2_,BattleResultPrize3,this.mcRegularPrizePanel.mcPrizesHolder,_loc10_);
         this._timLine.add(_loc8_.getShowTimeLine(1.5));
         _loc8_ = this.addPrize(new localIcon_gold(),_loc5_,BattleResultPrize2,this.mcBonusPrizePanel.mcPrizesHolder,_loc10_);
         this._timLine.add(_loc8_.getShowTimeLine(1.5),"-=0.1");
         this._timLine.fromTo(this._btnSkip,0.3,{
            "scaleX":0,
            "scaleY":0
         },{
            "scaleX":1,
            "scaleY":1,
            "ease":Back.easeOut
         },"-=0.1");
         if(this._btnClaim.visible)
         {
            this._timLine.fromTo(this._btnClaim,0.3,{
               "scaleX":0,
               "scaleY":0
            },{
               "scaleX":1,
               "scaleY":1,
               "ease":Back.easeOut
            },"-=0.2");
         }
         else
         {
            this._timLine.fromTo(this._btnVideo,0.3,{
               "scaleX":0,
               "scaleY":0
            },{
               "scaleX":1,
               "scaleY":1,
               "ease":Back.easeOut
            },"-=0.2");
         }
         this._timLine.addLabel("end");
      }
      
      private function addPanelLightsAnim(param1:MovieClip) : void
      {
         this._timLine.add(TweenMax.to(param1.mcLightsTop,0.07,{
            "startAt":{"alpha":0},
            "alpha":0.5
         }),"-=0.1");
         this._timLine.add(TweenMax.to(param1.mcLightsBottom,0.07,{
            "startAt":{"alpha":0},
            "alpha":0.5
         }),"-=0.1");
         this._timLine.add(TweenMax.to(param1.txtTitle,0.07,{
            "startAt":{"alpha":0},
            "alpha":1
         }),"-=0.1");
      }
      
      private function addPrize(param1:MovieClip, param2:int, param3:Class, param4:MovieClip, param5:Boolean = false) : BMLevelUpPrize
      {
         var _loc6_:BMLevelUpPrize = new param3();
         _loc6_.setContent(param1,param2,"",param5);
         _loc6_.y = param4.numChildren * 50;
         param4.addChild(_loc6_);
         return _loc6_;
      }
      
      private function onAnimComplete() : *
      {
         if(this._isAnimComplete)
         {
            return;
         }
         this.mcSkipHitArea.visible = false;
         this._isAnimComplete = true;
         if(_reward != null && _reward.hasItemsOrBoxes)
         {
            _reward.gold = 0;
            _reward.xp = 0;
            dataM.giveRewardPopup(_reward);
         }
         this._btnVideo.enableMe();
         this._btnSkip.enableMe();
      }
      
      private function onSkipAnimClick(param1:MouseEvent) : void
      {
         this._timLine.seek("end");
         this.onAnimComplete();
      }
      
      private function onVideoClick(param1:Event) : void
      {
         if(dataM.isRewardedVideoAvailable(BMScreenWatchRewardedVideo.PLACEMENT_PVP_INCREASE_REWARD_SCREEN))
         {
            screensM.addScreen(BMScreensManager.SCR_WATCH_REWARDED_VIDEO,false);
            screensM.screenWatchRewardedVideo.refreshScreen(screensM.screenWatchRewardedVideo.TYPE_WIN_PVP,this.didLose ? 0 : 1);
         }
         else
         {
            screensM.screenConfirmation.displayQuestionOrNotification("rewardVideosComeBackLater");
         }
      }
      
      private function onClaimClick(param1:Event) : void
      {
         this.doContinue();
      }
      
      private function onSkipClick(param1:Event) : void
      {
         dataM.trackAdvertisingEvent(BMDataManager.AD_TYPE_REWARDED_VIDEO,BMDataManager.AD_ACTION_SKIPPED,BMScreenWatchRewardedVideo.PLACEMENT_PVP_INCREASE_REWARD_SCREEN,this.didLose ? 0 : 1);
         this.doContinue();
      }
      
      private function onRewardedVideoWatched(param1:String, param2:BMRewardData) : void
      {
         screensM.removeScreen(BMScreensManager.SCR_WATCH_REWARDED_VIDEO);
         screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
         this.activatePremiumClaimState();
      }
      
      private function activatePremiumClaimState() : void
      {
         this._btnVideo.visible = false;
         this._btnClaim.visible = true;
         this._btnSkip.disableMe();
         this.mcRegularPrizePanel.mcBg.gotoAndStop(2);
         this.mcBonusPrizePanel.mcBg.gotoAndStop(2);
         this.mcRegularPrizePanel.mcDisabledOverlay.visible = true;
         this._btnClaim.removeEventListener(BMIntractable.HIT,this.onPremiumClick);
         this._btnClaim.addEventListener(BMIntractable.HIT,this.onClaimClick);
         this._btnClaim.text = getScreenText("claimPremium");
      }
      
      private function onRewardedVideoFailed(param1:String, param2:Object) : void
      {
         this.doContinue();
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
      
      public function doContinue() : void
      {
         var _loc1_:Boolean = false;
         if(dataM.gameType == BMDataManager.GAME_TYPE_PVP && dataM.battle_inBattleInvitation == false)
         {
            _loc1_ = true;
         }
         if(_loc1_)
         {
            screensM.addScreen(BMScreensManager.SCR_LADDER_STATUS);
            screensM.screenLadderStatus.refreshScreen();
            removeMe();
         }
         else
         {
            screensM.screenBattle.closeScreen();
         }
      }
      
      private function get goldSalePercentEffect() : uint
      {
         return getRewardSaleEffect(BMSale.STORE_SECTION_ARENA_GOLD);
      }
      
      private function get xpSalePercentEffect() : uint
      {
         return getRewardSaleEffect(BMSale.STORE_SECTION_ARENA_XP);
      }
   }
}

