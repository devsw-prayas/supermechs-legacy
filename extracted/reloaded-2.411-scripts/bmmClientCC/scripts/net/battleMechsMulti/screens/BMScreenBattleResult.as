package net.battleMechsMulti.screens
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.battleMechsMulti.helpers.BMGameShortcutsHelper;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.buttons.BMButton;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.utils.FeatureFlags;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1655")]
   public class BMScreenBattleResult extends BMBaseScreen
   {
      
      public var mcButtonsHolder:Sprite;
      
      public var mcSparksHolder:Sprite;
      
      public var mcFrameGlow:MovieClip;
      
      public var mcTutorialArrow_button:MovieClip;
      
      public var mcTutorialMarker_button:MovieClip;
      
      public var mcSizer_btnOK:Sprite;
      
      public var mcSizer_btnChat:Sprite;
      
      public var mcSizer_btnInviteToClan:Sprite;
      
      public var btnOK:BMButton;
      
      public var btnChat:BMButton_pictureE;
      
      public var btnInviteToClan:BMButton_pictureE;
      
      public var holder_main:MovieClip;
      
      public var holder_effects:MovieClip;
      
      public var mcGoldGlow:MovieClip;
      
      public var mcXPGlow:MovieClip;
      
      public var sparksBMD:BitmapData;
      
      public var sparksBM:Bitmap;
      
      public var txtBattleResult_victory:TextField;
      
      public var txtBattleResult_youLost:TextField;
      
      public var txtBattleResult_opponentQuit:TextField;
      
      public var txtGoldBaseText:TextField;
      
      public var txtGoldMultiplierText:TextField;
      
      public var txtGoldTotalText:TextField;
      
      public var txtGoldBaseValue:TextField;
      
      public var txtGoldMultiplierValue:TextField;
      
      public var txtGoldTotalValue:TextField;
      
      public var txtXPBaseText:TextField;
      
      public var txtXPMultiplierText:TextField;
      
      public var txtXPTotalText:TextField;
      
      public var txtXPBaseValue:TextField;
      
      public var txtXPMultiplierValue:TextField;
      
      public var txtXPTotalValue:TextField;
      
      public var txtTip:TextField;
      
      public var mcStarEmpty1:Sprite;
      
      public var mcStarEmpty2:Sprite;
      
      public var mcStarEmpty3:Sprite;
      
      public var mcStarFull1:Sprite;
      
      public var mcStarFull2:Sprite;
      
      public var mcStarFull3:Sprite;
      
      public var mcTipBackground:Sprite;
      
      public var goldBase:Number;
      
      public var goldTotal:Number;
      
      public var XPBase:Number;
      
      public var XPTotal:Number;
      
      public var rewardMultiplier:Number;
      
      public var mcButtonsFrame:Sprite;
      
      private var _btnOKOriginXPos:Number;
      
      private var _facebookSinglePlayerPublished:Boolean = false;
      
      private var _facebookMultiPlayerPublished:Boolean = false;
      
      private var _runningGoldValue:Number;
      
      private var _runningXPValue:Number;
      
      private var _titleTextsOriginYPos:Number;
      
      private var _showSparks:Boolean;
      
      private var _sparks:Array;
      
      private var _sparksSpeedAddon:Number;
      
      private var _tipOriginYPos:Number;
      
      private var _firstRefresh:Boolean = true;
      
      public const SPARKS_BMD_WIDTH:Number = 800;
      
      public const SPARKS_BMD_HEIGHT:Number = 600;
      
      public const SPARKS_BM_Y_POS:Number = 0;
      
      public const SPARKS_BM_Y_ADDON:Number = 0;
      
      public function BMScreenBattleResult()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("battleResult");
      }
      
      public function refreshScreen() : void
      {
         var _loc3_:Function = null;
         var _loc4_:Function = null;
         var _loc5_:Function = null;
         var _loc6_:Boolean = false;
         var _loc7_:BMPlayerProfile = null;
         var _loc8_:uint = 0;
         var _loc9_:Object = null;
         if(this._firstRefresh)
         {
            this._titleTextsOriginYPos = this.txtBattleResult_victory.y;
            screensM.createButtonFromSizer("screenBattleResult","btnOK","regular");
            screensM.createButtonFromSizer("screenBattleResult","btnChat","pictureE");
            screensM.createButtonFromSizer("screenBattleResult","btnInviteToClan","pictureE");
            _loc3_ = this.OKClicked;
            _loc4_ = this.chatClicked;
            _loc5_ = this.inviteToClanClicked;
            if(dataM.runAsMobile)
            {
               _loc3_ = null;
               _loc4_ = null;
               _loc5_ = null;
               this.btnOK.changeFontSize(34);
            }
            this.btnOK.initialize(getGeneralText("OK"),"blue",null,[],_loc3_,dataM.runAsMobile);
            this.btnChat.initialize("","",externalAssetsM.getAsset("general","interface_chat"),[],_loc4_,dataM.runAsMobile);
            this.btnInviteToClan.initialize("","",externalAssetsM.getAsset("general","interface_sendClanInvitation"),[],_loc5_,dataM.runAsMobile);
            if(dataM.runAsMobile == false)
            {
               this.btnChat.buttonCore.addMouseOverListerner(this.chatMouseOver);
               this.btnChat.buttonCore.addMouseOutListerner(this.buttonMouseOut);
               this.btnInviteToClan.buttonCore.addMouseOverListerner(this.inviteToClanMouseOver);
               this.btnInviteToClan.buttonCore.addMouseOutListerner(this.buttonMouseOut);
            }
            this.btnOK.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnChat.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnInviteToClan.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.mcTutorialArrow_button.mouseEnabled = false;
            this.mcTutorialArrow_button.mouseChildren = false;
            this.mcTutorialMarker_button.mouseEnabled = false;
            this.mcTutorialMarker_button.mouseChildren = false;
            this._btnOKOriginXPos = this.btnOK.x;
            this._tipOriginYPos = this.txtTip.y;
            this.holder_effects = new MovieClip();
            this.holder_main.addChild(this.holder_effects);
            this.languageUpdate();
            this._firstRefresh = false;
         }
         else if(lastLanguageID != dataM.languageID)
         {
            this.languageUpdate(true);
         }
         screensM.removeScreen("screenConfirmation");
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc2_:Boolean = false;
         if(_loc1_.clanID > 0)
         {
            if(dataM.gameType == BMDataManager.GAME_TYPE_PVP)
            {
               if(_loc1_.clan_leaderPlayerID == dataM.userID)
               {
                  if(_loc1_.clan_members.length < dataM.clanMaxMembers)
                  {
                     _loc6_ = false;
                     _loc7_ = dataM["player" + dataM.player2PlayerID + "Profile"];
                     if(_loc7_.clanID == 0)
                     {
                        _loc8_ = 0;
                        while(_loc8_ < _loc1_.clan_members.length)
                        {
                           _loc9_ = _loc1_.clan_members[_loc8_];
                           if(_loc9_.playerID == _loc7_.userID)
                           {
                              _loc6_ = true;
                              _loc8_ = _loc1_.clan_members.length;
                           }
                           _loc8_++;
                        }
                        if(_loc6_ == false)
                        {
                           _loc2_ = true;
                        }
                     }
                  }
               }
            }
         }
         this.btnOK.enableMe();
         this.btnChat.enableMe();
         this.btnInviteToClan.enableMe();
         this.mcButtonsFrame.visible = false;
         if(_loc2_)
         {
            this.btnInviteToClan.enableMe();
         }
         else
         {
            this.btnInviteToClan.disableMe();
         }
         this.btnChat.visible = false;
         this.btnInviteToClan.visible = false;
         if(dataM.gameType == BMDataManager.GAME_TYPE_PVP)
         {
            this.btnChat.visible = true;
            this.btnInviteToClan.visible = true;
            this.mcButtonsFrame.visible = true;
         }
         this.refreshScreenSub();
         if(screensM.isScreenOpened("screenBattleOptions"))
         {
            screensM.removeScreen("screenBattleOptions");
         }
         if(tutorialM.isTutorialActive())
         {
            this.mcTutorialArrow_button.gotoAndStop("animOn");
            this.mcTutorialMarker_button.gotoAndStop("animOn");
         }
         screensM.screenBattleInterfaceTop.moveScreenUp();
         this.refreshTip();
         if(BMGameShortcutsHelper.battleResultScreenShortcut())
         {
            this.OKClicked();
         }
      }
      
      private function languageUpdate(param1:Boolean = false) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         if(lastLanguageID != dataM.languageID)
         {
            lastLanguageID = dataM.languageID;
            TextUtils.updateTextFormat(this.txtBattleResult_opponentQuit,26);
            _loc2_ = 47;
            _loc3_ = 0;
            switch(dataM.languageID)
            {
               case 7:
                  _loc2_ = 40;
                  _loc3_ = 5;
            }
            TextUtils.updateTextFormat(this.txtBattleResult_victory,_loc2_);
            TextUtils.updateTextFormat(this.txtBattleResult_youLost,_loc2_);
            TextUtils.updateTextFormat(this.txtGoldMultiplierText,14);
            TextUtils.updateTextFormat(this.txtGoldMultiplierValue,15);
            TextUtils.updateTextFormat(this.txtGoldBaseText,14);
            TextUtils.updateTextFormat(this.txtGoldBaseValue,15);
            TextUtils.updateTextFormat(this.txtGoldTotalText,20);
            TextUtils.updateTextFormat(this.txtGoldTotalValue,24);
            TextUtils.updateTextFormat(this.txtXPMultiplierText,14);
            TextUtils.updateTextFormat(this.txtXPMultiplierValue,15);
            TextUtils.updateTextFormat(this.txtXPBaseText,14);
            TextUtils.updateTextFormat(this.txtXPBaseValue,15);
            TextUtils.updateTextFormat(this.txtXPTotalText,20);
            TextUtils.updateTextFormat(this.txtXPTotalValue,24);
            TextUtils.updateTextFormat(this.txtTip,18);
            this.txtBattleResult_victory.y = this._titleTextsOriginYPos + _loc3_;
            this.txtBattleResult_youLost.y = this._titleTextsOriginYPos + _loc3_;
            param1 = true;
         }
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(screensM.isScreenOpened("screenBattleResult") && screensM.screenBlack.isActive() == false)
         {
            this.runningTextsHandler();
            this.sparksHandler();
         }
      }
      
      private function refreshScreenSub() : void
      {
         var _loc4_:String = null;
         var _loc5_:Array = null;
         this.txtBattleResult_victory.visible = false;
         this.txtBattleResult_youLost.visible = false;
         this.txtBattleResult_opponentQuit.visible = false;
         this.txtBattleResult_opponentQuit.text = getScreenText("opponentQuit");
         this.txtBattleResult_youLost.text = getScreenText("youLost");
         this.txtGoldBaseText.text = getScreenText("reward");
         this.txtGoldTotalText.text = getScreenText("total");
         this.txtXPBaseText.text = getScreenText("reward");
         this.txtXPTotalText.text = getScreenText("total");
         this.txtGoldBaseValue.text = "";
         this.txtGoldMultiplierValue.text = "";
         this.txtGoldTotalValue.text = "";
         this.txtXPBaseValue.text = "";
         this.txtXPMultiplierValue.text = "";
         this.txtXPTotalValue.text = "";
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         this.removeAllSparks();
         this._showSparks = false;
         this._sparksSpeedAddon = 5;
         var _loc2_:String = "orange";
         switch(_loc1_.lastBattleResult)
         {
            case "youLost":
               this.txtBattleResult_youLost.visible = true;
               _loc2_ = "blue";
               break;
            case "youWon":
               this.txtBattleResult_victory.visible = true;
               _loc4_ = getScreenText("victory" + Math.ceil(Math.random() * 6));
               this.txtBattleResult_victory.text = _loc4_;
               this._showSparks = true;
               break;
            case "opponentQuit":
               this.txtBattleResult_opponentQuit.visible = true;
               this._showSparks = true;
         }
         this.txtGoldBaseValue.text = dataM.getNumberWithComma(this.goldBase);
         var _loc3_:Number = int(this.rewardMultiplier * 10) / 10;
         if(FeatureFlags.NEW_ECONOMY)
         {
            _loc3_ = 1;
         }
         this.txtGoldMultiplierValue.text = "X " + _loc3_;
         this._runningGoldValue = 0;
         this.txtGoldTotalValue.text = "+" + dataM.getNumberWithComma(this._runningGoldValue);
         this.txtXPBaseValue.text = dataM.getNumberWithComma(this.XPBase);
         this.txtXPMultiplierValue.text = "X " + _loc3_;
         this._runningXPValue = 0;
         this.txtXPTotalValue.text = "+" + this._runningXPValue;
         this.btnOK.y = this.mcSizer_btnOK.y;
         this.mcFrameGlow.gotoAndStop(_loc2_);
         if(dataM.playingVSComputer)
         {
            if(dataM.battleType == "challenge")
            {
               this.txtGoldMultiplierText.text = getScreenText("challengeMultiplier");
               this.txtXPMultiplierText.text = getScreenText("challengeMultiplier");
            }
            else
            {
               this.txtGoldMultiplierText.text = getScreenText("missionMultiplier");
               this.txtXPMultiplierText.text = getScreenText("missionMultiplier");
            }
         }
         else
         {
            this.txtGoldMultiplierText.text = getScreenText("rankMultiplier");
            this.txtXPMultiplierText.text = getScreenText("rankMultiplier");
         }
         if(dataM.runAsMobile)
         {
            _loc5_ = new Array();
            _loc5_.push(this.txtBattleResult_victory);
            _loc5_.push(this.txtBattleResult_opponentQuit);
            _loc5_.push(this.txtBattleResult_youLost);
            _loc5_.push(this.txtGoldBaseText);
            _loc5_.push(this.txtGoldBaseValue);
            _loc5_.push(this.txtGoldTotalText);
            _loc5_.push(this.txtGoldMultiplierText);
            _loc5_.push(this.txtGoldMultiplierValue);
            _loc5_.push(this.txtXPBaseText);
            _loc5_.push(this.txtXPBaseValue);
            _loc5_.push(this.txtXPTotalText);
            _loc5_.push(this.txtXPMultiplierText);
            _loc5_.push(this.txtXPMultiplierValue);
            screensM.createMultipleTextsBitmap("battleResult_texts",_loc5_,"",this);
            screensM.createMultipleTextsBitmap("battleResult_goldTotalAndXPTotal",[this.txtGoldTotalValue,this.txtXPTotalValue],"",this);
         }
      }
      
      public function resetRewardParameters() : void
      {
         this.goldBase = 0;
         this.goldTotal = 0;
         this.XPBase = 0;
         this.XPTotal = 0;
         this.rewardMultiplier = 1;
      }
      
      private function refreshTip() : void
      {
         this.txtTip.text = dataM.tipsManager.getTip();
         this.txtTip.y = this._tipOriginYPos;
         if(this.txtTip.numLines == 1)
         {
            this.txtTip.y += 12;
         }
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("battleResult_tip",[this.txtTip],"",this);
         }
      }
      
      private function runningTextsHandler() : void
      {
         var _loc1_:Number = 0.05;
         var _loc2_:Boolean = false;
         if(this._runningGoldValue < this.goldTotal)
         {
            this._runningGoldValue += this.goldTotal * _loc1_;
            if(this._runningGoldValue >= this.goldTotal)
            {
               this._runningGoldValue = this.goldTotal;
               this.mcGoldGlow.gotoAndPlay("animOn");
            }
            this.txtGoldTotalValue.text = "+" + dataM.getNumberWithComma(Math.ceil(this._runningGoldValue));
            _loc2_ = true;
         }
         if(this._runningXPValue < this.XPTotal)
         {
            this._runningXPValue += this.XPTotal * _loc1_;
            if(this._runningXPValue >= this.XPTotal)
            {
               this._runningXPValue = this.XPTotal;
               this.mcXPGlow.gotoAndPlay("animOn");
            }
            this.txtXPTotalValue.text = "+" + Math.ceil(this._runningXPValue);
            _loc2_ = true;
         }
         if(dataM.runAsMobile)
         {
            if(_loc2_)
            {
               screensM.createMultipleTextsBitmap("battleResult_goldTotalAndXPTotal",[this.txtGoldTotalValue,this.txtXPTotalValue],"",this);
            }
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
               _loc6_ = Math.random() * 95;
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
      
      public function chatClicked() : void
      {
         dataM.battle_goToChatAfterBattle = true;
         this.OKClicked();
      }
      
      public function inviteToClanClicked() : void
      {
         dataM.battle_inviteToClanAfterBattle = true;
         this.OKClicked();
      }
      
      public function removeMe() : void
      {
         this.removeAllSparks();
         screensM.removeScreen("screenBattleResult");
      }
      
      public function OKClicked() : void
      {
         var _loc2_:BMPlayerProfile = null;
         var _loc1_:Boolean = false;
         if(dataM.gameType == BMDataManager.GAME_TYPE_PVP && dataM.battle_inBattleInvitation == false)
         {
            _loc1_ = true;
         }
         if(_loc1_)
         {
            screensM.addScreen("screenLadderStatus");
            screensM.screenLadderStatus.refreshScreen();
            this.removeMe();
         }
         else
         {
            screensM.screenBattle.returnToLobbyClicked(false);
            this.btnOK.disableMe();
            this.btnChat.disableMe();
            this.btnInviteToClan.disableMe();
            _loc2_ = dataM["player" + dataM.player1PlayerID + "Profile"];
            if(tutorialM.isTutorialActive())
            {
               this.mcTutorialArrow_button.gotoAndStop("animOff");
               this.mcTutorialMarker_button.gotoAndStop("animOff");
            }
         }
      }
      
      public function chatMouseOver() : void
      {
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player2PlayerID + "Profile"];
         tooltip.showToolTip("regularText","Chat with " + _loc1_.playerName,-1,-1);
      }
      
      public function inviteToClanMouseOver() : void
      {
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player2PlayerID + "Profile"];
         tooltip.showToolTip("regularText","Invite " + _loc1_.playerName + " to your clan",-1,-1);
      }
      
      private function buttonMouseOut() : void
      {
         tooltip.hideToolTip();
      }
   }
}

