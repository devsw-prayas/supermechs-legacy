package net.battleMechsMulti.screens
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.battleMechsMulti.data.BattleTypeResolver;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.mobiles.BMPlayerData;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.buttons.BMButtonEmote;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureI;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3802")]
   public class BMScreenBattleInterfaceEmotes extends BMBaseScreen
   {
      
      public var mcButtonsHolder:Sprite;
      
      public var mcBackground:Sprite;
      
      public var txtChatInput:TextField;
      
      public var mcSizer_btnChatEnable:Sprite;
      
      public var mcSizer_btnChatDisable:Sprite;
      
      public var mcSizer_btnSendMessage:Sprite;
      
      public var mcSizer_btnEmote1:Sprite;
      
      public var mcSizer_btnEmote2:Sprite;
      
      public var mcSizer_btnEmote3:Sprite;
      
      public var mcSizer_btnEmote4:Sprite;
      
      public var mcSizer_btnEmote5:Sprite;
      
      public var mcSizer_btnEmote6:Sprite;
      
      public var mcSizer_btnEmote7:Sprite;
      
      public var mcSizer_btnEmote8:Sprite;
      
      public var btnEmote1:BMButtonEmote;
      
      public var btnEmote2:BMButtonEmote;
      
      public var btnEmote3:BMButtonEmote;
      
      public var btnEmote4:BMButtonEmote;
      
      public var btnEmote5:BMButtonEmote;
      
      public var btnEmote6:BMButtonEmote;
      
      public var btnEmote7:BMButtonEmote;
      
      public var btnEmote8:BMButtonEmote;
      
      public var btnSendMessage:BMButton_pictureI;
      
      public var btnChatEnable:BMButton_pictureI;
      
      public var btnChatDisable:BMButton_pictureI;
      
      public var mcSandClock:MovieClip;
      
      private var _firestRefresh:Boolean = true;
      
      private var _buttonPictures:Array = new Array();
      
      private var _emoteCooldown:uint;
      
      private var _screenStatus:String;
      
      private var _sendMessageCooldown:Number;
      
      private const EXIT_Y_POS:Number = -150;
      
      private var EMOTE_COOLDOWN:uint = 200;
      
      public const TOTAL_EMOTES:uint = 8;
      
      private const SEND_MESSAGE_COOLDOWN:uint = 60;
      
      public function BMScreenBattleInterfaceEmotes()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("battleInterfaceBottom");
         this.txtChatInput.restrict = "^<>&";
      }
      
      public function refreshScreen() : void
      {
         var _loc1_:Function = null;
         var _loc2_:Function = null;
         var _loc3_:Function = null;
         var _loc4_:uint = 0;
         var _loc5_:Function = null;
         var _loc6_:Function = null;
         var _loc7_:Function = null;
         if(this._firestRefresh)
         {
            this._buttonPictures[1] = "welcome";
            this._buttonPictures[2] = "wellPlayed";
            this._buttonPictures[3] = "happy";
            this._buttonPictures[4] = "showOff";
            this._buttonPictures[5] = "bored";
            this._buttonPictures[6] = "angry";
            this._buttonPictures[7] = "tease";
            this._buttonPictures[8] = "threaten";
            _loc1_ = this.emoteClicked;
            _loc2_ = this.emoteMouseOver;
            _loc3_ = this.emoteMouseOut;
            _loc4_ = 1;
            while(_loc4_ <= this.TOTAL_EMOTES)
            {
               screensM.createButtonFromSizer(BMScreensManager.SCR_BATTLE_INTERFACE_EMOTES,"btnEmote" + _loc4_,"emote");
               this["btnEmote" + _loc4_].initialize("",_loc4_,_loc1_,_loc2_,_loc3_,dataM.runAsMobile);
               this["btnEmote" + _loc4_].setPicture(externalAssetsM.getAsset("general","emote_" + this._buttonPictures[_loc4_]));
               _loc4_++;
            }
            screensM.createButtonFromSizer(BMScreensManager.SCR_BATTLE_INTERFACE_EMOTES,"btnChatEnable","pictureI");
            screensM.createButtonFromSizer(BMScreensManager.SCR_BATTLE_INTERFACE_EMOTES,"btnChatDisable","pictureI");
            screensM.createButtonFromSizer(BMScreensManager.SCR_BATTLE_INTERFACE_EMOTES,"btnSendMessage","pictureI");
            _loc5_ = this.chatEnableClicked;
            _loc6_ = this.chatDisableClicked;
            _loc7_ = this.sendChatMessageClicked;
            if(dataM.runAsMobile)
            {
               _loc7_ = null;
            }
            this.btnChatEnable.initialize("","",externalAssetsM.getAsset("general","interface_chatUnBlock"),null,_loc5_,dataM.runAsMobile);
            this.btnChatDisable.initialize("","",externalAssetsM.getAsset("general","interface_chatBlock"),null,_loc6_,dataM.runAsMobile);
            this.btnSendMessage.initialize("","",externalAssetsM.getAsset("general","interface_chat"),null,_loc7_,dataM.runAsMobile);
            this._firestRefresh = false;
         }
         if(dataM.clientRunningLocally || dataM.specialUser)
         {
         }
         this._emoteCooldown = this.EMOTE_COOLDOWN;
         this._screenStatus = "closed";
         y = this.EXIT_Y_POS;
         this.txtChatInput.text = "";
         this._sendMessageCooldown = 0;
         this.refreshSendMessageButton();
         this.refreshChatEnableDisableButtons();
      }
      
      public function onEnterFrameTrigger() : void
      {
         ++this._emoteCooldown;
         if(parent != null)
         {
            if(this._emoteCooldown == this.EMOTE_COOLDOWN)
            {
               this.refreshEmoteButtons();
               this.hideSandClock();
            }
            this.openCloseHandler();
            if(this._sendMessageCooldown > 0)
            {
               --this._sendMessageCooldown;
               if(this._sendMessageCooldown == 0)
               {
                  this.refreshSendMessageButton();
               }
            }
         }
      }
      
      private function openCloseHandler() : void
      {
         switch(this._screenStatus)
         {
            case "opening":
               if(y < -1)
               {
                  y += Math.abs(y * 0.3);
               }
               else
               {
                  y = 0;
                  if(screensM.screenBattleInterfaceEmotes.parent != null)
                  {
                     screensM.screenBattleInterfaceEmotes.parent.removeChild(screensM.screenBattleInterfaceEmotes);
                  }
                  screensM.screenBattleInterfaceTop.addChild(screensM.screenBattleInterfaceEmotes);
                  this._screenStatus = "opened";
               }
               break;
            case "closing":
               if(y > this.EXIT_Y_POS + 1)
               {
                  y -= (y - this.EXIT_Y_POS) * 0.3;
               }
               else
               {
                  y = this.EXIT_Y_POS;
                  this.removeMe();
                  this._screenStatus = "closed";
               }
               break;
            case "opened":
            case "closed":
         }
      }
      
      public function openMe() : void
      {
         if(this._screenStatus == "closed")
         {
            if(screensM.screenBattleInterfaceEmotes.parent != null)
            {
               screensM.screenBattleInterfaceEmotes.parent.removeChild(screensM.screenBattleInterfaceEmotes);
            }
            screensM.screenBattleInterfaceTop.mcEmotesAnimationHolder.addChild(screensM.screenBattleInterfaceEmotes);
            if(this._emoteCooldown >= this.EMOTE_COOLDOWN)
            {
               this.hideSandClock();
            }
            else
            {
               this.showSandClock();
            }
            this.refreshEmoteButtons();
            this._screenStatus = "opening";
         }
      }
      
      public function closeMe() : void
      {
         if(this._screenStatus == "opened")
         {
            this._screenStatus = "closing";
            if(screensM.screenBattleInterfaceEmotes.parent != null)
            {
               screensM.screenBattleInterfaceEmotes.parent.removeChild(screensM.screenBattleInterfaceEmotes);
            }
            screensM.screenBattleInterfaceTop.mcEmotesAnimationHolder.addChild(screensM.screenBattleInterfaceEmotes);
         }
      }
      
      public function getStatus() : String
      {
         return this._screenStatus;
      }
      
      public function chatDisableClicked() : void
      {
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         _loc1_.allowBattleChatMessages = false;
         this.refreshEmoteButtons();
         this.refreshChatEnableDisableButtons();
         this.refreshSendMessageButton();
      }
      
      public function chatEnableClicked() : void
      {
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         _loc1_.allowBattleChatMessages = true;
         this.refreshEmoteButtons();
         this.refreshChatEnableDisableButtons();
         this.refreshSendMessageButton();
      }
      
      private function refreshChatEnableDisableButtons() : void
      {
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(_loc1_.allowBattleChatMessages)
         {
            this.btnChatEnable.visible = false;
            this.btnChatDisable.visible = true;
         }
         else
         {
            this.btnChatEnable.visible = true;
            this.btnChatDisable.visible = false;
         }
      }
      
      public function refreshSendMessageButton() : void
      {
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(_loc1_.allowBattleChatMessages)
         {
            if(this._sendMessageCooldown == 0)
            {
               this.btnSendMessage.enableMe();
            }
            else
            {
               this.btnSendMessage.disableMe();
            }
         }
         else
         {
            this.btnSendMessage.disableMe();
         }
      }
      
      public function chatEnterClicked() : void
      {
         this.sendChatMessageClicked();
      }
      
      public function sendChatMessageClicked() : void
      {
         var _loc2_:String = null;
         var _loc3_:uint = 0;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:uint = 0;
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(_loc1_.allowBattleChatMessages)
         {
            _loc2_ = "";
            _loc3_ = 0;
            while(_loc3_ < this.txtChatInput.text.length)
            {
               _loc5_ = this.txtChatInput.text.substr(_loc3_,1);
               if(_loc5_ != "")
               {
                  _loc2_ += _loc5_;
               }
               _loc3_++;
            }
            _loc4_ = this.txtChatInput.text;
            if(_loc2_ != "")
            {
               if(BattleTypeResolver.isBattleOnServer)
               {
                  remoteM.battle_sendMessage(_loc4_);
               }
               this._sendMessageCooldown = this.SEND_MESSAGE_COOLDOWN;
               this.refreshSendMessageButton();
            }
            this.txtChatInput.text = "";
            this.closeMe();
            screensM.screenBattleInterfaceTop.btnEmotesOpen.visible = true;
            screensM.screenBattleInterfaceTop.btnEmotesClose.visible = false;
            if(BattleTypeResolver.isBattleOnServer == false)
            {
               _loc6_ = 1;
               screensM.screenBattleInterfaceTop.sendMessageSuccess(_loc4_,_loc6_);
            }
         }
      }
      
      public function refreshEmoteButtons() : void
      {
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(_loc1_.allowBattleChatMessages)
         {
            if(this._emoteCooldown >= this.EMOTE_COOLDOWN)
            {
               this.enableAllButtons();
            }
            else
            {
               this.disableAllButtons();
            }
         }
         else
         {
            this.disableAllButtons();
         }
      }
      
      public function emoteClicked(param1:uint) : void
      {
         var _loc2_:BMPlayerData = null;
         var _loc3_:uint = 0;
         if(this._screenStatus == "opened")
         {
            _loc2_ = dataM.playersData[dataM.player1PlayerID];
            if(BattleTypeResolver.isBattleOnServer)
            {
               screensM.screenBattle.tauntClicked(param1);
            }
            else
            {
               _loc3_ = 1;
               screensM.screenBattle.activateTaunt(_loc3_,param1);
            }
            this._emoteCooldown = 0;
            this.closeMe();
            screensM.screenBattleInterfaceTop.btnEmotesOpen.visible = true;
            screensM.screenBattleInterfaceTop.btnEmotesClose.visible = false;
         }
      }
      
      public function emoteMouseOver(param1:uint) : void
      {
      }
      
      public function emoteMouseOut(param1:uint) : void
      {
      }
      
      private function enableAllButtons() : void
      {
         var _loc1_:uint = 1;
         while(_loc1_ <= this.TOTAL_EMOTES)
         {
            this["btnEmote" + _loc1_].enableMe();
            this["btnEmote" + _loc1_].deactivatePressedEffect();
            this["btnEmote" + _loc1_].y = this["mcSizer_btnEmote" + _loc1_].y;
            _loc1_++;
         }
      }
      
      private function disableAllButtons() : void
      {
         var _loc1_:uint = 1;
         while(_loc1_ <= this.TOTAL_EMOTES)
         {
            this["btnEmote" + _loc1_].disableMe();
            this["btnEmote" + _loc1_].activatePressedEffect();
            this["btnEmote" + _loc1_].y = this["mcSizer_btnEmote" + _loc1_].y + 4;
            _loc1_++;
         }
      }
      
      private function hideSandClock() : void
      {
         this.mcSandClock.gotoAndStop("animOff");
         this.mcSandClock.visible = false;
      }
      
      private function showSandClock() : void
      {
         this.mcSandClock.gotoAndStop("animOn");
         this.mcSandClock.visible = true;
      }
      
      public function removeMe() : void
      {
         this.hideSandClock();
         if(screensM.screenBattleInterfaceEmotes.parent != null)
         {
            screensM.screenBattleInterfaceEmotes.parent.removeChild(screensM.screenBattleInterfaceEmotes);
         }
      }
   }
}

