package net.battleMechsMulti.screens.quests
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import net.battleMechsMulti.data.BMRewardData;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMExternalAssetsManager;
   import net.battleMechsMulti.managers.BMLanguageManager;
   import net.battleMechsMulti.managers.quests.BMPlayerQuestData;
   import net.battleMechsMulti.managers.quests.BMQuestData;
   import net.battleMechsMulti.managers.quests.BMQuestsManager;
   import net.battleMechsMulti.managers.sales.BMSalesManager;
   import net.battleMechsMulti.managers.shop.BMGachaMachineData;
   import net.battleMechsMulti.managers.singlePlayer.BMSinglePlayerManager;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMPlayerItemData;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.screens.mainMenu.TextHolder;
   import net.battleMechsMulti.screens.shop.IconAndText;
   import net.battleMechsMulti.utils.TextUtils;
   import net.battleMechsMulti.utils.TimeUtils;
   
   public class BMQuestView extends BMBasicButton
   {
      
      public var mcIconSizer:Sprite;
      
      public var txtBody:TextField;
      
      public var txtProgress:TextField;
      
      public var txtTimer:TextField;
      
      public var mcFill:MovieClip;
      
      public var mcRewardHolder:MovieClip;
      
      public var mcStars:MovieClip;
      
      public var btnStates:MovieClip;
      
      public var mcCompleted:MovieClip;
      
      public var mcBG:MovieClip;
      
      private var _playerQuestID:int = -1;
      
      private var _questID:int = -1;
      
      private var _saleQuestTimer:Timer;
      
      private var _saleQuestCompleted:Boolean;
      
      public function BMQuestView()
      {
         super();
      }
      
      public function setData(param1:BMQuestData, param2:Boolean = false) : void
      {
         this._questID = param1.questID;
         this.titleTxt = param1.title;
         var _loc3_:String = param1.body;
         switch(param1.storyID)
         {
            case BMSinglePlayerManager.STORY_ID_CAMPAIGN_2V2:
               _loc3_ = "2v2: " + _loc3_;
               break;
            case BMSinglePlayerManager.STORY_ID_CAMPAIGN_3V3:
               _loc3_ = "3v3: " + _loc3_;
         }
         this.bodyTxt = _loc3_;
         this.icon = param1.icon;
         this.setStarsOrTimer(param1);
         var _loc4_:BMPlayerQuestData = param1.getPlayerQuestData();
         disableMe();
         this.mcCompleted.visible = false;
         if(_loc4_ != null)
         {
            this.setPlayerData(_loc4_,param1);
         }
         else
         {
            this.setProgress(param1.getProgress(),param1.requiredProgress);
         }
         this.setReward(param1.reward);
         if(this.mcBG != null)
         {
            if(param2)
            {
               this.mcBG.gotoAndStop(2);
            }
         }
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
      }
      
      private function setStarsOrTimer(param1:BMQuestData) : void
      {
         var _loc2_:Boolean = false;
         if(this.txtTimer != null)
         {
            updateTextAndFormat(this.txtTimer,"");
         }
         if(this.mcStars == null)
         {
            return;
         }
         if(param1.type == BMQuestsManager.TYPE_SALE_QUEST)
         {
            this.mcStars.gotoAndStop("timer");
            _loc2_ = param1.getCompleteAmount() == 1;
            this.startSaleQuestTimer(_loc2_);
            return;
         }
         if(param1.hasStars())
         {
            this.mcStars.gotoAndStop("stars" + param1.getNumOfStars());
            return;
         }
         if(param1.getCompleteAmount() == 1)
         {
            this.mcStars.gotoAndStop("oneStarOn");
         }
         else
         {
            this.mcStars.gotoAndStop("oneStarOff");
         }
      }
      
      private function setPlayerData(param1:BMPlayerQuestData, param2:BMQuestData) : void
      {
         var _loc3_:TextHolder = null;
         this._playerQuestID = param1.playerQuestID;
         if(param1.rewarded)
         {
            this.setProgress(param2.requiredProgress,param2.requiredProgress);
            this.mcCompleted.visible = true;
            if(this.mcCompleted.mcCompletedTextHolder != null)
            {
               _loc3_ = this.mcCompleted.mcCompletedTextHolder;
               _loc3_.text = BMLanguageManager.getInstance().getText("quests_completed");
            }
         }
         else if(param1.completed)
         {
            this.mcFill.scaleX = 0;
            this.progressTxt = BMLanguageManager.getInstance().getText("quests_claim");
            enableMe();
         }
         else
         {
            this.setProgress(param2.getProgress(),param2.requiredProgress);
         }
      }
      
      private function setReward(param1:BMRewardData) : void
      {
         var _loc2_:IconAndText = null;
         if(param1 == null)
         {
            return;
         }
         if(param1.gold > 0)
         {
            _loc2_ = new BMQuestRewardGold();
            _loc2_.text = TextUtils.getNumberWithComma(param1.gold);
            this.addReward(_loc2_);
         }
         if(param1.tokens > 0)
         {
            _loc2_ = new BMQuestRewardTokens();
            _loc2_.text = TextUtils.getNumberWithComma(param1.tokens);
            this.addReward(_loc2_);
         }
         if(param1.battleCredits > 0)
         {
            _loc2_ = new BMQuestRewardBattleCredits();
            _loc2_.text = TextUtils.getNumberWithComma(param1.battleCredits);
            this.addReward(_loc2_);
         }
         if(param1.xp > 0)
         {
            _loc2_ = new BMQuestRewardXP();
            _loc2_.text = TextUtils.getNumberWithComma(param1.xp);
            this.addReward(_loc2_);
         }
         if(param1.clanCoins > 0)
         {
            _loc2_ = new BMQuestRewardClanCoins();
            _loc2_.text = TextUtils.getNumberWithComma(param1.clanCoins);
            this.addReward(_loc2_);
         }
         if(param1.boxes.length > 0)
         {
            this.addBoxRewards(param1.boxes);
         }
         if(param1.items.length > 0)
         {
            this.addItems(param1.items);
         }
         if(param1.hasBoxFragments)
         {
            this.addBoxFragmentRewards(param1.boxFragments);
         }
      }
      
      private function addBoxRewards(param1:Vector.<uint>) : *
      {
         var _loc4_:IconAndText = null;
         var _loc5_:String = null;
         var _loc6_:uint = 0;
         var _loc7_:BMGachaMachineData = null;
         var _loc2_:Object = new Object();
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            if(_loc2_.hasOwnProperty(param1[_loc3_]))
            {
               ++_loc2_[param1[_loc3_]];
            }
            else
            {
               _loc2_[param1[_loc3_]] = 1;
            }
            _loc3_++;
         }
         for(_loc5_ in _loc2_)
         {
            _loc6_ = uint(int(_loc5_));
            _loc7_ = BMDataManager.getInstance().gachaMachinesDB[_loc6_];
            _loc4_ = new BMQuestRewardBoxes();
            _loc4_.text = "X " + _loc2_[_loc5_];
            _loc4_.mcIcon.gotoAndStop("itemBox" + _loc7_.imageID);
            this.addReward(_loc4_);
         }
      }
      
      private function addBoxFragmentRewards(param1:Dictionary) : *
      {
         var _loc2_:IconAndText = null;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         for(_loc3_ in param1)
         {
            _loc4_ = int(_loc3_);
            _loc5_ = int(BMDataManager.getInstance().getGacheMachine(_loc4_).imageID);
            _loc6_ = int(param1[_loc3_]);
            _loc7_ = BMDataManager.getInstance().boxFragmentsManager.getFragmentsRequiredForBox(_loc4_);
            _loc2_ = new BMQuestRewardBoxes();
            _loc2_.text = _loc6_.toString() + " " + "Pieces";
            _loc2_.mcIcon.gotoAndStop("itemBox" + _loc5_);
            this.addReward(_loc2_);
         }
      }
      
      private function addItems(param1:Vector.<BMPlayerItemData>) : *
      {
         var _loc4_:IconAndText = null;
         var _loc5_:String = null;
         var _loc6_:BMItemData = null;
         var _loc7_:String = null;
         var _loc8_:MovieClip = null;
         var _loc2_:Object = new Object();
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            if(_loc2_.hasOwnProperty(param1[_loc3_].itemID))
            {
               ++_loc2_[param1[_loc3_].itemID];
            }
            else
            {
               _loc2_[param1[_loc3_].itemID] = 1;
            }
            _loc3_++;
         }
         for(_loc5_ in _loc2_)
         {
            _loc4_ = new BMQuestRewardItem();
            _loc6_ = BMDataManager.getInstance().itemsDB[_loc5_];
            _loc7_ = BMDataManager.getInstance().itemTypeSourceDB[_loc6_.type];
            _loc8_ = BMExternalAssetsManager.getInstance().getAsset(_loc7_,_loc6_.grp,_loc4_.mcIcon.width,_loc4_.mcIcon.height,true,false);
            _loc4_.mcIcon.scaleX = 1;
            _loc4_.mcIcon.scaleY = 1;
            _loc4_.mcIcon.addChild(_loc8_);
            _loc4_.text = "X " + _loc2_[_loc5_];
            this.addReward(_loc4_);
         }
      }
      
      private function addReward(param1:DisplayObject) : *
      {
         param1.y = this.mcRewardHolder.height;
         this.mcRewardHolder.addChild(param1);
      }
      
      private function setProgress(param1:int, param2:int) : *
      {
         this.mcFill.scaleX = 1 - param1 / param2;
         if(this.mcFill.scaleX < 0)
         {
            this.mcFill.scaleX = 0;
         }
         this.progressTxt = this.formatBigNum(param1) + " / " + this.formatBigNum(param2);
      }
      
      private function formatBigNum(param1:int) : String
      {
         if(param1 < 10000)
         {
            return param1.toString();
         }
         return Math.floor(param1 / 1000) + "K";
      }
      
      private function set titleTxt(param1:String) : void
      {
         if(txtTitle == null)
         {
            return;
         }
         if(param1 == null)
         {
            txtTitle.visible = false;
            return;
         }
         txtTitle.text = param1;
         ImageUtils.swapTextFieldWithBitMap(txtTitle,this);
      }
      
      private function set bodyTxt(param1:String) : void
      {
         if(param1 == null)
         {
            this.txtBody.visible = false;
            return;
         }
         updateTextAndFormat(this.txtBody,param1);
         ImageUtils.swapTextFieldWithBitMap(this.txtBody,this);
      }
      
      private function set progressTxt(param1:String) : void
      {
         updateTextAndFormat(this.txtProgress,param1);
         ImageUtils.swapTextFieldWithBitMap(this.txtProgress,this);
      }
      
      private function set icon(param1:String) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:MovieClip = BMExternalAssetsManager.getInstance().getAsset("general",param1,this.mcIconSizer.width,this.mcIconSizer.height,true,false);
         _loc2_.x = this.mcIconSizer.x;
         _loc2_.y = this.mcIconSizer.y;
         addChild(_loc2_);
      }
      
      public function get playerQuestID() : int
      {
         return this._playerQuestID;
      }
      
      public function get questID() : int
      {
         return this._questID;
      }
      
      override protected function gotoVisualState(param1:String) : void
      {
         this.btnStates.gotoAndStop(param1);
      }
      
      private function startSaleQuestTimer(param1:Boolean) : void
      {
         this._saleQuestCompleted = param1;
         this._saleQuestTimer = new Timer(1000);
         this._saleQuestTimer.addEventListener(TimerEvent.TIMER,this.onSaleQuestTimerTrigger);
         this._saleQuestTimer.start();
         this.refreshSaleQuestTimer();
      }
      
      private function onSaleQuestTimerTrigger(param1:TimerEvent) : void
      {
         this.refreshSaleQuestTimer();
      }
      
      private function refreshSaleQuestTimer() : void
      {
         var _loc1_:int = BMSalesManager.gi().getSaleData().endDate - BMDataManager.getInstance().currentTime;
         if(_loc1_ <= 0)
         {
            _loc1_ = 0;
            this._saleQuestTimer.stop();
         }
         var _loc2_:String = "<FONT COLOR=\'#FF0000\'>";
         if(this._saleQuestCompleted)
         {
            _loc2_ = "<FONT COLOR=\'#CCCCCC\'>";
         }
         updateTextAndFormat(this.txtTimer,_loc2_ + TimeUtils.formatTimeLeft(_loc1_),TextUtils.SIZE_KEEP_CURRENT,true,true);
      }
      
      private function removeSaleQuestTimerTrigger() : void
      {
         if(this._saleQuestTimer != null)
         {
            this._saleQuestTimer.stop();
            this._saleQuestTimer = null;
         }
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
         this.removeSaleQuestTimerTrigger();
      }
   }
}

