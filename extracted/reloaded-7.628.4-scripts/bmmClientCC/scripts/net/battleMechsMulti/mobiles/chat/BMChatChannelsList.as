package net.battleMechsMulti.mobiles.chat
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   import net.battleMechsMulti.mobiles.BMFingerWheeling;
   import net.battleMechsMulti.mobiles.BMItem;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.BMTileList;
   import net.battleMechsMulti.mobiles.BMTileListItem;
   import net.battleMechsMulti.utils.TextUtils;
   
   public class BMChatChannelsList extends BMBaseClass
   {
      
      public var mcFingerWheeling_channels:Sprite;
      
      public var mcTileListHolder:Sprite;
      
      private var _channels:Array = new Array();
      
      private var channelsServer:Array = new Array();
      
      private var channelsAdmins:Array = new Array();
      
      private var channelsClan:Array = new Array();
      
      private var channelsClanMembers:Array = new Array();
      
      private var channelsRegular:Array = new Array();
      
      private var channelsTileList:BMTileList;
      
      private var _fingerWheeling_channels:BMFingerWheeling;
      
      private var _channelClicked:Function;
      
      public function BMChatChannelsList()
      {
         super();
         generateSingletonClassesPointers();
      }
      
      public function initialize(param1:Function) : void
      {
         if(dataM.runAsMobile)
         {
            this._fingerWheeling_channels = new BMFingerWheeling();
            this._fingerWheeling_channels.initialize("channels",this.channelsTileList,this.mcFingerWheeling_channels,this.channelClicked,null,false,null,null,x,y);
            addChild(this._fingerWheeling_channels);
         }
         else
         {
            this.mcFingerWheeling_channels.parent.removeChild(this.mcFingerWheeling_channels);
            this.mcFingerWheeling_channels = null;
         }
         this._channelClicked = param1;
         this.initializeChannelsTileList();
         this.addAndRefreshChannelsTileList();
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
      }
      
      private function initializeChannelsTileList() : void
      {
         this.channelsTileList = new BMTileList();
         var _loc1_:Boolean = false;
         if(dataM.runAsMobile)
         {
            this._fingerWheeling_channels.resetTileList(this.channelsTileList);
            _loc1_ = true;
         }
         var _loc2_:Number = 8;
         var _loc3_:Number = 1;
         var _loc4_:Number = 27.5;
         var _loc5_:Number = 260;
         if(dataM.runAsMobile)
         {
            _loc2_ = 7;
            _loc4_ = 30;
            _loc5_ = 283;
            this.channelsTileList.activateExtendedMode(0.3,true);
         }
         var _loc6_:MovieClip = new Grp_scrollerContent();
         var _loc7_:Array = new Array();
         this.channelsTileList.initialize(screensM.stagePointer.stage,_loc7_,_loc2_,_loc3_,_loc5_,_loc4_,null,true,_loc6_,null,null,true,0,0.5,true,_loc1_,dataM.runAsMobile);
         this.mcTileListHolder.addChild(this.channelsTileList);
      }
      
      public function addAndRefreshChannelsTileList() : void
      {
         var _loc3_:Boolean = false;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:BMItem = null;
         var _loc7_:MovieClip = null;
         var _loc8_:String = null;
         var _loc9_:BMTileListItem = null;
         var _loc10_:Function = null;
         var _loc11_:BMPlayerProfile = null;
         var _loc1_:Array = new Array();
         var _loc2_:uint = 0;
         while(_loc2_ < dataM.chatData.channels.length)
         {
            _loc3_ = true;
            if(dataM.chatData.channels[_loc2_].channelID == dataM.chatData.CHAT_CLAN_CHANNEL_PLAYER_ID)
            {
               _loc11_ = dataM["player" + dataM.player1PlayerID + "Profile"];
               if(_loc11_.clanID == 0)
               {
                  _loc3_ = false;
               }
            }
            if(_loc3_ != false)
            {
               _loc4_ = 27.5;
               _loc5_ = 260;
               if(dataM.runAsMobile)
               {
                  _loc4_ = 30;
                  _loc5_ = 283;
               }
               _loc6_ = new BMItem();
               if(dataM.runAsMobile)
               {
                  _loc7_ = new mcChatChannelListRow_mobile();
               }
               else
               {
                  _loc7_ = new mcChatChannelListRow();
               }
               if(_loc2_ % 2 == 0)
               {
                  _loc7_.mcBackground.gotoAndStop("regular2");
               }
               _loc8_ = dataM.chatData.channels[_loc2_].name;
               switch(dataM.chatData.channels[_loc2_].type)
               {
                  case "server":
                     _loc8_ = "<FONT COLOR=\'#" + dataM.chatData.COLOR_SERVER + "\'>" + _loc8_ + "</FONT>";
                     break;
                  case "admin":
                     _loc8_ = "<FONT COLOR=\'#" + dataM.chatData.COLOR_ADMIN + "\'>" + _loc8_ + "</FONT>";
                     break;
                  case "friend":
                     _loc8_ = "<FONT COLOR=\'#" + dataM.chatData.COLOR_FRIEND + "\'>" + _loc8_ + "</FONT>";
                     break;
                  case "clan":
                     _loc8_ = "<FONT COLOR=\'#" + dataM.chatData.COLOR_FRIEND + "\'>" + _loc8_ + "</FONT>";
                     break;
                  case "regular":
               }
               TextUtils.updateTextFormat(_loc7_.txtName,15);
               TextUtils.updateTextFormat(_loc7_.txtMessages,15);
               updateTextAndFormat(_loc7_.txtName,_loc8_);
               _loc7_.txtMessages.text = "";
               _loc6_.initialize(dataM.chatData.channels[_loc2_].channelID,_loc5_,_loc4_,_loc7_,0,0,false,null,dataM.runAsMobile);
               _loc9_ = new BMTileListItem();
               _loc10_ = this.channelClicked;
               if(dataM.runAsMobile)
               {
                  _loc10_ = null;
               }
               _loc9_.initialize(_loc5_,_loc4_,_loc6_,"","","",0,_loc10_,null,null,null,null,dataM.runAsMobile);
               _loc1_.push(_loc9_);
            }
            _loc2_++;
         }
         this.channelsTileList.removeAllItems();
         this.channelsTileList.addItems(0,_loc1_,false);
         if(dataM.runAsMobile)
         {
            this._fingerWheeling_channels.tileListItemsModified();
         }
      }
      
      private function channelClicked(param1:Number, param2:Number) : void
      {
         if(this._channelClicked == null)
         {
            return;
         }
         this._channelClicked(param1,param2);
      }
      
      public function close() : void
      {
         visible = false;
         if(dataM.runAsMobile)
         {
            this._fingerWheeling_channels.removeMouseListeners();
         }
      }
      
      public function open() : void
      {
         visible = true;
         if(dataM.runAsMobile)
         {
            this._fingerWheeling_channels.addMouseListeners();
         }
      }
      
      public function cancelFingerWheeling() : void
      {
         if(dataM.runAsMobile)
         {
            this._fingerWheeling_channels.cancelFingerWheeling();
         }
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(dataM.runAsMobile)
         {
            this._fingerWheeling_channels.onEnterFrameTrigger();
         }
      }
      
      public function incraseChannelPendingMessages(param1:Number) : void
      {
         var _loc3_:String = null;
         var _loc4_:TextField = null;
         var _loc2_:BMTileListItem = this.channelsTileList.findTileListItemByTileListItemID(param1);
         if(_loc2_ != null)
         {
            _loc3_ = "";
            if(param1 != dataM.chatData.currentChannelPlayerID)
            {
               _loc4_ = _loc2_.item.itemGrp.txtMessages;
               if(_loc4_.text != "99+")
               {
                  if(_loc4_.text == "")
                  {
                     _loc3_ = "1";
                  }
                  else if(_loc4_.text == "99")
                  {
                     _loc3_ = "99+";
                  }
                  else
                  {
                     _loc3_ = String(int(_loc4_.text) + 1);
                  }
               }
            }
            updateTextAndFormat(_loc2_.item.itemGrp.txtMessages,_loc3_);
         }
      }
      
      public function resetChannelMessagesCounter(param1:uint) : void
      {
         var _loc2_:BMTileListItem = this.channelsTileList.findTileListItemByTileListItemID(param1);
         if(_loc2_ != null)
         {
            _loc2_.item.itemGrp.txtMessages.text = "";
         }
      }
      
      private function removeChannelsTileList() : void
      {
         if(this.channelsTileList != null)
         {
            this.channelsTileList.removeMe();
            this.channelsTileList = null;
         }
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
         this.removeChannelsTileList();
         if(dataM.runAsMobile)
         {
            this._fingerWheeling_channels.removeMouseListeners();
         }
      }
   }
}

