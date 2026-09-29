package net.battleMechsMulti.screens.clan
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.battleMechsMulti.data.ItemRarityResolver;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.shop.BMShopManager;
   import net.battleMechsMulti.mobiles.BMBar;
   import net.battleMechsMulti.mobiles.BMClanFlag;
   import net.battleMechsMulti.mobiles.BMPlayerItemData;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.mobiles.chat.BMChatInterface;
   import net.battleMechsMulti.screens.BMBaseScreen;
   import net.battleMechsMulti.screens.mainMenu.TextHolder;
   import net.battleMechsMulti.screens.missionDifficulty.MissionReward;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3334")]
   public class BMScreenClanChat extends BMBaseScreen
   {
      
      public var chatInterface:BMChatInterface;
      
      public var btnSettings:BMBasicButton;
      
      public var btnClanRankingList:BMBasicButton;
      
      public var btnClaimRewards:BMBasicButton;
      
      public var mcRewardsCounter:TextHolder;
      
      public var mcReward:MissionReward;
      
      public var mcIconsHolder:Sprite;
      
      public var mcMedalsHolder:Sprite;
      
      public var mcSizer_medals:Sprite;
      
      public var mcTooltipMedals:Sprite;
      
      public var mcSizer_rank:Sprite;
      
      public var mcSizer_flag:Sprite;
      
      public var txtTitle:TextField;
      
      public var txtWinsValue:TextField;
      
      public var txtMembers:TextField;
      
      public var txtArenaPoints:TextField;
      
      public var winsBar:BMBar;
      
      private var mcClanFlag:BMClanFlag;
      
      private var mcRank:Sprite;
      
      private var _medals:Array = new Array();
      
      private var _medalsBM:Bitmap;
      
      private var _medalsBMD:BitmapData;
      
      private var _sparks:Array = new Array();
      
      public function BMScreenClanChat()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers();
         setLanguageManagerScreenName("clan");
         this.initChatInterface();
         this.initClanFlag();
         this.initTexts();
         this.initButtons();
         this.initClanRewardInterface();
         this.initMedals();
         this.refreshRank();
         this.initMedalsTooltip();
         this.refreshClaimRewardButton();
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
      }
      
      public function onEnterFrameTrigger() : void
      {
         this.chatInterface.onEnterFrameTrigger();
      }
      
      private function initTexts() : void
      {
         var _loc3_:Number = NaN;
         updateTextAndFormat(this.txtTitle,dataM.myProfile.clanName);
         var _loc1_:String = getScreenText("ladderWins");
         if(dataM.myProfile.clanLadderBattles > 0)
         {
            _loc3_ = Math.ceil(dataM.myProfile.clanLadderWins / dataM.myProfile.clanLadderBattles * 100);
            _loc1_ = dataM.replaceStringInText(_loc1_,"%WINS%",TextUtils.getNumberWithComma(dataM.myProfile.clanLadderWins));
            _loc1_ = dataM.replaceStringInText(_loc1_,"%BATTLES%",TextUtils.getNumberWithComma(dataM.myProfile.clanLadderBattles) + " <FONT COLOR=\'#B2B2B2\'>( " + _loc3_ + "% )</FONT>");
         }
         else
         {
            _loc1_ = dataM.replaceStringInText(_loc1_,"%WINS%","0");
            _loc1_ = dataM.replaceStringInText(_loc1_,"%BATTLES%","0");
         }
         var _loc2_:String = dataM.myProfile.clanMembers + " / " + dataM.clanMaxMembers;
         updateTextAndFormat(this.txtMembers,_loc2_);
         updateTextAndFormat(this.txtArenaPoints,TextUtils.getNumberWithComma(dataM.myProfile.clan_arenaPoints));
      }
      
      private function initChatInterface() : void
      {
         this.chatInterface.initialize(this.tryToInspectPlayer,this.sendChatMessage,BMChatInterface.CHAT_TYPE_CLAN);
         dataM.chatData.currentChannelPlayerID = dataM.chatData.CHAT_CLAN_CHANNEL_PLAYER_ID;
         this.chatInterface.refreshChatHistory();
      }
      
      private function initClanRewardInterface() : void
      {
         var _loc1_:BMClanRewardData = null;
         var _loc8_:Number = NaN;
         this.winsBar.initialize("blue");
         this.winsBar.addSeparateorLines(4);
         _loc1_ = dataM.clanRewards[dataM.clanRewards.length - 1];
         var _loc2_:uint = _loc1_.winsRequired;
         var _loc3_:uint = dataM.clanRewards.length;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         while(_loc6_ < dataM.clanRewards.length)
         {
            _loc1_ = dataM.clanRewards[_loc6_];
            _loc4_ = _loc5_;
            _loc5_ = _loc1_.winsRequired;
            if(dataM.myProfile.clanLadderWins < _loc1_.winsRequired)
            {
               _loc2_ = _loc1_.winsRequired;
               _loc3_ = _loc6_;
               break;
            }
            _loc6_++;
         }
         var _loc7_:String = getScreenText("barWins");
         _loc7_ = dataM.replaceStringInText(_loc7_,"%CURRENT%",TextUtils.getNumberWithComma(dataM.myProfile.clanLadderWins));
         _loc7_ = dataM.replaceStringInText(_loc7_,"%MAX%",TextUtils.getNumberWithComma(_loc2_));
         updateTextAndFormat(this.txtWinsValue,_loc7_);
         if(_loc3_ == dataM.clanRewards.length)
         {
            this.mcReward.visible = false;
            this.winsBar.setFill(1);
         }
         else
         {
            _loc1_ = dataM.clanRewards[_loc3_];
            this.showRewardValueAndIcon("gold",_loc1_.rewardData.gold);
            this.showRewardValueAndIcon("tokens",_loc1_.rewardData.tokens);
            this.showRewardValueAndIcon("xp",_loc1_.rewardData.xp);
            this.showRewardValueAndIcon("battleCredits",_loc1_.rewardData.battleCredits);
            this.showRewardValueAndIcon("boxes",int(_loc1_.rewardData.hasBoxes));
            this.showRewardValueAndIcon("items",int(_loc1_.rewardData.hasItems),_loc1_.rewardData.items);
            _loc8_ = (dataM.myProfile.clanLadderWins - _loc4_) / (_loc5_ - _loc4_);
            this.winsBar.setFill(_loc8_);
         }
      }
      
      private function showRewardValueAndIcon(param1:String, param2:uint, param3:Vector.<BMPlayerItemData> = null) : void
      {
         var _loc4_:String = null;
         if(param2 == 0)
         {
            return;
         }
         this.mcReward.setIconByType(param1,param3);
         if(param1 == "boxes" && param2 == 1)
         {
            this.mcReward.text = "";
         }
         else
         {
            _loc4_ = TextUtils.getNumberWithComma(param2);
            if(param3 != null)
            {
               _loc4_ = "x " + param3.length;
            }
            this.mcReward.text = _loc4_;
         }
      }
      
      private function get() : void
      {
      }
      
      private function initButtons() : void
      {
         if(dataM.myProfile.clanLeaderID != dataM.userID)
         {
            this.btnSettings.visible = false;
         }
         this.btnSettings.addEventListener(BMIntractable.HIT,this.settingsClicked);
         this.btnClanRankingList.addEventListener(BMIntractable.HIT,this.clanRankingListClicked);
         this.btnClaimRewards.addEventListener(BMIntractable.HIT,this.claimRewardsClicked);
      }
      
      private function settingsClicked(param1:Event) : void
      {
         if(dataM.myProfile.clanLeaderID != dataM.userID)
         {
            return;
         }
         this.openSettings();
         soundM.createSound("buttonClick",1);
      }
      
      public function openSettings() : void
      {
         screensM.addScreen(BMScreensManager.SCR_CLAN_SETTINGS);
         screensM.screenClanSettings.refreshScreen();
         screensM.screenTransitionsManager.removeCurrentScreen();
         screensM.screenTransitionsManager.removeMe();
      }
      
      private function clanRankingListClicked(param1:Event) : void
      {
         screensM.screenClanMenu.goToClanRankingList();
      }
      
      private function refreshClaimRewardButton() : void
      {
         this.btnClaimRewards.visible = false;
         this.mcRewardsCounter.visible = false;
         this.mcMedalsHolder.visible = true;
         var _loc1_:uint = BMShopManager.gi().getFreePackagesAmount(false,true);
         if(_loc1_ == 0)
         {
            return;
         }
         this.mcRewardsCounter.text = _loc1_.toString();
         this.btnClaimRewards.visible = true;
         this.mcRewardsCounter.visible = true;
         this.mcMedalsHolder.visible = false;
      }
      
      private function claimRewardsClicked(param1:Event) : void
      {
         var _loc2_:int = BMShopManager.gi().getNextClanRewardPackageID();
         if(_loc2_ == -1)
         {
            throw Error("BMScreenClanChat claimRewardsClicked error: no reward to claim");
         }
         BMShopManager.gi().tryToClaimFreeBoost(_loc2_);
      }
      
      public function freeBoostClaimed() : void
      {
         this.refreshClaimRewardButton();
      }
      
      private function initClanFlag() : void
      {
         this.removeClanFlag();
         this.createFlag();
      }
      
      private function removeClanFlag() : void
      {
         if(this.mcClanFlag != null)
         {
            this.mcClanFlag.removeMe();
            this.mcClanFlag = null;
         }
      }
      
      private function createFlag() : void
      {
         var _loc3_:MovieClip = null;
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc2_:Array = dataM.getClanFlagData(_loc1_.clanFlag);
         if(_loc2_.length > 0)
         {
            this.mcClanFlag = new BMClanFlag();
            _loc3_ = externalAssetsM.getAsset("general","clanFlag",this.mcSizer_flag.width,this.mcSizer_flag.height,false,false);
            _loc3_.x = this.mcSizer_flag.x;
            _loc3_.y = this.mcSizer_flag.y;
            this.mcClanFlag.initialize(_loc3_,dataM.runAsMobile);
            this.mcClanFlag.updateFlag(_loc2_);
            this.mcIconsHolder.addChild(_loc3_);
         }
      }
      
      private function refreshRank() : void
      {
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(this.mcRank != null)
         {
            this.mcRank.parent.removeChild(this.mcRank);
            this.mcRank = null;
         }
         var _loc2_:uint = dataM.getLadderRankIconNumber(dataM.getLadderRankByProgress(_loc1_.clanLadderProgress));
         this.mcRank = externalAssetsM.getAsset("general","Grp_rank" + _loc2_,this.mcSizer_rank.width,this.mcSizer_rank.height,false,false);
         this.mcRank.x = this.mcSizer_rank.x;
         this.mcRank.y = this.mcSizer_rank.y;
         this.mcIconsHolder.addChild(this.mcRank);
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
      
      private function initMedals() : void
      {
         if(dataM.myProfile.clanLeaderID == dataM.userID)
         {
            this.mcTooltipMedals.width -= 55;
            this.mcSizer_medals.width -= 55;
         }
         this.refreshMedals();
      }
      
      private function refreshMedals() : void
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:Number = NaN;
         var _loc6_:String = null;
         var _loc7_:MovieClip = null;
         var _loc10_:Sprite = null;
         var _loc11_:Number = NaN;
         this.removeMedals();
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc2_:Number = 0;
         if(dataM.clientRunningLocally)
         {
         }
         if(dataM.weeklyTopClans[_loc1_.clanID] == null)
         {
            return;
         }
         var _loc8_:uint = 0;
         var _loc9_:Number = 0;
         _loc4_ = 3;
         while(_loc4_ >= 1)
         {
            _loc5_ = Number(dataM.weeklyTopClans[_loc1_.clanID].places[_loc4_]);
            if(_loc5_ > 0)
            {
               _loc3_ = 1;
               while(_loc3_ <= _loc5_)
               {
                  _loc6_ = "medalClan" + _loc4_;
                  if(_loc5_ - _loc3_ >= 9)
                  {
                     _loc3_ += 9;
                     _loc6_ += "_10";
                  }
                  else if(_loc5_ - _loc3_ >= 4)
                  {
                     _loc3_ += 4;
                     _loc6_ += "_5";
                  }
                  else if(_loc5_ - _loc3_ >= 2)
                  {
                     _loc3_ += 2;
                     _loc6_ += "_3";
                  }
                  _loc7_ = externalAssetsM.getAsset("general",_loc6_);
                  if(_loc9_ == 0)
                  {
                     _loc9_ = this.mcSizer_medals.x + this.mcSizer_medals.width + _loc7_.width / 2;
                  }
                  _loc7_.x = _loc9_ - (1 + this._medals.length) * _loc7_.width;
                  _loc7_.y = this.mcSizer_medals.y;
                  if(this._medals.length % 2 == 1)
                  {
                     _loc7_.gotoAndStop("long");
                  }
                  this.mcMedalsHolder.addChild(_loc7_);
                  this._medals.push(_loc7_);
                  _loc8_++;
                  _loc3_++;
               }
            }
            _loc4_--;
         }
         if(_loc8_ > 1)
         {
            _loc10_ = this._medals[this._medals.length - 1];
            if(_loc10_.x < this.mcSizer_medals.x + 15)
            {
               _loc11_ = this.mcSizer_medals.x + 15 - _loc10_.x;
               _loc3_ = this._medals.length - 1;
               while(_loc3_ > 0)
               {
                  this._medals[_loc3_].x += _loc11_ / (this._medals.length - 1) * _loc3_;
                  _loc3_--;
               }
            }
         }
         this.createMedalsImageForMobile();
      }
      
      private function createMedalsImageForMobile() : void
      {
         var _loc1_:Array = null;
         if(dataM.runAsMobile == false)
         {
            return;
         }
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
            _loc1_ = screensM.createAssetsBitmap([],this._medals,15,15);
            this._medalsBMD = _loc1_[0];
            this._medalsBM = _loc1_[1];
            this.mcMedalsHolder.addChild(this._medalsBM);
         }
      }
      
      private function medalsMouseOver(param1:MouseEvent) : void
      {
         this.medalsMouseOverSub();
      }
      
      private function medalsMouseOut(param1:MouseEvent) : void
      {
         tooltip.hideToolTip();
      }
      
      public function medalsMouseOverSub() : void
      {
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc2_:String = "";
         if(_loc1_.clanID <= 0)
         {
            return;
         }
         if(dataM.weeklyTopClans[_loc1_.clanID] == null)
         {
            return;
         }
         var _loc3_:uint = uint(dataM.weeklyTopClans[_loc1_.clanID].places[1]);
         var _loc4_:uint = uint(dataM.weeklyTopClans[_loc1_.clanID].places[2]);
         var _loc5_:uint = uint(dataM.weeklyTopClans[_loc1_.clanID].places[3]);
         if(_loc3_ <= 0 && _loc4_ <= 0 && _loc5_ <= 0)
         {
            return;
         }
         var _loc6_:String = "<FONT COLOR=\'#" + ItemRarityResolver.COLOR_LEGENDARY_ITEM + "\'>";
         var _loc7_:String = "</FONT>";
         if(_loc2_ == "")
         {
            _loc2_ = "Clan weekly wins:";
         }
         else
         {
            _loc2_ += "<BR>Clan weekly wins:";
         }
         if(_loc3_ > 0)
         {
            _loc2_ = _loc2_ + "<BR>   First place: " + _loc6_ + _loc3_ + _loc7_;
         }
         if(_loc4_ > 0)
         {
            _loc2_ = _loc2_ + "<BR>   Second place: " + _loc6_ + _loc4_ + _loc7_;
         }
         if(_loc5_ > 0)
         {
            _loc2_ = _loc2_ + "<BR>   Third place: " + _loc6_ + _loc5_ + _loc7_;
         }
         tooltip.showToolTip("regularText",_loc2_,-1,-1);
      }
      
      private function initMedalsTooltip() : void
      {
         if(dataM.runAsMobile == false)
         {
            this.mcTooltipMedals.addEventListener(MouseEvent.MOUSE_OVER,this.medalsMouseOver);
            this.mcTooltipMedals.addEventListener(MouseEvent.MOUSE_OUT,this.medalsMouseOut);
            this.mcTooltipMedals.addEventListener(MouseEvent.MOUSE_UP,this.medalsMouseOut);
         }
      }
      
      private function tryToInspectPlayer(param1:Number) : void
      {
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
      
      private function onRemovedFromStage(param1:Event) : void
      {
         this.removeClanFlag();
      }
      
      public function removeMe() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_CLAN_CHAT);
      }
   }
}

