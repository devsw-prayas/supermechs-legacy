package net.battleMechsMulti.screens.quests
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.battleMechsMulti.data.BMRewardData;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMExternalAssetsManager;
   import net.battleMechsMulti.managers.quests.BMPlayerQuestData;
   import net.battleMechsMulti.managers.quests.BMQuestData;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMPlayerItemData;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.screens.shop.IconAndText;
   
   public class BMQuestView extends BMBasicButton
   {
      
      public var mcIconSizer:Sprite;
      
      public var txtBody:TextField;
      
      public var txtProgress:TextField;
      
      public var mcFill:MovieClip;
      
      public var mcRewardHolder:MovieClip;
      
      public var mcStars:MovieClip;
      
      public var btnStates:MovieClip;
      
      public var mcCompleted:MovieClip;
      
      private var _playerQuestID:int = -1;
      
      private var _questID:int = -1;
      
      public function BMQuestView()
      {
         super();
      }
      
      public function setData(param1:BMQuestData) : void
      {
         this._questID = param1.questID;
         this.titleTxt = param1.title;
         this.bodyTxt = param1.body;
         this.icon = param1.icon;
         this.setStars(param1);
         var _loc2_:BMPlayerQuestData = param1.getPlayerQuestData();
         disableMe();
         this.mcCompleted.visible = false;
         if(_loc2_ != null)
         {
            this.setPlayerData(_loc2_,param1);
         }
         else
         {
            this.setProgress(param1.getProgress(),param1.requiredProgress);
         }
         this.setReward(param1.reward);
      }
      
      private function setStars(param1:BMQuestData) : void
      {
         if(this.mcStars == null)
         {
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
         this._playerQuestID = param1.playerQuestID;
         if(param1.rewarded)
         {
            this.setProgress(param2.requiredProgress,param2.requiredProgress);
            this.mcCompleted.visible = true;
         }
         else if(param1.completed)
         {
            this.mcFill.scaleX = 0;
            this.progressTxt = "CLAIM";
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
            _loc2_.text = BMDataManager.getInstance().getNumberWithComma(param1.gold);
            this.addReward(_loc2_);
         }
         if(param1.tokens > 0)
         {
            _loc2_ = new BMQuestRewardTokens();
            _loc2_.text = BMDataManager.getInstance().getNumberWithComma(param1.tokens);
            this.addReward(_loc2_);
         }
         if(param1.energy > 0)
         {
            _loc2_ = new BMQuestRewardEnergy();
            _loc2_.text = BMDataManager.getInstance().getNumberWithComma(param1.energy);
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
      }
      
      private function addBoxRewards(param1:Vector.<uint>) : *
      {
         var _loc4_:IconAndText = null;
         var _loc5_:String = null;
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
            _loc4_ = new BMQuestRewardBoxes();
            _loc4_.text = "X " + _loc2_[_loc5_];
            _loc4_.mcIcon.gotoAndStop("itemBox" + _loc5_);
            this.addReward(_loc4_);
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
      
      private function addReward(param1:MovieClip) : *
      {
         param1.y = this.mcRewardHolder.height;
         this.mcRewardHolder.addChild(param1);
      }
      
      private function setProgress(param1:int, param2:int) : *
      {
         this.mcFill.scaleX = 1 - param1 / param2;
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
         this.txtBody.text = param1;
         ImageUtils.swapTextFieldWithBitMap(this.txtBody,this);
      }
      
      private function set progressTxt(param1:String) : void
      {
         this.txtProgress.text = param1;
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
   }
}

