package net.battleMechsMulti.mobiles.chat
{
   import com.greensock.TweenMax;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMLanguageManager;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.chat.BMChatData;
   import net.battleMechsMulti.mobiles.BMChatMessageData;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.utils.TextUtils;
   
   public class BMMiniChat extends MovieClip
   {
      
      public var txtMessage:TextField;
      
      public var mcTextBitmapHolder:Sprite;
      
      public var btnOpenChat:BMBasicButton;
      
      public var btnOpenChat_blocked:BMBasicButton;
      
      public var mcMessageBackground:Sprite;
      
      private var _openChatCallback:Function;
      
      private var _gotFirstMessage:Boolean = false;
      
      public function BMMiniChat()
      {
         super();
         this.txtMessage.text = "";
         this.btnOpenChat.addEventListener(BMIntractable.HIT,this.openChatClicked);
         this.btnOpenChat_blocked.addEventListener(BMIntractable.HIT,this.openChatClicked);
         this.hideMessage();
         this.refresh();
      }
      
      public function refresh(param1:Boolean = false) : void
      {
         this.btnOpenChat.visible = false;
         this.btnOpenChat_blocked.visible = false;
         if(this.dataM.chatData.campaignChatBlocked)
         {
            this.btnOpenChat_blocked.visible = true;
            this.hideMessage(false);
         }
         else
         {
            this.btnOpenChat.visible = true;
            if(this._gotFirstMessage)
            {
               this.showMessage(param1);
            }
         }
      }
      
      private function get textVisualObject() : DisplayObject
      {
         if(this.dataM.runAsMobile)
         {
            return this.mcTextBitmapHolder;
         }
         return this.txtMessage;
      }
      
      private function killActiveAnimations() : void
      {
         TweenMax.killTweensOf(this.textVisualObject);
         TweenMax.killTweensOf(this.mcMessageBackground);
         TweenMax.killDelayedCallsTo(this.hideMessage);
      }
      
      private function hideMessage(param1:Boolean = false) : void
      {
         var _loc2_:Object = null;
         var _loc3_:Number = NaN;
         if(this.mcMessageBackground.visible == true && param1)
         {
            this.killActiveAnimations();
            _loc2_ = {"scaleY":0};
            _loc3_ = 0.5;
            TweenMax.to(this.textVisualObject,_loc3_,_loc2_);
            TweenMax.to(this.mcMessageBackground,_loc3_,_loc2_);
            TweenMax.delayedCall(0.5,this.hideMessage,[false]);
         }
         else
         {
            this.mcMessageBackground.visible = false;
            this.textVisualObject.visible = false;
         }
      }
      
      private function showMessage(param1:Boolean = false) : void
      {
         var _loc3_:Object = null;
         var _loc4_:Object = null;
         var _loc5_:Number = NaN;
         var _loc2_:Boolean = this.mcMessageBackground.visible;
         this.mcMessageBackground.visible = true;
         this.textVisualObject.visible = true;
         this.killActiveAnimations();
         if(_loc2_ == false && param1)
         {
            this.mcMessageBackground.scaleY = this.textVisualObject.scaleY = 0;
            _loc3_ = {"scaleY":0.2};
            _loc4_ = {"scaleY":1};
            _loc5_ = 0.5;
            TweenMax.fromTo(this.textVisualObject,_loc5_,_loc3_,_loc4_);
            TweenMax.fromTo(this.mcMessageBackground,_loc5_,_loc3_,_loc4_);
         }
         else
         {
            this.textVisualObject.scaleY = this.mcMessageBackground.scaleY = 1;
         }
         TweenMax.delayedCall(10,this.hideMessage,[true]);
      }
      
      public function setOpenChatCallback(param1:Function) : void
      {
         this._openChatCallback = param1;
      }
      
      private function openChatClicked(param1:Event) : void
      {
         if(this._openChatCallback == null)
         {
            throw Error("BMMiniChat setOpenChatCallback must be used");
         }
         this._openChatCallback();
      }
      
      public function addGlobalChatMessage(param1:Number, param2:uint) : void
      {
         var _loc3_:BMScreensManager = null;
         var _loc13_:Boolean = false;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         _loc3_ = BMScreensManager.getInstance();
         var _loc4_:BMChatMessageData = this.dataM.chatData.log[param1][param2];
         var _loc5_:BMPlayerProfile = this.dataM["player" + this.dataM.player1PlayerID + "Profile"];
         var _loc6_:String = this.dataM.chatData.COLOR_REGULAR_PLAYER;
         var _loc7_:String = this.dataM.chatData.COLOR_TEXT;
         switch(_loc4_.type)
         {
            case BMChatData.MSG_TYPE_BATTLE_INVITATION:
            case BMChatData.MSG_TYPE_CLAN_INVITATION:
               _loc6_ = this.dataM.chatData.COLOR_SERVER;
               _loc7_ = this.dataM.chatData.COLOR_SERVER;
               break;
            case BMChatData.MSG_TYPE_PRIVATE_MESSAGE_ALERT:
               _loc6_ = this.dataM.chatData.COLOR_SERVER;
               _loc7_ = this.dataM.chatData.COLOR_SERVER;
               break;
            case BMChatData.MSG_TYPE_CLAN_MESSAGE_ALERT:
               _loc6_ = this.dataM.chatData.COLOR_CLAN_MESSAGE;
               _loc7_ = this.dataM.chatData.COLOR_CLAN_MESSAGE;
               break;
            case BMChatData.MSG_TYPE_REGULAR:
               if(_loc4_.fromPlayerID == this.dataM.userID)
               {
                  _loc6_ = this.dataM.chatData.COLOR_SELF;
               }
               else
               {
                  _loc13_ = false;
                  if(_loc5_.clanID > 0)
                  {
                     if(this.dataM.chatData.playersData[_loc4_.fromPlayerID] != null)
                     {
                        if(this.dataM.chatData.playersData[_loc4_.fromPlayerID].clanID == _loc5_.clanID)
                        {
                           _loc13_ = true;
                        }
                     }
                  }
                  if(_loc13_)
                  {
                     _loc6_ = this.dataM.chatData.COLOR_FRIEND;
                  }
                  else if(_loc4_.toPlayerID == this.dataM.chatData.CHAT_CLAN_CHANNEL_PLAYER_ID)
                  {
                     _loc6_ = this.dataM.chatData.COLOR_FRIEND;
                  }
                  else if(this.dataM.isPlayerIDAdmin(_loc4_.fromPlayerID))
                  {
                     _loc6_ = this.dataM.chatData.COLOR_ADMIN;
                  }
               }
         }
         var _loc8_:String = this.dataM.chatData.getMessageText(_loc4_);
         var _loc9_:String = this.dataM.chatData.getMessageTextSeparator(_loc4_);
         var _loc10_:String = "<FONT COLOR=\'#" + _loc6_ + "\'>" + _loc4_.name + "</FONT><FONT COLOR=\'#" + _loc7_ + "\'>" + _loc9_ + _loc8_ + "</FONT>";
         var _loc11_:uint = 15;
         var _loc12_:Number = 1.6;
         switch(this.dataM.languageID)
         {
            case BMLanguageManager.LANGUAGE_RUSSIAN:
            case BMLanguageManager.LANGUAGE_ITALIAN:
            case BMLanguageManager.LANGUAGE_PORTUGUESE:
            case BMLanguageManager.LANGUAGE_SPANISH:
            case BMLanguageManager.LANGUAGE_POLISH:
               _loc11_ = 17;
               _loc12_ = 1.9;
         }
         if(param1 == this.dataM.chatData.currentChannelPlayerID)
         {
            this.txtMessage.htmlText = TextUtils.getTextFont(_loc11_,_loc12_) + _loc10_;
         }
         if(this.dataM.runAsMobile)
         {
            _loc14_ = this.txtMessage.x;
            this.txtMessage.x = 0;
            _loc15_ = this.txtMessage.y;
            this.txtMessage.y = 0;
            _loc3_.createTextBitmap("txtMessage",this.txtMessage," ",this.mcTextBitmapHolder);
            this.txtMessage.x = _loc14_;
            this.txtMessage.y = _loc15_;
         }
         this._gotFirstMessage = true;
         this.refresh(true);
      }
      
      private function get dataM() : BMDataManager
      {
         return BMDataManager.getInstance();
      }
   }
}

