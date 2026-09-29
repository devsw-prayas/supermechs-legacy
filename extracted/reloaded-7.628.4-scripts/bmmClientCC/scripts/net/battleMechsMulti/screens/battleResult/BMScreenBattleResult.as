package net.battleMechsMulti.screens.battleResult
{
   import com.greensock.TimelineMax;
   import com.greensock.TweenMax;
   import com.greensock.easing.Back;
   import fl.motion.Color;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.battleMechsMulti.data.BMClanMemberData;
   import net.battleMechsMulti.data.BMRewardData;
   import net.battleMechsMulti.data.BattleTypeResolver;
   import net.battleMechsMulti.helpers.BMGameShortcutsHelper;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMLevelUpManager;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.BMTipsManager;
   import net.battleMechsMulti.managers.sales.BMSale;
   import net.battleMechsMulti.managers.singlePlayer.BMSinglePlayerManager;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.mobiles.worldMap.BMWorldMapLocationData;
   import net.battleMechsMulti.screens.inventory.BMInventoryTileListItem;
   import net.battleMechsMulti.screens.levelUp.BMLevelUpPrize;
   import net.battleMechsMulti.screens.mainMenu.TextHolder;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3703")]
   public class BMScreenBattleResult extends BMScreenBattleResultBase
   {
      
      public static const PRIZE_ARENA_COINS:String = "arenaCoins";
      
      public static const PRIZE_RAID_SCORE:String = "raidScore";
      
      public static const PRIZE_GOLD:String = "gold";
      
      public static const PRIZE_XP:String = "xp";
      
      public static const PRIZE_TOKENS:String = "tokens";
      
      public static const PRIZE_BOXES:String = "boxes";
      
      public static const PRIZE_NUKES:String = "nukes";
      
      public static const PRIZE_BOX_FRAGMENTS:String = "boxFragments";
      
      public static const PRIZE_CLAN_BOSS_TICKETS:String = "clanBossTickets";
      
      public var mcSparksHolder:Sprite;
      
      public var mcFrameGlow:MovieClip;
      
      public var mcTutorialArrow_button:MovieClip;
      
      public var mcTutorialMarker_button:MovieClip;
      
      public var mcTitle:TextHolder;
      
      public var mcSubTitle:TextHolder;
      
      public var mcFlare:MovieClip;
      
      public var mcBannerLeft:MovieClip;
      
      public var mcBannerRight:MovieClip;
      
      public var mcSwordRight:MovieClip;
      
      public var mcSwordLeft:MovieClip;
      
      public var mcTip:TextHolder;
      
      public var mcSkipHitArea:MovieClip;
      
      public var continueBtn:BMBasicButton;
      
      public var nextMissionBtn:BMBasicButton;
      
      public var worldMapBtn:BMBasicButton;
      
      public var chatBtn:BMBasicButton;
      
      public var clanBtn:BMBasicButton;
      
      public var mcBackground:MovieClip;
      
      public var mcPrizesHolder:MovieClip;
      
      public var mcBg:MovieClip;
      
      public var mcGlowWin:MovieClip;
      
      public var mcGlowDefeat:MovieClip;
      
      public var mcRays:MovieClip;
      
      private var _timLine:TimelineMax;
      
      private var _showSparks:Boolean;
      
      private var _sparks:Array;
      
      private var _sparksSpeedAddon:Number = 5;
      
      private var _isAnimComplete:Boolean = false;
      
      private var _prizesToShow:Array = new Array();
      
      private var _prizesDisplayed:Vector.<BMLevelUpPrize> = new Vector.<BMLevelUpPrize>();
      
      public function BMScreenBattleResult()
      {
         super();
      }
      
      private function initButton() : void
      {
         var _loc1_:Color = null;
         this.mcSkipHitArea.addEventListener(MouseEvent.CLICK,this.onSkipAnimClick);
         this.continueBtn.addEventListener(BMIntractable.HIT,this.onContinueClick);
         this.continueBtn.text = getScreenText("continue");
         if(this.worldMapBtn != null)
         {
            this.worldMapBtn.addEventListener(BMIntractable.HIT,this.onContinueClick);
            this.worldMapBtn.text = getScreenText("worldMap");
            this.worldMapBtn.visible = false;
            _loc1_ = new Color();
            _loc1_.setTint(0,0.1);
            this.worldMapBtn.transform.colorTransform = _loc1_;
         }
         if(this.nextMissionBtn != null)
         {
            this.nextMissionBtn.addEventListener(BMIntractable.HIT,this.onNextMissionClick);
            this.nextMissionBtn.text = TextUtils.splitStringToTwoLines(getScreenText("nextMission")).join("\n");
            this.nextMissionBtn.visible = false;
         }
         if(this.clanBtn != null)
         {
            this.clanBtn.addEventListener(BMIntractable.HIT,this.onClanClick);
            this.clanBtn.addEventListener(MouseEvent.ROLL_OVER,this.onClanOver);
            this.clanBtn.addEventListener(MouseEvent.ROLL_OUT,this.onTipToolOutOver);
         }
         if(this.chatBtn != null)
         {
            this.chatBtn.addEventListener(BMIntractable.HIT,this.onChatClick);
            this.chatBtn.addEventListener(MouseEvent.ROLL_OVER,this.onChatOver);
            this.chatBtn.addEventListener(MouseEvent.ROLL_OUT,this.onTipToolOutOver);
         }
         if(BattleTypeResolver.isLadderPvPOnServer || BattleTypeResolver.isPvPPrivateBattle)
         {
            if(!this.isInviteToClan())
            {
               this.clanBtn.disableMe();
            }
         }
         else
         {
            if(this.clanBtn != null)
            {
               this.clanBtn.visible = false;
            }
            if(this.chatBtn != null)
            {
               this.chatBtn.visible = false;
            }
         }
      }
      
      override public function get isInNextMissionMode() : Boolean
      {
         return this.worldMapBtn != null;
      }
      
      override public function setPrizes(param1:Number, param2:Number, param3:Number, param4:Number, param5:BMRewardData = null) : void
      {
         super.setPrizes(param1,param2,param3,param4,param5);
         var _loc6_:Boolean = false;
         var _loc7_:Boolean = true;
         if(dataM.raidData.isRaidInProgress())
         {
            _loc6_ = true;
         }
         if(_loc6_)
         {
            this._prizesToShow.push(PRIZE_RAID_SCORE);
            if(param1 == 0)
            {
               _loc7_ = false;
            }
         }
         if(param3 > 0)
         {
            this._prizesToShow.push(PRIZE_ARENA_COINS);
         }
         if(_loc7_)
         {
            this._prizesToShow.push(PRIZE_GOLD);
         }
         if(param4 > 0)
         {
            this._prizesToShow.push(PRIZE_NUKES);
         }
         else if(param2 > 0)
         {
            this._prizesToShow.push(PRIZE_XP);
         }
         if(param5 != null && param5.tokens > 0)
         {
            this._prizesToShow.push(PRIZE_TOKENS);
         }
         if(param5 != null && Boolean(param5.clanBossTickets))
         {
            this._prizesToShow.push(PRIZE_CLAN_BOSS_TICKETS);
         }
         if(param5 != null && param5.hasItemsOrBoxes)
         {
            this._prizesToShow.push(PRIZE_BOXES);
         }
         if(param5 != null && param5.hasBoxFragments)
         {
            this._prizesToShow.push(PRIZE_BOX_FRAGMENTS);
         }
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
         this.mcSubTitle.text = getScreenText("missionReward");
         var _loc1_:uint = BMTipsManager.TIP_TYPE_DEFAULT;
         if(dataM.gameType == BMDataManager.GAME_TYPE_PVE && dataM.myProfile.lastBattleResult == BMDataManager.BATTLE_RESULT_LOSS)
         {
            _loc1_ = BMTipsManager.TIP_TYPE_PVE_LOSS;
         }
         this.mcTip.text = dataM.tipsManager.getTip(true,_loc1_);
         if(BMGameShortcutsHelper.battleResultScreenShortcut())
         {
            this.doContinue();
         }
         this.initTutorial();
         this.initButton();
         this.initWinState();
         this.doAnimation();
         this.doRaysAnimation();
      }
      
      private function initWinState() : void
      {
         var _loc1_:String = "";
         if(dataM.myProfile.lastBattleResult == BMDataManager.BATTLE_RESULT_LOSS)
         {
            _loc1_ = "<FONT COLOR=\'#DC4A40\'>" + getScreenText(BMDataManager.BATTLE_RESULT_LOSS);
            this.mcBannerLeft.visible = false;
            this.mcBannerRight.visible = false;
            this.mcSwordRight.visible = false;
            this.mcSwordLeft.visible = false;
            this.mcRays.visible = false;
            this.mcGlowWin.visible = false;
         }
         else
         {
            this.mcGlowDefeat.visible = false;
            _loc1_ = getScreenText("victory4");
         }
         this.mcTitle.text = _loc1_;
      }
      
      private function initTutorial() : void
      {
         this.mcTutorialArrow_button.mouseChildren = false;
         this.mcTutorialArrow_button.mouseEnabled = false;
         this.mcTutorialMarker_button.mouseChildren = false;
         this.mcTutorialMarker_button.mouseEnabled = false;
         if(tutorialM.isTutorialActive())
         {
            this.mcTutorialArrow_button.gotoAndStop("animOn");
            this.mcTutorialMarker_button.gotoAndStop("animOn");
         }
      }
      
      private function doAnimation() : void
      {
         var _loc1_:BMLevelUpPrize = null;
         this.continueBtn.disableMe();
         this._isAnimComplete = false;
         this._timLine = new TimelineMax({"onComplete":this.onAnimComplete});
         this._timLine.fromTo(this,0.5,{"y":-500},{
            "y":0,
            "ease":Back.easeOut
         });
         this._timLine.fromTo(this.mcBg,0.5,{"alpha":0},{"alpha":1},0);
         if(dataM.myProfile.lastBattleResult != BMDataManager.BATTLE_RESULT_LOSS)
         {
            this._timLine.addLabel("banners");
            this._timLine.fromTo(this.mcBannerLeft,0.3,{"x":this.mcBannerLeft.x + this.mcBannerLeft.width},{
               "x":this.mcBannerLeft.x,
               "ease":Back.easeOut
            },"banners");
            this._timLine.fromTo(this.mcBannerRight,0.3,{"x":this.mcBannerRight.x - this.mcBannerRight.width},{
               "x":this.mcBannerRight.x,
               "ease":Back.easeOut
            },"banners");
            this._timLine.addLabel("swords","-=0.2");
            this._timLine.fromTo(this.mcSwordRight,0.3,{"rotation":this.mcSwordRight.rotation - 90},{
               "rotation":this.mcSwordRight.rotation,
               "ease":Back.easeOut
            },"swords");
            this._timLine.fromTo(this.mcSwordLeft,0.3,{"rotation":this.mcSwordLeft.rotation + 90},{
               "rotation":this.mcSwordLeft.rotation,
               "ease":Back.easeOut
            },"swords");
         }
         this._timLine.fromTo(this.mcTitle,0.3,{
            "scaleX":0,
            "scaleY":0
         },{
            "scaleX":1,
            "scaleY":1,
            "ease":Back.easeOut
         });
         this._timLine.fromTo(this.mcSubTitle,0.3,{
            "scaleX":0,
            "scaleY":0
         },{
            "scaleX":1,
            "scaleY":1,
            "ease":Back.easeOut
         },"-=0.1");
         this._timLine.fromTo(this.mcFlare,0.3,{
            "scaleX":0,
            "scaleY":0
         },{
            "scaleX":1,
            "scaleY":1
         },"-=0.3");
         this._timLine.fromTo(this.mcFlare,0.2,{"alpha":1},{"alpha":0});
         this.addNextPrizesAnim();
         this._timLine.addLabel("btns");
         this._timLine.fromTo(this.continueBtn,0.3,{
            "scaleX":0,
            "scaleY":0
         },{
            "scaleX":1,
            "scaleY":1,
            "ease":Back.easeOut
         },"btns");
         this._timLine.fromTo(this.mcTip,0.3,{"alpha":0},{"alpha":1});
         this._timLine.addLabel("end");
      }
      
      private function addNextPrizesAnim() : void
      {
         var _loc1_:BMLevelUpPrize = null;
         var _loc2_:int = 0;
         while(_loc2_ < 2 && this._prizesToShow.length > 0)
         {
            _loc1_ = this.addPrizeByType(this._prizesToShow.shift());
            this._timLine.add(_loc1_.getShowTimeLine(),"-=0.1");
            _loc2_++;
         }
      }
      
      private function addPrizeByType(param1:String) : BMLevelUpPrize
      {
         var _loc4_:MovieClip = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:BMInventoryTileListItem = null;
         var _loc8_:int = 0;
         var _loc9_:MovieClip = null;
         var _loc10_:String = null;
         var _loc2_:Boolean = this.xpSalePercentEffect > 0;
         var _loc3_:Boolean = this.goldSalePercentEffect > 0;
         switch(param1)
         {
            case PRIZE_ARENA_COINS:
               return this.addPrize(new localIcon_arenaCoinsCentered(),_arenaCoins);
            case PRIZE_GOLD:
               return this.addPrize(new localIcon_gold(),_gold,"",_loc3_);
            case PRIZE_XP:
               return this.addPrize(new localIcon_xpStar(),_xp,"",_loc2_);
            case PRIZE_NUKES:
               return this.addPrize(new localIcon_nukes(),_nukes,"");
            case PRIZE_TOKENS:
               return this.addPrize(new localIcon_tokensCentered(),_reward.tokens);
            case PRIZE_BOXES:
               return this.addPrize(new mcEmptyItemBox(),-1,getSpecificText("levelUp_itemBox"));
            case PRIZE_BOX_FRAGMENTS:
               _loc4_ = new MovieClip();
               _loc5_ = 0;
               if(_reward.hasSpecificItemFragments)
               {
                  _loc6_ = 70;
                  _loc7_ = dataM.createItemFragmentTileListItem(_reward.fragmentItemID,_loc6_);
                  _loc7_.x -= _loc6_ / 2;
                  _loc7_.y -= _loc6_ / 2;
                  _loc4_.addChild(_loc7_);
               }
               else
               {
                  _loc8_ = 0;
                  _loc9_ = new grpItemBox1CenteredNew();
                  for(_loc10_ in _reward.boxFragments)
                  {
                     _loc8_ = int(_loc10_);
                  }
                  _loc9_.gotoAndStop("itemBox" + (500 + _loc8_));
                  _loc9_.y += _loc9_.height / 2;
                  _loc4_.addChild(_loc9_);
                  _loc5_ = 15;
               }
               return this.addPrize(_loc4_,-1,_reward.numBoxFragments.toString(),false,_loc5_);
            case PRIZE_RAID_SCORE:
               return this.addPrize(this.getRaidScoreTextIcon(),dataM.raidData.raidLastMissionScore);
            case PRIZE_CLAN_BOSS_TICKETS:
               return this.addPrize(new localIcon_clanBossTicketCentered(),_reward.clanBossTickets);
            default:
               return null;
         }
      }
      
      private function getRaidScoreTextIcon() : MovieClip
      {
         var _loc1_:MovieClip = null;
         if(dataM.raidData.raidLastMissionScore > dataM.raidData.currentLevelHighestScore)
         {
            _loc1_ = new battleResultRaidScoreTitle_best();
            updateTextAndFormat(_loc1_.txtScore,getSpecificText("raid_bestScore"));
         }
         else
         {
            _loc1_ = new battleResultRaidScoreTitle();
            updateTextAndFormat(_loc1_.txtScore,getSpecificText("raid_score"));
         }
         return _loc1_;
      }
      
      private function addPrize(param1:MovieClip, param2:int, param3:String = "", param4:Boolean = false, param5:uint = 0) : BMLevelUpPrize
      {
         var _loc6_:BMLevelUpPrize = new BattleResultPrize();
         _loc6_.setContent(param1,param2,param3,param4,param5);
         _loc6_.y = this._prizesDisplayed.length * 59;
         this.mcPrizesHolder.addChild(_loc6_);
         this._prizesDisplayed.push(_loc6_);
         return _loc6_;
      }
      
      private function onAnimComplete() : *
      {
         if(this._isAnimComplete)
         {
            return;
         }
         this._isAnimComplete = true;
         if(dataM.myProfile.lastBattleResult != BMDataManager.BATTLE_RESULT_LOSS && this._sparks == null)
         {
            this._sparks = new Array();
            this._showSparks = true;
         }
         if(_reward != null && (_reward.hasItemsOrBoxes || _reward.hasBoxFragments) && this._prizesToShow.length == 0)
         {
            _reward.gold = 0;
            _reward.xp = 0;
            _reward.tokens = 0;
            dataM.giveRewardPopup(_reward);
         }
         this.continueBtn.enableMe();
      }
      
      private function doAdditionalPrizesAnim() : void
      {
         this._isAnimComplete = false;
         this._timLine = new TimelineMax({"onComplete":this.onAnimComplete});
         var _loc1_:int = 0;
         while(_loc1_ < this._prizesDisplayed.length)
         {
            this._timLine.add(this._prizesDisplayed[_loc1_].getHideTimeLine(),0);
            _loc1_++;
         }
         this._prizesDisplayed = new Vector.<BMLevelUpPrize>();
         this._timLine.addLabel("ttt",0.9);
         this.addNextPrizesAnim();
         var _loc2_:Boolean = this._prizesToShow.length == 0;
         if(_loc2_ && this.isInNextMissionMode)
         {
            this.continueBtn.visible = false;
            this.nextMissionBtn.visible = true;
            this.worldMapBtn.visible = true;
            this._timLine.fromTo(this.nextMissionBtn,0.3,{
               "scaleX":0,
               "scaleY":0
            },{
               "scaleX":1,
               "scaleY":1,
               "ease":Back.easeOut
            });
            this._timLine.fromTo(this.worldMapBtn,0.3,{
               "scaleX":0,
               "scaleY":0
            },{
               "scaleX":1,
               "scaleY":1,
               "ease":Back.easeOut
            });
         }
         else
         {
            if(this.nextMissionBtn != null)
            {
               this.nextMissionBtn.visible = false;
            }
            if(this.worldMapBtn != null)
            {
               this.worldMapBtn.visible = false;
            }
            this._timLine.fromTo(this.continueBtn,0.3,{
               "scaleX":0,
               "scaleY":0
            },{
               "scaleX":1,
               "scaleY":1,
               "ease":Back.easeOut
            });
            this.continueBtn.disableMe();
         }
         this._timLine.addLabel("ttt1",0.6);
         this._timLine.addLabel("end");
      }
      
      private function doRaysAnimation() : void
      {
         if(dataM.myProfile.lastBattleResult != BMDataManager.BATTLE_RESULT_LOSS)
         {
            TweenMax.fromTo(this.mcGlowWin,2,{"alpha":0.6},{
               "alpha":1,
               "repeat":-1,
               "yoyo":true
            });
            TweenMax.fromTo(this.mcRays,50,{"rotation":0},{
               "rotation":360,
               "repeat":-1
            });
            TweenMax.fromTo(this.mcRays,2,{"alpha":0.5},{
               "alpha":1,
               "repeat":-1,
               "yoyo":true,
               "overwrite":0
            });
         }
         else
         {
            TweenMax.fromTo(this.mcGlowDefeat,2,{"alpha":0.2},{
               "alpha":0.8,
               "repeat":-1,
               "yoyo":true
            });
         }
      }
      
      private function isInviteToClan() : Boolean
      {
         var _loc3_:Boolean = false;
         var _loc4_:BMPlayerProfile = null;
         var _loc5_:uint = 0;
         var _loc6_:BMClanMemberData = null;
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc2_:Boolean = false;
         if(_loc1_.clanID > 0)
         {
            if(dataM.gameType == BMDataManager.GAME_TYPE_PVP)
            {
               if(_loc1_.clanLeaderID == dataM.userID)
               {
                  if(_loc1_.clanMembers < dataM.clanMaxMembers)
                  {
                     _loc3_ = false;
                     _loc4_ = dataM["player" + dataM.player2PlayerID + "Profile"];
                     if(_loc4_.clanID == 0)
                     {
                        _loc5_ = 0;
                        while(_loc5_ < _loc1_.clanMembers)
                        {
                           _loc6_ = _loc1_.clanData.members[_loc5_];
                           if(_loc6_.playerID == _loc4_.userID)
                           {
                              _loc3_ = true;
                              _loc5_ = uint(_loc1_.clanMembers);
                           }
                           _loc5_++;
                        }
                        if(_loc3_ == false)
                        {
                           _loc2_ = true;
                        }
                     }
                  }
               }
            }
         }
         return _loc2_;
      }
      
      override public function onEnterFrameTrigger() : void
      {
         super.onEnterFrameTrigger();
         if(screensM.isScreenOpened(BMScreensManager.SCR_BATTLE_RESULT) && screensM.screenBlack.isActive() == false)
         {
            this.sparksHandler();
         }
      }
      
      private function sparksHandler() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:Array = null;
         var _loc3_:uint = 0;
         var _loc4_:Number = NaN;
         var _loc5_:MovieClip = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:MovieClip = null;
         if(this._showSparks)
         {
            _loc1_ = Math.ceil(Math.random() * 2);
            if(this._sparksSpeedAddon > 1)
            {
               _loc1_ = 1;
            }
            if(_loc1_ == 1)
            {
               _loc5_ = externalAssetsM.getAsset("general","Grp_energySpark_orange");
               _loc1_ = Math.ceil(Math.random() * 2);
               _loc6_ = Math.random() * 80;
               _loc7_ = 160 + _loc6_;
               if(_loc1_ == 1)
               {
                  _loc7_ *= -1;
               }
               _loc8_ = 1 + Math.random() * 0.5;
               _loc5_.scaleX = _loc8_;
               _loc5_.scaleY = _loc8_;
               _loc5_.x = _loc7_;
               _loc5_.ySpeed = this._sparksSpeedAddon + Math.random() * 1.5 + 0.75;
               this.mcSparksHolder.addChild(_loc5_);
               this._sparks.push(_loc5_);
            }
            _loc2_ = new Array();
            _loc3_ = 0;
            while(_loc3_ < this._sparks.length)
            {
               _loc9_ = this._sparks[_loc3_];
               _loc9_.y += _loc9_.ySpeed;
               if(_loc9_.y > 140)
               {
                  _loc2_.push(_loc3_);
               }
               _loc3_++;
            }
            _loc4_ = _loc2_.length - 1;
            while(_loc4_ >= 0)
            {
               _loc3_ = uint(_loc2_[_loc4_]);
               this._sparks[_loc3_].parent.removeChild(this._sparks[_loc3_]);
               this._sparks[_loc3_] = null;
               this._sparks.splice(_loc3_,1);
               _loc4_--;
            }
            if(this._sparksSpeedAddon > 0)
            {
               this._sparksSpeedAddon -= 0.05;
            }
         }
      }
      
      override public function addSpark(param1:Sprite) : void
      {
         this.mcSparksHolder.addChild(param1);
      }
      
      private function removeAllSparks() : void
      {
         var _loc1_:uint = 0;
         if(this._sparks != null)
         {
            _loc1_ = 0;
            while(_loc1_ < this._sparks.length)
            {
               this._sparks[_loc1_].parent.removeChild(this._sparks[_loc1_]);
               this._sparks[_loc1_] = null;
               _loc1_++;
            }
         }
         this._sparks = new Array();
      }
      
      private function onContinueClick(param1:Event) : void
      {
         if(this._prizesToShow.length > 0)
         {
            this.doAdditionalPrizesAnim();
         }
         else
         {
            this.doContinue();
         }
      }
      
      private function onNextMissionClick(param1:Event) : void
      {
         screensM.screenMissionBaseMap.notifyUserSelectedNextMission();
         this.doContinue();
      }
      
      private function onSkipAnimClick(param1:MouseEvent) : void
      {
         this._timLine.seek("end");
         this.onAnimComplete();
      }
      
      private function onChatClick(param1:Event) : void
      {
         dataM.battle_goToChatAfterBattle = true;
         this.doContinue();
      }
      
      private function onClanClick(param1:Event) : void
      {
         dataM.battle_inviteToClanAfterBattle = true;
         this.doContinue();
      }
      
      private function onChatOver(param1:MouseEvent) : void
      {
         var _loc2_:BMPlayerProfile = dataM["player" + dataM.player2PlayerID + "Profile"];
         tooltip.showToolTip("regularText","Chat with " + _loc2_.playerName,-1,-1);
      }
      
      private function onClanOver(param1:MouseEvent) : void
      {
         var _loc2_:BMPlayerProfile = dataM["player" + dataM.player2PlayerID + "Profile"];
         tooltip.showToolTip("regularText","Invite " + _loc2_.playerName + " to your clan",-1,-1);
      }
      
      private function onTipToolOutOver(param1:MouseEvent) : void
      {
         tooltip.hideToolTip();
      }
      
      private function doContinue() : void
      {
         var _loc1_:BMWorldMapLocationData = null;
         var _loc2_:Boolean = false;
         if(tutorialM.isTutorialActive())
         {
            if(dataM.battleType == BMSinglePlayerManager.BATTLE_TYPE_REGULAR)
            {
               screensM.screenBattle.closeScreen();
            }
            else
            {
               screensM.screenMissionBaseMap.exitScreen();
            }
            this.removeMe();
            this.mcTutorialArrow_button.gotoAndStop("animOff");
            this.mcTutorialMarker_button.gotoAndStop("animOff");
            return;
         }
         if(dataM.myProfile.hasPandingLevelUp && !BMGameShortcutsHelper.levelUpShortcut())
         {
            BMLevelUpManager.gi().displayLevelUpPopUp();
            return;
         }
         if(dataM.raidData.isRaidInProgress() == false)
         {
            _loc1_ = dataM.singlePlayerM.currentMissionDB;
            _loc2_ = this.isInNextMissionMode == false && _loc1_.subType == BMWorldMapLocationData.SUB_TYPE_MISSION_BOSS && dataM.myProfile.currentMissionMode < 2 && dataM.singlePlayerM.finishMissionForFirstTime;
            if(_loc2_)
            {
               this.removeMe();
               screensM.addScreen(BMScreensManager.SCR_DIFFICULTY_UNLOCKED);
               return;
            }
         }
         this.removeMe();
         if(screensM.isScreenOpened(BMScreensManager.SCR_MISSION_BASE_MAP))
         {
            screensM.screenMissionBaseMap.exitScreen();
         }
      }
      
      override public function removeMe() : void
      {
         this.removeAllSparks();
         super.removeMe();
      }
      
      override public function backClicked() : *
      {
         this.doContinue();
         super.backClicked();
      }
      
      private function get goldSalePercentEffect() : uint
      {
         if(dataM.raidData.isRaidInProgress())
         {
            return 0;
         }
         return getRewardSaleEffect(BMSale.STORE_SECTION_CAMPAIGN_GOLD);
      }
      
      private function get xpSalePercentEffect() : uint
      {
         if(dataM.raidData.isRaidInProgress())
         {
            return 0;
         }
         return getRewardSaleEffect(BMSale.STORE_SECTION_CAMPAIGN_XP);
      }
   }
}

