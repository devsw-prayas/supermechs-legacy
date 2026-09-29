package net.battleMechsMulti.screens.worldMap
{
   import flash.events.Event;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.mobiles.scroller.BMScrollerNew;
   import net.battleMechsMulti.screens.BMBaseScreen;
   import net.battleMechsMulti.screens.battleCredits.BMScreenFillBattleCredits;
   import net.battleMechsMulti.utils.TextUtils;
   
   public class BMScreenLaunchNukes extends BMBaseScreen
   {
      
      public var btnClose:BMBasicButton;
      
      public var btnLaunch:BMBasicButton;
      
      public var mcScroller:BMScrollerNew;
      
      public var txtTitle:TextField;
      
      public var txtDesc1:TextField;
      
      public var txtDesc2:TextField;
      
      public var txtSelected:TextField;
      
      public var txtBattleCredits:TextField;
      
      private var _selectedNukes:uint = 0;
      
      private var _storyID:uint;
      
      private var _missionSlot:uint;
      
      private var _missionMode:uint;
      
      private var _singleMissionBattleCreditsCost:uint;
      
      private var _dataSet:Boolean = false;
      
      public function BMScreenLaunchNukes()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers();
         setLanguageManagerScreenName("nukes");
         this.btnClose.addEventListener(BMIntractable.HIT,this.closeClicked);
         this.btnLaunch.addEventListener(BMIntractable.HIT,this.launchClicked);
         this.initStaticTexts();
      }
      
      public function setData(param1:uint, param2:uint, param3:uint, param4:uint) : void
      {
         this._storyID = param1;
         this._missionMode = param3;
         this._missionSlot = param2;
         this._singleMissionBattleCreditsCost = param4;
         this._dataSet = true;
         this.updateSelectedNukes(this.launchableNukes);
         this.initScroller();
         if(dataM.myProfile.nukes == 0)
         {
            this.mcScroller.disableMe();
         }
      }
      
      private function initStaticTexts() : void
      {
         this.btnLaunch.text = getScreenText("launch");
         updateTextAndFormat(this.txtTitle,getScreenText("title"));
         updateTextAndFormat(this.txtDesc1,getScreenText("desc1"));
         updateTextAndFormat(this.txtDesc2,getScreenText("desc2"));
      }
      
      private function updateSelectedNukes(param1:uint) : void
      {
         this._selectedNukes = param1;
         if(this._selectedNukes == 0)
         {
            this.btnLaunch.disableMe();
         }
         else
         {
            this.btnLaunch.enableMe();
         }
         var _loc2_:String = this._selectedNukes + " / " + this.playerNukes;
         updateTextAndFormat(this.txtSelected,_loc2_);
         var _loc3_:String = "";
         if(this._selectedNukes > this.launchableNukes)
         {
            _loc3_ = "<FONT COLOR=\'#" + dataM.COLOR_BAD + "\'>";
         }
         updateTextAndFormat(this.txtBattleCredits,_loc3_ + this.requiredBattleCredits,TextUtils.SIZE_KEEP_CURRENT,false,true);
      }
      
      private function get requiredBattleCredits() : uint
      {
         return this._selectedNukes * this._singleMissionBattleCreditsCost;
      }
      
      private function get launchableNukes() : uint
      {
         var _loc1_:uint = Math.floor(dataM.myProfile.battleCredits / this._singleMissionBattleCreditsCost);
         return Math.min(_loc1_,this.playerNukes);
      }
      
      private function get launchableNukesWithOneRefill() : uint
      {
         var _loc1_:uint = dataM.myProfile.battleCredits + dataM.battleCreditsMax;
         var _loc2_:uint = Math.floor(_loc1_ / this._singleMissionBattleCreditsCost);
         return Math.min(_loc2_,this.playerNukes);
      }
      
      private function get playerNukes() : uint
      {
         return dataM.myProfile.nukes;
      }
      
      private function initScroller() : void
      {
         this.mcScroller.setWholeNumbers(this.launchableNukesWithOneRefill);
         this.mcScroller.setCallback(this.scrollerCallback);
         this.mcScroller.resetSelection(this.launchableNukes);
      }
      
      private function launchClicked(param1:Event) : void
      {
         if(this._dataSet == false)
         {
            throw Error("Data not set");
         }
         var _loc2_:uint = this._selectedNukes * this._singleMissionBattleCreditsCost;
         if(dataM.myProfile.battleCredits < _loc2_)
         {
            screensM.addScreen(BMScreensManager.SCR_FILL_BATTLE_CREDITS);
            screensM.screenFillBattleCredits.setPosition(BMScreenFillBattleCredits.POSITION_CENTER_SCREEN);
            return;
         }
         remoteM.socketM.mission_useNuke(this._storyID,this._missionSlot,this._missionMode,this._selectedNukes);
         screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
      }
      
      private function scrollerCallback(param1:Number) : void
      {
         this.updateSelectedNukes(param1);
      }
      
      public function missionCompletedSuccess(param1:Object) : void
      {
         screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
         screensM.screenMissionWorldMap.createNukeAnimationAndGiveRewards(this._missionSlot,param1);
         dataM.myProfile.missionsCompleted += this._selectedNukes;
         dataM.myProfile.nukes -= this._selectedNukes;
         dataM.myProfile.battleCredits -= this._selectedNukes * this._singleMissionBattleCreditsCost;
         dataM.battleCreditsManager.setBattleCredits(dataM.myProfile.battleCredits);
         this.removeMe();
      }
      
      public function battleCreditsModified() : void
      {
         this.setData(this._storyID,this._missionSlot,this._missionMode,this._singleMissionBattleCreditsCost);
      }
      
      private function closeClicked(param1:Event) : void
      {
         this.removeMe();
      }
      
      private function removeMe() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_LAUNCH_NUKES);
      }
   }
}

