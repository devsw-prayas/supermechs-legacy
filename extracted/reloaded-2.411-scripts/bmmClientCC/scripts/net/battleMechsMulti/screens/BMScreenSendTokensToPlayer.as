package net.battleMechsMulti.screens
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import net.battleMechsMulti.mobiles.BMAvatarImage;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.buttons.BMButton;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol734")]
   public class BMScreenSendTokensToPlayer extends BMBaseScreen
   {
      
      public var mcTextHolder:Sprite;
      
      public var mcButtonsHolder:Sprite;
      
      public var mcIconsHolder:Sprite;
      
      public var mcSizer_btnBack:Sprite;
      
      public var mcSizer_btnSend:Sprite;
      
      public var mcSizer_btnSearchPlayer:Sprite;
      
      public var mcSizer_rank:Sprite;
      
      public var mcSizer_flag:Sprite;
      
      public var mcFrame_playerID:Sprite;
      
      public var mcFrame_tokens:Sprite;
      
      public var mcTokens:Sprite;
      
      public var btnBack:BMButton_pictureE;
      
      public var btnSend:BMButton;
      
      public var btnSearchPlayer:BMButton_pictureE;
      
      public var txtTitle:TextField;
      
      public var txtName:TextField;
      
      public var txtInsertPlayerID:TextField;
      
      public var txtTokensAmountError:TextField;
      
      public var txtMySupporterTokens:TextField;
      
      public var txtInputPlayerID:TextField;
      
      public var txtInputTokens:TextField;
      
      private var mcFlag:BMAvatarImage;
      
      private var mcRank:Sprite;
      
      private var _firstRefresh:Boolean = true;
      
      private var _lastTokensStatus:String = "ok";
      
      private var _searchPlayerData:Object = new Object();
      
      private var _targetPlayerID:Number;
      
      public function BMScreenSendTokensToPlayer()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
      }
      
      public function refreshScreen() : void
      {
         var _loc1_:Function = null;
         var _loc2_:Function = null;
         var _loc3_:Function = null;
         if(this._firstRefresh)
         {
            setLanguageManagerScreenName("sendTokensToPlayer");
            screensM.createButtonFromSizer("screenSendTokensToPlayer","btnBack","pictureE");
            screensM.createButtonFromSizer("screenSendTokensToPlayer","btnSend","regular");
            screensM.createButtonFromSizer("screenSendTokensToPlayer","btnSearchPlayer","pictureE");
            _loc1_ = this.backClicked;
            _loc2_ = this.sendTokensClicked;
            _loc3_ = this.searchPlayerClicked;
            if(dataM.runAsMobile)
            {
               _loc1_ = null;
               _loc2_ = null;
               _loc3_ = null;
            }
            this.btnBack.initialize("","",externalAssetsM.getAsset("general","interface_cancel"),null,_loc1_,dataM.runAsMobile);
            this.btnSend.initialize(getScreenText("send"),"green",null,null,_loc2_,dataM.runAsMobile);
            this.btnSearchPlayer.initialize("","",externalAssetsM.getAsset("general","interface_inspect"),null,_loc3_,dataM.runAsMobile);
            this.btnBack.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnSend.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnSearchPlayer.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.txtInputPlayerID.restrict = "0123456789";
            this.txtInputTokens.restrict = "0123456789";
            this.languageUpdate();
            this._firstRefresh = false;
         }
         else if(lastLanguageID != dataM.languageID)
         {
            this.languageUpdate(true);
         }
         this.txtInputTokens.addEventListener(Event.CHANGE,this.inputTokensChange);
         this.inputTokensChangeSub();
         this.removeRank();
         this.removeFlag();
         this.mcFrame_playerID.visible = true;
         this.mcFrame_tokens.visible = false;
         this.txtInputPlayerID.visible = true;
         this.txtInsertPlayerID.text = getScreenText("insertPlayerID");
         this.txtInputTokens.visible = false;
         this.txtName.text = "";
         this.txtTokensAmountError.text = "";
         this.txtMySupporterTokens.text = "";
         this.btnSearchPlayer.visible = true;
         this.btnSend.visible = false;
         this.mcTokens.visible = false;
         this.refreshTextsForMobile();
      }
      
      private function languageUpdate(param1:Boolean = false) : void
      {
         if(lastLanguageID != dataM.languageID)
         {
            lastLanguageID = dataM.languageID;
            TextUtils.updateTextFormat(this.txtInsertPlayerID,20);
            TextUtils.updateTextFormat(this.txtMySupporterTokens,20);
            TextUtils.updateTextFormat(this.txtName,20);
            TextUtils.updateTextFormat(this.txtTitle,20);
            TextUtils.updateTextFormat(this.txtTokensAmountError,20);
            TextUtils.updateTextFormat(this.txtInputPlayerID,25);
            TextUtils.updateTextFormat(this.txtInputTokens,25);
            TextUtils.updateTextFormat(this.btnSend.txtButtonName,33);
            param1 = true;
         }
         this.btnSend.setButtonName(getScreenText("send"));
         this.txtTitle.text = getScreenText("title");
      }
      
      public function backClicked() : void
      {
         this.removeMe();
      }
      
      private function refreshTextsForMobile() : void
      {
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("sendTokensToPlayer_texts",[this.txtTitle,this.txtName,this.txtInsertPlayerID,this.txtTokensAmountError,this.txtMySupporterTokens],"",this.mcTextHolder);
         }
      }
      
      public function sendTokensClicked() : void
      {
         screensM.screenConfirmation.displayQuestionOrNotification("sendTokens",int(this.txtInputTokens.text));
      }
      
      public function sendTokensAccepted() : void
      {
         remoteM.socketM.tokens_sendToPlayerID(this._targetPlayerID,int(this.txtInputTokens.text));
      }
      
      public function sendTokensSuccess() : void
      {
         var _loc1_:Object = this._searchPlayerData[this._targetPlayerID];
         this.gotPlayerData(this._targetPlayerID,_loc1_.name,_loc1_.level,_loc1_.ladderProgress,_loc1_.geo);
         screensM.screenConfirmation.displayQuestionOrNotification("tokensSent");
      }
      
      public function searchPlayerClicked() : void
      {
         var _loc2_:Object = null;
         var _loc1_:Number = int(this.txtInputPlayerID.text);
         if(_loc1_ > 1000 && _loc1_ != dataM.userID)
         {
            TsLogger.log(this._searchPlayerData[_loc1_] + " " + _loc1_);
            if(this._searchPlayerData[_loc1_] == null)
            {
               remoteM.socketM.lobby_getPlayerData(_loc1_);
               screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
            }
            else if(this._searchPlayerData[_loc1_] == false)
            {
               screensM.screenConfirmation.displayQuestionOrNotification("playerDoesNotExist",-1,-1);
            }
            else
            {
               _loc2_ = this._searchPlayerData[_loc1_];
               this.gotPlayerData(_loc1_,_loc2_.name,_loc2_.level,_loc2_.ladderProgress,_loc2_.geo);
            }
         }
      }
      
      public function gotPlayerData(param1:Number, param2:String, param3:uint, param4:uint, param5:String) : void
      {
         var _loc6_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         this._targetPlayerID = param1;
         screensM.removeScreen("screenConfirmation");
         this._searchPlayerData[this._targetPlayerID] = {
            "name":param2,
            "level":param3,
            "ladderProgress":param4,
            "geo":param5
         };
         this.txtName.text = dataM.getCensoredString(param2);
         this.removeRank();
         var _loc7_:uint = dataM.getLadderRankIconNumber(dataM.getLadderRankByProgress(param4));
         this.mcRank = externalAssetsM.getAsset("general","Grp_rank" + _loc7_,this.mcSizer_rank.width,this.mcSizer_rank.height,false,false);
         this.mcRank.x = this.mcSizer_rank.x;
         this.mcRank.y = this.mcSizer_rank.y;
         this.mcIconsHolder.addChild(this.mcRank);
         var _loc8_:Boolean = false;
         if(param5 != null && param5 != "")
         {
            _loc8_ = true;
         }
         if(_loc8_)
         {
            this.mcFlag = dataM.getAvatarImage(param5);
            this.mcFlag.x = this.mcSizer_flag.x;
            this.mcFlag.y = this.mcSizer_flag.y;
            this.mcFlag.width = this.mcSizer_flag.width;
            this.mcFlag.height = this.mcSizer_flag.height;
            this.mcIconsHolder.addChild(this.mcFlag);
         }
         this.mcFrame_playerID.visible = false;
         this.mcFrame_tokens.visible = true;
         this.txtInputPlayerID.visible = false;
         this.txtInsertPlayerID.text = "";
         this.txtInputTokens.visible = true;
         this.txtInputTokens.text = "50";
         var _loc9_:String = getScreenText("myTokens");
         _loc9_ = dataM.replaceStringInText(_loc9_,"%AMOUNT%","<FONT COLOR=\'#" + dataM.COLOR_LEGENDARY_ITEM + "\'>" + _loc6_.tokens_supporter + "</FONT>");
         this.txtMySupporterTokens.htmlText = TextUtils.getTextFont(20) + _loc9_;
         this.btnSearchPlayer.visible = false;
         this.mcTokens.visible = true;
         this.inputTokensChangeSub();
         this.refreshTextsForMobile();
      }
      
      private function removeRank() : void
      {
         if(this.mcRank != null)
         {
            this.mcRank.parent.removeChild(this.mcRank);
            this.mcRank = null;
         }
      }
      
      private function removeFlag() : void
      {
         if(this.mcFlag != null)
         {
            this.mcFlag.removeMe();
            this.mcFlag = null;
         }
      }
      
      public function playerDoesNotExist() : void
      {
         var _loc1_:Number = int(this.txtInputPlayerID.text);
         this._searchPlayerData[_loc1_] = false;
      }
      
      private function inputTokensChange(param1:Event) : void
      {
         this.inputTokensChangeSub();
      }
      
      private function inputTokensChangeSub() : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(int(this.txtInputTokens.text) < dataM.sendTokens_minTokensToSend)
         {
            this._lastTokensStatus = "belowMin";
            _loc2_ = getScreenText("minimumTokens");
            _loc2_ = dataM.replaceStringInText(_loc2_,"%AMOUNT%",String(dataM.sendTokens_minTokensToSend));
            this.txtTokensAmountError.htmlText = TextUtils.getTextFont(20) + _loc2_;
            this.btnSend.visible = false;
         }
         else if(int(this.txtInputTokens.text) > _loc1_.tokens_supporter)
         {
            this._lastTokensStatus = "aboveMax";
            _loc3_ = getScreenText("notEnoughTokens");
            _loc3_ = dataM.replaceStringInText(_loc3_,"%AMOUNT%",String(_loc1_.tokens_supporter));
            this.txtTokensAmountError.htmlText = TextUtils.getTextFont(20) + _loc3_;
            this.btnSend.visible = false;
         }
         else
         {
            this._lastTokensStatus = "ok";
            this.txtTokensAmountError.text = "";
            this.btnSend.visible = true;
         }
      }
      
      public function removeMe() : void
      {
         this.txtInputTokens.removeEventListener(Event.CHANGE,this.inputTokensChange);
         screensM.removeScreen("screenSendTokensToPlayer");
      }
   }
}

