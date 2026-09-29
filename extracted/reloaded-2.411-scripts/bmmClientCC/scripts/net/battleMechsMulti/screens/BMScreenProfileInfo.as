package net.battleMechsMulti.screens
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.battleMechsMulti.mobiles.BMBar;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.utils.TextUtils;
   import net.tacticsoft.utils.RandomUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol784")]
   public class BMScreenProfileInfo extends BMBaseScreen
   {
      
      public var mcButtonsHolder:Sprite;
      
      public var mcIconsHolder:Sprite;
      
      public var mcSizer_btnAdminTools:Sprite;
      
      public var mcSizer_btnChangeName:Sprite;
      
      public var mcSizer_btnSendTokensToPlayer:Sprite;
      
      public var mcSizer_btnBack:Sprite;
      
      public var mcSoloMedalsTooltip:Sprite;
      
      public var mcClanMedalsTooltip:Sprite;
      
      public var btnAdminTools:BMButton_pictureE;
      
      public var btnChangeName:BMButton_pictureE;
      
      public var btnSendTokensToPlayer:BMButton_pictureE;
      
      public var btnBack:BMButton_pictureE;
      
      public var txtTitle:TextField;
      
      public var txtSoloMedals:TextField;
      
      public var txtClanMedals:TextField;
      
      public var txtCampaignStatus_title:TextField;
      
      public var txtCampaignStatus_stats:TextField;
      
      public var txtPremiumAccount_title:TextField;
      
      public var txtPremiumAccount_stats:TextField;
      
      public var txtChangeName:TextField;
      
      public var txtPlayersOnline:TextField;
      
      public var txtPlayerID_title:TextField;
      
      public var txtPlayerID_value:TextField;
      
      public var txtSupporterStatus_title:TextField;
      
      public var txtSupporterStatus_stats:TextField;
      
      public var mcCampaignBar:BMBar;
      
      public var mcSizer_soloMedals:Sprite;
      
      public var mcSizer_clanMedals:Sprite;
      
      public var mcOnlineGraph:MovieClip;
      
      public var onlineGraphMC:MovieClip;
      
      private var _onlineGraphInitialYPos:Number;
      
      private var _firstRefresh:Boolean = true;
      
      private var _secondsPerMinute:Number;
      
      private var _secondsPerHour:Number;
      
      private var _secondsPerDay:Number;
      
      private var _medals:Array;
      
      private var _medalsBMD:BitmapData;
      
      private var _medalsBM:Bitmap;
      
      private var _sparks:Array = new Array();
      
      private var _supporterStatus:String;
      
      private var _changeNameOriginYPos:Number;
      
      public function BMScreenProfileInfo()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("profile");
      }
      
      public function refreshScreen() : void
      {
         var _loc6_:Function = null;
         var _loc7_:Function = null;
         var _loc8_:Function = null;
         if(this._firstRefresh)
         {
            screensM.createButtonFromSizer("screenProfileInfo","btnAdminTools","pictureE");
            screensM.createButtonFromSizer("screenProfileInfo","btnChangeName","pictureE");
            screensM.createButtonFromSizer("screenProfileInfo","btnSendTokensToPlayer","pictureE");
            screensM.createButtonFromSizer("screenProfileInfo","btnBack","pictureE");
            _loc6_ = this.adminToolsClicked;
            _loc7_ = this.changeNameClicked;
            _loc8_ = this.sendTokensToPlayerClicked;
            if(dataM.runAsMobile)
            {
               _loc6_ = null;
               _loc7_ = null;
               _loc8_ = null;
            }
            this.btnAdminTools.initialize("","",null,null,_loc6_,dataM.runAsMobile);
            this.btnChangeName.initialize("","",externalAssetsM.getAsset("general","interface_edit"),null,_loc7_,dataM.runAsMobile);
            this.btnSendTokensToPlayer.initialize("","",externalAssetsM.getAsset("general","interface_sendTokens"),null,_loc8_,dataM.runAsMobile);
            this.btnBack.initialize("","",externalAssetsM.getAsset("general","interface_back2"),null,this.backClicked,false);
            if(dataM.runAsMobile == false)
            {
               this.btnAdminTools.buttonCore.addMouseOverListerner(this.adminToolsButtonMouseOver);
               this.btnAdminTools.buttonCore.addMouseOutListerner(this.generalButtonMouseOut);
               this.btnChangeName.buttonCore.addMouseOverListerner(this.changeNameButtonMouseOver);
               this.btnChangeName.buttonCore.addMouseOutListerner(this.generalButtonMouseOut);
               this.btnSendTokensToPlayer.buttonCore.addMouseOverListerner(this.sendTokensToPlayerButtonMouseOver);
               this.btnSendTokensToPlayer.buttonCore.addMouseOutListerner(this.generalButtonMouseOut);
            }
            this.btnAdminTools.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnChangeName.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnSendTokensToPlayer.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnBack.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.mcCampaignBar.initialize("blue","right");
            this.mcCampaignBar.addSeparateorLines(6);
            this._secondsPerMinute = 60;
            this._secondsPerHour = this._secondsPerMinute * 60;
            this._secondsPerDay = this._secondsPerHour * 24;
            this._changeNameOriginYPos = this.txtChangeName.y;
            this.languageUpdate();
            if(dataM.clientRunningLocally == false)
            {
               this.btnSendTokensToPlayer.visible = false;
            }
            this._onlineGraphInitialYPos = this.mcOnlineGraph.y;
            this._firstRefresh = false;
         }
         else
         {
            this.languageUpdate();
         }
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         this.btnAdminTools.visible = false;
         if(_loc1_.isAdmin == 1)
         {
            this.btnAdminTools.visible = true;
         }
         this.refreshSendTokens();
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         while(_loc3_ < _loc1_.mapProgress.length)
         {
            if(_loc1_.mapProgress[_loc3_] == "v")
            {
               _loc2_++;
            }
            _loc3_++;
         }
         var _loc4_:uint = dataM.missionsDB.length - 3;
         var _loc5_:Number = _loc2_ / _loc4_;
         if(_loc5_ > 1)
         {
            _loc5_ = 1;
         }
         this.mcCampaignBar.setFill(_loc5_,false);
         _loc5_ = Math.ceil(_loc5_ * 100);
         this.txtCampaignStatus_stats.text = _loc5_ + "%";
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("profile_campaignStatus",[this.txtCampaignStatus_stats],"",this);
         }
         this.refreshPremiumAccountText();
         this.refreshMedals();
         this.updateOnlineStatistics();
         this.txtPlayerID_value.text = String(dataM.userID);
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("profile_playerID",[this.txtPlayerID_value],"",this);
         }
         if(dataM.specialUser)
         {
            this.mcOnlineGraph.y = this._onlineGraphInitialYPos + 70;
         }
         else
         {
            this.mcOnlineGraph.y = this._onlineGraphInitialYPos;
         }
      }
      
      private function languageUpdate(param1:Boolean = false) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         if(lastLanguageID != dataM.languageID)
         {
            lastLanguageID = dataM.languageID;
            _loc2_ = 20;
            _loc3_ = 0;
            switch(dataM.languageID)
            {
               case 10:
                  _loc2_ = 20;
                  _loc3_ = 10;
            }
            TextUtils.updateTextFormat(this.txtCampaignStatus_stats,20);
            TextUtils.updateTextFormat(this.txtCampaignStatus_title,20);
            TextUtils.updateTextFormat(this.txtChangeName,_loc2_);
            TextUtils.updateTextFormat(this.txtClanMedals,20);
            TextUtils.updateTextFormat(this.txtPlayerID_title,20);
            TextUtils.updateTextFormat(this.txtPlayerID_value,20);
            TextUtils.updateTextFormat(this.txtPlayersOnline,20);
            TextUtils.updateTextFormat(this.txtPremiumAccount_stats,20);
            TextUtils.updateTextFormat(this.txtPremiumAccount_title,20);
            TextUtils.updateTextFormat(this.txtSoloMedals,20);
            TextUtils.updateTextFormat(this.txtSupporterStatus_stats,20);
            TextUtils.updateTextFormat(this.txtSupporterStatus_title,20);
            TextUtils.updateTextFormat(this.txtTitle,20);
            this.txtChangeName.y = this._changeNameOriginYPos - _loc3_;
         }
         this.txtTitle.text = getScreenText("info");
         this.txtCampaignStatus_title.text = getScreenText("campaignProgress");
         this.txtSoloMedals.htmlText = TextUtils.getTextFont() + getScreenText("topPlayersMedals");
         this.txtClanMedals.htmlText = TextUtils.getTextFont() + getScreenText("topClansMedals");
         this.txtPremiumAccount_title.text = getScreenText("premiumAccount");
         this.txtChangeName.text = getScreenText("changeName");
         this.txtPlayerID_title.text = getScreenText("playerID");
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("profile_mainTexts",[this.txtTitle,this.txtCampaignStatus_title,this.txtSoloMedals,this.txtClanMedals,this.txtPremiumAccount_title,this.txtChangeName,this.txtPlayerID_title],"",this);
         }
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(parent != null)
         {
            this.sparksHandler();
         }
      }
      
      public function refreshPremiumAccountText() : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:String = null;
         var _loc1_:Boolean = true;
         if(dataM.premiumAccountTime <= dataM.currentTime)
         {
            _loc1_ = false;
         }
         if(_loc1_)
         {
            _loc2_ = dataM.premiumAccountTime - dataM.currentTime;
            _loc3_ = Math.floor(_loc2_ / this._secondsPerDay);
            _loc2_ -= _loc3_ * this._secondsPerDay;
            _loc4_ = Math.floor(_loc2_ / this._secondsPerHour);
            _loc2_ -= _loc4_ * this._secondsPerHour;
            _loc5_ = Math.floor(_loc2_ / this._secondsPerMinute);
            _loc2_ -= _loc5_ * this._secondsPerMinute;
            if(_loc3_ > 0)
            {
               if(_loc3_ == 1)
               {
                  _loc6_ = "1 " + getGeneralText("day");
               }
               else
               {
                  _loc6_ = _loc3_ + " " + getGeneralText("days");
               }
            }
            else if(_loc4_ > 0)
            {
               if(_loc4_ == 1)
               {
                  _loc6_ = "1 " + getGeneralText("hour");
               }
               else
               {
                  _loc6_ = _loc4_ + " " + getGeneralText("hours");
               }
            }
            else if(_loc5_ > 0)
            {
               if(_loc5_ == 1)
               {
                  _loc6_ = "1 " + getGeneralText("minute");
               }
               else
               {
                  _loc6_ = _loc5_ + " " + getGeneralText("minutes");
               }
            }
            else if(_loc2_ > 0)
            {
               if(_loc2_ == 1)
               {
                  _loc6_ = "01 " + getGeneralText("second");
               }
               else if(_loc2_ < 10)
               {
                  _loc6_ = "0" + _loc2_ + " " + getGeneralText("seconds");
               }
               else
               {
                  _loc6_ = _loc2_ + " " + getGeneralText("seconds");
               }
            }
            this.txtPremiumAccount_stats.htmlText = TextUtils.getTextFont() + getGeneralText("premiumAccountActive") + ", " + _loc6_ + " LEFT";
         }
         else
         {
            this.txtPremiumAccount_stats.text = getScreenText("inactive");
            if(dataM.runAsMobile)
            {
               screensM.createMultipleTextsBitmap("profile_premiumStatus",[this.txtPremiumAccount_stats],"",this);
            }
         }
      }
      
      public function adminToolsClicked() : void
      {
         screensM.screenConfirmation.displayQuestionOrNotification("openAdminTools",-1,-1);
      }
      
      public function changeNameClicked() : void
      {
         if(dataM.useNameChange)
         {
            screensM.addScreen("screenChangeName");
            screensM.screenChangeName.refreshScreen();
         }
      }
      
      public function sendTokensToPlayerClicked() : void
      {
         screensM.addScreen("screenSendTokensToPlayer");
         screensM.screenSendTokensToPlayer.refreshScreen();
      }
      
      private function refreshSendTokens() : void
      {
         var _loc3_:Number = NaN;
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         this.txtSupporterStatus_title.text = getScreenText("supporterStatus");
         this._supporterStatus = "none";
         var _loc2_:String = "FFFFFF";
         if(_loc1_.tokensSpent > 0)
         {
            _loc3_ = (dataM.currentTime - _loc1_.timeToFirstPayment) / 86400;
            if(_loc1_.tokensSpent >= dataM.sendTokens_tokensSpentRequired && _loc3_ >= dataM.sendTokens_daysFromFirstPaymentRequired)
            {
               if(_loc1_.tokensSpent >= dataM.sendTokens_tokensSpentRequired * 3)
               {
                  this._supporterStatus = "ultra";
                  _loc2_ = dataM.COLOR_MYTHICAL_ITEM;
               }
               else
               {
                  this._supporterStatus = "super";
                  _loc2_ = dataM.COLOR_LEGENDARY_ITEM;
               }
            }
            else
            {
               this._supporterStatus = "normal";
               _loc2_ = dataM.COLOR_GOOD;
            }
         }
         this.txtSupporterStatus_stats.htmlText = TextUtils.getTextFont() + "<FONT COLOR=\'#" + _loc2_ + "\'>" + getScreenText("supporterStatus_" + this._supporterStatus) + "</FONT>";
         this.btnSendTokensToPlayer.visible = false;
         if(dataM.sendTokens_allow)
         {
            switch(this._supporterStatus)
            {
               case "super":
               case "ultra":
                  if(dataM.getLadderRankByProgress(_loc1_.ladderProgress) <= 2)
                  {
                     this.btnSendTokensToPlayer.visible = true;
                     if(dataM.runAsMobile == false)
                     {
                        this.btnSendTokensToPlayer.buttonCore.addMouseOverListerner(this.sendTokensToPlayerMouseOver);
                        this.btnSendTokensToPlayer.buttonCore.addMouseOutListerner(this.generalButtonMouseOut);
                     }
                  }
            }
         }
         if(dataM.clientRunningLocally)
         {
            this.btnSendTokensToPlayer.visible = true;
         }
      }
      
      public function sendTokensToPlayerMouseOver() : void
      {
         tooltip.showToolTip("regularText",getScreenText("sendTokens"));
      }
      
      private function adminToolsButtonMouseOver() : void
      {
      }
      
      private function changeNameButtonMouseOver() : void
      {
      }
      
      private function sendTokensToPlayerButtonMouseOver() : void
      {
      }
      
      private function generalButtonMouseOut() : void
      {
         tooltip.hideToolTip();
      }
      
      private function removeMedals() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:MovieClip = null;
         if(this._medals != null)
         {
            _loc1_ = 0;
            while(_loc1_ < this._medals.length)
            {
               _loc2_ = this._medals[_loc1_];
               if(_loc2_.parent != null)
               {
                  _loc2_.parent.removeChild(_loc2_);
               }
               this._medals[_loc1_] = null;
               _loc1_++;
            }
         }
         this._medals = new Array();
      }
      
      private function refreshMedals() : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:String = null;
         var _loc5_:Number = NaN;
         var _loc6_:MovieClip = null;
         var _loc8_:Sprite = null;
         var _loc9_:Number = NaN;
         var _loc11_:Array = null;
         this.removeMedals();
         var _loc1_:Number = 0;
         var _loc7_:Number = 0;
         if(dataM.weeklySoloWinners[dataM.userID] != null)
         {
            _loc3_ = 3;
            while(_loc3_ >= 1)
            {
               _loc5_ = Number(dataM.weeklySoloWinners[dataM.userID].places[_loc3_]);
               if(_loc5_ > 0)
               {
                  _loc2_ = 1;
                  while(_loc2_ <= _loc5_)
                  {
                     _loc4_ = "medal" + _loc3_;
                     if(_loc5_ - _loc2_ >= 4)
                     {
                        _loc2_ += 4;
                        _loc4_ += "_5";
                     }
                     else if(_loc5_ - _loc2_ >= 2)
                     {
                        _loc2_ += 2;
                        _loc4_ += "_3";
                     }
                     _loc6_ = externalAssetsM.getAsset("general",_loc4_);
                     if(_loc7_ == 0)
                     {
                        _loc7_ = this.mcSizer_soloMedals.x + this.mcSizer_soloMedals.width + _loc6_.width / 2;
                     }
                     _loc6_.x = _loc7_ - (1 + this._medals.length) * (_loc6_.width - 3);
                     _loc1_ = _loc6_.width - 3;
                     _loc6_.y = this.mcSizer_soloMedals.y;
                     if(this._medals.length % 2 == 1)
                     {
                        _loc6_.gotoAndStop("long");
                     }
                     this.mcIconsHolder.addChild(_loc6_);
                     this._medals.push(_loc6_);
                     _loc2_++;
                  }
               }
               _loc3_--;
            }
            _loc8_ = this._medals[this._medals.length - 1];
            if(_loc8_.x < this.mcSizer_soloMedals.x + 15)
            {
               _loc9_ = this.mcSizer_soloMedals.x + 15 - _loc8_.x;
               _loc2_ = this._medals.length - 1;
               while(_loc2_ > 0)
               {
                  this._medals[_loc2_].x += _loc9_ / (this._medals.length - 1) * _loc2_;
                  _loc2_--;
               }
            }
         }
         if(this._medals.length == 0)
         {
            this.mcSoloMedalsTooltip.visible = false;
         }
         else
         {
            this.mcSoloMedalsTooltip.visible = true;
            if(dataM.runAsMobile == false)
            {
               this.mcSoloMedalsTooltip.addEventListener(MouseEvent.MOUSE_OVER,this.soloMedalsMouseOver);
               this.mcSoloMedalsTooltip.addEventListener(MouseEvent.MOUSE_OUT,this.generalMouseOut);
               this.mcSoloMedalsTooltip.addEventListener(MouseEvent.MOUSE_UP,this.generalMouseOut);
            }
         }
         var _loc10_:uint = this._medals.length;
         _loc7_ = 0;
         if(dataM.weeklyClanWinners[dataM.userID] != null)
         {
            _loc3_ = 3;
            while(_loc3_ >= 1)
            {
               _loc5_ = Number(dataM.weeklyClanWinners[dataM.userID].places[_loc3_]);
               if(_loc5_ > 0)
               {
                  _loc2_ = 1;
                  while(_loc2_ <= _loc5_)
                  {
                     _loc4_ = "medalClan" + _loc3_;
                     if(_loc5_ - _loc2_ >= 4)
                     {
                        _loc2_ += 4;
                        _loc4_ += "_5";
                     }
                     else if(_loc5_ - _loc2_ >= 2)
                     {
                        _loc2_ += 2;
                        _loc4_ += "_3";
                     }
                     _loc6_ = externalAssetsM.getAsset("general",_loc4_);
                     if(_loc7_ == 0)
                     {
                        _loc7_ = this.mcSizer_clanMedals.x + this.mcSizer_clanMedals.width + _loc6_.width / 2;
                     }
                     _loc6_.x = _loc7_ - (1 + this._medals.length - _loc10_) * _loc6_.width;
                     _loc1_ = _loc6_.width - 3;
                     _loc6_.y = this.mcSizer_clanMedals.y;
                     if(this._medals.length % 2 == 1)
                     {
                        _loc6_.gotoAndStop("long");
                     }
                     this.mcIconsHolder.addChild(_loc6_);
                     this._medals.push(_loc6_);
                     _loc2_++;
                  }
               }
               _loc3_--;
            }
            _loc8_ = this._medals[this._medals.length - 1];
            if(_loc8_.x < this.mcSizer_clanMedals.x + 15)
            {
               _loc9_ = this.mcSizer_clanMedals.x + 15 - _loc8_.x;
               _loc2_ = this._medals.length - 1 - _loc10_;
               while(_loc2_ > 0)
               {
                  this._medals[_loc10_ + _loc2_].x += _loc9_ / (this._medals.length - 1 - _loc10_) * _loc2_;
                  _loc2_--;
               }
            }
         }
         if(this._medals.length > _loc10_)
         {
            this.mcClanMedalsTooltip.visible = true;
            if(dataM.runAsMobile == false)
            {
               this.mcClanMedalsTooltip.addEventListener(MouseEvent.MOUSE_OVER,this.clanMedalsMouseOver);
               this.mcClanMedalsTooltip.addEventListener(MouseEvent.MOUSE_OUT,this.generalMouseOut);
               this.mcClanMedalsTooltip.addEventListener(MouseEvent.MOUSE_UP,this.generalMouseOut);
            }
         }
         else
         {
            this.mcClanMedalsTooltip.visible = false;
         }
         if(dataM.runAsMobile)
         {
            if(this._medalsBMD != null)
            {
               this._medalsBMD.dispose();
               this._medalsBMD = null;
            }
            if(this._medalsBM != null)
            {
               this._medalsBM.parent.removeChild(this._medalsBM);
               this._medalsBM = null;
            }
            if(this._medals.length > 0)
            {
               _loc11_ = screensM.createAssetsBitmap([],this._medals,15,15);
               this._medalsBMD = _loc11_[0];
               this._medalsBM = _loc11_[1];
               this.mcIconsHolder.addChild(this._medalsBM);
            }
         }
      }
      
      private function medalsTooltipMouseOut(param1:MouseEvent) : void
      {
         tooltip.hideToolTip();
      }
      
      public function updateOnlineStatistics() : void
      {
         var _loc1_:Number = 0;
         var _loc2_:uint = 1;
         while(_loc2_ <= 40)
         {
            if(dataM.usersOnline[_loc2_] != undefined)
            {
               _loc1_ += dataM.usersOnline[_loc2_];
            }
            _loc2_++;
         }
         var _loc3_:String = getSpecificText("bottomBar_online");
         _loc3_ = dataM.replaceStringInText(_loc3_,"%PLAYERS%",dataM.getNumberWithComma(_loc1_));
         this.txtPlayersOnline.htmlText = TextUtils.getTextFont() + _loc3_;
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("profile_playersOnline",[this.txtPlayersOnline],"",this);
         }
         this.createUsersOnlineGraph();
      }
      
      private function createUsersOnlineGraph() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:uint = 0;
         var _loc5_:Number = NaN;
         var _loc6_:BMPlayerProfile = null;
         var _loc7_:Number = NaN;
         if(dataM.specialUser)
         {
            if(this.onlineGraphMC != null)
            {
               this.onlineGraphMC.parent.removeChild(this.onlineGraphMC);
            }
            this.onlineGraphMC = new MovieClip();
            _loc1_ = Number(this.mcOnlineGraph.mcGraphSizer.width);
            _loc2_ = Number(this.mcOnlineGraph.mcGraphSizer.height);
            _loc3_ = dataM.LEVEL_MAX;
            _loc5_ = 0;
            _loc4_ = 2;
            while(_loc4_ <= _loc3_)
            {
               if(dataM.usersOnline[_loc4_] != undefined)
               {
                  if(_loc5_ < dataM.usersOnline[_loc4_])
                  {
                     _loc5_ = Number(dataM.usersOnline[_loc4_]);
                  }
               }
               _loc4_++;
            }
            this.onlineGraphMC.graphics.lineStyle(1,65343,0);
            _loc4_ = 2;
            while(_loc4_ <= _loc3_)
            {
               if(_loc4_ > 2 && dataM.usersOnline[_loc4_] != null)
               {
                  this.onlineGraphMC.graphics.lineTo((_loc4_ - 2) / (_loc3_ - 2) * _loc1_,_loc2_ - dataM.usersOnline[_loc4_] / _loc5_ * _loc2_);
               }
               else
               {
                  this.onlineGraphMC.graphics.lineTo((_loc4_ - 2) / (_loc3_ - 2) * _loc1_,_loc2_);
               }
               if(_loc4_ == 2)
               {
                  this.onlineGraphMC.graphics.lineStyle(1,65343,1);
               }
               _loc4_++;
            }
            this.onlineGraphMC.x = this.mcOnlineGraph.mcGraphSizer.x;
            this.onlineGraphMC.y = this.mcOnlineGraph.mcGraphSizer.y;
            _loc6_ = dataM["player" + dataM.player1PlayerID + "Profile"];
            _loc6_.updateLevelByItems();
            _loc7_ = _loc6_.levelByItems;
            if(_loc7_ > _loc3_)
            {
               _loc7_ = _loc3_;
            }
            this.mcOnlineGraph.addChild(this.onlineGraphMC);
         }
      }
      
      private function soloMedalsMouseOver(param1:MouseEvent) : void
      {
         this.soloMedalsMouseOverSub();
      }
      
      public function soloMedalsMouseOverSub() : void
      {
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc1_:String = "";
         var _loc2_:String = "<FONT COLOR=\'#" + dataM.COLOR_LEGENDARY_ITEM + "\'>";
         var _loc3_:String = "</FONT>";
         if(dataM.weeklySoloWinners[dataM.userID] != null)
         {
            _loc4_ = uint(dataM.weeklySoloWinners[dataM.userID].places[1]);
            _loc5_ = uint(dataM.weeklySoloWinners[dataM.userID].places[2]);
            _loc6_ = uint(dataM.weeklySoloWinners[dataM.userID].places[3]);
            if(_loc4_ > 0 || _loc5_ > 0 || _loc6_ > 0)
            {
               _loc1_ = getScreenText("soloWeeklyWins");
               if(_loc4_ > 0)
               {
                  _loc7_ = getScreenText("place1");
                  _loc7_ = dataM.replaceStringInText(_loc7_,"%PLACE%",_loc2_ + _loc4_ + _loc3_);
                  _loc1_ = _loc1_ + "<BR>   " + _loc7_;
               }
               if(_loc5_ > 0)
               {
                  _loc8_ = getScreenText("place2");
                  _loc8_ = dataM.replaceStringInText(_loc8_,"%PLACE%",_loc2_ + _loc5_ + _loc3_);
                  _loc1_ = _loc1_ + "<BR>   " + _loc8_;
               }
               if(_loc6_ > 0)
               {
                  _loc9_ = getScreenText("place3");
                  _loc9_ = dataM.replaceStringInText(_loc9_,"%PLACE%",_loc2_ + _loc6_ + _loc3_);
                  _loc1_ = _loc1_ + "<BR>   " + _loc9_;
               }
            }
         }
         if(_loc1_ != "")
         {
            tooltip.showToolTip("regularText",_loc1_,-1,-1);
         }
      }
      
      private function clanMedalsMouseOver(param1:MouseEvent) : void
      {
         this.clanMedalsMouseOverSub();
      }
      
      public function clanMedalsMouseOverSub() : void
      {
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc1_:String = "";
         var _loc2_:String = "<FONT COLOR=\'#" + dataM.COLOR_LEGENDARY_ITEM + "\'>";
         var _loc3_:String = "</FONT>";
         if(dataM.weeklyClanWinners[dataM.userID] != null)
         {
            _loc4_ = uint(dataM.weeklyClanWinners[dataM.userID].places[1]);
            _loc5_ = uint(dataM.weeklyClanWinners[dataM.userID].places[2]);
            _loc6_ = uint(dataM.weeklyClanWinners[dataM.userID].places[3]);
            if(_loc4_ > 0 || _loc5_ > 0 || _loc6_ > 0)
            {
               _loc1_ = getScreenText("clanWeeklyWins");
               if(_loc4_ > 0)
               {
                  _loc7_ = getScreenText("place1");
                  _loc7_ = dataM.replaceStringInText(_loc7_,"%PLACE%",_loc2_ + _loc4_ + _loc3_);
                  _loc1_ = _loc1_ + "<BR>   " + _loc7_;
               }
               if(_loc5_ > 0)
               {
                  _loc8_ = getScreenText("place2");
                  _loc8_ = dataM.replaceStringInText(_loc8_,"%PLACE%",_loc2_ + _loc5_ + _loc3_);
                  _loc1_ = _loc1_ + "<BR>   " + _loc8_;
               }
               if(_loc6_ > 0)
               {
                  _loc9_ = getScreenText("place3");
                  _loc9_ = dataM.replaceStringInText(_loc9_,"%PLACE%",_loc2_ + _loc6_ + _loc3_);
                  _loc1_ = _loc1_ + "<BR>   " + _loc9_;
               }
            }
         }
         if(_loc1_ != "")
         {
            tooltip.showToolTip("regularText",_loc1_,-1,-1);
         }
      }
      
      private function generalMouseOut(param1:MouseEvent) : void
      {
         tooltip.hideToolTip();
      }
      
      private function sparksHandler() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Sprite = null;
         var _loc7_:Sprite = null;
         var _loc8_:Sprite = null;
         if(this._medals.length > 0)
         {
            _loc2_ = 22 - (this._medals.length - 1);
            if(_loc2_ < 5)
            {
               _loc2_ = 5;
            }
            _loc3_ = Math.ceil(Math.random() * _loc2_);
            if(_loc3_ == 1)
            {
               _loc3_ = RandomUtils.chooseRandomIndex(this._medals);
               _loc6_ = this._medals[_loc3_];
               _loc4_ = _loc6_.x;
               _loc5_ = _loc6_.y + _loc6_.height - 10;
               _loc7_ = externalAssetsM.getAsset("general","Grp_itemBoxSpark",0,0,false,false);
               _loc7_.scaleX = 1.3;
               _loc7_.scaleY = 1.3;
               _loc7_.x = _loc4_ + Math.random() * 16 - 8;
               _loc7_.y = _loc5_ + Math.random() * 16 - 8;
               this.mcIconsHolder.addChild(_loc7_);
               this._sparks.push(_loc7_);
            }
         }
         _loc1_ = 0;
         while(_loc1_ < this._sparks.length)
         {
            _loc8_ = this._sparks[_loc1_];
            if(_loc8_.scaleX > 0.075)
            {
               _loc8_.scaleX -= 0.075;
               _loc8_.scaleY -= 0.075;
            }
            else
            {
               this._sparks[_loc1_].parent.removeChild(this._sparks[_loc1_]);
               this._sparks[_loc1_] = null;
               this._sparks.splice(_loc1_,1);
            }
            _loc1_++;
         }
      }
      
      public function backClicked() : void
      {
         screensM.screenNewMenu.mainMenu();
      }
      
      public function removeMe() : void
      {
         screensM.removeScreen("screenProfileInfo");
         this.removeMedals();
         if(dataM.runAsMobile == false)
         {
            this.mcSoloMedalsTooltip.removeEventListener(MouseEvent.MOUSE_OVER,this.soloMedalsMouseOver);
            this.mcSoloMedalsTooltip.removeEventListener(MouseEvent.MOUSE_OUT,this.generalMouseOut);
            this.mcSoloMedalsTooltip.removeEventListener(MouseEvent.MOUSE_UP,this.generalMouseOut);
            this.mcClanMedalsTooltip.removeEventListener(MouseEvent.MOUSE_OVER,this.clanMedalsMouseOver);
            this.mcClanMedalsTooltip.removeEventListener(MouseEvent.MOUSE_OUT,this.generalMouseOut);
            this.mcClanMedalsTooltip.removeEventListener(MouseEvent.MOUSE_UP,this.generalMouseOut);
         }
      }
   }
}

