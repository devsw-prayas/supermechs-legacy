package net.battleMechsMulti.screens
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.mobiles.BMBar;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.buttons.BMButton_plus;
   import net.battleMechsMulti.mobiles.buttons.BMButton_plus2;
   import net.battleMechsMulti.utils.FeatureFlags;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1156")]
   public class BMScreenTopBar extends BMBaseScreen
   {
      
      public var mcSizer_btnDebugger:Sprite;
      
      public var txtGold:TextField;
      
      public var txtTokens:TextField;
      
      public var mcGold:Sprite;
      
      public var mcTokens:Sprite;
      
      public var mcTokensShadow:Sprite;
      
      public var mcMainHolder:MovieClip;
      
      public var mcButtonsHolder:MovieClip;
      
      public var mcRanksHolder:MovieClip;
      
      public var mcEffectsHolder:MovieClip;
      
      public var mcSizer_rank:Sprite;
      
      public var mcSizer_btnGetGold:Sprite;
      
      public var mcSizer_btnGetTokens:Sprite;
      
      public var btnGetGold:BMButton_plus2;
      
      public var btnGetTokens:BMButton_plus;
      
      public var XPBar:BMBar;
      
      public var txtLevel:TextField;
      
      public var txtXP:TextField;
      
      public var sparksBMD:BitmapData;
      
      public var sparksBM:Bitmap;
      
      public var mcBackgroundCover:Sprite;
      
      public var mcStarsStripe:MovieClip;
      
      private var mcLevelRank:MovieClip;
      
      public var mcTooltip_gold:MovieClip;
      
      public var mcTooltip_tokens:MovieClip;
      
      public var mcTooltip_XP:MovieClip;
      
      public var mcTooltip_level:MovieClip;
      
      public var mcTooltip_rank:MovieClip;
      
      private var _oldXP:Number;
      
      private var _currentLevelXPBase:Number;
      
      private var _currentLevelXPMax:Number;
      
      private var _maxLevelReached:Boolean;
      
      private var _newXP:Number;
      
      private var _currentXP:Number;
      
      private var _refreshXPBar:Boolean = false;
      
      private var _displayLevelUpBonus:Boolean = false;
      
      private var _xpSoundCooldown:Number;
      
      public var displayGold:Number = -1;
      
      public var displayTokens:Number = -1;
      
      private var _showRankStars:Boolean = false;
      
      private var _showRankStarsCounter:Number = 0;
      
      private var _starsStripeTargetYPos:Number;
      
      private var _rankStars:Array = new Array();
      
      private var _firstRefresh:Boolean = true;
      
      public const GOLD_FLYING_NUMBER_X_POS:Number = 101;
      
      public const TOKENS_FLYING_NUMBER_X_POS:Number = 237;
      
      public const FLYING_NUMBER_Y_POS:Number = 15;
      
      public const SPARKS_BMD_WIDTH:Number = 800;
      
      public const SPARKS_BMD_HEIGHT:Number = 600;
      
      public const SPARKS_BM_Y_POS:Number = 0;
      
      public const SPARKS_BM_Y_ADDON:Number = 0;
      
      private const STARS_STRIPE_ORIGIN_Y_POS:Number = -20;
      
      public function BMScreenTopBar()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(parent != null)
         {
            if(screensM.screenBlack.isActive() == false && screensM.isScreenOpened("screenItemCards") == false && screensM.isScreenOpened("screenPopUp") == false)
            {
               this.refreshXPBarHandler();
               this.refreshGoldHandler();
               this.refreshTokensHandler();
               this.rankStarsHandler();
            }
         }
      }
      
      public function refreshScreen(param1:Boolean) : void
      {
         var _loc4_:Function = null;
         var _loc5_:Function = null;
         if(this._firstRefresh)
         {
            setLanguageManagerScreenName("topBar");
            this.XPBar.initialize("blue","right");
            this.XPBar.addSeparateorLines(5);
            this.XPBar.setFill(0,false);
            this.XPBar.mcBackground.visible = false;
            this.txtXP.text = "";
            this.mcRanksHolder = new MovieClip();
            this.mcEffectsHolder = new MovieClip();
            this.mcMainHolder.addChild(this.mcRanksHolder);
            this.mcMainHolder.addChild(this.mcEffectsHolder);
            this.mcTooltip_gold.type = "gold";
            this.mcTooltip_tokens.type = "tokens";
            this.mcTooltip_XP.type = "XP";
            this.mcTooltip_level.type = "level";
            this.mcTooltip_rank.type = "rank";
            if(dataM.runAsMobile == false)
            {
               this.mcTooltip_gold.addEventListener(MouseEvent.MOUSE_OVER,this.tooltipMouseOver);
               this.mcTooltip_gold.addEventListener(MouseEvent.MOUSE_OUT,this.tooltipMouseOut);
               this.mcTooltip_tokens.addEventListener(MouseEvent.MOUSE_OVER,this.tooltipMouseOver);
               this.mcTooltip_tokens.addEventListener(MouseEvent.MOUSE_OUT,this.tooltipMouseOut);
               this.mcTooltip_XP.addEventListener(MouseEvent.MOUSE_OVER,this.tooltipMouseOver);
               this.mcTooltip_XP.addEventListener(MouseEvent.MOUSE_OUT,this.tooltipMouseOut);
               this.mcTooltip_level.addEventListener(MouseEvent.MOUSE_OVER,this.tooltipMouseOver);
               this.mcTooltip_level.addEventListener(MouseEvent.MOUSE_OUT,this.tooltipMouseOut);
               this.mcTooltip_rank.addEventListener(MouseEvent.MOUSE_OVER,this.tooltipMouseOver);
               this.mcTooltip_rank.addEventListener(MouseEvent.MOUSE_OUT,this.tooltipMouseOut);
            }
            screensM.createButtonFromSizer("screenTopBar","btnGetGold","plus2");
            screensM.createButtonFromSizer("screenTopBar","btnGetTokens","plus");
            _loc4_ = this.getGoldClicked;
            _loc5_ = this.getTokensClicked;
            if(dataM.runAsMobile)
            {
               _loc4_ = null;
               _loc5_ = null;
            }
            this.btnGetGold.initialize("","",null,[],_loc4_,dataM.runAsMobile);
            this.btnGetTokens.initialize("","",null,[],_loc5_,dataM.runAsMobile);
            this.btnGetGold.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnGetTokens.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            if(dataM.runAsMobile == false)
            {
               this.btnGetGold.buttonCore.addMouseOverListerner(this.getGoldMouseOver);
               this.btnGetGold.buttonCore.addMouseOutListerner(this.buttonMouseOut);
               this.btnGetTokens.buttonCore.addMouseOverListerner(this.getTokensMouseOver);
               this.btnGetTokens.buttonCore.addMouseOutListerner(this.buttonMouseOut);
            }
            this.hideGetGoldTokensButtons();
            this.mcStarsStripe.y = this.STARS_STRIPE_ORIGIN_Y_POS;
            this.languageUpdate();
            this._firstRefresh = false;
         }
         else if(lastLanguageID != dataM.languageID)
         {
            this.languageUpdate();
         }
         var _loc2_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(this.displayGold == -1)
         {
            this.displayGold = _loc2_.gold;
            this.txtGold.text = dataM.getNumberWithComma(this.displayGold);
            if(dataM.runAsMobile)
            {
               screensM.createTextBitmap("screenTopBar_txtGold",this.txtGold,"",this);
            }
         }
         if(this.displayTokens == -1)
         {
            this.displayTokens = _loc2_.tokens;
            if(this.displayTokens < 0)
            {
               this.txtTokens.text = "0";
            }
            else
            {
               this.txtTokens.text = dataM.getNumberWithComma(this.displayTokens);
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
         var _loc3_:Boolean = false;
         if(_loc2_.level < 3)
         {
            _loc3_ = true;
         }
         if(_loc3_)
         {
            this.mcBackgroundCover.visible = true;
            this.txtTokens.visible = false;
            this.mcTokens.visible = false;
            this.mcTokensShadow.visible = false;
         }
         else
         {
            this.mcBackgroundCover.visible = false;
            this.txtTokens.visible = true;
            this.mcTokens.visible = true;
            this.mcTokensShadow.visible = true;
         }
         if(dataM.runAsMobile)
         {
            screensM.createTextBitmap("screenTopBar_txtTokens",this.txtTokens,"",this);
         }
      }
      
      private function languageUpdate() : void
      {
         var _loc1_:uint = 0;
         if(lastLanguageID != dataM.languageID)
         {
            lastLanguageID = dataM.languageID;
            TextUtils.updateTextFormat(this.txtGold,18);
            _loc1_ = 22;
            switch(dataM.languageID)
            {
               case 3:
                  _loc1_ = 25;
            }
            TextUtils.updateTextFormat(this.txtLevel,_loc1_);
            TextUtils.updateTextFormat(this.txtTokens,18);
            TextUtils.updateTextFormat(this.txtXP,18);
         }
      }
      
      private function refreshGoldHandler() : void
      {
         var _loc1_:BMPlayerProfile = null;
         var _loc2_:Number = NaN;
         var _loc3_:Boolean = false;
         var _loc4_:Number = NaN;
         if(screensM.isScreenOpened("screenTopBar"))
         {
            _loc1_ = dataM["player" + dataM.player1PlayerID + "Profile"];
            _loc2_ = _loc1_.gold - this.displayGold;
            if(_loc2_ != 0)
            {
               _loc3_ = true;
               if(_loc3_)
               {
                  _loc4_ = 0.1;
                  if(dataM.runAsMobile)
                  {
                     _loc4_ = 0.3;
                  }
                  if(_loc2_ >= 1)
                  {
                     this.displayGold += Math.ceil(_loc2_ * _loc4_);
                  }
                  else if(_loc2_ <= -1)
                  {
                     this.displayGold -= Math.ceil(Math.abs(_loc2_) * _loc4_);
                  }
                  this.txtGold.text = dataM.getNumberWithComma(this.displayGold);
                  if(dataM.runAsMobile)
                  {
                     screensM.createTextBitmap("screenTopBar_txtGold",this.txtGold,"",this);
                  }
               }
            }
         }
      }
      
      private function refreshTokensHandler() : void
      {
         var _loc1_:BMPlayerProfile = null;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(screensM.isScreenOpened("screenTopBar"))
         {
            _loc1_ = dataM["player" + dataM.player1PlayerID + "Profile"];
            _loc2_ = _loc1_.tokens - this.displayTokens;
            if(_loc2_ != 0)
            {
               _loc3_ = 0.1;
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
                  this.txtTokens.text = dataM.getNumberWithComma(this.displayTokens);
               }
               if(dataM.runAsMobile)
               {
                  screensM.createTextBitmap("screenTopBar_txtTokens",this.txtTokens,"",this);
               }
            }
         }
      }
      
      private function refreshProfile(param1:Boolean) : void
      {
         this._refreshXPBar = false;
         this._maxLevelReached = false;
         var _loc2_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(param1 && _loc2_.level > _loc2_.lastLevel)
         {
            this._displayLevelUpBonus = true;
            this.disableButtons();
         }
         var _loc3_:Number = _loc2_.overallRank;
         var _loc4_:Number = _loc2_.onlineWins;
         var _loc5_:Number = _loc2_.onlineBattles;
         this.refreshLevelRank();
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
         if(param1 && _loc2_.lastXPGained > 0)
         {
            this.txtLevel.text = String(_loc2_.lastLevel);
            this._oldXP = _loc2_.XP - _loc2_.lastXPGained;
            this._newXP = _loc2_.XP;
            this._currentXP = this._oldXP;
            this._xpSoundCooldown = 0;
            this._refreshXPBar = true;
         }
         else
         {
            this._currentXP = _loc2_.XP;
            this.txtLevel.text = String(_loc2_.level);
            this.refreshXPBar();
         }
         if(dataM.runAsMobile)
         {
            screensM.createTextBitmap("screenTopBar_txtLevel",this.txtLevel,"",this);
         }
      }
      
      private function refreshLevelRank() : void
      {
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(this.mcLevelRank != null)
         {
            this.mcLevelRank.parent.removeChild(this.mcLevelRank);
         }
         var _loc2_:Number = dataM.getLadderRankIconNumber(dataM.getLadderRankByProgress(_loc1_.ladderProgress));
         this.mcLevelRank = externalAssetsM.getAsset("general","Grp_rank" + _loc2_,0,0,false,false);
         this.mcLevelRank.filters = [new GlowFilter(0,1,2,2,3),new DropShadowFilter(3,45,0,1,0,0,0.8)];
         this.mcLevelRank.width = this.mcSizer_rank.width;
         this.mcLevelRank.height = this.mcSizer_rank.height;
         this.mcLevelRank.x = this.mcSizer_rank.x;
         this.mcLevelRank.y = this.mcSizer_rank.y;
         this.mcRanksHolder.addChild(this.mcLevelRank);
      }
      
      public function displayLevelUpPopUp() : void
      {
         if(FeatureFlags.PLAYER_ENERGY)
         {
            dataM.battleCreditsManager.setBattleCreditsToMax();
         }
         if(screensM.isScreenOpened("screenLevelUpEntry") == false)
         {
            soundM.createSound("levelUp",1);
            screensM.addScreen("screenLevelUpEntry");
            screensM.screenLevelUpEntry.refreshScreen(true);
         }
      }
      
      private function refreshXPBarHandler() : void
      {
         var _loc1_:BMPlayerProfile = null;
         var _loc2_:Boolean = false;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         if(this._refreshXPBar)
         {
            _loc1_ = dataM["player" + dataM.player1PlayerID + "Profile"];
            if(this._displayLevelUpBonus)
            {
               this.displayLevelUpPopUp();
               this._displayLevelUpBonus = false;
            }
            _loc2_ = true;
            if(dataM.runAsMobile)
            {
            }
            if(_loc2_)
            {
               if(this._currentXP < this._newXP)
               {
                  _loc3_ = this._currentXP;
                  _loc4_ = 2;
                  if(dataM.runAsMobile)
                  {
                     if(_loc1_.level >= 5)
                     {
                        _loc4_ = 8;
                     }
                     else
                     {
                        _loc4_ = 4;
                     }
                  }
                  this._currentXP += _loc4_;
                  if(this._currentXP >= this._newXP)
                  {
                     this._currentXP = this._newXP;
                  }
                  this.refreshXPBar();
                  if(this._currentXP >= this._currentLevelXPMax && _loc3_ < this._currentLevelXPMax)
                  {
                     ++_loc1_.lastLevel;
                     this.refreshLevelRank();
                     this._currentLevelXPBase = dataM.levelUpDB[_loc1_.lastLevel];
                     if(dataM.levelUpDB[_loc1_.lastLevel + 1] != null)
                     {
                        this._currentLevelXPMax = dataM.levelUpDB[_loc1_.lastLevel + 1];
                     }
                     else
                     {
                        this._currentLevelXPMax = this._currentLevelXPBase;
                     }
                     this.txtLevel.text = String(_loc1_.lastLevel);
                     if(dataM.runAsMobile)
                     {
                        screensM.createTextBitmap("screenTopBar_txtLevel",this.txtLevel,"",this);
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
                  _loc1_ = dataM["player" + dataM.player1PlayerID + "Profile"];
                  _loc1_.lastXPGained = 0;
               }
            }
         }
      }
      
      private function refreshXPBar() : void
      {
         var _loc1_:Number = NaN;
         if(this._currentXP > dataM.levelUpDB[dataM.LEVEL_MAX])
         {
            this.txtXP.text = dataM.getNumberWithComma(this._currentXP);
            _loc1_ = 1;
         }
         else
         {
            this.txtXP.text = dataM.getNumberWithComma(this._currentXP) + " / " + dataM.getNumberWithComma(this._currentLevelXPMax);
            _loc1_ = (this._currentXP - this._currentLevelXPBase) / (this._currentLevelXPMax - this._currentLevelXPBase);
         }
         if(dataM.runAsMobile)
         {
            screensM.createTextBitmap("screenTopBar_txtXP",this.txtXP,"",this);
         }
         this.XPBar.setFill(_loc1_,false);
      }
      
      public function getGoldClicked() : void
      {
         if(this.canClickOnButton())
         {
            if(screensM.screenBlack.isActive() == false)
            {
               screensM.addScreen("screenBuyGold");
               screensM.screenBuyGold.refreshScreen();
            }
         }
      }
      
      public function getTokensClicked() : void
      {
         if(this.canClickOnButton())
         {
            dataM.openBuyTokensPage("TopBarGetTokens");
         }
      }
      
      public function canClickOnButton() : Boolean
      {
         var _loc1_:Boolean = true;
         if(screensM.isScreenOpened("screenItemCards"))
         {
            _loc1_ = false;
         }
         else if(screensM.isScreenOpened("screenLevelUpEntry") || screensM.isScreenOpened("screenLevelUp"))
         {
            _loc1_ = false;
         }
         else if(screensM.isScreenOpened("screenMissionWorldMap"))
         {
            if(screensM.screenMissionWorldMap.isMapLocked())
            {
               _loc1_ = false;
            }
            if(screensM.isScreenOpened("screenBuyMissions"))
            {
               _loc1_ = false;
            }
         }
         else if(screensM.isScreenOpened("screenMissionBaseMap"))
         {
            if(screensM.screenMissionBaseMap.missionCompletedAnimationActive())
            {
               _loc1_ = false;
            }
            if(screensM.isScreenOpened("screenMissionCompleted"))
            {
               _loc1_ = false;
            }
         }
         return _loc1_;
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
         if(tutorialM.isTutorialActive())
         {
            this.hideGetGoldTokensButtons();
         }
         else
         {
            this.btnGetGold.visible = true;
            this.btnGetTokens.visible = true;
         }
      }
      
      public function hideGetGoldTokensButtons() : void
      {
         this.btnGetGold.visible = false;
         this.btnGetTokens.visible = false;
      }
      
      public function disableButtons() : void
      {
         this.btnGetGold.disableMe();
         this.btnGetTokens.disableMe();
      }
      
      public function enableButtons(param1:String) : void
      {
         this.btnGetGold.enableMe();
         this.btnGetTokens.enableMe();
      }
      
      public function showRankStars(param1:Boolean = false) : void
      {
         if(dataM.gameType != BMDataManager.GAME_TYPE_TUTORIAL)
         {
            this.createRankStars();
            if(param1)
            {
               this._showRankStarsCounter = 70;
               this.mcStarsStripe.y = this._starsStripeTargetYPos;
            }
            else
            {
               this._showRankStars = true;
               if(this._showRankStarsCounter > 0)
               {
                  this._showRankStarsCounter = 0;
               }
               else
               {
                  this.mcStarsStripe.y = this.STARS_STRIPE_ORIGIN_Y_POS;
               }
            }
         }
      }
      
      private function rankStarsHandler() : void
      {
         var _loc1_:Number = NaN;
         if(this._showRankStars || this._showRankStarsCounter > 0)
         {
            if(this.mcStarsStripe.y < this._starsStripeTargetYPos - 1)
            {
               _loc1_ = this._starsStripeTargetYPos - this.mcStarsStripe.y;
               this.mcStarsStripe.y += _loc1_ * 0.3;
               if(this.mcStarsStripe.y > this._starsStripeTargetYPos - 1)
               {
                  this.mcStarsStripe.y = this._starsStripeTargetYPos;
               }
            }
            if(this._showRankStarsCounter > 0)
            {
               --this._showRankStarsCounter;
            }
         }
         else if(this.mcStarsStripe.y > this.STARS_STRIPE_ORIGIN_Y_POS + 1)
         {
            this.mcStarsStripe.y -= (this.mcStarsStripe.y + Math.abs(this.STARS_STRIPE_ORIGIN_Y_POS)) * 0.3;
            if(this.mcStarsStripe.y < this.STARS_STRIPE_ORIGIN_Y_POS + 1)
            {
               this.mcStarsStripe.y = this.STARS_STRIPE_ORIGIN_Y_POS;
               this.removeRankStars();
            }
         }
      }
      
      private function createRankStars() : void
      {
         var _loc8_:uint = 0;
         var _loc9_:Sprite = null;
         var _loc10_:Sprite = null;
         this.removeRankStars();
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc2_:uint = dataM.getLadderRankByProgress(_loc1_.ladderProgress);
         var _loc3_:uint = dataM.getLadderProgressBaseByRank(_loc2_);
         var _loc4_:uint = dataM.getLadderProgressMaxByRank(_loc2_);
         var _loc5_:Number = _loc1_.ladderProgress - _loc3_;
         var _loc6_:Number = _loc4_ - _loc1_.ladderProgress;
         var _loc7_:uint = 0;
         if(_loc5_ > 0)
         {
            _loc8_ = 1;
            while(_loc8_ <= _loc5_)
            {
               _loc9_ = new mcStarFull();
               _loc9_.scaleX = 0.66;
               _loc9_.scaleY = 0.66;
               _loc9_.y = -_loc7_ * 43;
               this.mcStarsStripe.addChild(_loc9_);
               this._rankStars.push(_loc9_);
               _loc7_++;
               _loc8_++;
            }
         }
         if(_loc6_ > 0)
         {
            _loc8_ = 1;
            while(_loc8_ <= _loc6_)
            {
               _loc10_ = new mcStarEmpty();
               _loc10_.scaleX = 0.58;
               _loc10_.scaleY = 0.58;
               _loc10_.y = -_loc7_ * 43;
               this.mcStarsStripe.addChild(_loc10_);
               this._rankStars.push(_loc10_);
               _loc7_++;
               _loc8_++;
            }
         }
         this._starsStripeTargetYPos = _loc7_ * 43 + 25;
      }
      
      private function removeRankStars() : void
      {
         var _loc1_:uint = 0;
         if(this._rankStars != null)
         {
            _loc1_ = 0;
            while(_loc1_ < this._rankStars.length)
            {
               this._rankStars[_loc1_].parent.removeChild(this._rankStars[_loc1_]);
               this._rankStars[_loc1_] = null;
               _loc1_++;
            }
         }
         this._rankStars = new Array();
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
               break;
            case "rank":
               _loc2_ = getScreenText("rankTooltip");
               this.showRankStars();
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
         this._showRankStars = false;
      }
      
      override public function notifyClientDataReloaded() : *
      {
         this.refreshScreen(false);
      }
   }
}

