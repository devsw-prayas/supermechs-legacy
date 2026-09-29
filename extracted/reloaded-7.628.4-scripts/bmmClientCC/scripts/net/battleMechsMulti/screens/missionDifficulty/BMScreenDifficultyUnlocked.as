package net.battleMechsMulti.screens.missionDifficulty
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.mobiles.worldMap.BMWorldMapLocationData;
   import net.battleMechsMulti.screens.BMBaseScreen;
   import net.battleMechsMulti.screens.BMScreenWatchRewardedVideo;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2412")]
   public class BMScreenDifficultyUnlocked extends BMBaseScreen
   {
      
      public var mcRays:Sprite;
      
      public var txtTitle:TextField;
      
      public var txtBody:TextField;
      
      public var mcBg:MovieClip;
      
      public var continueBtn:BMBasicButton;
      
      public function BMScreenDifficultyUnlocked()
      {
         super();
         this.continueBtn.addEventListener(BMIntractable.HIT,this.onClick);
      }
      
      private function onClick(param1:Event) : void
      {
         this.closeClicked();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("missionDifficulty");
         ImageUtils.swapTextFieldWithBitMap(this.txtTitle,this);
         this.refrash();
      }
      
      public function refrash() : void
      {
         var _loc1_:BMWorldMapLocationData = dataM.singlePlayerM.currentMissionDB;
         var _loc2_:String = this.getDifficaltyText();
         var _loc3_:String = dataM.singlePlayerM.getChapterName(_loc1_.chapterID);
         var _loc4_:String = getScreenText("missionDifficulty");
         _loc4_ = dataM.replaceStringInText(_loc4_,"%DIFFNAME%",_loc2_);
         _loc4_ = dataM.replaceStringInText(_loc4_,"%CHAPNAME%",_loc3_);
         updateTextAndFormat(this.txtBody,_loc4_);
         ImageUtils.swapTextFieldWithBitMap(this.txtBody,this);
      }
      
      private function getDifficaltyText() : String
      {
         if(dataM.myProfile.currentMissionMode == 0)
         {
            return getScreenText("hardMode");
         }
         return getScreenText("insaneMode");
      }
      
      public function onEnterFrameTrigger() : void
      {
         this.mcRays.rotation += 0.5;
      }
      
      public function closeClicked() : void
      {
         screensM.removeScreen("screenDifficultyUnlocked");
         if(dataM.isRewardedVideoAvailable(BMScreenWatchRewardedVideo.PLACEMENT_COMPLETE_MISSION))
         {
            screensM.addScreen(BMScreensManager.SCR_WATCH_REWARDED_VIDEO);
            screensM.screenWatchRewardedVideo.refreshScreen(screensM.screenWatchRewardedVideo.TYPE_COMPLETE_MISSION,dataM.myProfile.currentMissionSlot);
         }
         else
         {
            screensM.screenMissionBaseMap.exitScreen();
         }
      }
   }
}

