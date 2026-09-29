package net.battleMechsMulti.screens
{
   import com.greensock.TweenMax;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMTutorialManager;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMButton_plus;
   import net.battleMechsMulti.mobiles.buttons.BMButton_plus2;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1142")]
   public class BMScreenTopBarNew extends BMBaseScreen
   {
      
      public var mcSizer_btnDebugger:Sprite;
      
      public var txtGold:TextField;
      
      public var txtTokens:TextField;
      
      public var mcGold:Sprite;
      
      public var mcTokens:Sprite;
      
      public var mcTokensFrame:Sprite;
      
      public var mcMainHolder:MovieClip;
      
      public var mcButtonsHolder:MovieClip;
      
      public var mcEffectsHolder:MovieClip;
      
      public var mcOptionsButton:BMBasicButton;
      
      public var mcSizer_btnGetGold:Sprite;
      
      public var mcSizer_btnGetTokens:Sprite;
      
      public var btnGetGold:BMButton_plus2;
      
      public var btnGetTokens:BMButton_plus;
      
      public var mcLvlAndXp:MovieClip;
      
      public var sparksBMD:BitmapData;
      
      public var sparksBM:Bitmap;
      
      private var mcLevelRank:MovieClip;
      
      public var mcTooltip_gold:MovieClip;
      
      public var mcTooltip_tokens:MovieClip;
      
      public var mcTooltip_XP:MovieClip;
      
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
      
      private var _firstRefresh:Boolean = true;
      
      public const GOLD_FLYING_NUMBER_X_POS:Number = 101;
      
      public const TOKENS_FLYING_NUMBER_X_POS:Number = 237;
      
      public const FLYING_NUMBER_Y_POS:Number = 15;
      
      public const SPARKS_BMD_WIDTH:Number = 800;
      
      public const SPARKS_BMD_HEIGHT:Number = 600;
      
      public const SPARKS_BM_Y_POS:Number = 0;
      
      public const SPARKS_BM_Y_ADDON:Number = 0;
      
      public function BMScreenTopBarNew()
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
            }
         }
      }
      
      public function refreshScreen(param1:Boolean = false) : void
      {
         var _loc4_:Function = null;
         var _loc5_:Function = null;
         if(this._firstRefresh)
         {
            setLanguageManagerScreenName("topBar");
            this.mcLvlAndXp.XPBar.initialize("blue","right");
            this.mcLvlAndXp.XPBar.addSeparateorLines(5);
            this.mcLvlAndXp.XPBar.setFill(0,false);
            this.mcLvlAndXp.XPBar.mcBackground.visible = false;
            this.mcLvlAndXp.txtXP.text = "";
            this.mcEffectsHolder = new MovieClip();
            this.mcMainHolder.addChild(this.mcEffectsHolder);
            this.mcTooltip_gold.type = "gold";
            this.mcTooltip_tokens.type = "tokens";
            this.mcLvlAndXp.mcTooltip_XP.type = "XP";
            this.mcLvlAndXp.mcTooltip_level.type = "level";
            if(dataM.runAsMobile == false)
            {
               this.mcTooltip_gold.addEventListener(MouseEvent.MOUSE_OVER,this.tooltipMouseOver);
               this.mcTooltip_gold.addEventListener(MouseEvent.MOUSE_OUT,this.tooltipMouseOut);
               this.mcTooltip_tokens.addEventListener(MouseEvent.MOUSE_OVER,this.tooltipMouseOver);
               this.mcTooltip_tokens.addEventListener(MouseEvent.MOUSE_OUT,this.tooltipMouseOut);
               this.mcLvlAndXp.mcTooltip_XP.addEventListener(MouseEvent.MOUSE_OVER,this.tooltipMouseOver);
               this.mcLvlAndXp.mcTooltip_XP.addEventListener(MouseEvent.MOUSE_OUT,this.tooltipMouseOut);
               this.mcLvlAndXp.mcTooltip_level.addEventListener(MouseEvent.MOUSE_OVER,this.tooltipMouseOver);
               this.mcLvlAndXp.mcTooltip_level.addEventListener(MouseEvent.MOUSE_OUT,this.tooltipMouseOut);
            }
            screensM.createButtonFromSizer("screenTopBarNew","btnGetGold","plus2");
            screensM.createButtonFromSizer("screenTopBarNew","btnGetTokens","plus");
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
            this.mcOptionsButton.addEventListener(BMIntractable.HIT,this.onOptionsButtonHit);
            this.hideGetGoldTokensButtons();
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
               screensM.createTextBitmap("screenTopBarNew_txtGold",this.txtGold,"",this);
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
            this.mcOptionsButton.disableMe();
         }
         else
         {
            this.showGetGoldTokensButtons();
            this.mcOptionsButton.enableMe();
         }
         var _loc3_:Boolean = false;
         if(_loc2_.level < 3)
         {
            _loc3_ = true;
         }
         if(_loc3_)
         {
            this.txtTokens.visible = false;
            this.mcTokens.visible = false;
            this.mcTokensFrame.visible = false;
         }
         else
         {
            this.txtTokens.visible = true;
            this.mcTokens.visible = true;
            this.mcTokensFrame.visible = true;
         }
         if(dataM.runAsMobile)
         {
            screensM.createTextBitmap("screenTopBarNew_txtTokens",this.txtTokens,"",this);
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
            TextUtils.updateTextFormat(this.mcLvlAndXp.txtLevel,_loc1_);
            TextUtils.updateTextFormat(this.txtTokens,18);
            TextUtils.updateTextFormat(this.mcLvlAndXp.txtXP,18);
         }
      }
      
      private function refreshGoldHandler() : void
      {
         var _loc1_:BMPlayerProfile = null;
         var _loc2_:Number = NaN;
         var _loc3_:Boolean = false;
         var _loc4_:Number = NaN;
         if(screensM.isScreenOpened("screenTopBarNew"))
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
                     screensM.createTextBitmap("screenTopBarNew_txtGold",this.txtGold,"",this);
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
         if(screensM.isScreenOpened("screenTopBarNew"))
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
                  screensM.createTextBitmap("screenTopBarNew_txtTokens",this.txtTokens,"",this);
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
            this.mcLvlAndXp.txtLevel.text = String(_loc2_.lastLevel);
            this._oldXP = _loc2_.XP - _loc2_.lastXPGained;
            this._newXP = _loc2_.XP;
            this._currentXP = this._oldXP;
            this._xpSoundCooldown = 0;
            this._refreshXPBar = true;
         }
         else
         {
            this._currentXP = _loc2_.XP;
            this.mcLvlAndXp.txtLevel.text = String(_loc2_.level);
            this.refreshXPBar();
         }
         if(this._currentXP == 100 && tutorialM.getTutorialDestination() == BMTutorialManager.TUTORIAL_DESTINATION_MECH)
         {
            this.mcLvlAndXp.txtLevel.text = "1";
         }
         if(dataM.runAsMobile)
         {
            ImageUtils.swapTextFieldWithBitMap(this.mcLvlAndXp.txtLevel,this.mcLvlAndXp);
         }
      }
      
      public function displayLevelUpPopUp() : void
      {
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
                     this._currentLevelXPBase = dataM.levelUpDB[_loc1_.lastLevel];
                     if(dataM.levelUpDB[_loc1_.lastLevel + 1] != null)
                     {
                        this._currentLevelXPMax = dataM.levelUpDB[_loc1_.lastLevel + 1];
                     }
                     else
                     {
                        this._currentLevelXPMax = this._currentLevelXPBase;
                     }
                     this.mcLvlAndXp.txtLevel.text = String(_loc1_.lastLevel);
                     if(dataM.runAsMobile)
                     {
                        ImageUtils.swapTextFieldWithBitMap(this.mcLvlAndXp.txtLevel,this.mcLvlAndXp);
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
         var _loc2_:Number = this._currentXP;
         if(this._currentXP == 100 && tutorialM.getTutorialDestination() == BMTutorialManager.TUTORIAL_DESTINATION_MECH)
         {
            _loc2_ = 50;
         }
         if(_loc2_ > dataM.levelUpDB[dataM.LEVEL_MAX])
         {
            this.mcLvlAndXp.txtXP.text = dataM.getNumberWithComma(_loc2_);
            _loc1_ = 1;
         }
         else
         {
            this.mcLvlAndXp.txtXP.text = dataM.getNumberWithComma(_loc2_) + " / " + dataM.getNumberWithComma(this._currentLevelXPMax);
            _loc1_ = (_loc2_ - this._currentLevelXPBase) / (this._currentLevelXPMax - this._currentLevelXPBase);
         }
         if(dataM.runAsMobile)
         {
            ImageUtils.swapTextFieldWithBitMap(this.mcLvlAndXp.txtXP,this.mcLvlAndXp);
         }
         this.mcLvlAndXp.XPBar.setFill(_loc1_,false);
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
      
      private function onOptionsButtonHit(param1:Event) : void
      {
         screensM.screenNewMenu.extraOptions();
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
         this._showRankStars = false;
      }
      
      public function showLvlAndXp() : *
      {
         TweenMax.to(this.mcLvlAndXp,0.3,{"alpha":1});
      }
      
      public function hideLvlAndXp() : *
      {
         TweenMax.to(this.mcLvlAndXp,0.3,{"alpha":0});
      }
      
      override public function notifyClientDataReloaded() : *
      {
         this.refreshScreen(false);
      }
   }
}

