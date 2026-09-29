package net.battleMechsMulti.screens.quests
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMLanguageManager;
   import net.battleMechsMulti.managers.quests.BMQuestData;
   import net.battleMechsMulti.managers.singlePlayer.BMSinglePlayerManager;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1772")]
   public class BMQuestsMiniPanelItem extends BMBaseClass
   {
      
      public var txtTitle:TextField;
      
      public var txtCounter:TextField;
      
      public var mcBar:MovieClip;
      
      public var txtClaim:TextField;
      
      public var mcBg:MovieClip;
      
      private var _questID:int = -1;
      
      public function BMQuestsMiniPanelItem()
      {
         super();
      }
      
      public function setData(param1:BMQuestData) : void
      {
         var _loc2_:String = null;
         this._questID = param1.questID;
         if(param1.title == null)
         {
            trace("ERROR BMQuestsMiniPanelItem setData title is null");
         }
         else
         {
            _loc2_ = param1.title;
            switch(param1.storyID)
            {
               case BMSinglePlayerManager.STORY_ID_CAMPAIGN_2V2:
                  _loc2_ = "2v2 " + _loc2_;
                  break;
               case BMSinglePlayerManager.STORY_ID_CAMPAIGN_3V3:
                  _loc2_ = "3v3 " + _loc2_;
            }
            updateTextAndFormat(this.txtTitle,_loc2_);
         }
         this.mcBar.scaleX = param1.getCompleteAmount();
         this.txtCounter.text = param1.getProgress() + "/" + param1.requiredProgress;
         this.setCompletedState(param1.getCompleteAmount() == 1);
         updateTextAndFormat(this.txtClaim,BMLanguageManager.getInstance().getText("quests_claim"));
         ImageUtils.swapTextFieldWithBitMap(this.txtClaim,this);
      }
      
      private function setCompletedState(param1:Boolean) : void
      {
         this.txtCounter.visible = !param1;
         this.txtClaim.visible = param1;
         if(param1)
         {
            this.mcBg.gotoAndStop(2);
         }
         else
         {
            this.mcBg.gotoAndStop(1);
         }
      }
      
      public function get questID() : int
      {
         return this._questID;
      }
   }
}

