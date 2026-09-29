package net.battleMechsMulti.screens.campaignsMenu
{
   import flash.events.Event;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.singlePlayer.BMSinglePlayerManager;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.mobiles.BMMechView;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.mobiles.itemList.BMHorizontalItemsScroller;
   import net.battleMechsMulti.mobiles.worldMap.BMWorldMapBossData;
   import net.battleMechsMulti.mobiles.worldMap.BMWorldMapLocationData;
   import net.battleMechsMulti.screens.BMBaseScreen;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1042")]
   public class BMScreenCampaignsMenu extends BMBaseScreen
   {
      
      public var btnClose:BMBasicButton;
      
      public var txtTitle:TextField;
      
      private var _enterCampaign:Function;
      
      public var itemsScroller:BMHorizontalItemsScroller;
      
      private var itemsData:Array;
      
      public function BMScreenCampaignsMenu()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers();
         setLanguageManagerScreenName("campaignsMenu");
         updateTextAndFormat(this.txtTitle,getScreenText("title"));
         this.btnClose.addEventListener(BMIntractable.HIT,this.closeClicked);
         this.initItemsScroller();
      }
      
      private function initItemsScroller() : void
      {
         var _loc3_:uint = 0;
         this.itemsScroller.visible = true;
         if(this.itemsScroller.isInitiated())
         {
            return;
         }
         this.itemsData = new Array();
         var _loc1_:uint = 0;
         while(_loc1_ < BMSinglePlayerManager.STORY_IDS_FOR_CAMPAIGNS_MENU.length)
         {
            _loc3_ = uint(BMSinglePlayerManager.STORY_IDS_FOR_CAMPAIGNS_MENU[_loc1_]);
            this.initSpecificCampaignButton(_loc3_);
            _loc1_++;
         }
         this.itemsScroller.setViewClass(BMCampaignMenuButton);
         var _loc2_:uint = BMHorizontalItemsScroller.NAVIGATION_TYPE_NONE;
         if(BMSinglePlayerManager.is3V3CampaignEnabled)
         {
            if(dataM.runAsMobile)
            {
               _loc2_ = BMHorizontalItemsScroller.NAVIGATION_TYPE_FINGER_SCROLLING;
            }
            else
            {
               _loc2_ = BMHorizontalItemsScroller.NAVIGATION_TYPE_BUTTONS;
            }
         }
         else
         {
            this.itemsScroller.y += 12;
         }
         this.itemsScroller.activateScrolling(_loc2_,BMHorizontalItemsScroller.NAVIGATION_DIRECTION_VERTICAL);
         this.itemsScroller.setItemSelectedFunction(this.storySelected);
         this.itemsScroller.setItems(this.itemsData);
      }
      
      private function initSpecificCampaignButton(param1:uint) : void
      {
         var _loc9_:BMMechView = null;
         var _loc10_:BMMechStructure = null;
         var _loc15_:BMWorldMapLocationData = null;
         var _loc16_:BMWorldMapBossData = null;
         var _loc17_:uint = 0;
         var _loc18_:String = null;
         var _loc2_:BMDataManager = BMDataManager.getInstance();
         if(_loc2_.singlePlayerM.isStoryVisible(param1) == false)
         {
            return;
         }
         var _loc3_:uint = _loc2_.singlePlayerM.getHighestChapterCompleted(param1,0) + 1;
         var _loc4_:Array = [_loc3_,_loc3_ + 1];
         if(_loc3_ >= 7)
         {
            _loc4_ = [6,7];
         }
         var _loc5_:Array = _loc2_.singlePlayerM.getVisualMissionsDataByChapterIDs(param1,_loc4_);
         var _loc6_:uint = 0;
         var _loc7_:int = _loc2_.singlePlayerM.getHighestPlayableMissionSlot(param1,_loc6_);
         var _loc8_:int = BMSinglePlayerManager.NO_LOCATION_ID;
         if(_loc7_ < _loc2_.singlePlayerM.getMissionsDB(param1).length - 1)
         {
            _loc8_ = _loc2_.singlePlayerM.getNextBossLocationID(param1,_loc7_);
         }
         if(_loc8_ != BMSinglePlayerManager.NO_LOCATION_ID)
         {
            _loc15_ = _loc2_.singlePlayerM.getSpecificMissionDB(param1,_loc8_);
            _loc16_ = _loc2_.singlePlayerM.getMissionBossData(param1,_loc15_.campaignID,_loc15_.bossID,0);
            _loc10_ = _loc16_.getBossMechStructure();
         }
         var _loc11_:uint = _loc2_.singlePlayerM.getStoryCompletionRatio(param1);
         var _loc12_:Boolean = false;
         var _loc13_:String = "";
         if(_loc2_.singlePlayerM.isStoryLocked(param1))
         {
            _loc12_ = true;
            _loc17_ = _loc2_.singlePlayerM.getStoryLevelRequired(param1);
            _loc18_ = getScreenText("reachLevelXToUnlock");
            _loc13_ = _loc18_ = _loc2_.replaceStringInText(_loc18_,"%LEVEL%",String(_loc17_));
         }
         var _loc14_:Object = new Object();
         _loc14_.storyID = param1;
         _loc14_.chapters = _loc4_;
         _loc14_.missionsData = _loc5_;
         _loc14_.completionRatio = _loc11_;
         _loc14_.bossMechStructure = _loc10_;
         _loc14_.clicked = null;
         _loc14_.locked = _loc12_;
         _loc14_.unlockMessage = _loc13_;
         this.itemsData.push(_loc14_);
      }
      
      public function setEnterCampaignFunction(param1:Function) : void
      {
         this._enterCampaign = param1;
      }
      
      private function storySelected(param1:uint) : void
      {
         var _loc3_:uint = 0;
         if(dataM.singlePlayerM.isStoryLocked(param1))
         {
            return;
         }
         var _loc2_:uint = uint(BMSinglePlayerManager.MECHS_PER_STORY_ID[param1]);
         if(dataM.areMechsReadyForBattle(_loc2_) == false)
         {
            _loc3_ = 1;
            while(_loc3_ <= _loc2_)
            {
               if(dataM.areMechsReadyForBattle(_loc3_) == false)
               {
                  break;
               }
               _loc3_++;
            }
            screensM.screenConfirmation.displayQuestionOrNotification("mechIsNotReady",_loc3_);
         }
         else
         {
            this._enterCampaign(param1);
         }
         this.removeMe();
      }
      
      private function closeClicked(param1:Event) : void
      {
         screensM.disableNextClickForMobile = true;
         this.removeMe();
      }
      
      private function removeMe() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_CAMPAIGNS_MENU);
      }
   }
}

