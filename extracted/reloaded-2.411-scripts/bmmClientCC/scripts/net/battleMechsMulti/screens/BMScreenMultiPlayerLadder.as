package net.battleMechsMulti.screens
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMSpecialOffersManager;
   import net.battleMechsMulti.mobiles.BMMultiplayerLadderChatAlert;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.buttons.BMButton;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureH;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1108")]
   public class BMScreenMultiPlayerLadder extends BMBaseScreen
   {
      
      public var mcButtonsHolder:Sprite;
      
      public var txtTitle:TextField;
      
      public var txtPlayersInLobby:TextField;
      
      public var txtWinningWall:TextField;
      
      public var txtSearching:TextField;
      
      public var mcTutorialMarker_btnSearchForBattle:MovieClip;
      
      public var mcQuickMatchIcon:Sprite;
      
      public var mcSizer_btnSearchForBattle:Sprite;
      
      public var mcSizer_btnCancelSearch:Sprite;
      
      public var mcSizer_btnChatRoom:Sprite;
      
      public var mcSizer_btnRankingList:Sprite;
      
      public var mcSizer_btnClan:Sprite;
      
      public var mcSizer_btnReplays:Sprite;
      
      public var mcSizer_btnBack:Sprite;
      
      public var mcSizer_btnChangeMechsOrder:Sprite;
      
      public var mcSizer_SMTV:Sprite;
      
      public var mcSizer_chatAlert1:Sprite;
      
      public var mcSizer_chatAlertsHitArea:Sprite;
      
      public var mcChatAlert0Position:Sprite;
      
      public var mcChatAlert1Position:Sprite;
      
      public var mcChatAlert2Position:Sprite;
      
      public var mcChatAlert3Position:Sprite;
      
      public var mcChatAlert4Position:Sprite;
      
      public var mcChatAlert5Position:Sprite;
      
      public var mcSpecialOffersLocation:Sprite;
      
      public var btnSearchForBattle:BMButton_pictureH;
      
      public var btnCancelSearch:BMButton;
      
      public var btnChatRoom:BMButton_pictureE;
      
      public var btnRankingList:BMButton_pictureE;
      
      public var btnClan:BMButton_pictureE;
      
      public var btnReplays:BMButton_pictureE;
      
      public var btnBack:BMButton_pictureE;
      
      public var btnChangeMechsOrder:BMButton_pictureE;
      
      public var mcSandClock:MovieClip;
      
      private var _firstRefresh:Boolean = true;
      
      private var _searchingForBattleInProgress:Boolean = false;
      
      private var _btnChatRoomOriginalYPos:Number;
      
      public var chatAlerts:Array = new Array();
      
      private const CHAT_ALERT_X_JUMP:uint = 8;
      
      private const WINNING_WALL_MAX_MESSAGES:Number = 6;
      
      public function BMScreenMultiPlayerLadder()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
      }
      
      public function refreshScreen(param1:Boolean = true) : void
      {
         var _loc2_:Function = null;
         var _loc3_:Function = null;
         var _loc4_:Function = null;
         var _loc5_:Function = null;
         var _loc6_:Function = null;
         var _loc7_:Function = null;
         var _loc8_:Function = null;
         var _loc9_:Function = null;
         if(this._firstRefresh)
         {
            setLanguageManagerScreenName("multiplayerLadder");
            screensM.createButtonFromSizer("screenMultiPlayerLadder","btnSearchForBattle","pictureH");
            screensM.createButtonFromSizer("screenMultiPlayerLadder","btnCancelSearch","regular");
            screensM.createButtonFromSizer("screenMultiPlayerLadder","btnChatRoom","pictureE");
            screensM.createButtonFromSizer("screenMultiPlayerLadder","btnRankingList","pictureE");
            screensM.createButtonFromSizer("screenMultiPlayerLadder","btnReplays","pictureE");
            screensM.createButtonFromSizer("screenMultiPlayerLadder","btnClan","pictureE");
            screensM.createButtonFromSizer("screenMultiPlayerLadder","btnBack","pictureE");
            screensM.createButtonFromSizer("screenMultiPlayerLadder","btnChangeMechsOrder","pictureE");
            _loc2_ = this.backClicked;
            _loc3_ = this.searchForBattleClicked;
            _loc4_ = this.cancelSearchClicked;
            _loc5_ = this.chatRoomClicked;
            _loc6_ = this.rankingListClicked;
            _loc7_ = this.replaysClicked;
            _loc8_ = this.clanClicked;
            _loc9_ = this.changeMechsOrderClicked;
            if(dataM.runAsMobile)
            {
               _loc2_ = null;
               _loc3_ = null;
               _loc4_ = null;
               _loc5_ = null;
               _loc6_ = null;
               _loc7_ = null;
               _loc8_ = null;
               _loc9_ = null;
            }
            this.btnSearchForBattle.initialize("","",null,null,_loc3_,dataM.runAsMobile);
            this.btnCancelSearch.initialize(getGeneralText("cancel"),"blue",null,null,_loc4_,dataM.runAsMobile);
            this.btnChatRoom.initialize("","",externalAssetsM.getAsset("general","interface_chat"),null,_loc5_,dataM.runAsMobile);
            this.btnRankingList.initialize("","",externalAssetsM.getAsset("general","interface_menu_rankingList"),null,_loc6_,dataM.runAsMobile);
            this.btnReplays.initialize("","",externalAssetsM.getAsset("general","interface_replays"),null,_loc7_,dataM.runAsMobile);
            this.btnClan.initialize("","",externalAssetsM.getAsset("general","interface_clan"),null,_loc8_,dataM.runAsMobile);
            this.btnBack.initialize("","",externalAssetsM.getAsset("general","interface_back2"),null,_loc2_,dataM.runAsMobile);
            this.btnChangeMechsOrder.initialize("","",externalAssetsM.getAsset("general","interface_changeMechsOrder"),null,_loc9_,dataM.runAsMobile);
            if(dataM.myProfile.level < dataM.SECOND_MECH_UNLOCK_LEVEL)
            {
               this.btnChangeMechsOrder.disableMe();
            }
            else
            {
               this.btnChangeMechsOrder.enableMe();
            }
            if(!dataM.runAsMobile)
            {
               this.btnSearchForBattle.buttonCore.addMouseOverListerner(this.searchForBattleMouseOver);
               this.btnSearchForBattle.buttonCore.addMouseOutListerner(this.generalButtonMouseOut);
               this.btnCancelSearch.buttonCore.addMouseOverListerner(this.cancelSearchMouseOver);
               this.btnCancelSearch.buttonCore.addMouseOutListerner(this.generalButtonMouseOut);
               this.btnChatRoom.buttonCore.addMouseOverListerner(this.chatRoomMouseOver);
               this.btnChatRoom.buttonCore.addMouseOutListerner(this.generalButtonMouseOut);
               this.btnRankingList.buttonCore.addMouseOverListerner(this.rankingListMouseOver);
               this.btnRankingList.buttonCore.addMouseOutListerner(this.generalButtonMouseOut);
               this.btnReplays.buttonCore.addMouseOverListerner(this.replaysMouseOver);
               this.btnReplays.buttonCore.addMouseOutListerner(this.generalButtonMouseOut);
               this.btnClan.buttonCore.addMouseOverListerner(this.clanRoomMouseOver);
               this.btnClan.buttonCore.addMouseOutListerner(this.generalButtonMouseOut);
               this.btnChangeMechsOrder.buttonCore.addMouseOverListerner(this.changeMechsOrderMouseOver);
               this.btnChangeMechsOrder.buttonCore.addMouseOutListerner(this.generalButtonMouseOut);
               this.mcTutorialMarker_btnSearchForBattle.mouseEnabled = false;
               this.mcTutorialMarker_btnSearchForBattle.mouseChildren = false;
               this.mcQuickMatchIcon.mouseEnabled = false;
               this.mcQuickMatchIcon.mouseChildren = false;
            }
            this.btnSearchForBattle.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnCancelSearch.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnChatRoom.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnRankingList.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnReplays.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnClan.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnBack.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnChangeMechsOrder.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.languageUpdate();
            this.createWinningWallMobileBitmap();
            this._btnChatRoomOriginalYPos = this.btnChatRoom.y;
            this._firstRefresh = false;
         }
         else if(lastLanguageID != dataM.languageID)
         {
            this.languageUpdate(true);
         }
         if(param1)
         {
            remoteM.socketM.chat_enter(1);
         }
         this.refreshSpecialOffers();
         this.hideSearchForBattle();
         this.mcQuickMatchIcon.visible = true;
         this.btnSearchForBattle.visible = true;
         this.btnChatRoom.enableMe();
         this._searchingForBattleInProgress = false;
         this.refreshChatRoomFrame();
      }
      
      private function languageUpdate(param1:Boolean = false) : void
      {
         var _loc2_:uint = 0;
         _loc2_ = 33;
         switch(dataM.languageID)
         {
            case 5:
               _loc2_ = 28;
         }
         if(lastLanguageID != dataM.languageID)
         {
            lastLanguageID = dataM.languageID;
            TextUtils.updateTextFormat(this.txtPlayersInLobby,16);
            TextUtils.updateTextFormat(this.txtSearching,16);
            TextUtils.updateTextFormat(this.txtTitle,20);
            TextUtils.updateTextFormat(this.txtWinningWall,16);
            TextUtils.updateTextFormat(this.btnCancelSearch.txtButtonName,_loc2_);
            param1 = true;
         }
         if(param1)
         {
            this.btnCancelSearch.changeFontSize(_loc2_);
            this.btnCancelSearch.setButtonName(getGeneralText("cancel"));
         }
         this.txtTitle.text = getScreenText("title");
         this.txtWinningWall.text = "";
         this.refreshPlayersInLobbyText();
      }
      
      public function createWinningWallMobileBitmap() : void
      {
         if(dataM.runAsMobile)
         {
            screensM.createTextBitmap("multiplayerLadder_txtWinningWall",this.txtWinningWall," ",this);
         }
      }
      
      public function addWinningWallMessage(param1:String, param2:Boolean = false) : void
      {
         var _loc3_:uint = 0;
         if(this.txtWinningWall.numLines > this.WINNING_WALL_MAX_MESSAGES && dataM.chat_winningWallTexts.length > this.WINNING_WALL_MAX_MESSAGES)
         {
            this.txtWinningWall.htmlText = "";
            _loc3_ = dataM.chat_winningWallTexts.length - this.WINNING_WALL_MAX_MESSAGES - 1;
            while(_loc3_ < dataM.chat_winningWallTexts.length)
            {
               this.txtWinningWall.htmlText = TextUtils.getTextFont() + this.txtWinningWall.htmlText + dataM.chat_winningWallTexts[_loc3_].winningWallText;
               _loc3_++;
            }
         }
         else
         {
            this.txtWinningWall.htmlText = TextUtils.getTextFont() + this.txtWinningWall.htmlText + param1;
         }
         this.txtWinningWall.scrollV = this.txtWinningWall.maxScrollV;
         this.createWinningWallMobileBitmap();
      }
      
      public function refreshPlayersInLobbyText() : void
      {
         var _loc1_:String = getScreenText("playersInLobby");
         _loc1_ = dataM.replaceStringInText(_loc1_,"%PLAYERS%",String(dataM.chat_totalPlayersInLobby));
         this.txtPlayersInLobby.text = _loc1_;
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("menuMultiPlayerLadder_txtPlayersInLobby",[this.txtPlayersInLobby],"",this);
         }
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(parent != null)
         {
            this.chatAlertsHandler();
         }
      }
      
      public function searchForBattleClicked() : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:uint = 0;
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(_loc1_.level >= dataM.SECOND_MECH_UNLOCK_LEVEL)
         {
            _loc2_ = false;
            if(screensM.isScreenOpened("screenSelectBattleMechsPerPlayer"))
            {
               if(screensM.screenSelectBattleMechsPerPlayer.getBattleType() == "ladder")
               {
                  _loc2_ = true;
               }
            }
            if(_loc2_)
            {
               screensM.screenSelectBattleMechsPerPlayer.closeScreen();
            }
            else
            {
               screensM.addScreen("screenSelectBattleMechsPerPlayer");
               _loc3_ = 2;
               if(_loc1_.level >= dataM.levelRequired3V3)
               {
                  _loc3_ = 3;
               }
               screensM.screenSelectBattleMechsPerPlayer.refreshScreen(_loc3_);
               screensM.screenSelectBattleMechsPerPlayer.x = this.btnSearchForBattle.x + this.btnSearchForBattle.width + 6;
               screensM.screenSelectBattleMechsPerPlayer.y = this.btnSearchForBattle.y - 2;
            }
         }
         else
         {
            this.battleMechsPerPlayerSelected(1);
         }
         this.mcTutorialMarker_btnSearchForBattle.gotoAndStop("animOff");
         tooltip.hideToolTip();
      }
      
      public function battleMechsPerPlayerSelected(param1:uint) : void
      {
         var _loc2_:Array = null;
         var _loc3_:uint = 0;
         var _loc4_:BMPlayerProfile = null;
         if(dataM.isMechReadyForBattle(false,param1))
         {
            _loc2_ = new Array();
            _loc3_ = 1;
            while(_loc3_ <= param1)
            {
               _loc2_.push(_loc3_);
               _loc3_++;
            }
            if(dataM.mechIsOverWeight(_loc2_))
            {
               screensM.screenConfirmation.displayQuestionOrNotification("weightBlock",-1,-1);
            }
            else
            {
               _loc4_ = dataM["player" + dataM.player1PlayerID + "Profile"];
               _loc4_.updateLevelByItems();
               dataM.battleMechsPerPlayer = param1;
               remoteM.lobby_searchForBattle(dataM.battleMechsPerPlayer);
               this.disableAllButtons();
               this.mcQuickMatchIcon.visible = false;
               this.btnSearchForBattle.visible = false;
               this.btnChatRoom.disableMe();
               this._searchingForBattleInProgress = true;
               if(screensM.isScreenOpened("screenSpecialOffers"))
               {
                  screensM.screenSpecialOffers.disableMe();
               }
            }
         }
         else
         {
            screensM.screenConfirmation.displayQuestionOrNotification("mechIsNotReady",-1,-1);
         }
      }
      
      public function findBattleSuccess() : void
      {
         if(dataM.runAsMobile)
         {
            screensM.screenBlack.activateBlackScreen(this.findBattleSuccessSub,true,true,null,0);
         }
         else
         {
            this.findBattleSuccessSub();
         }
      }
      
      private function findBattleSuccessSub() : void
      {
         screensM.addBattleScreens();
         screensM.screenTopBar.enableButtons("screenMultiPlayerLadder findBattleSuccess");
         screensM.screenNewMenu.removeCurrentScreen();
         screensM.screenNewMenu.removeMe();
         screensM.removeScreen("screenConfirmation");
      }
      
      public function searchingForBattleInProgress() : Boolean
      {
         return this._searchingForBattleInProgress;
      }
      
      public function searchForBattleSuccess() : void
      {
         this.showSearchForBattle();
      }
      
      private function hideSearchForBattle() : void
      {
         this.btnCancelSearch.visible = false;
         this.txtSearching.text = "";
         this.mcSandClock.gotoAndStop("animOff");
         if(screensM.isScreenOpened("screenSpecialOffers"))
         {
            screensM.screenSpecialOffers.enableMe();
         }
      }
      
      private function showSearchForBattle() : void
      {
         this.btnCancelSearch.visible = true;
         this.btnCancelSearch.enableMe();
         this.txtSearching.text = getScreenText("searching");
         this.mcSandClock.gotoAndStop("animOn");
      }
      
      public function cancelSearchClicked() : void
      {
         remoteM.lobby_cancelSearchForBattle();
         this.btnCancelSearch.disableMe();
      }
      
      public function cancelSearchForBattleSuccess() : void
      {
         this.enableAllButtons();
         this.hideSearchForBattle();
         this.mcQuickMatchIcon.visible = true;
         this.btnSearchForBattle.visible = true;
         this.btnChatRoom.enableMe();
         this._searchingForBattleInProgress = false;
      }
      
      public function refreshSpecialOffers() : void
      {
         dataM.starterPack_goBackToScreen = "multiplayerLadder";
         BMSpecialOffersManager.gi().showBigBanner(this.mcSpecialOffersLocation,1.114);
         if(BMSpecialOffersManager.gi().hasSpecialOffers() == false)
         {
            if(screensM.isScreenOpened("screenSMTV") == false)
            {
               screensM.addScreen("screenSMTV",false);
               screensM.screenSMTV.addMe("multiplayerLadder");
               screensM.screenSMTV.refreshWatchReplay();
            }
         }
         else if(screensM.isScreenOpened("screenSMTV"))
         {
            screensM.screenSMTV.removeMe();
         }
      }
      
      private function disableAllButtons() : void
      {
         screensM.screenTopBar.disableButtons();
      }
      
      private function enableAllButtons() : void
      {
         screensM.screenTopBar.enableButtons("screenMultiPlayerLadder enableAllButtons");
      }
      
      private function refreshChatRoomFrame() : void
      {
         if(this.chatAlerts.length > 0)
         {
            this.btnChatRoom.y = this._btnChatRoomOriginalYPos - 30;
            this.btnRankingList.y = this._btnChatRoomOriginalYPos - 30;
            this.btnClan.y = this._btnChatRoomOriginalYPos - 30;
            this.btnReplays.y = this._btnChatRoomOriginalYPos - 30;
            this.btnChangeMechsOrder.y = this._btnChatRoomOriginalYPos - 30;
         }
         else
         {
            this.btnChatRoom.y = this._btnChatRoomOriginalYPos;
            this.btnRankingList.y = this._btnChatRoomOriginalYPos;
            this.btnClan.y = this._btnChatRoomOriginalYPos;
            this.btnReplays.y = this._btnChatRoomOriginalYPos;
            this.btnChangeMechsOrder.y = this._btnChatRoomOriginalYPos;
         }
      }
      
      public function addChatAlert(param1:String, param2:Number, param3:String, param4:Number, param5:String, param6:uint) : void
      {
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:BMMultiplayerLadderChatAlert = null;
         var _loc7_:BMMultiplayerLadderChatAlert = new BMMultiplayerLadderChatAlert();
         var _loc8_:uint = this.chatAlerts.length + 1;
         if(_loc8_ >= 5)
         {
            _loc8_ = 5;
         }
         _loc7_.initialize(param1,param2,param3,param4,param5,param6,_loc8_);
         soundM.createSound("messagePop",1);
         _loc7_.x = this["mcChatAlert" + _loc8_ + "Position"].x;
         _loc7_.y = this["mcChatAlert" + _loc8_ + "Position"].y;
         _loc7_.scaleX = 0.2;
         _loc7_.scaleY = 0.2;
         this.mcButtonsHolder.addChild(_loc7_);
         this.chatAlerts.push(_loc7_);
         if(this.chatAlerts.length == 1)
         {
            this.refreshChatRoomFrame();
         }
         else if(this.chatAlerts.length > 5)
         {
            _loc9_ = this.chatAlerts.length - 5;
            _loc10_ = 0;
            while(_loc10_ < this.chatAlerts.length)
            {
               _loc11_ = this.chatAlerts[_loc10_];
               if(_loc10_ < _loc9_)
               {
                  _loc11_.targetSlot = 0;
                  _loc11_.animationStatus = "disappear";
               }
               else
               {
                  _loc11_.targetSlot = 5 + 1 - (this.chatAlerts.length - _loc10_);
               }
               _loc10_++;
            }
         }
      }
      
      public function chatAlertClicked(param1:String, param2:Number, param3:Number, param4:uint) : void
      {
         if(screensM.screenMultiPlayerLadder.searchingForBattleInProgress())
         {
            screensM.screenConfirmation.displayQuestionOrNotification("mustExitSearchForBattle",-1,-1);
         }
         else
         {
            switch(param1)
            {
               case "message_regular":
                  dataM.chat_goToSpecificPlayerChatPlayerID = param2;
                  break;
               case "message_clan":
                  dataM.chat_goToClanChat = true;
                  break;
               case "battleInvitation":
               case "clanInvitation":
                  dataM.chat_goToInspectPlayerID = param2;
            }
            this.chatRoomClicked();
         }
      }
      
      private function chatAlertsHandler() : void
      {
         var _loc4_:BMMultiplayerLadderChatAlert = null;
         var _loc5_:Number = NaN;
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         while(_loc2_ < this.chatAlerts.length)
         {
            _loc4_ = this.chatAlerts[_loc2_];
            switch(_loc4_.animationStatus)
            {
               case "appear1":
                  _loc4_.scaleX += 0.2;
                  _loc4_.scaleY += 0.2;
                  if(_loc4_.scaleX >= 1.3)
                  {
                     _loc4_.scaleX = 1;
                     _loc4_.scaleY = 1;
                     _loc4_.animationStatus = "appear2";
                  }
                  break;
               case "appear2":
                  _loc4_.scaleX -= 0.1;
                  _loc4_.scaleY -= 0.1;
                  if(_loc4_.scaleX <= 1)
                  {
                     _loc4_.scaleX = 1;
                     _loc4_.scaleY = 1;
                     _loc4_.animationStatus = "none";
                  }
                  break;
               case "disappear":
                  _loc4_.scaleX -= 0.2;
                  _loc4_.scaleY -= 0.2;
                  if(_loc4_.scaleX < 0.2)
                  {
                     _loc4_.visible = false;
                     _loc4_.animationStatus = "none";
                  }
                  break;
               case "none":
            }
            if(_loc4_.currentSlot != _loc4_.targetSlot)
            {
               _loc5_ = _loc4_.x - this["mcChatAlert" + _loc4_.targetSlot + "Position"].x;
               if(Math.abs(_loc5_) <= 1)
               {
                  _loc4_.x = this["mcChatAlert" + _loc4_.targetSlot + "Position"].x;
                  _loc4_.currentSlot = _loc4_.targetSlot;
                  if(_loc4_.currentSlot == 0)
                  {
                     _loc1_++;
                  }
               }
               else
               {
                  _loc4_.x -= _loc5_ * 0.3;
               }
            }
            _loc2_++;
         }
         var _loc3_:uint = 0;
         while(_loc3_ < _loc1_)
         {
            this.chatAlerts[0].parent.removeChild(this.chatAlerts[0]);
            this.chatAlerts[0] = null;
            this.chatAlerts.splice(0,1);
            _loc3_++;
         }
      }
      
      private function removeChatAlerts() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < this.chatAlerts.length)
         {
            this.chatAlerts[_loc1_].parent.removeChild(this.chatAlerts[_loc1_]);
            this.chatAlerts[_loc1_] = null;
            _loc1_++;
         }
         this.chatAlerts = new Array();
      }
      
      public function chatRoomClicked() : void
      {
         screensM.screenNewMenu.multiplayerChatClicked();
      }
      
      public function rankingListClicked() : void
      {
         screensM.screenNewMenu.communityRankingListClicked();
      }
      
      public function clanClicked() : void
      {
         screensM.screenNewMenu.communityClanClicked();
      }
      
      public function replaysClicked() : void
      {
         screensM.screenNewMenu.profileReplaysClicked();
      }
      
      public function backClicked() : void
      {
         screensM.screenNewMenu.mainMenu();
      }
      
      public function changeMechsOrderClicked() : void
      {
         screensM.addScreen("screenChangeMechsOrder");
         screensM.screenChangeMechsOrder.refreshScreen();
      }
      
      private function searchForBattleMouseOver() : void
      {
         tooltip.showToolTip("regularText",getScreenText("battle"),-1,-1);
      }
      
      private function cancelSearchMouseOver() : void
      {
         tooltip.showToolTip("regularText",getScreenText("cancelSearch"),-1,-1);
      }
      
      private function chatRoomMouseOver() : void
      {
         tooltip.showToolTip("regularText",getScreenText("goToChat"),-1,-1);
      }
      
      private function rankingListMouseOver() : void
      {
         tooltip.showToolTip("regularText",getSpecificText("newMenu_rankingList"));
      }
      
      private function replaysMouseOver() : void
      {
         tooltip.showToolTip("regularText",getSpecificText("newMenu_replays"));
      }
      
      private function clanRoomMouseOver() : void
      {
         tooltip.showToolTip("regularText",getSpecificText("newMenu_clan"));
      }
      
      private function changeMechsOrderMouseOver() : void
      {
         tooltip.showToolTip("regularText",getGeneralText("changeMechsOrder"));
      }
      
      private function generalButtonMouseOut() : void
      {
         tooltip.hideToolTip();
      }
      
      public function removeMe() : void
      {
         if(screensM.isScreenOpened("screenSelectBattleMechsPerPlayer"))
         {
            screensM.screenSelectBattleMechsPerPlayer.removeMe();
         }
         BMSpecialOffersManager.gi().removeSpecialOffer();
         if(screensM.isScreenOpened("screenYouTubeVidsGuide"))
         {
            screensM.screenYouTubeVidsGuide.removeMe();
         }
         if(screensM.isScreenOpened("screenSMTV"))
         {
            screensM.screenSMTV.removeMe();
         }
         this.removeChatAlerts();
         tooltip.hideToolTip();
         this.mcTutorialMarker_btnSearchForBattle.gotoAndStop("animOff");
         this.mcSandClock.gotoAndStop("animOff");
         screensM.removeScreen("screenMultiPlayerLadder");
      }
      
      override public function notifyClientDataReloaded() : *
      {
         this.cancelSearchForBattleSuccess();
         this.refreshScreen(true);
      }
      
      public function handleSearchForBattleFailed() : *
      {
         this.cancelSearchForBattleSuccess();
         this.refreshScreen(true);
         screensM.screenConfirmation.displayCustomMessage("Could not search for battle, please try again");
      }
   }
}

