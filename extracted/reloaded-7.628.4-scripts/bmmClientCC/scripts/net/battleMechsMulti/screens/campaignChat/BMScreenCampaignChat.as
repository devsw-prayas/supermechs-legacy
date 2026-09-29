package net.battleMechsMulti.screens.campaignChat
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.mobiles.chat.BMChatInterface;
   import net.battleMechsMulti.screens.BMBaseScreen;
   import net.battleMechsMulti.utils.TextUtils;
   
   public class BMScreenCampaignChat extends BMBaseScreen
   {
      
      public var chatInterface:BMChatInterface;
      
      public var channelsList:BMChatChannelsList;
      
      public var txtPlayersInLobby:TextField;
      
      public var txtCurrentChannel:TextField;
      
      public var txtTitle:TextField;
      
      public var btnClose:BMBasicButton;
      
      public var btnChannelsOpen:BMBasicButton;
      
      public var btnChannelsClose:BMBasicButton;
      
      public var btnBlockChat:BMBasicButton;
      
      public var btnUnblockChat:BMBasicButton;
      
      public var mcCampaignChatBackground:Sprite;
      
      public function BMScreenCampaignChat()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers();
         setLanguageManagerScreenName("campaignChat");
         this.initChatInterface();
         this.btnBlockChat.addEventListener(BMIntractable.HIT,this.blockChatClicked);
         this.btnUnblockChat.addEventListener(BMIntractable.HIT,this.unblockChatClicked);
         this.refreshChatToggleButtons();
         this.btnClose.addEventListener(BMIntractable.HIT,this.onCloseClicked);
         this.mcCampaignChatBackground.alpha = 0.75;
      }
      
      public function onEnterFrameTrigger() : void
      {
         this.chatInterface.onEnterFrameTrigger();
      }
      
      public function cancelFingerWheeling() : void
      {
      }
      
      private function initChatInterface() : void
      {
         updateTextAndFormat(this.txtTitle,languageM.getText("newMenu_chat"));
         this.chatInterface.initialize(this.tryToInspectPlayer,this.sendChatMessage,BMChatInterface.CHAT_TYPE_CAMPAIGN);
         this.chatInterface.refreshChatHistory();
      }
      
      private function blockChatClicked(param1:Event) : void
      {
         dataM.chatData.campaignChatBlocked = true;
         this.refreshChatToggleButtons();
      }
      
      private function unblockChatClicked(param1:Event) : void
      {
         dataM.chatData.campaignChatBlocked = false;
         this.refreshChatToggleButtons();
      }
      
      private function refreshChatToggleButtons() : void
      {
         this.btnBlockChat.visible = false;
         this.btnUnblockChat.visible = false;
         if(dataM.chatData.campaignChatBlocked)
         {
            this.btnUnblockChat.visible = true;
         }
         else
         {
            this.btnBlockChat.visible = true;
         }
      }
      
      private function sendChatMessage(param1:String) : void
      {
         if(param1 == "" || dataM.chatData.sendMessageCooldown > 0)
         {
            return;
         }
         if(TextUtils.doesStringOnlyContainsSpaces(param1))
         {
            return;
         }
         remoteM.socketM.lobby_chatToAll(param1,dataM.chatData.currentChannelPlayerID);
         this.chatInterface.chatMessageSent();
      }
      
      private function tryToInspectPlayer(param1:Number) : void
      {
         var _loc2_:Boolean = param1 >= dataM.chatData.CHAT_LANGUAGES && dataM.chatData.playersData[param1] != null && param1 != dataM.userID;
         if(_loc2_ == false)
         {
            if(screensM.isScreenOpened(BMScreensManager.SCR_MENU_MULTIPLAYER_INSPECT))
            {
               screensM.removeScreen(BMScreensManager.SCR_MENU_MULTIPLAYER_INSPECT);
            }
            return;
         }
         screensM.addScreen(BMScreensManager.SCR_MENU_MULTIPLAYER_INSPECT);
         var _loc3_:Boolean = false;
         var _loc4_:Boolean = false;
         var _loc5_:Number = Number(dataM.chatData.playersData[param1].clanID);
         if(dataM.chatData.clanInvitations[_loc5_] != null)
         {
            _loc4_ = true;
         }
         screensM.screenMenuMultiPlayerInspect.refreshScreen(param1,_loc3_,_loc4_,this.chatInterface.isRollOverClanMessage(),false);
      }
      
      public function tryToInspectPlayerForMobile() : void
      {
         this.tryToInspectPlayer(this.chatInterface.getRollOverPlayerID());
      }
      
      override public function notifyClientDataReloaded() : *
      {
         this.onCloseClicked(null);
      }
      
      private function onCloseClicked(param1:Event) : void
      {
         screensM.removeScreen(BMScreensManager.SCR_CAMPAIGN_CHAT);
      }
      
      override public function notifyRemoved() : *
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_MENU_MULTIPLAYER_INSPECT))
         {
            screensM.removeScreen(BMScreensManager.SCR_MENU_MULTIPLAYER_INSPECT);
         }
      }
   }
}

