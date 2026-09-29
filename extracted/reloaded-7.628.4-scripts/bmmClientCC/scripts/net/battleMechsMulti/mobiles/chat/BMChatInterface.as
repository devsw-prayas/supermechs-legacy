package net.battleMechsMulti.mobiles.chat
{
   import com.distriqt.extension.application.Application;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.SoftKeyboardEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.ui.Keyboard;
   import net.battleMechsMulti.managers.BMLanguageManager;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.chat.BMChatData;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   import net.battleMechsMulti.mobiles.BMChatMessageData;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.BMScroller;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.screens.BMBaseScreen;
   import net.battleMechsMulti.utils.TextUtils;
   
   public class BMChatInterface extends BMBaseClass
   {
      
      public static const CHAT_TYPE_MULTIPLAYER_LOBBY:uint = 1;
      
      public static const CHAT_TYPE_CLAN:uint = 2;
      
      public static const CHAT_TYPE_CAMPAIGN:uint = 3;
      
      public var btnSendMessage:BMBasicButton;
      
      public var txtChatHistory:TextField;
      
      public var txtChatInput:TextField;
      
      public var txtSizeTester:TextField;
      
      public var txtPasswordWarning:TextField;
      
      public var mcSizer_scroller:Sprite;
      
      public var mcChatMouseHitArea:Sprite;
      
      public var mcTextBitmapHolder:Sprite;
      
      public var mcTextMarker:Sprite;
      
      private var scroller:BMScroller;
      
      private var _mouseOverHistory:Boolean = false;
      
      private var _rollOverPlayerID:Number = 0;
      
      private var _rollOverClanMessage:Boolean = false;
      
      private var _lastTargetRow:Number = -1;
      
      private var _channels:Array = new Array();
      
      private var _lastChatInputLength:uint = 0;
      
      private var _tryToInspectPlayer:Function;
      
      private var _sendChatMessage:Function;
      
      private var _chatType:uint;
      
      private const CHAT_MAX_ROWS_MP_LOBBY:Number = 15;
      
      private const CHAT_MAX_ROWS_CLAN:Number = 10;
      
      private const CHAT_MAX_ROWS_CAMPAIGN:Number = 15;
      
      private const ROW_HEIGHT:Number = 20.5;
      
      private const SEND_MESSAGE_COOLDOWN_FRAMES:Number = 100;
      
      private var CLEAN_CHAT_MESSAGES_MAX:Number = 40;
      
      private var CLEAN_CHAT_MESSAGES_REMAIN:Number = 25;
      
      private var isKeyboardVisible:Boolean = false;
      
      public function BMChatInterface()
      {
         super();
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("multiplayerChat");
         updateTextAndFormat(this.txtPasswordWarning,getScreenText("passwordWarning"));
      }
      
      public function initialize(param1:Function, param2:Function, param3:uint = 1) : void
      {
         this.btnSendMessage.addEventListener(BMIntractable.HIT,this.sendMessageClicked);
         this._tryToInspectPlayer = param1;
         this._sendChatMessage = param2;
         this._chatType = param3;
         this.addScroller();
         this.txtChatHistory.htmlText = "";
         this.txtChatInput.text = "";
         this.txtChatInput.restrict = "^<>&";
         this.txtChatInput.addEventListener(Event.CHANGE,this.chatInputChanged);
         this._lastChatInputLength = 0;
         if(dataM.runAsMobile)
         {
            screensM.createTextBitmap("txtChatHistory",this.txtChatHistory," ",this.mcTextBitmapHolder);
         }
         if(Math.abs(this.txtChatHistory.width - this.txtSizeTester.width) > 0.5)
         {
            TsLogger.log("WARNING - SIZE TESTER TEXT WIDTH DOES NOT EQUAL CHAT\'S WIDTH (SCREEN MENU CHAT)");
         }
         if(dataM.runAsMobile == false)
         {
            this.mcChatMouseHitArea.addEventListener(MouseEvent.CLICK,this.mouseHitAreaClicked);
            this.mcChatMouseHitArea.addEventListener(MouseEvent.MOUSE_OVER,this.mouseHitAreaMouseOver);
            this.mcChatMouseHitArea.addEventListener(MouseEvent.MOUSE_OUT,this.mouseHitAreaMouseOut);
         }
         this.mcTextMarker.visible = false;
         addEventListener(Event.ADDED_TO_STAGE,this.addedToStage);
         if(dataM.runAsMobile)
         {
            this.CLEAN_CHAT_MESSAGES_MAX = this.getChatMaxRows() + 1;
            this.CLEAN_CHAT_MESSAGES_REMAIN = this.getChatMaxRows();
         }
         if(dataM.runAsMobile)
         {
            this.txtSizeTester.parent.removeChild(this.txtSizeTester);
            this.txtChatHistory.width += 34;
            this.txtSizeTester.width += 34;
            this.mcTextMarker.width += 34;
            this.mcChatMouseHitArea.width += 34;
         }
         this.languageUpdate();
         keyboardM.setKeyboardOutputFunction(this.keyboardOutput,"screeMenuChat refreshScreen");
         keyboardM.activateMe(BMScreensManager.SCR_MULTIPLAYER_CHAT);
         this._mouseOverHistory = false;
         this.refreshChatHistory();
         this.enableAllButtons();
         addEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStage);
         Application.service.keyboard.addEventListener(SoftKeyboardEvent.SOFT_KEYBOARD_ACTIVATE,this.application_onKeyboardActivate);
         Application.service.keyboard.addEventListener(SoftKeyboardEvent.SOFT_KEYBOARD_DEACTIVATE,this.application_onKeyboardDeactivate);
         this.txtChatInput.needsSoftKeyboard = true;
         this.txtChatInput.addEventListener(SoftKeyboardEvent.SOFT_KEYBOARD_ACTIVATE,this.onKeyboardActivate);
         this.txtChatInput.addEventListener(SoftKeyboardEvent.SOFT_KEYBOARD_DEACTIVATE,this.onKeyboardDeactivate);
         if(this.stage != null)
         {
            this.addedToStage(null);
         }
      }
      
      private function languageUpdate(param1:Boolean = false) : void
      {
         var _loc2_:uint = 0;
         if(lastLanguageID != dataM.languageID)
         {
            lastLanguageID = dataM.languageID;
            _loc2_ = 15;
            switch(dataM.languageID)
            {
               case 3:
               case 6:
               case 7:
               case 8:
               case 9:
                  _loc2_ = 17;
            }
            TextUtils.updateTextFormat(this.txtChatHistory,_loc2_);
            TextUtils.updateTextFormat(this.txtChatInput,_loc2_);
            TextUtils.updateTextFormat(this.txtSizeTester,_loc2_);
         }
      }
      
      private function addedToStage(param1:Event) : void
      {
         this.setStageFocusOnChatInput();
      }
      
      private function keyUpEventHandler(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.SEARCH)
         {
            trace("search button pressed");
         }
      }
      
      public function setStageFocusOnChatInput() : void
      {
         if(stage != null)
         {
            stage.focus = this.txtChatInput;
         }
      }
      
      private function findParentBaseScreen() : BMBaseScreen
      {
         var _loc1_:DisplayObject = this;
         while(_loc1_ != null)
         {
            if(_loc1_ is BMBaseScreen)
            {
               return _loc1_ as BMBaseScreen;
            }
            _loc1_ = _loc1_.parent;
         }
         throw Error("No base screen found");
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(screensM.screenBlack.isActive())
         {
            return;
         }
         var _loc1_:BMBaseScreen = this.findParentBaseScreen();
         var _loc2_:BMBaseScreen = screensM.getTopMostScreen();
         var _loc3_:Boolean = _loc1_ == _loc2_;
         if(!_loc3_)
         {
            return;
         }
         if(dataM.runAsMobile == false)
         {
            this.chatHistoryMouseOverHandler();
         }
         if(dataM.chatData.sendMessageCooldown > 0)
         {
            --dataM.chatData.sendMessageCooldown;
            return;
         }
         this.setStageFocusOnChatInput();
         if(keyboardM.activator != "ChatInterface")
         {
            keyboardM.activateMe("ChatInterface");
         }
         if(this.txtChatInput.alpha < 1)
         {
            this.txtChatInput.alpha = 1;
            this.btnSendMessage.enableMe();
         }
      }
      
      public function addGlobalChatMessage(param1:Number, param2:uint, param3:Boolean = false) : void
      {
         var _loc14_:Boolean = false;
         var _loc4_:BMChatMessageData = dataM.chatData.log[param1][param2];
         var _loc5_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc6_:String = dataM.chatData.COLOR_REGULAR_PLAYER;
         var _loc7_:String = dataM.chatData.COLOR_TEXT;
         switch(_loc4_.type)
         {
            case BMChatData.MSG_TYPE_BATTLE_INVITATION:
            case BMChatData.MSG_TYPE_CLAN_INVITATION:
               _loc6_ = dataM.chatData.COLOR_SERVER;
               _loc7_ = dataM.chatData.COLOR_SERVER;
               break;
            case BMChatData.MSG_TYPE_PRIVATE_MESSAGE_ALERT:
               _loc6_ = dataM.chatData.COLOR_SERVER;
               _loc7_ = dataM.chatData.COLOR_SERVER;
               break;
            case BMChatData.MSG_TYPE_CLAN_MESSAGE_ALERT:
               _loc6_ = dataM.chatData.COLOR_CLAN_MESSAGE;
               _loc7_ = dataM.chatData.COLOR_CLAN_MESSAGE;
               break;
            case BMChatData.MSG_TYPE_REGULAR:
               if(_loc4_.fromPlayerID == dataM.userID)
               {
                  _loc6_ = dataM.chatData.COLOR_SELF;
               }
               else
               {
                  _loc14_ = false;
                  if(_loc5_.clanID > 0)
                  {
                     if(dataM.chatData.playersData[_loc4_.fromPlayerID] != null)
                     {
                        if(dataM.chatData.playersData[_loc4_.fromPlayerID].clanID == _loc5_.clanID)
                        {
                           _loc14_ = true;
                        }
                     }
                  }
                  if(_loc14_)
                  {
                     _loc6_ = dataM.chatData.COLOR_FRIEND;
                  }
                  else if(_loc4_.toPlayerID == dataM.chatData.CHAT_CLAN_CHANNEL_PLAYER_ID)
                  {
                     _loc6_ = dataM.chatData.COLOR_FRIEND;
                  }
                  else if(dataM.isPlayerIDAdmin(_loc4_.fromPlayerID))
                  {
                     _loc6_ = dataM.chatData.COLOR_ADMIN;
                  }
               }
         }
         var _loc8_:String = dataM.chatData.getMessageText(_loc4_);
         var _loc9_:String = dataM.chatData.getMessageTextSeparator(_loc4_);
         var _loc10_:String = "<FONT COLOR=\'#" + _loc6_ + "\'>" + _loc4_.name + "</FONT><FONT COLOR=\'#" + _loc7_ + "\'>" + _loc9_ + _loc8_ + "</FONT>";
         var _loc11_:uint = 15;
         var _loc12_:Number = 1.6;
         switch(dataM.languageID)
         {
            case BMLanguageManager.LANGUAGE_RUSSIAN:
            case BMLanguageManager.LANGUAGE_ITALIAN:
            case BMLanguageManager.LANGUAGE_PORTUGUESE:
            case BMLanguageManager.LANGUAGE_SPANISH:
            case BMLanguageManager.LANGUAGE_POLISH:
               _loc11_ = 17;
               _loc12_ = 1.9;
         }
         if(param1 == dataM.chatData.currentChannelPlayerID)
         {
            this.txtChatHistory.htmlText = TextUtils.getTextFont(_loc11_,_loc12_) + this.txtChatHistory.htmlText + _loc10_;
         }
         if(param3)
         {
            if(dataM.runAsMobile)
            {
               screensM.createTextBitmap("txtChatHistory",this.txtChatHistory," ",this.mcTextBitmapHolder);
            }
         }
         this.txtSizeTester.htmlText = TextUtils.getTextFont(_loc11_,_loc12_) + _loc10_;
         var _loc13_:Number = this.txtSizeTester.numLines;
         dataM.chatData.setMessageRowsInLog(param1,param2,_loc13_,this._chatType);
         if(param3)
         {
            if(param1 == dataM.chatData.currentChannelPlayerID)
            {
               if(this.txtChatHistory.numLines > this.getChatMaxRows())
               {
                  if(dataM.runAsMobile == false)
                  {
                     this.scroller.enableMe();
                  }
                  if(this.txtChatHistory.scrollV > this.txtChatHistory.maxScrollV - 2 - _loc13_)
                  {
                     this.txtChatHistory.scrollV = this.txtChatHistory.maxScrollV;
                     if(param3)
                     {
                        if(dataM.runAsMobile)
                        {
                           screensM.createTextBitmap("txtChatHistory",this.txtChatHistory," ",this.mcTextBitmapHolder);
                        }
                     }
                     if(dataM.runAsMobile == false)
                     {
                        this.scroller.setScrollPosition(1);
                     }
                  }
               }
               else if(dataM.runAsMobile == false)
               {
                  this.scroller.disableMe();
               }
            }
         }
      }
      
      private function chatInputChanged(param1:Event) : void
      {
         if(dataM.chatData.currentChannelPlayerID >= dataM.chatData.CHAT_CLAN_CHANNEL_PLAYER_ID)
         {
            return;
         }
         var _loc2_:Number = Math.abs(this.txtChatInput.text.length - this._lastChatInputLength);
         if(dataM.clientRunningLocally == false && _loc2_ > 2)
         {
            this.txtChatInput.text = "";
         }
         this._lastChatInputLength = this.txtChatInput.text.length;
      }
      
      public function chatMessageSent() : void
      {
         this.txtChatInput.text = "";
         this._lastChatInputLength = 0;
         dataM.chatData.sendMessageCooldown = this.SEND_MESSAGE_COOLDOWN_FRAMES;
         this.txtChatInput.alpha = 0.3;
         this.btnSendMessage.disableMe();
      }
      
      public function refreshChatHistory() : void
      {
         var _loc3_:Array = null;
         var _loc4_:uint = 0;
         var _loc5_:BMChatMessageData = null;
         var _loc6_:Number = NaN;
         var _loc1_:Number = this.txtChatHistory.scrollV;
         this.txtChatHistory.htmlText = "";
         if(dataM.runAsMobile)
         {
            screensM.createTextBitmap("txtChatHistory",this.txtChatHistory," ",this.mcTextBitmapHolder);
         }
         var _loc2_:Boolean = false;
         if(dataM.chatData.log[dataM.chatData.currentChannelPlayerID] != null)
         {
            _loc3_ = dataM.chatData.log[dataM.chatData.currentChannelPlayerID];
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length)
            {
               _loc5_ = _loc3_[_loc4_];
               _loc6_ = _loc5_.fromPlayerID;
               switch(_loc5_.type)
               {
                  case BMChatData.MSG_TYPE_PRIVATE_MESSAGE_ALERT:
                  case BMChatData.MSG_TYPE_CLAN_MESSAGE_ALERT:
                  case BMChatData.MSG_TYPE_BATTLE_INVITATION:
                  case BMChatData.MSG_TYPE_CLAN_INVITATION:
                     _loc6_ = _loc5_.specialPlayerID;
               }
               if(_loc4_ == _loc3_.length - 1)
               {
                  _loc2_ = true;
               }
               if(dataM.chatData.playersData[_loc6_].blocked == false)
               {
                  this.addGlobalChatMessage(_loc5_.channelID,_loc5_.slot,_loc2_);
               }
               _loc4_++;
            }
         }
         if(dataM.runAsMobile)
         {
            this.txtChatHistory.scrollV = this.txtChatHistory.maxScrollV;
         }
         else if(_loc1_ < this.txtChatHistory.maxScrollV)
         {
            this.txtChatHistory.scrollV = _loc1_;
         }
         else
         {
            this.txtChatHistory.scrollV = this.txtChatHistory.maxScrollV;
         }
         if(dataM.runAsMobile)
         {
            screensM.createTextBitmap("txtChatHistory",this.txtChatHistory," ",this.mcTextBitmapHolder);
         }
         if(dataM.runAsMobile == false)
         {
            if(this.txtChatHistory.maxScrollV == 1)
            {
               this.scroller.disableMe();
            }
            else
            {
               this.scroller.enableMe();
            }
            this.scrollerScrolled(1);
         }
      }
      
      private function mouseHitAreaClicked(param1:MouseEvent) : void
      {
         if(screensM.screenBlack.isActive() == false)
         {
            this._tryToInspectPlayer(this._rollOverPlayerID);
         }
      }
      
      private function mouseHitAreaMouseOver(param1:MouseEvent) : void
      {
         this._mouseOverHistory = true;
      }
      
      private function mouseHitAreaMouseOut(param1:MouseEvent) : void
      {
         this._mouseOverHistory = false;
         this.mcTextMarker.visible = false;
         this._rollOverPlayerID = 0;
         this._rollOverClanMessage = false;
      }
      
      public function chatHistoryMouseOverHandler() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Array = null;
         var _loc4_:uint = 0;
         var _loc5_:BMChatMessageData = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         if(this._mouseOverHistory || dataM.runAsMobile)
         {
            if(dataM.chatData.log[dataM.chatData.currentChannelPlayerID] != null)
            {
               _loc1_ = Math.floor((mouseY - this.mcChatMouseHitArea.y) / this.ROW_HEIGHT) + this.txtChatHistory.scrollV;
               _loc2_ = 0;
               _loc3_ = dataM.chatData.log[dataM.chatData.currentChannelPlayerID];
               _loc4_ = 0;
               while(_loc4_ < _loc3_.length)
               {
                  _loc5_ = _loc3_[_loc4_];
                  _loc6_ = _loc5_.fromPlayerID;
                  switch(_loc5_.type)
                  {
                     case BMChatData.MSG_TYPE_PRIVATE_MESSAGE_ALERT:
                     case BMChatData.MSG_TYPE_CLAN_MESSAGE_ALERT:
                     case BMChatData.MSG_TYPE_BATTLE_INVITATION:
                     case BMChatData.MSG_TYPE_CLAN_INVITATION:
                        _loc6_ = _loc5_.specialPlayerID;
                  }
                  if(dataM.chatData.playersData[_loc6_].blocked == false)
                  {
                     _loc2_ += _loc5_.rowsInLog[this._chatType];
                     if(_loc2_ >= _loc1_)
                     {
                        this._rollOverPlayerID = _loc6_;
                        this._rollOverClanMessage = false;
                        if(_loc5_.toPlayerID == dataM.chatData.CHAT_CLAN_CHANNEL_PLAYER_ID)
                        {
                           this._rollOverClanMessage = true;
                        }
                        if(dataM.runAsMobile == false)
                        {
                           if(_loc5_.rowsInLog[this._chatType] > 1)
                           {
                              this.mcTextMarker.y = this.mcChatMouseHitArea.y + (_loc2_ - this.txtChatHistory.scrollV - _loc5_.rowsInLog[this._chatType] + 1) * (this.ROW_HEIGHT - 0.2);
                           }
                           else
                           {
                              this.mcTextMarker.y = this.mcChatMouseHitArea.y + (_loc2_ - this.txtChatHistory.scrollV) * (this.ROW_HEIGHT - 0.2);
                           }
                           this.mcTextMarker.height = _loc5_.rowsInLog[this._chatType] * this.ROW_HEIGHT;
                           _loc7_ = 0;
                           if(this.mcTextMarker.y < this.mcChatMouseHitArea.y)
                           {
                              _loc7_ = this.mcChatMouseHitArea.y - this.mcTextMarker.y;
                              this.mcTextMarker.height -= _loc7_;
                              this.mcTextMarker.y += _loc7_;
                           }
                           if(this.mcTextMarker.y + this.mcTextMarker.height > this.mcChatMouseHitArea.y + this.mcChatMouseHitArea.height)
                           {
                              _loc7_ = this.mcTextMarker.y + this.mcTextMarker.height - (this.mcChatMouseHitArea.y + this.mcChatMouseHitArea.height);
                              this.mcTextMarker.height -= _loc7_;
                           }
                           this.mcTextMarker.visible = true;
                        }
                        _loc4_ = _loc3_.length;
                     }
                     else
                     {
                        this._rollOverPlayerID = 0;
                        this.mcTextMarker.visible = false;
                     }
                  }
                  _loc4_++;
               }
               this._lastTargetRow = _loc1_;
            }
            else
            {
               this._lastTargetRow = 0;
            }
         }
      }
      
      public function getRollOverPlayerID() : Number
      {
         return this._rollOverPlayerID;
      }
      
      public function isRollOverClanMessage() : Boolean
      {
         return this._rollOverClanMessage;
      }
      
      private function scrollerScrolled(param1:Number) : void
      {
         var _loc2_:Number = this.txtChatHistory.scrollV;
         this.txtChatHistory.scrollV = Math.ceil(param1 * this.txtChatHistory.maxScrollV);
         if(dataM.runAsMobile)
         {
            if(_loc2_ != this.txtChatHistory.scrollV)
            {
               screensM.createTextBitmap("txtChatHistory",this.txtChatHistory," ",this.mcTextBitmapHolder);
            }
         }
      }
      
      private function scrollingEnded() : void
      {
      }
      
      private function scrollerButtonUp() : void
      {
         if(this.txtChatHistory.scrollV > 1)
         {
            --this.txtChatHistory.scrollV;
            if(dataM.runAsMobile)
            {
               screensM.createTextBitmap("txtChatHistory",this.txtChatHistory," ",this.mcTextBitmapHolder);
            }
            this.scroller.setScrollPosition((this.txtChatHistory.scrollV - 1) / (this.txtChatHistory.maxScrollV - 1));
         }
      }
      
      private function scrollerButtonDown() : void
      {
         if(this.txtChatHistory.scrollV < this.txtChatHistory.maxScrollV)
         {
            ++this.txtChatHistory.scrollV;
            if(dataM.runAsMobile)
            {
               screensM.createTextBitmap("txtChatHistory",this.txtChatHistory," ",this.mcTextBitmapHolder);
            }
            this.scroller.setScrollPosition((this.txtChatHistory.scrollV - 1) / (this.txtChatHistory.maxScrollV - 1));
         }
      }
      
      private function addScroller() : void
      {
         if(dataM.runAsMobile)
         {
            return;
         }
         this.scroller = new BMScroller();
         var _loc1_:MovieClip = new Grp_scrollerContent();
         var _loc2_:Number = 0.2;
         this.scroller.initialize(screensM.stagePointer,this.mcSizer_scroller.height * 1.66,_loc2_,_loc1_,this.scrollerScrolled,this.scrollingEnded,this.scrollerButtonUp,this.scrollerButtonDown,false,dataM.runAsMobile);
         this.scroller.x = this.mcSizer_scroller.x;
         this.scroller.y = this.mcSizer_scroller.y;
         this.scroller.width *= 0.7;
         this.scroller.height *= 0.6;
         addChild(this.scroller);
         this.scroller.disableMe();
      }
      
      private function keyboardOutput(param1:Object) : void
      {
         if(param1.enter)
         {
            this._sendChatMessage(this.txtChatInput.text);
            stage.focus = null;
         }
      }
      
      private function getChatMaxRows() : uint
      {
         switch(this._chatType)
         {
            case CHAT_TYPE_MULTIPLAYER_LOBBY:
               return this.CHAT_MAX_ROWS_MP_LOBBY;
            case CHAT_TYPE_CAMPAIGN:
               return this.CHAT_MAX_ROWS_CAMPAIGN;
            default:
               return this.CHAT_MAX_ROWS_CLAN;
         }
      }
      
      public function sendMessageClicked(param1:Event) : void
      {
         this._sendChatMessage(this.txtChatInput.text);
      }
      
      public function removedFromStage(param1:Event) : void
      {
         keyboardM.removeKeyboardOutputFunction("chatInterface removedFromStage");
         this.txtChatInput.removeEventListener(SoftKeyboardEvent.SOFT_KEYBOARD_ACTIVATE,this.onKeyboardActivate);
         this.txtChatInput.removeEventListener(SoftKeyboardEvent.SOFT_KEYBOARD_DEACTIVATE,this.onKeyboardDeactivate);
         Application.service.keyboard.removeEventListener(SoftKeyboardEvent.SOFT_KEYBOARD_ACTIVATE,this.application_onKeyboardActivate);
         Application.service.keyboard.removeEventListener(SoftKeyboardEvent.SOFT_KEYBOARD_DEACTIVATE,this.application_onKeyboardDeactivate);
      }
      
      public function disableAllButtons() : void
      {
         this.btnSendMessage.disableMe();
      }
      
      public function enableAllButtons() : void
      {
         this.btnSendMessage.enableMe();
      }
      
      private function onKeyboardActivate(param1:SoftKeyboardEvent) : void
      {
         trace("onKeyboardActivate");
      }
      
      private function onKeyboardDeactivate(param1:SoftKeyboardEvent) : void
      {
         trace("onKeyboardDeactivate");
      }
      
      private function application_onKeyboardActivate(param1:SoftKeyboardEvent) : void
      {
         trace("application_onKeyboardActivate");
         this.isKeyboardVisible = true;
         this.updateInputPositionWithKeyboard();
      }
      
      private function application_onKeyboardDeactivate(param1:SoftKeyboardEvent) : void
      {
         trace("application_onKeyboardDeactivate");
         this.isKeyboardVisible = false;
         this.updateInputPositionWithKeyboard();
      }
      
      private function getContainingScreen() : DisplayObject
      {
         var _loc1_:DisplayObject = this;
         while(!(_loc1_ is BMBaseScreen))
         {
            _loc1_ = _loc1_.parent;
         }
         return _loc1_;
      }
      
      private function updateInputPositionWithKeyboard(param1:Event = null) : void
      {
         var _loc2_:InteractiveObject = null;
         var _loc3_:int = 0;
         var _loc4_:Stage = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         if(this.isKeyboardVisible)
         {
            this.getContainingScreen().y = 0;
            _loc2_ = this.txtChatInput;
            _loc3_ = 0;
            _loc4_ = this.stage;
            _loc5_ = _loc4_.stageHeight / _loc4_.fullScreenHeight;
            _loc6_ = Application.service.keyboard.y * _loc5_;
            _loc7_ = _loc2_.localToGlobal(new Point()).y;
            if(_loc6_ != 0 && _loc7_ + _loc2_.height > _loc6_)
            {
               _loc3_ = _loc7_ + _loc2_.height - _loc6_;
            }
            if(_loc7_ - _loc3_ < 0)
            {
               _loc3_ += _loc7_ - _loc3_;
            }
            this.getContainingScreen().y = -_loc3_;
         }
         else
         {
            this.getContainingScreen().y = 0;
         }
      }
   }
}

