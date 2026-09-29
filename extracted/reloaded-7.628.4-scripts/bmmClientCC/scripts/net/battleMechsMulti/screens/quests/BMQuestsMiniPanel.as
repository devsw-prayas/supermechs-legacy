package net.battleMechsMulti.screens.quests
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.battleMechsMulti.managers.quests.BMPlayerQuestData;
   import net.battleMechsMulti.managers.quests.BMQuestData;
   import net.battleMechsMulti.managers.quests.BMQuestsManager;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2469")]
   public class BMQuestsMiniPanel extends BMBaseClass
   {
      
      public var mcListPlaceHolder:MovieClip;
      
      public var openQuestsBtn:BMBasicButton;
      
      public var mcCompleted:MovieClip;
      
      public function BMQuestsMiniPanel()
      {
         super();
         this.initialize();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         if(tutorialM.isTutorialActive())
         {
            visible = false;
            return;
         }
         this.openQuestsBtn.addEventListener(BMIntractable.HIT,this.onOpenQuestsClick);
         this.openQuestsBtn.text = getSpecificText("quests_achievements");
         this.onQuestsDataUpdated();
      }
      
      private function onOpenQuestsClick(param1:Event) : void
      {
         if(screensM.screensDirector.hasTasks())
         {
            return;
         }
         screensM.screenMainMenu.showQuestsScreen(BMQuestsManager.TYPE_DAILY_QUEST);
      }
      
      public function onQuestsDataUpdated() : void
      {
         var _loc4_:BMQuestsMiniPanelItem = null;
         this.mcCompleted.visible = dataM.questsManager.getNumOfCompletedAll() > 0;
         this.mcListPlaceHolder.removeChildren();
         var _loc1_:Vector.<BMQuestData> = dataM.questsManager.getQuestsOfTypes([BMQuestsManager.TYPE_SALE_QUEST,BMQuestsManager.TYPE_ACHIEVEMENT_QUEST]);
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_.length)
         {
            if(_loc2_ == 3)
            {
               break;
            }
            if(!_loc1_[_loc3_].isRewarded())
            {
               _loc4_ = new BMQuestsMiniPanelItem();
               _loc4_.setData(_loc1_[_loc3_]);
               _loc4_.addEventListener(MouseEvent.CLICK,this.onItemClick);
               _loc4_.y = _loc2_ * _loc4_.height;
               this.mcListPlaceHolder.addChild(_loc4_);
               _loc2_++;
            }
            _loc3_++;
         }
      }
      
      private function onItemClick(param1:MouseEvent) : void
      {
         if(screensM.screensDirector.hasTasks())
         {
            return;
         }
         var _loc2_:int = BMQuestsMiniPanelItem(param1.currentTarget).questID;
         var _loc3_:BMPlayerQuestData = dataM.questsManager.getPlayerQuestForQuestID(_loc2_);
         if(_loc3_ != null && _loc3_.isReadyToClaim)
         {
            dataM.questsManager.claimQuestReward(_loc3_.playerQuestID);
         }
         else
         {
            screensM.screenMainMenu.showQuestsScreen(BMQuestsManager.TYPE_ACHIEVEMENT_QUEST,_loc2_);
         }
      }
      
      public function notifyClientDataReloaded() : *
      {
         this.onQuestsDataUpdated();
      }
   }
}

