package net.battleMechsMulti.screens.topBar
{
   import com.greensock.TweenMax;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMLevelUpManager;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.mining.BMMiningManager;
   import net.battleMechsMulti.managers.shop.BMShopManager;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.buttons.BMButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.screens.BMBaseScreen;
   import net.battleMechsMulti.utils.BMPubSub;
   import net.battleMechsMulti.utils.FeatureFlags;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol458")]
   public class BMScreenTopBar extends BMBaseScreen
   {
      
      public var mcSizer_btnDebugger:Sprite;
      
      public var txtGold:TextField;
      
      public var txtTokens:TextField;
      
      public var txtKin:TextField;
      
      public var mcGold:Sprite;
      
      public var mcTokens:Sprite;
      
      public var mcKin:Sprite;
      
      public var mcTokensShadow:Sprite;
      
      public var mcTokensFrame:Sprite;
      
      public var mcMainHolder:MovieClip;
      
      public var mcButtonsHolder:MovieClip;
      
      public var mcEffectsHolder:MovieClip;
      
      public var btnGetGold:BMButton;
      
      public var btnGetTokens:BMButton;
      
      public var btnKin:BMButton;
      
      public var mcLevelAndXp:MovieClip;
      
      public var sparksBMD:BitmapData;
      
      public var sparksBM:Bitmap;
      
      public var mcBackgroundCover:Sprite;
      
      public var mcOptionsButton:MovieClip;
      
      public var mcTooltip_gold:MovieClip;
      
      public var mcTooltip_tokens:MovieClip;
      
      public var mcLadderRankDisplay:BMLadderRankDisplay;
      
      public var mcEnableBaseBuildingIndicator:Sprite;
      
      private var _oldXP:Number;
      
      private var _currentLevelXPBase:Number;
      
      private var _currentLevelXPMax:Number;
      
      private var _maxLevelReached:Boolean;
      
      private var _maxXPReached:Boolean;
      
      private var _newXP:Number;
      
      private var _currentXP:Number;
      
      private var _xpChangePerFrame:uint;
      
      private var _refreshXPBar:Boolean = false;
      
      private var _displayLevelUpBonus:Boolean = false;
      
      private var _xpSoundCooldown:Number;
      
      public var displayGold:Number = -1;
      
      public var displayTokens:Number = -1;
      
      private var _firstRefresh:Boolean = true;
      
      public const GOLD_FLYING_NUMBER_X_POS:Number = 101;
      
      public const TOKENS_FLYING_NUMBER_X_POS:Number = 237;
      
      public const FLYING_NUMBER_Y_POS:Number = 15;
      
      public const SPARKS_BMD_WIDTH:Number = 800;
      
      public const SPARKS_BMD_HEIGHT:Number = 600;
      
      public const SPARKS_BM_Y_POS:Number = 0;
      
      public const SPARKS_BM_Y_ADDON:Number = 0;
      
      public function BMScreenTopBar()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         sub(BMPubSub.MESSAGE_KIN_READY_FOR_DISPLAY,this.onKinReadyForDisplay);
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(parent == null)
         {
            return;
         }
         if(screensM.screenBlack.isActive() == false && screensM.isScreenOpened(BMScreensManager.SCR_ITEM_CARDS) == false && screensM.isScreenOpened(BMScreensManager.SCR_POPUP) == false)
         {
            this.refreshXPBarHandler();
            this.refreshGoldHandler();
            this.refreshTokensHandler();
            this.refreshKinHandler();
            if(this.mcLadderRankDisplay != null)
            {
               this.mcLadderRankDisplay.onEnterFrameTrigger();
            }
         }
      }
      
      public function refreshScreen(param1:Boolean = false, param2:Boolean = false) : void
      {
         var _loc4_:Function = null;
         var _loc5_:Function = null;
         var _loc6_:Function = null;
         var _loc7_:String = null;
         if(this._firstRefresh)
         {
            setLanguageManagerScreenName("topBar");
            if(this.xpInScreen)
            {
               this.mcLevelAndXp.XPBar.initialize("blue","right");
               this.mcLevelAndXp.XPBar.addSeparateorLines(5);
               this.mcLevelAndXp.XPBar.setFill(0,false);
               this.mcLevelAndXp.XPBar.mcBackground.visible = false;
               this.mcLevelAndXp.txtXP.text = "";
            }
            this.mcEffectsHolder = new MovieClip();
            this.mcMainHolder.addChild(this.mcEffectsHolder);
            if(this.goldInScreen)
            {
               this.mcTooltip_gold.type = "gold";
               if(dataM.runAsMobile == false)
               {
                  this.mcTooltip_gold.addEventListener(MouseEvent.MOUSE_OVER,this.tooltipMouseOver);
                  this.mcTooltip_gold.addEventListener(MouseEvent.MOUSE_OUT,this.tooltipMouseOut);
               }
            }
            if(this.tokensInScreen)
            {
               this.mcTooltip_tokens.type = "tokens";
               if(dataM.runAsMobile == false)
               {
                  this.mcTooltip_tokens.addEventListener(MouseEvent.MOUSE_OVER,this.tooltipMouseOver);
                  this.mcTooltip_tokens.addEventListener(MouseEvent.MOUSE_OUT,this.tooltipMouseOut);
               }
            }
            if(this.xpInScreen)
            {
               this.mcLevelAndXp.mcTooltip_XP.type = "XP";
               this.mcLevelAndXp.mcTooltip_level.type = "level";
               if(dataM.runAsMobile == false)
               {
                  this.mcLevelAndXp.mcTooltip_XP.addEventListener(MouseEvent.MOUSE_OVER,this.tooltipMouseOver);
                  this.mcLevelAndXp.mcTooltip_XP.addEventListener(MouseEvent.MOUSE_OUT,this.tooltipMouseOut);
                  this.mcLevelAndXp.mcTooltip_level.addEventListener(MouseEvent.MOUSE_OVER,this.tooltipMouseOver);
                  this.mcLevelAndXp.mcTooltip_level.addEventListener(MouseEvent.MOUSE_OUT,this.tooltipMouseOut);
               }
            }
            if(this.mcOptionsButton != null)
            {
               this.mcOptionsButton.addEventListener(BMIntractable.HIT,this.onOptionsButtonHit);
               this.mcOptionsButton.visible = !tutorialM.isTutorialActive();
            }
            _loc4_ = this.getGoldClicked;
            _loc5_ = this.getTokensClicked;
            _loc6_ = this.kinClicked;
            if(dataM.runAsMobile)
            {
               _loc4_ = null;
               _loc5_ = null;
               _loc6_ = null;
            }
            if(this.goldInScreen)
            {
               this.btnGetGold.initialize("","",null,[],_loc4_,dataM.runAsMobile);
               this.btnGetGold.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
               if(dataM.runAsMobile == false)
               {
                  this.btnGetGold.buttonCore.addMouseOverListerner(this.getGoldMouseOver);
                  this.btnGetGold.buttonCore.addMouseOutListerner(this.buttonMouseOut);
               }
            }
            if(this.tokensInScreen)
            {
               this.btnGetTokens.initialize("","",null,[],_loc5_,dataM.runAsMobile);
               this.btnGetTokens.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
               if(dataM.runAsMobile == false)
               {
                  this.btnGetTokens.buttonCore.addMouseOverListerner(this.getTokensMouseOver);
                  this.btnGetTokens.buttonCore.addMouseOutListerner(this.buttonMouseOut);
               }
            }
            if(this.kinInScreen)
            {
               this.btnKin.initialize("","",null,[],_loc6_,dataM.runAsMobile);
               this.btnKin.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
               if(dataM.runAsMobile == false)
               {
               }
            }
            this.hideGetGoldTokensButtons();
            this.languageUpdate();
            this._firstRefresh = false;
         }
         else if(lastLanguageID != dataM.languageID)
         {
            this.languageUpdate();
         }
         var _loc3_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(this.goldInScreen)
         {
            if(this.displayGold == -1 || param2)
            {
               this.displayGold = _loc3_.gold;
               this.txtGold.text = TextUtils.getNumberWithComma(this.displayGold);
               if(dataM.runAsMobile)
               {
                  screensM.createTextBitmap("screenTopBar_txtGold",this.txtGold,"",this);
               }
            }
         }
         if(this.tokensInScreen)
         {
            if(this.displayTokens == -1 || param2)
            {
               this.displayTokens = _loc3_.tokens;
               if(this.displayTokens < 0)
               {
                  this.txtTokens.text = "0";
               }
               else
               {
                  this.txtTokens.text = TextUtils.getNumberWithComma(this.displayTokens);
               }
            }
         }
         if(this.kinInScreen)
         {
            _loc7_ = "0";
            if(dataM.kinM != null)
            {
               this.txtKin.text = TextUtils.getNumberWithComma(dataM.kinM.kin);
            }
            if(dataM.runAsMobile)
            {
               screensM.createTextBitmap("screenTopBar_txtKin",this.txtKin,"",this);
            }
         }
         this.refreshProfile(param1);
         if(tutorialM.isTutorialActive())
         {
            this.hideGetGoldTokensButtons();
         }
         else
         {
            this.showGetGoldTokensButtons();
         }
         if(this.tokensInScreen)
         {
            if(this.hideTokens())
            {
               if(this.mcBackgroundCover != null)
               {
                  this.mcBackgroundCover.visible = true;
               }
               this.btnGetTokens.visible = false;
               this.txtTokens.visible = false;
               this.mcTokens.visible = false;
               if(this.mcTokensShadow != null)
               {
                  this.mcTokensShadow.visible = false;
               }
               else
               {
                  this.mcTokensFrame.visible = false;
               }
            }
            else
            {
               if(this.mcBackgroundCover != null)
               {
                  this.mcBackgroundCover.visible = false;
               }
               this.btnGetTokens.visible = true;
               this.txtTokens.visible = true;
               this.mcTokens.visible = true;
               if(this.mcTokensShadow != null)
               {
                  this.mcTokensShadow.visible = true;
               }
               else
               {
                  this.mcTokensFrame.visible = true;
               }
            }
            if(dataM.runAsMobile)
            {
               screensM.createTextBitmap("screenTopBar_txtTokens",this.txtTokens,"",this);
            }
         }
         if(this.kinInScreen)
         {
            if(this.hideKin())
            {
               this.btnKin.visible = false;
               this.txtKin.visible = false;
               this.mcKin.visible = false;
            }
            else
            {
               this.showKin();
            }
            if(dataM.runAsMobile)
            {
               screensM.createTextBitmap("screenTopBar_txtKin",this.txtKin,"",this);
            }
         }
         this.refreshEnableBaseBuildingIndicator();
      }
      
      private function refreshEnableBaseBuildingIndicator() : void
      {
         if(this.mcEnableBaseBuildingIndicator == null)
         {
            return;
         }
         this.mcEnableBaseBuildingIndicator.mouseEnabled = false;
         this.mcEnableBaseBuildingIndicator.mouseChildren = false;
         this.mcEnableBaseBuildingIndicator.visible = false;
         if(dataM.baseBuildingManager.isEnabled == false && dataM.baseBuildingManager.isOptInAllowed)
         {
            this.mcEnableBaseBuildingIndicator.visible = true;
         }
      }
      
      private function languageUpdate() : void
      {
         if(lastLanguageID == dataM.languageID)
         {
            return;
         }
         lastLanguageID = dataM.languageID;
         if(this.goldInScreen)
         {
            TextUtils.updateTextFormat(this.txtGold,18);
         }
         var _loc1_:uint = 22;
         switch(dataM.languageID)
         {
            case 3:
               _loc1_ = 25;
         }
         if(this.xpInScreen)
         {
            TextUtils.updateTextFormat(this.mcLevelAndXp.txtLevel,_loc1_);
            TextUtils.updateTextFormat(this.mcLevelAndXp.txtXP,14);
         }
         if(this.tokensInScreen)
         {
            TextUtils.updateTextFormat(this.txtTokens,18);
         }
         if(this.kinInScreen)
         {
            TextUtils.updateTextFormat(this.txtKin,18);
         }
      }
      
      private function get goldInScreen() : Boolean
      {
         return this.txtGold != null;
      }
      
      private function refreshGoldHandler() : void
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_TOP_BAR) == false)
         {
            return;
         }
         if(this.goldInScreen == false)
         {
            return;
         }
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc2_:Number = _loc1_.gold - this.displayGold;
         if(_loc2_ == 0)
         {
            return;
         }
         var _loc3_:Number = 0.1;
         if(dataM.runAsMobile)
         {
            _loc3_ = 0.3;
         }
         if(_loc2_ >= 1)
         {
            this.displayGold += Math.ceil(_loc2_ * _loc3_);
         }
         else if(_loc2_ <= -1)
         {
            this.displayGold -= Math.ceil(Math.abs(_loc2_) * _loc3_);
         }
         this.txtGold.text = TextUtils.getNumberWithComma(this.displayGold);
         if(dataM.runAsMobile)
         {
            screensM.createTextBitmap("screenTopBar_txtGold",this.txtGold,"",this);
         }
      }
      
      private function get tokensInScreen() : Boolean
      {
         return this.txtTokens != null;
      }
      
      private function refreshTokensHandler() : void
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_TOP_BAR) == false)
         {
            return;
         }
         if(this.tokensInScreen == false)
         {
            return;
         }
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc2_:Number = _loc1_.tokens - this.displayTokens;
         if(_loc2_ == 0)
         {
            return;
         }
         var _loc3_:Number = 0.1;
         if(dataM.runAsMobile)
         {
            _loc3_ = 0.3;
         }
         if(_loc2_ >= 1)
         {
            this.displayTokens += Math.ceil(_loc2_ * _loc3_);
         }
         else if(_loc2_ <= -1)
         {
            this.displayTokens -= Math.ceil(Math.abs(_loc2_) * _loc3_);
         }
         if(this.displayTokens < 0)
         {
            this.txtTokens.text = "0";
         }
         else
         {
            this.txtTokens.text = TextUtils.getNumberWithComma(this.displayTokens);
         }
         if(dataM.runAsMobile)
         {
            screensM.createTextBitmap("screenTopBar_txtTokens",this.txtTokens,"",this);
         }
      }
      
      private function mineTokensClicked(param1:Event) : void
      {
         BMMiningManager.openMiningPopup();
      }
      
      private function showKin() : void
      {
         this.btnKin.visible = true;
         this.txtKin.visible = true;
         this.mcKin.visible = true;
      }
      
      private function onKinReadyForDisplay(param1:String, param2:Object) : void
      {
         if(dataM.kinM.isEnabled == false)
         {
            return;
         }
         if(this.kinInScreen == false)
         {
            return;
         }
         if(this.mcTokens.visible)
         {
            this.showKin();
         }
         this.refreshKinHandler();
      }
      
      private function get kinInScreen() : Boolean
      {
         return this.txtKin != null;
      }
      
      private function refreshKinHandler() : void
      {
         if(dataM.kinM.isEnabled == false)
         {
            return;
         }
         if(screensM.isScreenOpened(BMScreensManager.SCR_TOP_BAR) == false)
         {
            return;
         }
         if(this.kinInScreen == false)
         {
            return;
         }
         if(this.txtKin.length > 0 && int(this.txtKin.text) == dataM.kinM.kin)
         {
            return;
         }
         this.txtKin.text = TextUtils.getNumberWithComma(dataM.kinM.kin);
         if(dataM.runAsMobile)
         {
            screensM.createTextBitmap("screenTopBar_txtKin",this.txtKin,"",this);
         }
      }
      
      public function kinClicked() : void
      {
         screensM.addScreen(BMScreensManager.SCR_KIN_SHOP);
         screensM.screenKinShop.refreshScreen(screensM.screenKinShop.TAB_INFO);
      }
      
      private function get xpInScreen() : Boolean
      {
         return this.mcLevelAndXp != null;
      }
      
      private function refreshProfile(param1:Boolean) : void
      {
         this._refreshXPBar = false;
         this._maxLevelReached = false;
         this._maxXPReached = false;
         var _loc2_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(param1 && _loc2_.level > _loc2_.lastLevel)
         {
            this._displayLevelUpBonus = true;
            this.disableButtons();
         }
         var _loc3_:Number = _loc2_.onlineWins;
         var _loc4_:Number = _loc2_.onlineBattles;
         this.refreshLadderRank();
         if(this.mcLevelAndXp == null)
         {
            return;
         }
         this._currentLevelXPBase = dataM.levelUpDB[_loc2_.lastLevel];
         if(dataM.levelUpDB[_loc2_.lastLevel + 1] != null)
         {
            this._currentLevelXPMax = dataM.levelUpDB[_loc2_.lastLevel + 1];
         }
         else
         {
            this._currentLevelXPMax = this._currentLevelXPBase;
         }
         if(dataM.levelUpDB[_loc2_.level + 1] == null)
         {
            this._maxLevelReached = true;
         }
         if(_loc2_.maxXPAllowed >= 0 && _loc2_.XP >= _loc2_.maxXPAllowed - 1)
         {
            this._maxXPReached = true;
         }
         if(param1 && _loc2_.lastXPGained > 0)
         {
            this.mcLevelAndXp.txtLevel.text = String(_loc2_.lastLevel);
            this._oldXP = _loc2_.XP - _loc2_.lastXPGained;
            this._newXP = _loc2_.XP;
            if(this._maxXPReached)
            {
               this._oldXP = this._newXP;
            }
            this._xpChangePerFrame = Math.ceil((this._newXP - this._oldXP) / 60);
            this._currentXP = this._oldXP;
            this._xpSoundCooldown = 0;
            this._refreshXPBar = true;
         }
         else
         {
            this._currentXP = _loc2_.XP;
            this.mcLevelAndXp.txtLevel.text = String(_loc2_.level);
            this.refreshXPBar();
         }
         if(dataM.runAsMobile)
         {
            screensM.createTextBitmap("screenTopBar_txtLevel",this.mcLevelAndXp.txtLevel,"",this.mcLevelAndXp);
         }
      }
      
      private function refreshLadderRank() : void
      {
         if(this.mcLadderRankDisplay == null)
         {
            return;
         }
         this.mcLadderRankDisplay.addRank();
      }
      
      private function refreshXPBarHandler() : void
      {
         var _loc1_:BMPlayerProfile = null;
         var _loc2_:int = 0;
         if(this._refreshXPBar)
         {
            _loc1_ = dataM["player" + dataM.player1PlayerID + "Profile"];
            if(this._displayLevelUpBonus && screensM.screensDirector.hasTasks() == false)
            {
               BMLevelUpManager.gi().displayLevelUpPopUp();
               this._displayLevelUpBonus = false;
            }
            if(this._currentXP < this._newXP)
            {
               this._currentXP += this._xpChangePerFrame;
               if(this._currentXP >= this._newXP)
               {
                  this._currentXP = this._newXP;
               }
               this.refreshXPBar();
               _loc2_ = dataM.getLevelForXp(this._currentXP,_loc1_.lastLevel);
               if(_loc2_ != _loc1_.lastLevel)
               {
                  _loc1_.lastLevel = _loc2_;
                  this._currentLevelXPBase = dataM.getXpForLevel(_loc1_.lastLevel);
                  this._currentLevelXPMax = dataM.getXpForLevel(_loc1_.lastLevel + 1);
                  this.refreshLadderRank();
                  this.mcLevelAndXp.txtLevel.text = String(_loc1_.lastLevel);
                  if(dataM.runAsMobile)
                  {
                     screensM.createTextBitmap("screenTopBar_txtLevel",this.mcLevelAndXp.txtLevel,"",this.mcLevelAndXp);
                  }
                  this.refreshXPBar();
               }
               if(this._xpSoundCooldown == 0)
               {
                  soundM.createSound("xpDing",1);
                  this._xpSoundCooldown = 1;
               }
               else
               {
                  --this._xpSoundCooldown;
               }
            }
            else
            {
               this._refreshXPBar = false;
               this.finishAnimation();
            }
         }
      }
      
      private function refreshXPBar() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:String = null;
         if(this._maxXPReached)
         {
            this.mcLevelAndXp.txtXP.text = languageM.getText("arenaShop_max");
            _loc1_ = 0;
         }
         else if(this._currentXP > dataM.levelUpDB[dataM.LEVEL_MAX])
         {
            this.mcLevelAndXp.txtXP.text = TextUtils.getNumberWithComma(this._currentXP);
            _loc1_ = 1;
         }
         else
         {
            _loc1_ = (this._currentXP - this._currentLevelXPBase) / (this._currentLevelXPMax - this._currentLevelXPBase);
            _loc2_ = String(Math.ceil(_loc1_ * 1000) / 10) + "%";
            this.mcLevelAndXp.txtXP.text = _loc2_;
         }
         if(dataM.runAsMobile)
         {
            screensM.createTextBitmap("screenTopBar_txtXP",this.mcLevelAndXp.txtXP,"",this.mcLevelAndXp);
         }
         this.mcLevelAndXp.XPBar.setFill(_loc1_,false);
      }
      
      public function isLevelUpDisplayInProgress() : Boolean
      {
         if(this._refreshXPBar)
         {
            if(this._currentLevelXPMax <= this._newXP)
            {
               return true;
            }
         }
         return false;
      }
      
      public function showLvlAndXp() : *
      {
         TweenMax.to(this.mcLevelAndXp,0.3,{"alpha":1});
      }
      
      public function hideLvlAndXp() : *
      {
         TweenMax.to(this.mcLevelAndXp,0.3,{"alpha":0});
      }
      
      public function getGoldClicked() : void
      {
         if(FeatureFlags.BLOCK_SHOP)
         {
            screensM.screenConfirmation.displayQuestionOrNotification("featureNotAvailable");
            return;
         }
         if(this.canClickOnButton())
         {
            if(screensM.screenBlack.isActive() == false)
            {
               BMShopManager.gi().showGoldPackages();
            }
         }
      }
      
      public function getTokensClicked() : void
      {
         if(FeatureFlags.BLOCK_SHOP)
         {
            screensM.screenConfirmation.displayQuestionOrNotification("featureNotAvailable");
            return;
         }
         if(this.canClickOnButton())
         {
            dataM.openBuyTokensPage("TopBarGetTokens");
         }
      }
      
      public function canClickOnButton() : Boolean
      {
         if(dataM.userAutopilot)
         {
            if(screensM.isScreenOpened(BMScreensManager.SCR_MISSION_BASE_MAP))
            {
               screensM.screenMissionBaseMap.mcAutoplayAndGameSpeedPanel.activateUserAutopilotArrow();
            }
            return false;
         }
         if(screensM.isScreenOpened(BMScreensManager.SCR_ITEM_CARDS))
         {
            return false;
         }
         if(screensM.isScreenOpened(BMScreensManager.SCR_MISSION_WORLD_MAP))
         {
            if(screensM.screenMissionWorldMap.isMapLocked())
            {
               return false;
            }
         }
         if(screensM.isScreenOpened(BMScreensManager.SCR_MISSION_BASE_MAP))
         {
            if(screensM.screenMissionBaseMap.missionCompletedAnimationActive())
            {
               return false;
            }
            if(screensM.isScreenOpened(BMScreensManager.SCR_DISPLAY_REWARD))
            {
               return false;
            }
         }
         if(screensM.isScreenOpened(BMScreensManager.SCR_KIN_SHOP))
         {
            return false;
         }
         return true;
      }
      
      private function russianShowPaymentsError(param1:Object) : void
      {
      }
      
      public function getGoldMouseOver() : void
      {
         tooltip.showToolTip("regularText",getGeneralText("getMoreCredits"),-1,-1);
      }
      
      public function getTokensMouseOver() : void
      {
         if(this.mcTokens.visible)
         {
            tooltip.showToolTip("regularText",getGeneralText("getMoreTokens"),-1,-1);
         }
      }
      
      private function buttonMouseOut() : void
      {
         tooltip.hideToolTip();
      }
      
      public function showGetGoldTokensButtons() : void
      {
         if(this.btnGetGold == null)
         {
            return;
         }
         if(tutorialM.isTutorialActive())
         {
            this.hideGetGoldTokensButtons();
         }
         else
         {
            this.btnGetGold.visible = true;
            if(this.hideTokens() == false)
            {
               this.btnGetTokens.visible = true;
               if(dataM.clientRunningLocally && dataM.myProfile.tokens > 9999)
               {
                  this.btnGetTokens.visible = false;
               }
            }
            if(this.kinInScreen && this.hideKin() == false)
            {
               this.btnKin.visible = true;
            }
         }
      }
      
      private function hideTokens() : Boolean
      {
         if(tutorialM.isTutorialActive())
         {
            return true;
         }
         return false;
      }
      
      private function hideKin() : Boolean
      {
         if(tutorialM.isTutorialActive())
         {
            return true;
         }
         return dataM.kinM.isEnabled == false;
      }
      
      public function hideGetGoldTokensButtons() : void
      {
         if(this.goldInScreen)
         {
            this.btnGetGold.visible = false;
         }
         if(this.tokensInScreen)
         {
            this.btnGetTokens.visible = false;
         }
         if(this.kinInScreen)
         {
            this.btnKin.visible = false;
         }
      }
      
      public function disableButtons() : void
      {
         if(this.goldInScreen)
         {
            this.btnGetGold.disableMe();
         }
         if(this.tokensInScreen)
         {
            this.btnGetTokens.disableMe();
         }
         if(this.kinInScreen)
         {
            this.btnKin.disableMe();
         }
      }
      
      public function enableButtons(param1:String) : void
      {
         if(this.goldInScreen)
         {
            this.btnGetGold.enableMe();
         }
         if(this.tokensInScreen)
         {
            this.btnGetTokens.enableMe();
         }
         if(this.kinInScreen)
         {
            this.btnKin.enableMe();
         }
      }
      
      private function onOptionsButtonHit(param1:Event) : void
      {
         screensM.screenTransitionsManager.extraOptions();
      }
      
      private function tooltipMouseOver(param1:MouseEvent) : void
      {
         this.tooltipMouseOverSub(param1.target.type);
      }
      
      public function tooltipMouseOverSub(param1:String) : void
      {
         var _loc2_:String = "";
         var _loc3_:Boolean = false;
         switch(param1)
         {
            case "gold":
               _loc2_ = getScreenText("creditsReserves");
               break;
            case "tokens":
               break;
            case "XP":
               _loc2_ = getScreenText("experienceBar");
               break;
            case "level":
               _loc2_ = getScreenText("levelTooltip");
         }
         if(_loc3_ == false)
         {
            if(_loc2_ != "")
            {
               tooltip.showToolTip("regularText",_loc2_,-1,-1);
            }
            else
            {
               tooltip.showToolTip("tokens","");
            }
         }
      }
      
      private function tooltipMouseOut(param1:MouseEvent) : void
      {
         this.tooltipMouseOutSub();
      }
      
      public function tooltipMouseOutSub() : void
      {
         tooltip.hideToolTip();
      }
      
      override public function notifyClientDataReloaded() : *
      {
         this.refreshScreen(false);
      }
      
      override public function notifyRemoved() : *
      {
         if(this._refreshXPBar)
         {
            this.finishAnimation();
         }
      }
      
      private function finishAnimation() : *
      {
         dataM.myProfile.lastXPGained = 0;
      }
   }
}

